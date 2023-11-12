<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Food Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Edit Food Item</h1>

        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://http://localhost/FastImoveis/?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            
            // Check if the form was submitted
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int recordId = Integer.parseInt(request.getParameter("recordId"));
                String address = request.getParameter("address");
                String category = request.getParameter("category");
                String priceStr = request.getParameter("price");
                String sallerName = request.getParameter("sallerName");
                int sallerPhone = Integer.parseInt(request.getParameter("sallerPhone"));
                String sallerEmail = request.getParameter("sallerEmail");
                String status = request.getParameter("status");
                
                // Convert the price from String to Double
                Double price = Double.parseDouble(priceStr);
                
                String updateQuery = "UPDATE alimentos SET endereco=?, descricao=?, preco=?, categoria=?, origem=?, data_validade=?, calorias=?, peso_gramas=?, fabricante=? WHERE id=?";
                
                PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
                preparedStatement.setString(1, address);
                preparedStatement.setString(2, category);
                preparedStatement.setDouble(3, price);
                preparedStatement.setString(4, sallerName);
                preparedStatement.setInt(5, sallerPhone);
                preparedStatement.setString(6, sallerEmail);
                preparedStatement.setString(7, sallerEmail);
                preparedStatement.setString(8, status);
                preparedStatement.setInt(10, recordId);
                
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
