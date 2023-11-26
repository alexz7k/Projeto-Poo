<%@ page import="java.sql.*" %>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");  // Carrega o driver JDBC do MySQL
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/FastImoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");  // Estabelece a conexão com o banco de dados

    
    String recordIdStr = request.getParameter("recordId");  // Verifica se a requisição contém um ID de registro
    if (recordIdStr != null) {
        int recordId = Integer.parseInt(recordIdStr);
        
        
        String deleteQuery = "DELETE FROM imoveis WHERE id=?";  // Executa a exclusão do registro
        PreparedStatement preparedStatement = conn.prepareStatement(deleteQuery);
        preparedStatement.setInt(1, recordId);
        
        int rowsDeleted = preparedStatement.executeUpdate();
        preparedStatement.close();

        
        if (rowsDeleted > 0) {  // Verifica se o registro foi excluído com sucesso
%>
<div class="alert alert-success" role="alert">
    Record deleted successfully!
</div>
<%
        } else {  // Senão, falha em excluir o registro
%>
<div class="alert alert-danger" role="alert">
    Failed to delete the record.
</div>
<%
        }
    }
    conn.close();  // Fecha a conexão com o banco de dados
} catch (Exception e) {
    e.printStackTrace();
}
%>

<a href="painel.jsp">Back to the List</a>
