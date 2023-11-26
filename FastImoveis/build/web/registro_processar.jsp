<%@ page import="java.sql.*" %>  <!-- Importa��o de classes SQL -->
<%@ page import="java.io.*" %>  <!-- Importa��o de classes de entrada e sa�da de dados do java -->
<%
String nome = request.getParameter("nome");  //Declara��o de String nome e requisi��o para 'pegar' o par�metro nome
String email = request.getParameter("email"); //Declara��o de String email e requisi��o para 'pegar' o par�metro email
String senha = request.getParameter("senha"); //Declara��o de String senha e requisi��o para 'pegar' o par�metro senha

try {  // Verifica��o dos dados fornecidos em 'registro.jsp'
    Class.forName("com.mysql.cj.jdbc.Driver");  // Carrega driver JDBC para MySQL
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");  // Conex�o com banco de dados MySQL (PHPmyAdmin)
    Statement stmt = conn.createStatement();  // Cria declara��o para executar consultas SQL
    
    // (At� linha 20) Verificar se o email j� est� em uso
    String verificaEmail = "SELECT * FROM usuarios WHERE email=?";
    PreparedStatement ps = conn.prepareStatement(verificaEmail);
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
        out.println("Email j� est� em uso. Escolha outro.");
    } else { // (At� linha 27) Se o email ainda n�o estiver em uso, os par�metros s�o adicionados e a conta � criada
        String inserirUsuario = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";  // Inserir na tabela 'usuarios' do banco de dados as informa��es fornecidas
        ps = conn.prepareStatement(inserirUsuario);  // Prepara a declara��o SQL para inserir um novo usu�rio no banco de dados
        ps.setString(1, nome);  // Define o primeiro par�metro da declara��o SQL (nome do usu�rio)
        ps.setString(2, email);  // Define o segundo par�metro da declara��o SQL (email do usu�rio)
        ps.setString(3, senha);  // Define o terceeiro par�metro da declara��o SQL (senha do usu�rio)
        ps.executeUpdate();  // Executa a atualiza��o no banco de dados (inser��o do novo usu�rio)
        out.println("Registro bem-sucedido. <a href='index.jsp'>Fa�a o login</a>");  // Exibe mensagem de sucesso e fornece um link para a p�gina de login
    }
      
    ps.close();  // At� linha 33, fecha os recursos do banco de dados
    stmt.close();
    conn.close();
} catch (Exception e) {  // Trata exce��o que ocorra durante o processo
    out.println("Erro: " + e.getMessage());
}
%>
