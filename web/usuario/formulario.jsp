<%-- 
    Document   : formulario
    Created on : 31/03/2016, 10:00:11
    Author     : gustavo
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="rs.com.xucro.dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="usuarioDao" scope="session" type="UsuarioDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Usuario</title>
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
        <h1>Edição de Usuario</h1>
        <h2> <%=usuarioDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletUsuario" method="GET">
            Codigo: <input type="text" name="id" value="<%=usuarioDao.getObjetoSelecionado().getId() == null ? "" : usuarioDao.getObjetoSelecionado().getId()%>"/><br/>
            Nome: <input type="text" name="nome" value="<%=usuarioDao.getObjetoSelecionado().getNome() == null ? "" : usuarioDao.getObjetoSelecionado().getNome()%>"/><br/>
            E-mail: <input type="email" name="email" value="<%=usuarioDao.getObjetoSelecionado().getEmail() == null ? "" : usuarioDao.getObjetoSelecionado().getEmail()%>"/><br/>
            Login: <input type="text" name="login" value="<%=usuarioDao.getObjetoSelecionado().getLogin() == null ? "" : usuarioDao.getObjetoSelecionado().getLogin()%>"/><br/>
            Senha: <input type="password" name="senha" value="<%=usuarioDao.getObjetoSelecionado().getSenha() == null ? "" : usuarioDao.getObjetoSelecionado().getSenha()%>"/><br/>

            <%
                Calendar c = usuarioDao.getObjetoSelecionado().getDataNascimento();
                String a = null;
                if (c != null) {
                    SimpleDateFormat s = new SimpleDateFormat("dd/MM/yyyy");
                    a = s.format(c.getTime());
                }

            %>


            Data Nascimento:<input type="text" name="data" value="<%=usuarioDao.getObjetoSelecionado().getDataNascimento() == null ? "" : a%>"/><br/>
            Caminho da imagem: <input type="text" name="imagem" value="<%=usuarioDao.getObjetoSelecionado().getImagem() == null ? "" : usuarioDao.getObjetoSelecionado().getImagem()%>"/><br/>

            <%
                if (usuarioDao.getObjetoSelecionado().isStatus() == true) {
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
                if (usuarioDao.getObjetoSelecionado().isAdministrador() == true) {
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
