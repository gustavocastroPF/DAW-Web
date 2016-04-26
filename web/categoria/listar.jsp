
<%-- 
    Document   : listar
    Created on : 31/03/2016, 09:50:34
    Author     : gustavo

--%>

<%@page import="rs.com.xucro.modelo.Categoria"%>
<%@page import="rs.com.xucro.dao.CategoriaDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="categoriaDao" scope="session" type="CategoriaDAO"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
    </head>
    <body>
        <a href="../index.jsp">Início</a>
        <h1>Categorias</h1>
        <h2><%=categoriaDao.getMensagem()%></h2>
        <a href="ServletCategoria?acao=incluir">Incluir</a>
        <table border="1">
            <thead><tr><th>ID</th><th>Nome</th><th>UF</th><th>Alterar</th><th>Excluir</th></tr></thead>
            <tbody>
                <%
                    for(Categoria c : categoriaDao.getLista()){
                %>
                <tr>
                    <td><%=c.getId()%></td>
                    <td><%=c.getNome()%></td>
                    
                    <td><a href="ServletCategoria?acao=alterar&id=<%=c.getId()%>">Alterar</a></td>
                    <td><a href="ServletCategoria?acao=excluir&id=<%=c.getId()%>">Excluir</a></td>
                </tr>
                
                <%
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
