<<<<<<< HEAD
package servlet;

import dao.DBConnection;
import model.Product;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
       
    	Connection con = DBConnection.getConnection();
    	Map<String, List<Product>> productByCategory = new LinkedHashMap<>();
    	
    	try {
    		String sql = "SELECT * FROM products ORDER BY category";
    		PreparedStatement ps = con.prepareStatement(sql);
    		ResultSet rs = ps.executeQuery();
    		
    		while(rs.next()) {
    			String category = rs.getString("category");
    			Product p = new Product();
    			
    			p.setId(rs.getInt("id"));
    			p.setName(rs.getString("name"));
    			p.setCategory(category);
    			p.setPrice(rs.getDouble("price"));
    			p.setImageUrl(rs.getString("image_url"));
    			p.setDescription(rs.getString("description"));
    			p.setQuantity(rs.getInt("quantity"));
    			
    			productByCategory.computeIfAbsent(category, k -> new ArrayList<>()).add(p);
    			
    			
    			
    		}
		}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	
		req.setAttribute("productByCategory", productByCategory);
		req.getRequestDispatcher("jsp/home.jsp").forward(req, res);
	
    }
}
=======
package servlet;

import dao.DBConnection;
import model.Product;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
       
    	Connection con = DBConnection.getConnection();
    	Map<String, List<Product>> productByCategory = new LinkedHashMap<>();
    	
    	try {
    		String sql = "SELECT * FROM products ORDER BY category";
    		PreparedStatement ps = con.prepareStatement(sql);
    		ResultSet rs = ps.executeQuery();
    		
    		while(rs.next()) {
    			String category = rs.getString("category");
    			Product p = new Product();
    			
    			p.setId(rs.getInt("id"));
    			p.setName(rs.getString("name"));
    			p.setCategory(category);
    			p.setPrice(rs.getDouble("price"));
    			p.setImageUrl(rs.getString("image_url"));
    			p.setDescription(rs.getString("description"));
    			p.setQuantity(rs.getInt("quantity"));
    			
    			productByCategory.computeIfAbsent(category, k -> new ArrayList<>()).add(p);
    			
    			
    			
    		}
		}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	
		req.setAttribute("productByCategory", productByCategory);
		req.getRequestDispatcher("jsp/home.jsp").forward(req, res);
	
    }
}
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
