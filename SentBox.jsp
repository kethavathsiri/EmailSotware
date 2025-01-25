<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My SentBox</title>
    <style>
        th, td {
            font-size: 32px;
            padding: 10px;
            text-align: left;
        }
        .myCheckBox {
            width: 20px;
            height: 20px;
        }
        .myButton {
            padding: 10px;
            font-size: 32px;
        }
    </style>
</head>
<body>
    <table border="1" width="90%" align="center">
        <tr>
            <td align="center"><a href="inbox.jsp">Inbox</a></td>
            <td align="center"><a href="SentBox.jsp">Sentbox</a></td>
            <td align="center"><a href="ComposeMail.jsp">ComposeMail</a></td>
            <td align="center"><a href="logout.jsp">Logout</a></td>
        </tr>
    </table>
    <br><br>
    
    <center><h1>My SentBox</h1></center><br><br>
    
    <form action="DeleteMail.jsp" method="post">
        <table border="1" align="center" width="60%">
            <tr>
                <th>To</th>
                <th>Subject</th>
                <th><input type="submit" align=center class="myButton" value="Delete"</th>
            </tr>
            <% 
                String driver = "com.mysql.jdbc.Driver";
                String connectionUrl = "jdbc:mysql://localhost:3306/";
                String database = "EmailSoftware";
                String userid = "shirisha";
                String password = "siri@123";
                
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;
                
                try {
                    Class.forName(driver);
                    connection = DriverManager.getConnection(connectionUrl + database, userid, password);
                    statement = connection.createStatement();
                    
                    String user_id = session.getAttribute("emailid").toString();
                    String sql = "SELECT * FROM mails WHERE mfrom='" + user_id + "' AND sentbox=1";
                    resultSet = statement.executeQuery(sql);
                    
                    while(resultSet.next()) {
                        int mid = resultSet.getInt("mid");
                        String mto = resultSet.getString("mto");
                        String subject = resultSet.getString("subject");
            %>
            <tr>
                <td><%= mto %></td>
                <td><a href="ReadMail2.jsp?mid=<%= mid %>"><%= subject %></a></td>
                <td><input type="checkbox" name="selectedMessages" class="myCheckBox" value="<%= mid %>"></td>
            </tr>
            <% 
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        out.println("Error closing database resources: " + e.getMessage());
                    }
                }
            %>
        </table>
        <br>
        <!--<input type="submit" align=center class="myButton" value="Delete Selected">-->
    </form>
</body>
</html>

