package servlet;

import dao.ProductDAO;
import model.CartItem;
import model.Product;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        int productId = Integer.parseInt(req.getParameter("productId"));
        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductById(productId);

        if (action.equals("add")) {
            boolean exists = false;
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(item.getQuantity() + 1);
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                cart.add(new CartItem(product, 1));
            }
        } else if (action.equals("remove")) {
            cart.removeIf(item -> item.getProduct().getId() == productId);
        } else if (action.equals("update")) {
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(quantity);
                    break;
                }
            }
        }

        session.setAttribute("cart", cart);
        res.sendRedirect("jsp/cart.jsp");
    }
}
