<%@ page import="java.sql.*, java.math.BigDecimal, java.util.Random" %>

<%
// Retrieve form data from request
String endereco = request.getParameter("endereco");
String categoria = request.getParameter("categoria");
String preco = request.getParameter("preco");
String nome_vendedor = request.getParameter("nome_vendedor");
String telefone_vendedor = request.getParameter("telefone_vendedor");
String email_vendedor = request.getParameter("email_vendedor");
String status = request.getParameter("status");

// Database connection parameters
String dbUrl = "jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
String dbUser = "root";
String dbPassword = "";

Connection conn = null;
PreparedStatement stmt = null;

try {
    // Connect to the database
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    // SQL query to insert a new record
    String sql = "INSERT INTO imoveis (endereco, categoria, preco, nome_vendedor, telefone_vendedor, email_vendedor, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
    
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, endereco);
    stmt.setString(2, categoria);
    stmt.setBigDecimal(3, new BigDecimal(preco));
    stmt.setString(4, nome_vendedor);
    stmt.setString(5, telefone_vendedor);
    stmt.setString(6, email_vendedor);
    stmt.setString(7, status);

    // Execute the SQL query to insert the new record
    int rowsAffected = stmt.executeUpdate();

    if (rowsAffected > 0) {
        // Record was successfully added
        response.sendRedirect("painel.jsp");
    } else {
        // Record insertion failed
        response.sendRedirect("your_failure_page.jsp");
    }

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("your_error_page.jsp");
} finally {
    // Close resources
    try {
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
