<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"> <!-- CDN e Folha de esttilo (CSS) do Bootstrap -->

<section class="vh-100" style="background-color: #508bfc;"> <!-- Nesta linha, é realizada o início de sessão que apresentará o fundo da página 'registro.jsp' como uma cor de tom azul, cobrindo 100% do fundo da tela (background) -->
    <div class="container py-5 h-100"> <!-- Contêiner que centraliza o conteúdo verticalmente e define um preenchimento -->
        <div class="row d-flex justify-content-center align-items-center h-100"> <!-- Linha que centraliza e alinha verticalmente os elementos -->
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">  <!-- Coluna que define a largura do formulário em diferentes tamanhos de tela -->
                <div class="card shadow-2-strong" style="border-radius: 1rem;">  <!-- Card Bootstrap com sombra e bordas arredondadas -->
                    <div class="card-body p-5 text-center"> <!-- Corpo do card com preenchimento e alinhamento centralizado -->

                        <h3 class="mb-5">Registrar</h3> <!-- Linha que apresenta texto no início do 'cartão' -->
                        <form action="registro_processar.jsp" method="post"> <!-- Desta linha até a linha 30, é inicializado o formulário que irá solicitar as informações de registro (cadastro); com esta linha, especificamente fazendo link com a página responsável por inserir as informações cadastradas no banco de dados -->
                            
                            <div class="form-outline mb-4">
                                <input type="text" id="name" placeholder="Nome" name="nome" class="form-control form-control-lg" />  <!-- Apresenta campo para digitar nome que será utilizado na sessão do usuário -->

                            </div>
                            
                               <div class="form-outline mb-4">
                                <input type="email" id="typeEmailX-2" placeholder="Email" name="email" class="form-control form-control-lg" /> <!-- Apresenta campo para digitar nome que será utilizado na sessão do usuário -->

                            </div>

                            <div class="form-outline mb-4">
                                <input type="password" placeholder="Senha:" id="typePasswordX-2"  name="senha" class="form-control form-control-lg" /> <!-- Apresenta campo para digitar nome que será utilizado na sessão do usuário -->

                            </div>

                            <button class="btn btn-primary btn-lg btn-block" type="submit">Registrar</button> <!-- Botão para o registro de informações fornecidas-->

                        </form>

                    </div>
                </div>
            </div><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>  <!-- Adicionar a parte JavaScript refenciada do Bootstrap -->
        </div>
    </div>
</section>