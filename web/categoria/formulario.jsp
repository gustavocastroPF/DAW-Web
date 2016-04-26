<%-- 
    Document   : formulario
    Created on : 31/03/2016, 10:00:11
    Author     : gustavo
--%>

<%@page import="rs.com.xucro.dao.CategoriaDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="categoriaDao" scope="session" type="CategoriaDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Categorias</title>
        <script>
            
            function doSalvar(){
                document.getElementById("acao").value="salvar";
                document.getElementById("form").submit();
            }
            function doCancelar(){
                document.getElementById("acao").value="cancelar";
                document.getElementById("form").submit();
            }
            
            
        </script>
    </head>
    <body>
        <h1>Edição de Categoria</h1>
        <h2> <%=categoriaDao.getMensagem() %></h2>
        <form name="form" id="form" action="ServletCategoria" method="GET">
            Codigo: <input type="text" name="id" value="<%=categoriaDao.getObjetoSelecionado().getId()==null?"":categoriaDao.getObjetoSelecionado().getId()%>"/><br/>
            Nome: <input type="text" name="nome" value="<%=categoriaDao.getObjetoSelecionado().getNome()==null?"":categoriaDao.getObjetoSelecionado().getNome()%>"/><br/>
            Descrição: <input type="text" name="descricao" value="<%=categoriaDao.getObjetoSelecionado().getDescricao()==null?"":categoriaDao.getObjetoSelecionado().getDescricao()%>"/><br/>
            Caminho da imagem: <input type="text" name="imagem" value="<%=categoriaDao.getObjetoSelecionado().getImagem()==null?"":categoriaDao.getObjetoSelecionado().getImagem()%>"/><br/>
            <%
                if (categoriaDao.getObjetoSelecionado().isStatus() == true) {
            %>
            Status: <input type="checkbox" name="status" checked=""/> <br/>       
            <%
            } else {
            %>
            Status: <input type="checkbox" name="status"/>  <br/>
            <%
                }
            %>
            
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar();"/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
        </form>
    </body>
</html>
