package dao;

import model.Address;
import java.sql.*;
import java.util.*;

public class AddressDAO {
    public static List<Address> getAddressesByEmail(String email) {
        List<Address> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM addresses WHERE user_email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Address a = new Address();
                a.setId(rs.getInt("id"));
                a.setUserEmail(rs.getString("user_email"));
                a.setFullName(rs.getString("full_name"));
                a.setStreet(rs.getString("street"));
                a.setCity(rs.getString("city"));
                a.setState(rs.getString("state"));
                a.setPincode(rs.getString("pincode"));
                a.setPhone(rs.getString("phone"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

//=======
//package dao;
//
//import model.Address;
//import java.sql.*;
//import java.util.*;
//
//public class AddressDAO {
//    public static List<Address> getAddressesByEmail(String email) {
//        List<Address> list = new ArrayList<>();
//        try (Connection conn = DBConnection.getConnection()) {
//            PreparedStatement ps = conn.prepareStatement("SELECT * FROM addresses WHERE user_email = ?");
//            ps.setString(1, email);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Address a = new Address();
//                a.setId(rs.getInt("id"));
//                a.setUserEmail(rs.getString("user_email"));
//                a.setFullName(rs.getString("full_name"));
//                a.setStreet(rs.getString("street"));
//                a.setCity(rs.getString("city"));
//                a.setState(rs.getString("state"));
//                a.setPincode(rs.getString("pincode"));
//                a.setPhone(rs.getString("phone"));
//                list.add(a);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
//}
//>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
