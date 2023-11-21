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

    <!-- Navbar -->  <!-- alterar navbar, para que seja possível a funcionalidade -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <!-- Container wrapper -->
        <div class="container-fluid">
            <!-- Toggle button -->
            <button
                class="navbar-toggler"
                type="button"
                data-mdb-toggle="collapse"
                data-mdb-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent"
                aria-expanded="false"
                aria-label="Toggle navigation"
                >
                <i class="fas fa-bars"></i>
            </button>

            <!-- Collapsible wrapper -->
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <!-- Navbar brand -->
                <a class="navbar-brand mt-2 mt-lg-0" href="#">
                    <img
                        src="https://mdbcdn.b-cdn.net/img/logo/mdb-transaprent-noshadows.webp"
                        height="15"
                        alt="MDB Logo"
                        loading="lazy"
                        />
                </a>
                <!-- Left links -->
              
                <!-- Left links -->
            </div>
            <!-- Collapsible wrapper -->

            <!-- Right elements -->
            <div class="d-flex align-items-center">
                <!-- Icon -->
                <a class="text-reset me-3" href="#">
                    <i class="fas fa-shopping-cart"></i>
                </a>
               
                <div class="dropdown">
                    <a>
                        <h5 class="mt-3" style="color: white;">Bem-vindo, <%= nomeUsuario %>!</h5>

                    </a>
                       
                <div class="ms-3">
        <a href="logout.jsp" class="btn btn-outline-light">Logout</a>
    </div>
            <!-- Right elements -->
        </div>
        <!-- Container wrapper -->
    </nav>
    <!-- Navbar -->

    <body>
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
