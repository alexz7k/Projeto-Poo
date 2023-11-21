<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
String nome = request.getParameter("nome");
String email = request.getParameter("email");
String senha = request.getParameter("senha");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
    Statement stmt = conn.createStatement();
    
    // Verificar se o email já está em uso
    String verificaEmail = "SELECT * FROM usuarios WHERE email=?";
    PreparedStatement ps = conn.prepareStatement(verificaEmail);
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
        out.println("Email já está em uso. Escolha outro.");
    } else {
        String inserirUsuario = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";
        ps = conn.prepareStatement(inserirUsuario);
        ps.setString(1, nome);
        ps.setString(2, email);
        ps.setString(3, senha);
        ps.executeUpdate();
        out.println("Registro bem-sucedido. <a href='index.jsp'>Faça o login</a>");
    }
    
    ps.close();
    stmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Erro: " + e.getMessage());
}
%>
