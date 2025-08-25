//package model;
//
//import jakarta.mail.*;
//import jakarta.mail.internet.*;
//import java.util.Properties;
//
//public class EmailUtil {
//
//    public static void sendEmail(String toEmail, String subject, String body) {
//        final String fromEmail = "--mail"; 
//        final String password = "password";    
//
//        // Set up mail server properties
//        Properties props = new Properties();
//        props.put("mail.smtp.host", "smtp.gmail.com"); 
//        props.put("mail.smtp.port", "587");              
//        props.put("mail.smtp.auth", "true");             
//        props.put("mail.smtp.starttls.enable", "true");  
//
//        // Create a session with authentication
//        Session session = Session.getInstance(props, new Authenticator() {
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(fromEmail, password);
//            }
//        });
//
//        try {
//            // Create email message
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(fromEmail));
//            message.setRecipients(
//                Message.RecipientType.TO, InternetAddress.parse(toEmail));
//            message.setSubject(subject);
//            message.setText(body);
//
//            // Send the email
//            Transport.send(message);
//            System.out.println("✅ Email sent successfully to " + toEmail);
//        } catch (MessagingException e) {
//            e.printStackTrace();
//        }
//    }
//}
