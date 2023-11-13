<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String email = request.getParameter("email");
String senha = request.getParameter("senha");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
    Statement stmt = conn.createStatement();
    
    String verificarUsuario = "SELECT * FROM usuarios WHERE email=? AND senha=?";
    PreparedStatement ps = conn.prepareStatement(verificarUsuario);
    ps.setString(1, email);
    ps.setString(2, senha);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
 
       // Login bem-sucedido, defina a vari�vel de sess�o e redirecione para o painel
    String nomeUsuario = rs.getString("nome");
    session.setAttribute("nomeUsuario", nomeUsuario);
    response.sendRedirect("painel.jsp");
    } else {
        out.println("Login falhou. Verifique suas credenciais. <a href='login.jsp'>Tentar novamente</a>");
    }
    
    ps.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Erro: " + e.getMessage());
}
%>
