<%@ page import="java.sql.*" %> //todos os comandos em mysql 
<%@ page import="java.io.*" %>  //todos os comandos de entrada e saida de dados
<%@ page contentType="application/json" %>//aplicaçao json/aplicaçao dados armazenados em json
<%@ page language="java" %> //falando sobre a linguagem

<%
    Connection conn = null; //definindo as variaveis em banco de dados como NULL para ser inicializada
    PreparedStatement preparedStatement = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");   //try- classforname carrega o drive jdbc do mySQL 
        conn = DriverManager.getConnection("jdbc:mysql://localhost/fastimoveis?useUnicode=true&characterEncoding=UTF-8", "root", "");
        //Inicializaçao da conexao com banco de dados/ metodo get que e responsavel para pegar a conexao com o BD

        String recordIdStr = request.getParameter("recordId"); //declarando uma variavel de id,´pois ira ter uma requisiçao para pegar o parametro(dados) em outras paginas
        if (recordIdStr != null) { //if se tiver dado para ser editado, ele disponibiliza a ediçao
            int recordId = Integer.parseInt(recordIdStr); //ta convertendo para int

            // Obter os dados do formulário
            String endereco = request.getParameter("endereco");// declaraçao de variaveis para fazer requisiçao dos parametros no projeto
            String categoria = request.getParameter("categoria");
            

            // Verificar se os campos obrigatórios estão presentes
            if (endereco != null && categoria != null) {  //if(esta verificando se tem algum dado presente no campo,se tiver ele disponibiliza a ediçao
                // Atualizar o registro no banco de dados
                String updateQuery = "UPDATE imoveis SET endereco=?, categoria=? WHERE id=?"; //declarando uma variavel de atualizaçao/ comando de atualizaçao
                preparedStatement = conn.prepareStatement(updateQuery); //começa a alteraçao dos dados ate a linha 31
                preparedStatement.setString(1, endereco);
                preparedStatement.setString(2, categoria);
                preparedStatement.setInt(3, recordId); //obtém o parâmetro "recordId" da solicitação HTTP(parametro do id) ver qual id sera substituido

                // Execute a consulta preparada
                int rowsUpdated = preparedStatement.executeUpdate();

                // Verificar se a atualização foi bem-sucedida
                if (rowsUpdated > 0) {
                //Se a atualização for bem-sucedida, imprime uma mensagem JSON de sucesso
                    out.println("{\"success\": true, \"message\": \"Record updated successfully!\"}");

                      // Adicionar redirecionamento para a página 'painel.jsp'
                    response.sendRedirect("painel.jsp"); //se a informaçao for alterada com sucesso sera redirecionado a pagina de painel
                } else { // Se na for atualização, imprime uma mensagem de falha
                    out.println("{\"success\": false, \"message\": \"Failed to update the record.\"}");
                }
            } else {// Se tiver faltando dado, imprime uma mensagem indicando a falta desses campos
                out.println("{\"success\": false, \"message\": \"Missing required fields.\"}");
            }
        } else {// Se o 'id' no banco de dados não estiver presente na solicitação, imprime uma mensagem indicando um ID de registro inválido
            out.println("{\"success\": false, \"message\": \"Invalid record ID.\"}");
        }
    } catch (Exception e) {  // Se qualquer exceção ocorrer durante a execução do código no bloco try, captura a exceção e imprime uma mensagem de erro em formato JSON
        out.println("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
    } finally {
        try { // Garantir que os recursos (PreparedStatement e Connection) sejam fechados mesmo se ocorrer uma exceção
        if (preparedStatement != null) { // se for executada sera fechada
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (conn != null) {// se for executada sera fechada
                conn.close();
            }
        } catch (SQLException e) {  // Em caso de exceção ao fechar os recursos, imprime o rastreamento da exceção
            e.printStackTrace();
        }
    }
%>
