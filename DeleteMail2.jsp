<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%

try
{
         Class.forName("com.mysql.jdbc.Driver");
           Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyProjectDatabase", "shirisha", "siri@123");
           Statement st=conn.createStatement();
           int user_id=Integer.parseInt(request.getParameter("mid"));

           int i=st.executeUpdate("update mails set sentbox=0 where mid="+mid );
          
        out.println("<center><b>Data is successfully deleted!<br><a href='SentBox.jsp'>Check Now</a></b></center>");
          
        }
        catch(Exception e)
        {
        System.out.print(e);
        e.printStackTrace();
        }
 %>
