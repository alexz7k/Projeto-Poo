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
                            <h5 class="modal-title" id="addModalLabel">Adicionar Novo Imóvel</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Add form fields here to input a new food item -->
                            <form method="post" action="addRecord.jsp">
                                <div class="mb-3">
                                    <label for="nome" class="form-label">Endereço:</label>
                                    <input type="text" class="form-control" id="endereco" name="endereco">
                                </div>
                                <div class="mb-3">
                                    <label for="descricao" class="form-label">Categoria:</label>
                                    <select class="form-select" id="categoria" name="categoria">
                                        <option value="Casa">Casa</option>
                                        <option value="Apartamento">Apartamento</option>
                                        <option value="Kitnet">Kitnet</option>
                                        <option value="Sobrado">Sobrado</option>
                                        <option value="Mansão">Mansão</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="preco" class="form-label">Preço:</label>
                                    <input type="text" class="form-control" id="preco" name="preco">
                                </div>
                                <div class="mb-3">
                                    <label for="nome_vendedor" class="form-label">Nome do Vendedor (Proprietário):</label>
                                    <textarea class="form-control" id="nome_vendedor" name="nome_vendedor" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="telefone_vendedor" class="form-label">Telefone do Vendedor (Proprietário):</label>
                                    <textarea class="form-control" id="telefone_vendedor" name="telefone_vendedor" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="email_vendedor" class="form-label">Email do Vendedor (Proprietário):</label>
                                    <textarea class="form-control" id="email_vendedor" name="email_vendedor" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="descricao" class="form-label">Status:</label>
                                    <select class="form-select" id="status" name="status">
                                        <option value="à_venda">à venda</option>
                                        <option value="alugar">alugar</option>
                                    </select>
                                </div>
                                
                                <button type="submit" class="btn btn-primary">Adicionar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

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
                        <td>
                            <i class="edit-icon icon-button" data-bs-toggle="modal" data-bs-target="#editModal<%= rs.getInt("id") %>">
                                <i class="fas fa-edit"></i>
                            </i>

                            <i class="delete-icon" type="button" class="btn btn-icon btn-danger" onclick="deleteRecord(<%= rs.getInt("id") %>)">
                                <i class="fas fa-trash"></i>
                            </i>

                        </td>
                    </tr>

                    <!-- Delete Modal -->
                <div class="modal fade" id="deleteModal<%= rs.getInt("id") %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= rs.getInt("id") %>" aria-hidden="true">
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
                <div class="modal fade" id="editModal<%= rs.getInt("id") %>" tabindex="-1" aria-labelledby="editModalLabel<%= rs.getInt("id") %>" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel<%= rs.getInt("id") %>">Edit Record</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Add form fields here to edit the record -->
                                <form method="post" action="editRecord.jsp">
                                    <!-- You can populate this form with data from the current row -->
                                    <input type="hidden" name="recordId" value="<%= rs.getInt("id") %>">
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

        <script>
            
            function deleteRecord(recordId) {
                if (confirm("Are you sure you want to delete this record?")) {
                    $.ajax({
                        type: "POST",
                        url: "deleteRecord.jsp",
                        data: {recordId: recordId},
                        success: function (data) {
                            // Handle the response (e.g., show a success message or refresh the page)
                            // You can also use JavaScript to hide the modal after a successful delete.

                            location.reload(); // Refresh the page
                        }
                    });
                }
            }
        </script>

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
