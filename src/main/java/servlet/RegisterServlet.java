<<<<<<< HEAD
package servlet;

import dao.UserDAO;
import model.User;
import security.HashUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/RegisterServlet") // Optional if web.xml already maps this
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Get user input
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String rawPassword = req.getParameter("password");
        String password = HashUtil.hashPassword(rawPassword);

        // Set user details
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("customer"); // default role

        // Register user using DAO
        UserDAO dao = new UserDAO();
        boolean registered = dao.registerUser(user);

        if (registered) {
            // Success: redirect to login
            res.sendRedirect("HomeServlet");
        } else {
            // Failure: back to register with error
            res.sendRedirect("jsp/register.jsp?error=1");
        }
    }
}
=======
package servlet;

import dao.UserDAO;
import model.User;
import security.HashUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/RegisterServlet") // Optional if web.xml already maps this
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Get user input
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String rawPassword = req.getParameter("password");
        String password = HashUtil.hashPassword(rawPassword);

        // Set user details
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("customer"); // default role

        // Register user using DAO
        UserDAO dao = new UserDAO();
        boolean registered = dao.registerUser(user);

        if (registered) {
            // Success: redirect to login
            res.sendRedirect("jsp/home.jsp");
        } else {
            // Failure: back to register with error
            res.sendRedirect("jsp/register.jsp?error=1");
        }
    }
}
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
