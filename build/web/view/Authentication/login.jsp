<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Neon Login - Hotel Management</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/view/Authentication/css/style.css">
    </head>
    <body>
        <div class="login-container">
            <div class="login-card">
                <div class="login-header">
                    <h2>Sign In</h2>
                    <p>Access your account</p>
                </div>

                <form class="login-form" id="loginForm" action="${pageContext.request.contextPath}/login" method="post" novalidate>
                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="text" id="username" name="username" required autocomplete="username">
                            <label for="username">Username</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper password-wrapper">
                            <input type="password" id="password" name="password" required autocomplete="current-password">
                            <label for="password">Password</label>
                        </div>
                    </div>

                    <button type="submit" class="login-btn btn">Sign In</button>
                    <% if (request.getParameter("success") != null) { %>
                    <div style="color: #00ff88; text-align: center; margin-top: 15px; font-weight: 600;">
                        ✅ Registration successful! Redirecting to login...
                    </div>


                    <script>
                        setTimeout(function () {
                            window.location.href = "<%=request.getContextPath()%>/login";
                        }, 2000);
                    </script>
                    <% } %>

                </form>

                </form> 

                <div class="divider"><span>or</span></div>

                <a href="<%=request.getContextPath()%>/google-login" class="social-btn google-btn">
                    <span class="social-icon google-icon"></span>
                    <span>Continue with Google</span>
                </a>

                <div class="auth-options"> 
                    <a href="<%=request.getContextPath()%>/view/Authentication/forgot_password.jsp" class="forgot-password">
                        Forgot password?
                    </a>

                    <div class="signup-link">
                        <p>New here? <a href="<%=request.getContextPath()%>/register">Create an account</a></p>
                    </div>
                </div>

                <% if (request.getParameter("error") != null) { %>
                <script>alert('Invalid username or password!');</script>
                <% } %>
            </div>
        </div>
    </body>
</html>
