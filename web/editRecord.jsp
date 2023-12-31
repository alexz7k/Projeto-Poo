<!-- editRecord.jsp, arquivo utilizado quando for necess�rio realizar a edi��o de um registro no banco de dados diretamente pelo projeto -->

<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Properties Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">  <!-- CSS do Bootstrap adicionado -->
</head>
<body>
    <div class="container">
        <h1>Edit Properties Item</h1>

        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // Carrega o driver JDBC do MySQL
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis/?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");  // Estabelece a conex�o com o banco de dados
            
            
            if (request.getMethod().equalsIgnoreCase("POST")) {  // Verifica se o formul�rio foi enviado
                int recordId = Integer.parseInt(request.getParameter("recordId"));  // Obt�m os par�metros do formul�rio
                String address = request.getParameter("address");
                String category = request.getParameter("category");
                String priceStr = request.getParameter("price").replace(",", ".");
                String sallerName = request.getParameter("sallerName");
                String sallerPhone = request.getParameter("sallerPhone");
                String sallerEmail = request.getParameter("sallerEmail");
                String status = request.getParameter("status");
                
                // Converte o pre�o de String para BigDecimal
                BigDecimal price = new BigDecimal(priceStr);
                
                String updateQuery = "UPDATE imoveis SET endereco=?, categoria=?, preco=?, nome_vendedor=?, telefone_vendedor=?, email_vendedor=?, status=? WHERE id=?";  // Query SQL para atualizar o registro

                
                PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
                preparedStatement.setString(1, address);
                preparedStatement.setString(2, category);
                preparedStatement.setBigDecimal(3, price);
                preparedStatement.setString(4, sallerName);
                preparedStatement.setString(5, sallerPhone);
                preparedStatement.setString(6, sallerEmail);
                preparedStatement.setString(7, status);
                preparedStatement.setInt(8, recordId);
                
                int rowsUpdated = preparedStatement.executeUpdate();  // Executa a atualiza��o do registro
                preparedStatement.close();
                
                if (rowsUpdated > 0) {  // Exibe mensagem de sucesso ou falha
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
