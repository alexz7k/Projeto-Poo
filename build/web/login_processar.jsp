<%@ page import="java.sql.*" %> <!-- Importa��o de classes SQL -->
<%@ page import="java.io.*" %> <!-- Importa��o de classes de entrada e sa�da de dados do java -->
<%
String email = request.getParameter("email"); //Declara��o de String email e requisi��o para 'pegar' o par�metro email
String senha = request.getParameter("senha"); //Declara��o de String senha e requisi��o para 'pegar' o par�metro senha

try { // Verifica��o dos dados fornecidos em 'index.jsp'
    Class.forName("com.mysql.cj.jdbc.Driver"); // Carrega driver JDBC para MySQL
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", ""); // Conex�o com banco de dados MySQL (PHPmyAdmin)
    Statement stmt = conn.createStatement(); // Cria declara��o para executar consultas SQL 
    
    String verificarUsuario = "SELECT * FROM usuarios WHERE email=? AND senha=?";  // (At� linha 16) Consulta se as informa��es fornecidas no login (email e senha) est�o de acordo com alguma informa��o no banco de dados
    PreparedStatement ps = conn.prepareStatement(verificarUsuario);
    ps.setString(1, email);
    ps.setString(2, senha);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) { // Verifica se o usu�rio foi encontrado no banco de dados
        String nomeUsuario = rs.getString("nome"); // Obt�m o nome do usu�ro
        session.setAttribute("nomeUsuario", nomeUsuario); // Carrega o nome do usu�rio para apresentar no projeto
        
        // Verifica se o usu�rio est� na conta de administrador
        if(email.equals("adminbr@gmail.com")) {  // Se o email do usu�rio for igual ao email de administrador, ent�o � redirecionado para 'painel.jsp'
            response.sendRedirect("painel.jsp"); 
        } else {  // Se o email for diferente do email de administrador, � redirecionado para 'users.jsp'
            response.sendRedirect("users.jsp");
        }
    } else { // Se o usu�rio n�o foi encontrado no banco de dados, aparece esta mensagem, para tentar novamente
        out.println("Login falhou. Verifique suas credenciais. <a href='login.jsp'>Tentar novamente</a>");
    }
    
    ps.close(); // At� linha 34, fecha os recursos do banco de dados
    stmt.close();
    conn.close();
} catch (Exception e) {  // Trata exce��o que ocorra durante o processo
    out.println("Erro: " + e.getMessage());
}
%>