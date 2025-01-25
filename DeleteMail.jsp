<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String[] selectedMessages = request.getParameterValues("selectedMessages");
    if (selectedMessages != null && selectedMessages.length > 0) {
        String driver = "com.mysql.jdbc.Driver";
        String connectionUrl = "jdbc:mysql://localhost:3306/";
        String database = "EmailSoftware";
        String userid = "shirisha";
        String password = "siri@123";
        
        Connection connection = null;
        Statement statement = null;
        
        try {
            Class.forName(driver);
            connection = DriverManager.getConnection(connectionUrl + database, userid, password);
            statement = connection.createStatement();
            
            for (String messageId : selectedMessages) {
                // Update the sentbox flag to 0 for SentBox deletion
                String updateSentboxSql = "UPDATE mails SET sentbox = '0' WHERE mid = " + Integer.parseInt(messageId);
                statement.executeUpdate(updateSentboxSql);
                
                // Update the inbox flag to 1 for SentBox deletion
                String updateInboxSql = "UPDATE mails SET inbox = '1' WHERE mid = " + Integer.parseInt(messageId);
                statement.executeUpdate(updateInboxSql);
            }
            
            // Redirect back to the SentBox page after deletion
            response.sendRedirect("SentBox.jsp");
            
        } catch (ClassNotFoundException | SQLException e) {
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                out.println("Error closing database resources: " + e.getMessage());
            }
        }
    } else {
        out.println("No messages selected for deletion.");
    }
%>


