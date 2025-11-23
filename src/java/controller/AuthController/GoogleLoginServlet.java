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

    
    private static final String CLIENT_ID = "861333935241-fme60hi3sojf9nero06kbd4ll3ohi1fk.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:9999/HotelManagementandBookingSystem/google-login";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
      
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String code = request.getParameter("code");

      
        if (code == null || code.isEmpty()) {
            String oauthUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                    + "?client_id=" + CLIENT_ID
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                    + "&response_type=code"
                    + "&scope=email%20profile"
                    + "&access_type=offline";
            
           
            String redirectParam = request.getParameter("redirect");
            if (redirectParam != null && !redirectParam.isEmpty()) {
                request.getSession().setAttribute("redirectAfterLogin", redirectParam);
            }

            response.sendRedirect(oauthUrl);
            return;
        }

       
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

       
        String userInfo = getUserInfo(accessToken);
        JSONObject userJson = new JSONObject(userInfo);

        String email = userJson.optString("email", "unknown");
        String name = userJson.optString("name", "unknown");

        
        User user = UserDAO.getUserByEmail(email);

        if (user == null) {
           
            boolean registered = UserDAO.registerUser(name, "google_login", email);
            if (registered) {
                user = UserDAO.getUserByEmail(email);
            }
        } else {
            System.out.println("✅ Found existing user: " + user.getEmail() + " | role = " + user.getRole());
        }

       
        if (user != null) {
             String status = user.getAccountStatus().toLowerCase();
             if ("banned".equals(status)) {
                
                response.sendRedirect(request.getContextPath() + "/login?error=banned");
                return;
            }
            
           
            HttpSession session = request.getSession();
            session.setAttribute("user", user); 
            session.setAttribute("customerId", user.getUserId()); 
            session.setAttribute("role", user.getRole()); 
            
           
            if ("suspended".equals(status)) {
                session.setAttribute("loginAlertMessage", "Your account in suspended.");
            } else {
                session.removeAttribute("loginAlertMessage"); 
            }

            // 7. Điều hướng (logic giống với LoginServlet)
            String ctx = request.getContextPath();
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin"); 

            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                // Nếu có redirect → quay về trang trước
                session.removeAttribute("redirectAfterLogin"); 
                response.sendRedirect(redirectUrl);
                return;
            }

      
            String role = user.getRole().toLowerCase();
            if ("admin".equals(role)) {
               
                response.sendRedirect(ctx + "/admin-home"); 
            } else {
            
                response.sendRedirect(ctx + "/index.jsp");
            }
        } else {
           
            response.sendRedirect(request.getContextPath() + "/view/Authentication/login.jsp?error=google_failed");
            return;
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