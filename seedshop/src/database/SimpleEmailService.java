package database;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SimpleEmailService {

    // Replace sender@example.com with your "From" address.
    // This address must be verified.
    static final String FROM = "xpflxhfl94@naver.com";
    static final String FROMNAME = "SEEDSHOP";
	
    // Replace recipient@example.com with a "To" address. If your account 
    // is still in the sandbox, this address must be verified.
    static final String TO = "xpflxhfl94@gmail.com";
    
    // Replace smtp_username with your Amazon SES SMTP user name.
    static final String SMTP_USERNAME = "AKIAXWQLVBH4DPT4EPXG";
    
    // Replace smtp_password with your Amazon SES SMTP password.
    static final String SMTP_PASSWORD = "BG14lfE4P/6kXOYYDI9909byWThbpL6+qohXqz3WQZK0";
    
    
    // Amazon SES SMTP host name. This example uses the US West (Oregon) region.
    // See https://docs.aws.amazon.com/ses/latest/DeveloperGuide/regions.html#region-endpoints
    // for more information.
    static final String HOST = "email-smtp.ap-northeast-2.amazonaws.com";
    
    // The port you will connect to on the Amazon SES SMTP endpoint. 
    static final int PORT = 587;
    
    static final String SUBJECT = "Thank you for using our SEED SHOP!";
    
    public static String BODY = "";
    
    public static void messageBody() {
    	SimpleEmailService.BODY = String.join(
        	    System.getProperty("line.separator"),
        	    "<h1>Order completed!</h1>", //order complete
        	    "<h3>Thank you for using our SEED SHOP</h3>", 
        	    "<a href='http://ec2-3-37-50-123.ap-northeast-2.compute.amazonaws.com:8080/seedshop/home/Orders.jsp'>Click and check my orders</a>",
        	    " <br> <a href='http://ec2-3-37-50-123.ap-northeast-2.compute.amazonaws.com:8080/seedshop/home/index.jsp'>SEED SHOP</a>."
        	);
    }

    public static void SendMessage(String href) throws Exception {
    	messageBody(); //보낼 메세지 내용 입력
    	
    	
        // Create a Properties object to contain connection configuration information.
    	Properties props = System.getProperties();
    	props.put("mail.transport.protocol", "smtp");
    	props.put("mail.smtp.port", PORT); 
    	props.put("mail.smtp.starttls.enable", "true");
    	props.put("mail.smtp.auth", "true");

        // Create a Session object to represent a mail session with the specified properties. 
    	Session session = Session.getDefaultInstance(props);

        // Create a message with the specified information. 
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(FROM,FROMNAME));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
        msg.setSubject(SUBJECT);
        msg.setContent(BODY,"text/html");
        
            
        // Create a transport.
        Transport transport = session.getTransport();
                    
        // Send the message.
        try
        {
            System.out.println("Sending...");
            
            // Connect to Amazon SES using the SMTP username and password you specified above.
            transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
        	
            // Send the email.
            transport.sendMessage(msg, msg.getAllRecipients());
            System.out.println("Email sent!");
        }
        catch (Exception ex) {
            System.out.println("The email was not sent.");
            System.out.println("Error message: " + ex.getMessage());
        }
        finally
        {
            // Close and terminate the connection.
            transport.close();
        }
    }
}