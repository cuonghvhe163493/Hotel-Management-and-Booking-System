package controller.AuthController;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.*;
import org.json.JSONObject;
import dao.Authentication.UserDAO;
import model.User;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {

    // ⚠️ LƯU Ý: Thay thế bằng Client ID, Client Secret và REDIRECT_URI của bạn
    private static final String CLIENT_ID = "861333935241-fme60hi3sojf9nero06kbd4ll3ohi1fk.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:9999/HotelManagementandBookingSystem/google-login";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Thiết lập mã hóa và Content Type
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String code = request.getParameter("code");

        // 1. Chuyển hướng sang trang đăng nhập Google (nếu chưa có code)
        if (code == null || code.isEmpty()) {
            String oauthUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                    + "?client_id=" + CLIENT_ID
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                    + "&response_type=code"
                    + "&scope=email%20profile"
                    + "&access_type=offline";
            
            // Nếu có tham số 'redirect' trong request ban đầu, lưu vào session
            String redirectParam = request.getParameter("redirect");
            if (redirectParam != null && !redirectParam.isEmpty()) {
                request.getSession().setAttribute("redirectAfterLogin", redirectParam);
            }

            response.sendRedirect(oauthUrl);
            return;
        }

        // 2. Nếu có code, gọi Google để lấy access token
        String tokenResponse = getAccessToken(code);
        if (tokenResponse == null) {
            response.getWriter().println("Error: cannot get token from Google!");
            return;
        }

        JSONObject jsonToken = new JSONObject(tokenResponse);
        String accessToken = jsonToken.optString("access_token", null);
        if (accessToken == null) {
            response.getWriter().println("Error: invalid access token");
            return;
        }

        // 3. Lấy thông tin người dùng từ Google
        String userInfo = getUserInfo(accessToken);
        JSONObject userJson = new JSONObject(userInfo);

        String email = userJson.optString("email", "unknown");
        String name = userJson.optString("name", "unknown");

        // 4. Kiểm tra user trong DB
        User user = UserDAO.getUserByEmail(email);

        if (user == null) {
            // Đăng ký user mới nếu chưa tồn tại
            boolean registered = UserDAO.registerUser(name, "google_login", email);
            if (registered) {
                user = UserDAO.getUserByEmail(email);
            }
        } else {
            System.out.println("✅ Found existing user: " + user.getEmail() + " | role = " + user.getRole());
        }

        // 5. Nếu vẫn không tìm thấy user
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/view/Authentication/login.jsp?error=google_failed");
            return;
        }

        // 6. Đăng nhập thành công → Lưu session (Đồng nhất với LoginServlet)
        HttpSession session = request.getSession();
        session.setAttribute("user", user); // Lưu đối tượng User
        session.setAttribute("customerId", user.getUserId()); // Lưu userId
        session.setAttribute("role", user.getRole()); // Lưu Role

        // 7. Điều hướng (logic giống với LoginServlet)
        String ctx = request.getContextPath();
        String redirectUrl = (String) session.getAttribute("redirectAfterLogin"); // Lấy URL đã lưu trước đó

        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            // Nếu có redirect → quay về trang trước
            session.removeAttribute("redirectAfterLogin"); // Xóa URL sau khi sử dụng
            response.sendRedirect(redirectUrl);
            return;
        }

        // Không có redirect → redirect theo role (logic đồng nhất với LoginServlet)
        String role = user.getRole().toLowerCase();
        if ("admin".equals(role)) {
            // Redirect đến path controller của Admin
            response.sendRedirect(ctx + "/admin-home"); 
        } else {
            // Redirect đến trang chủ (áp dụng cho customer, hotel_manager, và các role khác)
            response.sendRedirect(ctx + "/index.jsp");
        }
    }

    
    private String getAccessToken(String code) throws IOException {
        URL url = new URL("https://oauth2.googleapis.com/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        String data = "code=" + code
                + "&client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&grant_type=authorization_code";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(data.getBytes());
        }

        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            return response.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    
    private String getUserInfo(String accessToken) throws IOException {
        URL url = new URL("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + accessToken);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            return response.toString();
        }
    }
}