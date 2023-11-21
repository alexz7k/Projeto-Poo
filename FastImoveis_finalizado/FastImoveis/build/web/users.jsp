<%-- 
    Document   : users
    Created on : 12 de nov. de 2023, 01:41:59
    Author     : LGBadures
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>FastImóveis</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>.edit-icon {
                color: blue;
            }

            .delete-icon {
                color: red;
            }
            .icon-button {
                cursor: pointer;
                transition: color 0.2s;
            }
        </style>

    </head>
    <%
         String nomeUsuario = (String) session.getAttribute("nomeUsuario");
         if (nomeUsuario != null) {
    %>

    <body>
        <%
         nomeUsuario = (String) session.getAttribute("nomeUsuario");
         if (!nomeUsuario.equals("admin")) {
    %>
       
    <%@include file="WEB-INF/jspf/header2.jspf" %>
        <div class="container">

            <h2 class="mt-5">Listagem de Imóveis</h2>
            
            <table id="imoveisTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Endereço</th>
                        <th>Categoria</th>
                        <th>Preço</th>
                        <th>Nome do Vendedor</th>
                        <th>Telefone do Vendedor</th>
                        <th>Email do Vendedor</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                        Statement stmt = conn.createStatement();
                        String query = "SELECT * FROM imoveis";
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("endereco") %></td>
                        <td><%= rs.getString("categoria") %></td>
                        <td><%= rs.getBigDecimal("preco").toString() %></td>
                        <td><%= rs.getString("nome_vendedor") %></td>
                        <td><%= rs.getString("telefone_vendedor") %></td>
                        <td><%= rs.getString("email_vendedor") %></td>
                        <td><%= rs.getString("status") %></td>
                        
                    </tr>

                <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
                </tbody>
                
            </table>
                <%
            } else {
            %>
            <%@include file="WEB-INF/jspf/header.jspf" %>
            <div class="container">

            <h2 class="mt-5">Listagem de Imóveis</h2>
            
            <table id="imoveisTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Endereço</th>
                        <th>Categoria</th>
                        <th>Preço</th>
                        <th>Nome do Vendedor</th>
                        <th>Telefone do Vendedor</th>
                        <th>Email do Vendedor</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                        Statement stmt = conn.createStatement();
                        String query = "SELECT * FROM imoveis";
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("endereco") %></td>
                        <td><%= rs.getString("categoria") %></td>
                        <td><%= rs.getBigDecimal("preco").toString() %></td>
                        <td><%= rs.getString("nome_vendedor") %></td>
                        <td><%= rs.getString("telefone_vendedor") %></td>
                        <td><%= rs.getString("email_vendedor") %></td>
                        <td><%= rs.getString("status") %></td>
                        
                    </tr>

                <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
                </tbody>
                
            </table>
            
            <%
            }
            %>
            
            <%
            } else {
            %>
            <p class="mt-3">Você não está autenticado. Por favor, faça login <a href='login.jsp'>aqui</a>.</p>
            <%
            }
            %>

        </div>

        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
        <script src="https://cdn.datatables.net/plug-ins/1.10.25/i18n/Portuguese-Brasil.json"></script>
        <script>
            $(document).ready(function () {
                $('#imoveisTable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Portuguese-Brasil.json"
                    },
                    "responsive": true
                });
            });
        </script>
    </body>
</html>