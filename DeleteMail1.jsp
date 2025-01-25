<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
 
 
try
{
         Class.forName("com.mysql.jdbc.Driver");
           Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/EmailSoftware", "shirisha", "siri@123");
           Statement st=conn.createStatement();
           String uidp=request.getParameter("mid");
           int i=st.executeUpdate("update mails set inbox=0 where mid="+mid );
           response.sendRedirect("inbox-1.jsp?msg='mail sent successfully'");
        out.println("<center><b>Data is successfully deleted!<br><a href='inbox-1.jsp'>Check Now</a></b></center>");
        }
        catch(Exception e)
        {
        System.out.print(e.getMessage());
        e.printStackTrace();
        }
 %>
