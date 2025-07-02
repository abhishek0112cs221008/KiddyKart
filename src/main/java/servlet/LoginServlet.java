package servlet;

import dao.UserDAO;
import model.User;
import security.HashUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/LoginServlet") // optional, use if not configured in web.xml
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        // Get form input
        String email = req.getParameter("email");
        String inputPassword = req.getParameter("password");
        String password = HashUtil.hashPassword(inputPassword);

        // Authenticate user
        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email, password);  // Returns null if invalid

        if (user != null) {
            // Start session and set user
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getName());
            
            // Redirect based on role
            String role = user.getRole();
            if ("admin".equalsIgnoreCase(role)) {
//                res.sendRedirect("jsp/admin/admin.jsp");
            	res.sendRedirect("AdminServlet"); 
            } else {
                res.sendRedirect("HomeServlet"); 
            }
        } else {
            // Invalid login: redirect to error page or back to login with message
            res.sendRedirect("jsp/error.jsp");
            // Or: res.sendRedirect("jsp/login.jsp?error=1");
        }
    }
}
