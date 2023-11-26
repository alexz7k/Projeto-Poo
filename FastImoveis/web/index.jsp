<%-- 
    Document   : index
    Created on : 11 de nov. de 2023, 00:48:54
    Author     : LGBadures
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"> <!-- CDN e Folha de esttilo (CSS) do Bootstrap -->

<section class="vh-100" style="background-color: #508bfc;"> <!-- Nesta linha, é realizada o início de sessão que apresentará o fundo da página 'index.jsp' como azul, cobrindo 100% do fundo da tela (background) -->
    <div class="container py-5 h-100">  <!-- Desta linha, até a linha 15, são inicializadas tags que definirão a altura e largura,formatação, estilo e responsividade do 'cartão' que aparecerá solicitando os dados de login na página 'index.jsp' -->
        <div class="row d-flex justify-content-center align-items-center h-100"> <!-- Contêiner que centraliza o conteúdo verticalmente e define um preenchimento -->
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">  <!-- Nesta linha, é realizada a formatação da responsividade conforme os tipos de telas -->
                <div class="card shadow-2-strong" style="border-radius: 1rem;">
                    <div class="card-body p-5 text-center">

                        <h3 class="mb-5">Entrar</h3> <!-- Linha que apresenta texto no início do 'cartão' -->
                        <form action="login_processar.jsp" method="post"> <!-- Desta linha até a linha 31, é inicializado o formulário que irá solicitar as informações de login; com esta linha, especificamente fazendo link com a página responsável por verificar as informações apresentadas, se estes são ou não iguais às informações cadastradas no banco de dados -->
                            <div class="form-outline mb-4">
                                <input type="email" id="typeEmailX-2" placeholder="Email" name="email" class="form-control form-control-lg" /> <!-- Apresenta campo para digitar email -->

                            </div>

                            <div class="form-outline mb-4">
                                <input type="password" placeholder="Senha:" id="typePasswordX-2"  name="senha" class="form-control form-control-lg" /> <!-- Apresenta campo para digitar senha -->

                            </div>

                            <button class="btn btn-primary btn-lg btn-block" type="submit">Login</button> <!-- Botão para o login-->

                        </form>

                        <div class="text-center">
                            <p>Não tem cadastro? <a href="registro.jsp">faça seu registro</a></p> <!-- Caso usuário não tenha sido cadastrado ainda, será apresentado link para a criação do cadastro -->
                           
                        </div>

                    </div>
                </div>
            </div><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script> <!-- Adicionar a parte JavaScript refenciada do Bootstrap -->
        </div>
    </div>
</section>