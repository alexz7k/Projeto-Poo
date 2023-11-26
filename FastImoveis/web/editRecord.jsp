<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="application/json" %>
<%@ page language="java" %>

<%
    Connection conn = null;
    PreparedStatement preparedStatement = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&characterEncoding=UTF-8", "root", "");

        String recordIdStr = request.getParameter("recordId");
        if (recordIdStr != null) {
            int recordId = Integer.parseInt(recordIdStr);

            // Obter os dados do formulário
            String endereco = request.getParameter("endereco");
            String categoria = request.getParameter("categoria");
            

            // Verificar se os campos obrigatórios estão presentes
            if (endereco != null && categoria != null) {
                // Atualizar o registro no banco de dados
                String updateQuery = "UPDATE imoveis SET endereco=?, categoria=? WHERE id=?";
                preparedStatement = conn.prepareStatement(updateQuery);
                preparedStatement.setString(1, endereco);
                preparedStatement.setString(2, categoria);
                preparedStatement.setInt(3, recordId);

                // Execute a consulta preparada
                int rowsUpdated = preparedStatement.executeUpdate();

                // Verificar se a atualização foi bem-sucedida
                if (rowsUpdated > 0) {
                    out.println("{\"success\": true, \"message\": \"Record updated successfully!\"}");

                    // Adicionar redirecionamento 
                    response.sendRedirect("painel.jsp");
                } else {
                    out.println("{\"success\": false, \"message\": \"Failed to update the record.\"}");
                }
            } else {
                out.println("{\"success\": false, \"message\": \"Missing required fields.\"}");
            }
        } else {
            out.println("{\"success\": false, \"message\": \"Invalid record ID.\"}");
        }
    } catch (Exception e) {
        out.println("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
    } finally {
        try {
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
