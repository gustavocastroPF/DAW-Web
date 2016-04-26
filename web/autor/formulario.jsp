<%-- 
    Document   : formulario
    Created on : 31/03/2016, 10:00:11
    Author     : gustavo
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="rs.com.xucro.dao.AutorDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="autorDao" scope="session" type="AutorDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Autor</title>
        <script>

            function doSalvar() {
                document.getElementById("acao").value = "salvar";
                document.getElementById("form").submit();
            }
            function doCancelar() {
                document.getElementById("acao").value = "cancelar";
                document.getElementById("form").submit();
            }


        </script>
    </head>
    <body>
        <h1>Edição de Autor</h1>
        <h2> <%=autorDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletAutor" method="GET">
            Codigo: <input type="text" name="id" value="<%=autorDao.getObjetoSelecionado().getId() == null ? "" : autorDao.getObjetoSelecionado().getId()%>"/><br/>
            Nome: <input type="text" name="nome" value="<%=autorDao.getObjetoSelecionado().getNome() == null ? "" : autorDao.getObjetoSelecionado().getNome()%>"/><br/>
            E-mail: <input type="email" name="email" value="<%=autorDao.getObjetoSelecionado().getEmail() == null ? "" : autorDao.getObjetoSelecionado().getEmail()%>"/><br/>
            Login: <input type="text" name="login" value="<%=autorDao.getObjetoSelecionado().getLogin() == null ? "" : autorDao.getObjetoSelecionado().getLogin()%>"/><br/>
            Senha: <input type="password" name="senha" value="<%=autorDao.getObjetoSelecionado().getSenha() == null ? "" : autorDao.getObjetoSelecionado().getSenha()%>"/><br/>
            Rede Social: <input type="text" name="redeSocial" value="<%=autorDao.getObjetoSelecionado().getRedeSocial()== null ? "" : autorDao.getObjetoSelecionado().getRedeSocial()%>"/><br/>
            Site Autor: <input type="text" name="siteAutor" value="<%=autorDao.getObjetoSelecionado().getSiteAutorDesenvolvedor()== null ? "" : autorDao.getObjetoSelecionado().getSiteAutorDesenvolvedor()%>"/><br/>
            Site Distribuidor: <input type="text" name="siteDistribuidor" value="<%=autorDao.getObjetoSelecionado().getSiteDistribuidor()== null ? "" : autorDao.getObjetoSelecionado().getSiteDistribuidor()%>"/><br/>
            <%
                Calendar c = autorDao.getObjetoSelecionado().getDataNascimento();
                String a = null;
                if (c != null) {
                    SimpleDateFormat s = new SimpleDateFormat("dd/MM/yyyy");
                    a = s.format(c.getTime());
                }

            %>


            Data Nascimento:<input type="text" name="data" value="<%=autorDao.getObjetoSelecionado().getDataNascimento() == null ? "" : a%>"/><br/>
            Caminho da imagem: <input type="text" name="imagem" value="<%=autorDao.getObjetoSelecionado().getImagem() == null ? "" : autorDao.getObjetoSelecionado().getImagem()%>"/><br/>

            <%
                if (autorDao.getObjetoSelecionado().isStatus() == true) {
            %>
            Status: <input type="checkbox" name="status" checked=""/> <br/>       
            <%
            } else {
            %>
            Status: <input type="checkbox" name="status"/>  <br/>
            <%
                }
            %>
            
            <%
                if (autorDao.getObjetoSelecionado().isDistribuidor()== true) {
            %>
            Distribuidor: <input type="checkbox" name="distribuidor" checked=""/> <br/>       
            <%
            } else {
            %>
            Distribuidor: <input type="checkbox" name="distribuidor"/>  <br/>
            <%
                }
            %>

            <%
                if (autorDao.getObjetoSelecionado().isAdministrador() == true) {
            %>
            Administrador: <input type="checkbox" name="adm" checked=""/>   <br/>     
            <%
            } else {
            %>
            Administrador: <input type="checkbox" name="adm"/>  <br/>
            <%
                }
            %>

            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar();"/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
        </form>
    </body>
</html>
