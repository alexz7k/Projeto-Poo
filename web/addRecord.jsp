<%@ page import="java.sql.*, java.math.BigDecimal, java.util.Random" %>

<%
// Recupera os dados do formul�rio da requisi��o para buscar os par�metros
String endereco = request.getParameter("endereco");
String categoria = request.getParameter("categoria");
String preco = request.getParameter("preco");
String nome_vendedor = request.getParameter("nome_vendedor");
String telefone_vendedor = request.getParameter("telefone_vendedor");
String email_vendedor = request.getParameter("email_vendedor");
String status = request.getParameter("status");

// Par�metros de conex�o com o banco de dados
String dbUrl = "jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
String dbUser = "root";
String dbPassword = "";  // Define a senha do banco de dados

Connection conn = null;  // Vari�vel usada para representar a conex�o com o banco de dados. Inicialmente, ela � definida como null
PreparedStatement stmt = null;  // Usada para representar uma instru��o SQL precompilada

try {
    // Conecta ao banco de dados
    Class.forName("com.mysql.cj.jdbc.Driver");  //  Carrega dinamicamente o driver JDBC para o MySQL.
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);  // Conex�o com o banco de dados usando a URL, o nome de usu�rio e a senha fornecidos. 

    // Consulta SQL para inserir um novo registro
    String sql = "INSERT INTO imoveis (endereco, categoria, preco, nome_vendedor, telefone_vendedor, email_vendedor, status) VALUES (?, ?, ?, ?, ?, ?, ?)";  // Define uma consulta SQL parametrizada para inserir um novo registro na tabela imoveis.
    
    stmt = conn.prepareStatement(sql);  // Permite que sejam fornecidos valores para os par�metros da consulta de forma segura e eficiente.
    stmt.setString(1, endereco);
    stmt.setString(2, categoria);
    stmt.setBigDecimal(3, new BigDecimal(preco));
    stmt.setString(4, nome_vendedor);
    stmt.setString(5, telefone_vendedor);
    stmt.setString(6, email_vendedor);
    stmt.setString(7, status);

    // Executa a consulta SQL para inserir o novo registro
    int rowsAffected = stmt.executeUpdate();  // Executa a instru��o SQL no banco de dados e retorna o n�mero de linhas afetadas. No contexto de uma inser��o, rowsAffected indicar� quantas linhas foram inseridas no banco de dados.

    if (rowsAffected > 0) {  // Se pelo menos uma linha foi inserida com sucesso
        
        response.sendRedirect("painel.jsp"); // Registro foi adicionado com sucesso, e redirecionamento para p�gina painel.jsp
    } else {  // ssen�o, inser��o do registro falhou. E redireciona para p�gina inexistente (de erro).
        
        response.sendRedirect("your_failure_page.jsp");
    }

} catch (Exception e) {  // Excess�o, ent�o redireciona para p�gina de erro no registro
    e.printStackTrace();
    response.sendRedirect("your_error_page.jsp");
} finally {
    // Fecha os recursos
    try {
        if (stmt != null) {  // Verifica se o objeto stmt n�o � nulo antes de tentar fechar.
            stmt.close();  // fecha o objeto stmt.
        }
        if (conn != null) {  // Verifica se o objeto conex�o com banco de dados n�o � nulo antes de tentar fechar.
            conn.close();  // fecha o objeto conn.
        }
    } catch (SQLException e) {  // Se ocorrer uma exce��o do tipo SQLException durante a execu��o do bloco try, as informa��es detalhadas sobre essa exce��o ser�o impressas no console
        e.printStackTrace();
    }
}
%>
