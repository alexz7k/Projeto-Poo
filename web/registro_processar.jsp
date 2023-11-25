<%@ page import="java.sql.*" %>  <!-- Importação de classes SQL -->
<%@ page import="java.io.*" %>  <!-- Importação de classes de entrada e saída de dados do java -->
<%
String nome = request.getParameter("nome");  //Declaração de String nome e requisição para 'pegar' o parâmetro nome
String email = request.getParameter("email"); //Declaração de String email e requisição para 'pegar' o parâmetro email
String senha = request.getParameter("senha"); //Declaração de String senha e requisição para 'pegar' o parâmetro senha

try {  // Verificação dos dados fornecidos em 'registro.jsp'
    Class.forName("com.mysql.cj.jdbc.Driver");  // Carrega driver JDBC para MySQL
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");  // Conexão com banco de dados MySQL (PHPmyAdmin)
    Statement stmt = conn.createStatement();  // Cria declaração para executar consultas SQL
    
    // (Até linha 20) Verificar se o email já está em uso
    String verificaEmail = "SELECT * FROM usuarios WHERE email=?";
    PreparedStatement ps = conn.prepareStatement(verificaEmail);
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
        out.println("Email já está em uso. Escolha outro.");
    } else { // (Até linha 27) Se o email ainda não estiver em uso, os parâmetros são adicionados e a conta é criada
        String inserirUsuario = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";  // Inserir na tabela 'usuarios' do banco de dados as informações fornecidas
        ps = conn.prepareStatement(inserirUsuario);  // Prepara a declaração SQL para inserir um novo usuário no banco de dados
        ps.setString(1, nome);  // Define o primeiro parâmetro da declaração SQL (nome do usuário)
        ps.setString(2, email);  // Define o segundo parâmetro da declaração SQL (email do usuário)
        ps.setString(3, senha);  // Define o terceeiro parâmetro da declaração SQL (senha do usuário)
        ps.executeUpdate();  // Executa a atualização no banco de dados (inserção do novo usuário)
        out.println("Registro bem-sucedido. <a href='index.jsp'>Faça o login</a>");  // Exibe mensagem de sucesso e fornece um link para a página de login
    }
      
    ps.close();  // Até linha 33, fecha os recursos do banco de dados
    stmt.close();
    conn.close();
} catch (Exception e) {  // Trata exceção que ocorra durante o processo
    out.println("Erro: " + e.getMessage());
}
%>
