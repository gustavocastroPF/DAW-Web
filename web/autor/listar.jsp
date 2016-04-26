
<%-- 
    Document   : listar
    Created on : 31/03/2016, 09:50:34
    Author     : gustavo

--%>

<%@page import="rs.com.xucro.modelo.Autor"%>
<%@page import="rs.com.xucro.dao.AutorDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="autorDao" scope="session" type="AutorDAO"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
    </head>
    <body>
        <a href="../index.jsp">Início</a>
        <h1>Autores</h1>
        <h2><%=autorDao.getMensagem()%></h2>
        <a href="ServletAutor?acao=incluir">Incluir</a>
        <table border="1">
            <thead><tr><th>ID</th><th>Nome</th><th>Login</th><th>Alterar</th><th>Excluir</th></tr></thead>
            <tbody>
                <%
                    for(Autor c : autorDao.getLista()){
                %>
                <tr>
                    <td><%=c.getId()%></td>
                    <td><%=c.getNome()%></td>
                    <td><%=c.getLogin()%></td>
                    
                    <td><a href="ServletAutor?acao=alterar&id=<%=c.getId()%>">Alterar</a></td>
                    <td><a href="ServletAutor?acao=excluir&id=<%=c.getId()%>">Excluir</a></td>
                </tr>
                
                <%
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
