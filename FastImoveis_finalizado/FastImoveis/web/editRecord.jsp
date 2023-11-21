<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Properties Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Edit Properties Item</h1>

        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis/?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            
            // Check if the form was submitted
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int recordId = Integer.parseInt(request.getParameter("recordId"));
                String address = request.getParameter("address");
                String category = request.getParameter("category");
                String priceStr = request.getParameter("price").replace(",", ".");
                String sallerName = request.getParameter("sallerName");
                String sallerPhone = request.getParameter("sallerPhone");
                String sallerEmail = request.getParameter("sallerEmail");
                String status = request.getParameter("status");
                
                // Convert the price from String to Double
                //Double price = Double.parseDouble(priceStr);
                BigDecimal price = new BigDecimal(priceStr);
                
                String updateQuery = "UPDATE imoveis SET endereco=?, categoria=?, preco=?, nome_vendedor=?, telefone_vendedor=?, email_vendedor=?, status=? WHERE id=?";
                
                PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
                preparedStatement.setString(1, address);
                preparedStatement.setString(2, category);
                preparedStatement.setBigDecimal(3, price);
                preparedStatement.setString(4, sallerName);
                preparedStatement.setString(5, sallerPhone);
                preparedStatement.setString(6, sallerEmail);
                preparedStatement.setString(7, status);
                preparedStatement.setInt(8, recordId);
                
                int rowsUpdated = preparedStatement.executeUpdate();
                preparedStatement.close();
                
                if (rowsUpdated > 0) {
        %>
        <div class="alert alert-success" role="alert">
            Record updated successfully!
        </div>
        <%
                } else {
        %>
        <div class="alert alert-danger" role="alert">
            Failed to update the record.
        </div>
        <%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>

        <a href="painel.jsp">Back to the List</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
