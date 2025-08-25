<<<<<<< HEAD
package security;

import java.security.MessageDigest;

public class HashUtil {
	
	public static String hashPassword(String password) {
		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
			
			// Convert to hex code
			StringBuilder sb = new StringBuilder();
			
			for(byte b : hashBytes) {
				sb.append(String.format("%02x", b));
			}
				
			return sb.toString();
		}
		catch(Exception e) {
			throw new RuntimeException("Error hashing Password" + e);
		}
	}
}
=======
package security;

import java.security.MessageDigest;

public class HashUtil {
	
	public static String hashPassword(String password) {
		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
			
			// Convert to hex code
			StringBuilder sb = new StringBuilder();
			
			for(byte b : hashBytes) {
				sb.append(String.format("%02x", b));
			}
				
			return sb.toString();
		}
		catch(Exception e) {
			throw new RuntimeException("Error hashing Password" + e);
		}
	}
}
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
