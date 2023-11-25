<%@ page import="java.sql.*" %>  <!-- Importa��o de classes SQL -->
<%@ page import="java.io.*" %>  <!-- Importa��o de classes de entrada e sa�da de dados do java -->

<!DOCTYPE html>
<html>
    <head>
        <title>FastIm�veis</title>  <!-- T�tulo da p�gina no navegador -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">  <!-- Inclui o arquivo CSS do Bootstrap para estiliza��o -->
        <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">  <!-- Inclui o arquivo CSS do DataTables Bootstrap para estiliza��o de tabelas -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />  <!-- Inclui o arquivo CSS do Font Awesome para �cones -->

        <!-- Defini��o de cores paras �cones de a��es (linha 21: Define o cursor como ponteiro ao passar sobre bot�es de �cones; linha 22: Adiciona uma transi��o suave de cor com dura��o de 0.2 segundos) -->
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
         String nomeUsuario = (String) session.getAttribute("nomeUsuario");  // Recupera o nome do usu�rio armazenado na sess�o
         if (nomeUsuario != null) {  // Verifica se o nome do usu�rio n�o � nulo (se o usu�rio est� autenticado)
    %>

    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>  <!-- Caminho para anexar o arquivo de cabe�alho com barra de navega��o -->
        <div class="container">

            <h2 class="mt-5">Listagem de Im�veis</h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
                Adicionar novo <!--********-->
            </button>

            <br>
            <br>

            <!-- Add Modal -->
            <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addModalLabel">Adicionar Novo Im�vel</h5>  <!-- T�tulo do modal -->
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>  <!-- Bot�o de fechar o modal -->
                        </div>
                        <div class="modal-body">
                            
                            <form method="post" action="addRecord.jsp">  <!-- Formul�rio para adicionar um novo im�vel, realizando chamada para o arquivo addRecord.jsp -->
                                <div class="mb-3">  <!-- Campos do formul�rio para inserir informa��es sobre o im�vel -->
                                    <label for="nome" class="form-label">Endere�o:</label>
                                    <input type="text" class="form-control" id="endereco" name="endereco">
                                </div>
                                <div class="mb-3">
                                    <label for="descricao" class="form-label">Categoria:</label>
                                    <select class="form-select" id="categoria" name="categoria">
                                        <option value="Casa">Casa</option>
                                        <option value="Apartamento">Apartamento</option>
                                        <option value="Kitnet">Kitnet</option>
                                        <option value="Sobrado">Sobrado</option>
                                        <option value="Mans�o">Mans�o</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="preco" class="form-label">Pre�o:</label>
                                    <input type="text" class="form-control" id="preco" name="preco">
                                </div>
                                <div class="mb-3">
                                    <label for="nome_vendedor" class="form-label">Nome do Vendedor (Propriet�rio):</label>
                                    <textarea class="form-control" id="nome_vendedor" name="nome_vendedor" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="telefone_vendedor" class="form-label">Telefone do Vendedor (Propriet�rio):</label>
                                    <textarea class="form-control" id="telefone_vendedor" name="telefone_vendedor" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="email_vendedor" class="form-label">Email do Vendedor (Propriet�rio):</label>
                                    <textarea class="form-control" id="email_vendedor" name="email_vendedor" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="descricao" class="form-label">Status:</label>
                                    <select class="form-select" id="status" name="status">
                                        <option value="�_venda">� venda</option>
                                        <option value="alugar">alugar</option>
                                    </select>
                                </div>
                                
                                <button type="submit" class="btn btn-primary">Adicionar</button>  <!-- Bot�o para adicionar -->
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <table id="imoveisTable" class="table table-striped">  <!-- Tabela HTML para exibir a lista de im�veis -->
                <thead>  <!-- Cabe�alho da tabela com os nomes das colunas -->
                    <tr>  
                        <th>ID</th>
                        <th>Endere�o</th>
                        <th>Categoria</th>
                        <th>Pre�o</th>
                        <th>Nome do Vendedor</th>
                        <th>Telefone do Vendedor</th>
                        <th>Email do Vendedor</th>
                        <th>Status</th>
                        <th>A��es</th>
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
                    <tr>  <!-- Linha da tabela com os dados de um im�vel -->
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("endereco") %></td>
                        <td><%= rs.getString("categoria") %></td>
                        <td><%= rs.getBigDecimal("preco").toString() %></td>
                        <td><%= rs.getString("nome_vendedor") %></td>
                        <td><%= rs.getString("telefone_vendedor") %></td>
                        <td><%= rs.getString("email_vendedor") %></td>
                        <td><%= rs.getString("status") %></td>
                        <td> <!-- �cones para editar e excluir um registro -->
                            <i class="edit-icon icon-button" data-bs-toggle="modal" data-bs-target="#editModal<%= rs.getInt("id") %>">
                                <i class="fas fa-edit"></i>
                            </i>

                            <i class="delete-icon" type="button" class="btn btn-icon btn-danger" onclick="deleteRecord(<%= rs.getInt("id") %>)">
                                <i class="fas fa-trash"></i>
                            </i>

                        </td>
                    </tr>

                    <!-- Delete Modal -->
                <div class="modal fade" id="deleteModal<%= rs.getInt("id") %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= rs.getInt("id") %>" aria-hidden="true">  <!-- Modal para confirmar a exclus�o de um registro -->
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteModalLabel<%= rs.getInt("id") %>">Confirm Deletion</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to delete this record?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>

                            </div>
                        </div>
                    </div>
                </div>

                <!-- Edit Modal -->
                <div class="modal fade" id="editModal<%= rs.getInt("id") %>" tabindex="-1" aria-labelledby="editModalLabel<%= rs.getInt("id") %>" aria-hidden="true">  <!-- Modal para editar um registro -->
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel<%= rs.getInt("id") %>">Edit Record</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                
                                <form method="post" action="editRecord.jsp">  <!-- Formul�rio para editar os detalhes do registro -->
                                    
                                    <input type="hidden" name="recordId" value="<%= rs.getInt("id") %>">  <!-- Input hidden para armazenar o ID do registro sendo editado -->
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address:</label>
                                        <input type="text" class="form-control" id="address" name="address" value="<%= rs.getString("endereco") %>">
                                    </div>
                                    <!-- Add more input fields as needed for editing -->
                                    <div class="mb-3">
                                        <label for="category" class="form-label">Category:</label>
                                        <input type="text" class="form-control" id="category" name="category" value="<%= rs.getString("categoria") %>">
                                    </div>
                                    <div class="mb-3">
                                        <label for="price" class="form-label">Price:</label>
                                        <input type="text" class="form-control" id="price" name="price" value="<%= rs.getBigDecimal("preco") %>">
                                    </div>
                                    <div class="mb-3">
                                        <label for="sallerName" class="form-label">Saller Name:</label>
                                        <input type="text" class="form-control" id="sallerName" name="sallerName" value="<%= rs.getString("nome_vendedor") %>">
                                    </div>
                                    <div class="mb-3">
                                        <label for="sallerPhone" class="form-label">saller Phone:</label>
                                       <input type="text" class="form-control" id="sallerPhone" name="sallerPhone" value="<%= rs.getString("telefone_vendedor") %>">
                                    </div>
                                    <div class="mb-3">
                                        <label for="sallerEmail" class="form-label">Saller Email:</label>
                                        <input type="email" class="form-control" id="sallerEmail" name="sallerEmail" value="<%= rs.getString("email_vendedor") %>">
                                    </div>
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Status:</label>
                                        <input type="text" class="form-control" id="status" name="status" value="<%= rs.getString("status") %>">
                                    </div>
                                    
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <%
                    }  
                    rs.close();  // Fecha o ResultSet (conjunto de resultados)
                    stmt.close();  // Fecha o Statement (declara��o SQL)
                    conn.close();  // Fecha a Connection (conex�o com o banco de dados)
                } catch (Exception e) {  // Imprime informa��es detalhadas sobre a exce��o no console
                    e.printStackTrace();
                }
                %>
                </tbody>
            </table>
    
            <%
            } else {  // Se o usu�rio n�o est� autenticado, aparecer� a seguite mensagem
            %>
            <p class="mt-3">Voc� n�o est� autenticado. Por favor, fa�a login <a href='login.jsp'>aqui</a>.</p>
            <%
            }
            %>

        </div>

        <script>
            
            function deleteRecord(recordId) {  // Para deletar registros
                if (confirm("Are you sure you want to delete this record?")) {
                    $.ajax({
                        type: "POST",
                        url: "deleteRecord.jsp",
                        data: {recordId: recordId},
                        success: function (data) {
                            // Lida com a resposta (por exemplo, exibe uma mensagem de sucesso ou atualiza a p�gina)

                            location.reload(); // Atualiza a p�gina
                        }
                    });
                }
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>  <!-- Inclui a biblioteca jQuery -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>  <!-- Inclui o plugin DataTables -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>  <!-- Inclui a biblioteca Bootstrap JavaScript -->
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>  <!-- Inclui o estilo Bootstrap para DataTables -->
        <script src="https://cdn.datatables.net/plug-ins/1.10.25/i18n/Portuguese-Brasil.json"></script>  <!-- Configura��o de idioma para DataTables -->
        <script>
            $(document).ready(function () {
                $('#imoveisTable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.25/i18n/Portuguese-Brasil.json"  // Configura��o de idioma para DataTables
                    },
                    "responsive": true  // Torna a tabela responsiva
                });
            });
        </script>
    </body>
</html>
