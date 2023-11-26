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
        <title>FastImóveis</title>  <!-- Título da página no navegador -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">  <!-- Inclui o arquivo CSS do Bootstrap para estilização -->
        <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">  <!-- Inclui o arquivo CSS do DataTables Bootstrap para estilização de tabelas -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />  <!-- Inclui o arquivo CSS do Font Awesome para ícones -->

        <!-- Definição de cores paras ícones de ações (linha 21: Define o cursor como ponteiro ao passar sobre botões de ícones; linha 22: Adiciona uma transição suave de cor com duração de 0.2 segundos) -->
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
         String nomeUsuario = (String) session.getAttribute("nomeUsuario");  // Recupera o nome do usuário armazenado na sessão
         if (nomeUsuario != null) {  // Verifica se o nome do usuário não é nulo (se o usuário está autenticado)
    %>

    <body>
        <%
         nomeUsuario = (String) session.getAttribute("nomeUsuario");
         if (!nomeUsuario.equals("admin")) {
    %>
       
    <%@include file="WEB-INF/jspf/header2.jspf" %>  <!-- Caminho para anexar o arquivo de cabeçalho com barra de navegação -->
        <div class="container">

            <h2 class="mt-5">Listagem de Imóveis</h2>
            
            <table id="imoveisTable" class="table table-striped">  <!-- Tabela HTML para exibir a lista de imóveis -->
                <thead>  <!-- Cabeçalho da tabela com os nomes das colunas -->
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
                    <%  // Script JavaServer Pages (JSP) que acessa o banco de dados para obter a lista de registros
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                        Statement stmt = conn.createStatement();
                        String query = "SELECT * FROM imoveis";
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) {  // Loop para iterar sobre os resultados da consulta e exibir os dados na tabela
                    %>
                    <tr>  <!-- Linha da tabela com os dados de um imóvel -->
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
                    rs.close();  // Fecha o ResultSet (conjunto de resultados)
                    stmt.close();  // Fecha o Statement (declaração SQL)
                    conn.close();  // Fecha a Connection (conexão com o banco de dados)
                } catch (Exception e) {  // Imprime informações detalhadas sobre a exceção no console
                    e.printStackTrace();
                }
                %>
                </tbody>
                
            </table>
                <%
            } else {
            %>
            <%@include file="WEB-INF/jspf/header.jspf" %>  <!-- Caminho para anexar o arquivo de cabeçalho com barra de navegação -->
            <div class="container">

            <h2 class="mt-5">Listagem de Imóveis</h2>
            
            <table id="imoveisTable" class="table table-striped">  <!-- Tabela HTML para exibir a lista de imóveis -->
                <thead>  <!-- Cabeçalho da tabela com os nomes das colunas -->
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
                    <%  // Script JavaServer Pages (JSP) que acessa o banco de dados para obter a lista de registros
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
                        Statement stmt = conn.createStatement();
                        String query = "SELECT * FROM imoveis";
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) {  // Loop para iterar sobre os resultados da consulta e exibir os dados na tabela
                    %>
                    <tr>  <!-- Linha da tabela com os dados de um imóvel -->
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
                    rs.close();  // Fecha o ResultSet (conjunto de resultados)
                    stmt.close();  // Fecha o Statement (declaração SQL)
                    conn.close();  // Fecha a Connection (conexão com o banco de dados)
                } catch (Exception e) {  // Imprime informações detalhadas sobre a exceção no console
                    e.printStackTrace();
                }
                %>
                </tbody>
                
            </table>
            
            <%
            }
            %>
            
            <%
            } else {  // Se o usuário não está autenticado, aparecerá a seguite mensagem
            %>
            <p class="mt-3">Você não está autenticado. Por favor, faça login <a href='login.jsp'>aqui</a>.</p>
            <%
            }
            %>

        </div>

        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>  <!-- Inclui a biblioteca jQuery -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>  <!-- Inclui o plugin DataTables -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>  <!-- Inclui a biblioteca Bootstrap JavaScript -->
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>  <!-- Inclui o estilo Bootstrap para DataTables -->
        <script src="https://cdn.datatables.net/plug-ins/1.10.25/i18n/Portuguese-Brasil.json"></script>  <!-- Configuração de idioma para DataTables -->
        <script>
            $(document).ready(function () {
                $('#imoveisTable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Portuguese-Brasil.json"  // Configuração de idioma para DataTables
                    },
                    "responsive": true  // Torna a tabela responsiva
                });
            });
        </script>
    </body>
</html>