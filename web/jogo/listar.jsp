<%@page import="rs.com.xucro.modelo.Jogo"%>
<%@page import="rs.com.xucro.dao.JogoDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="jogoDao" scope="session"
             type="JogoDAO"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de Jogos</title>
    </head>
    <body>
        <a href="../index.jsp">Início</a>
        <h1>Jogos</h1>
        <h2><%=jogoDao.getMensagem()%></h2>
        <a href="ServletJogo?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Categoria</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Jogo e : jogoDao.getLista()) {
                %>
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getNome()%></td>
                    <td><%=e.getCategoria().getNome()%></td>
                    <td><a href="ServletJogo?acao=alterar&id=<%=e.getId()%>">Alterar</a></td>
                    <td><a href="ServletJogo?acao=excluir&id=<%=e.getId()%>">Excluir</a></td>
                </tr>
                <%
                    }
                %>    
            </tbody>
        </table>
    </body>
</html>
