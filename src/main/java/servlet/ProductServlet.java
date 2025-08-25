
package servlet;

import dao.ProductDAO;
import model.Product;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        ProductDAO dao = new ProductDAO();

        if ("add".equalsIgnoreCase(action)) {
            try {
                String name = req.getParameter("name");
                String category = req.getParameter("category");
                double price = Double.parseDouble(req.getParameter("price"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                String imageUrl = req.getParameter("imageUrl");
                String description = req.getParameter("description");

                Product p = new Product();
                p.setName(name);
                p.setCategory(category);
                p.setPrice(price);
                p.setQuantity(quantity);
                p.setImageUrl(imageUrl);
                p.setDescription(description);

                boolean status = dao.addProduct(p);

                if (status) {
                    res.sendRedirect("jsp/viewProducts.jsp");
                } else {
                    res.sendRedirect("jsp/addProduct.jsp?error=1");
                }
                return;
            } catch (Exception e) {
                e.printStackTrace();
                res.sendRedirect("jsp/addProduct.jsp?error=1");
                return;
            }

        } else if ("update".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));

                Product p = new Product();
                p.setId(id);
                p.setName(req.getParameter("name"));
                p.setCategory(req.getParameter("category"));
                p.setPrice(Double.parseDouble(req.getParameter("price")));
                p.setQuantity(Integer.parseInt(req.getParameter("quantity")));
                p.setImageUrl(req.getParameter("imageUrl"));
                p.setDescription(req.getParameter("description"));

                boolean updated = dao.updateProduct(p);

                if (updated) {
                    res.sendRedirect("jsp/viewProducts.jsp");
                } else {
                    res.sendRedirect("jsp/editProduct.jsp?id=" + id + "&error=1");
                }
                return;

            } catch (Exception e) {
                e.printStackTrace();
                res.sendRedirect("jsp/viewProducts.jsp?error=1");
                return;
            }

        } else  {
            res.sendRedirect("jsp/error.jsp");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
    	
    	String action = req.getParameter("action");
        ProductDAO dao = new ProductDAO();
    	if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.deleteProduct(id);
                res.sendRedirect("jsp/viewProducts.jsp");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                res.sendRedirect("jsp/viewProducts.jsp?error=1");
                return;
            }

        } else if ("edit".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = dao.getProductById(id);
                req.setAttribute("product", product);
                RequestDispatcher rd = req.getRequestDispatcher("jsp/editProduct.jsp");
                rd.forward(req, res);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                res.sendRedirect("jsp/viewProducts.jsp?error=1");
                return;
            }

        } 
    }
}

