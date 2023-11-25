<%@ page import="java.sql.*" %> <!-- Importação de classes SQL -->
<%@ page import="java.io.*" %> <!-- Importação de classes de entrada e saída de dados do java -->
<%
String email = request.getParameter("email"); //Declaração de String email e requisição para 'pegar' o parâmetro email
String senha = request.getParameter("senha"); //Declaração de String senha e requisição para 'pegar' o parâmetro senha

try { // Verificação dos dados fornecidos em 'index.jsp'
    Class.forName("com.mysql.cj.jdbc.Driver"); // Carrega driver JDBC para MySQL
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", ""); // Conexão com banco de dados MySQL (PHPmyAdmin)
    Statement stmt = conn.createStatement(); // Cria declaração para executar consultas SQL 
    
    String verificarUsuario = "SELECT * FROM usuarios WHERE email=? AND senha=?";  // (Até linha 16) Consulta se as informações fornecidas no login (email e senha) estão de acordo com alguma informação no banco de dados
    PreparedStatement ps = conn.prepareStatement(verificarUsuario);
    ps.setString(1, email);
    ps.setString(2, senha);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) { // Verifica se o usuário foi encontrado no banco de dados
        String nomeUsuario = rs.getString("nome"); // Obtém o nome do usuáro
        session.setAttribute("nomeUsuario", nomeUsuario); // Carrega o nome do usuário para apresentar no projeto
        
        // Verifica se o usuário está na conta de administrador
        if(email.equals("adminbr@gmail.com")) {  // Se o email do usuário for igual ao email de administrador, então é redirecionado para 'painel.jsp'
            response.sendRedirect("painel.jsp"); 
        } else {  // Se o email for diferente do email de administrador, é redirecionado para 'users.jsp'
            response.sendRedirect("users.jsp");
        }
    } else { // Se o usuário não foi encontrado no banco de dados, aparece esta mensagem, para tentar novamente
        out.println("Login falhou. Verifique suas credenciais. <a href='login.jsp'>Tentar novamente</a>");
    }
    
    ps.close(); // Até linha 34, fecha os recursos do banco de dados
    stmt.close();
    conn.close();
} catch (Exception e) {  // Trata exceção que ocorra durante o processo
    out.println("Erro: " + e.getMessage());
}
%>