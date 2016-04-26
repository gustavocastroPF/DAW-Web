<%-- 
    Document   : formulario
    Created on : 31/03/2016, 10:00:55
    Author     : gustavo
--%>


<%@page import="rs.com.xucro.dao.AutorDAO"%>
<%@page import="rs.com.xucro.modelo.Imagem"%>
<%@page import="rs.com.xucro.dao.ImagemDAO"%>
<%@page import="rs.com.xucro.modelo.Categoria"%>
<%@page import="rs.com.xucro.dao.CategoriaDAO"%>
<%@page import="rs.com.xucro.dao.JogoDAO"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="jogoDao" scope="session"
             type="JogoDAO"/>
<jsp:useBean id="categoriaDao" scope="session"
             type="CategoriaDAO"/>
<jsp:useBean id="imagemDao" scope="session"
             type="ImagemDAO"/>
<jsp:useBean id="autorDao" scope="session"
             type="AutorDAO"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de Jogos</title>
        <script>
            function doSalvar() {
                document.getElementById("acao").value = 'salvar';
                document.getElementById("form").submit();
            }
            function doCancelar() {
                document.getElementById("acao").value = 'cancelar';
                document.getElementById("form").submit();
            }
        </script>            
    </head>
    <body>
        <h1>Edição de Jogo</h1>
        <h2><%=jogoDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletJogo" method="POST">
            Código: <input type="text" name="id" value="<%=jogoDao.getObjetoSelecionado().getId() == null ? "" : jogoDao.getObjetoSelecionado().getId()%>" size="6" readonly/>
            <br/>Nome: <input type="text" name="nome" value="<%=jogoDao.getObjetoSelecionado().getNome() == null ? "" : jogoDao.getObjetoSelecionado().getNome()%>" size="40"/>
            <br/>Categoria:
            <select id="idCategoria" name="idCategoria">
                <%
                    for (Categoria e : categoriaDao.getLista()) {
                        String selected = "";
                        if (jogoDao.getObjetoSelecionado().getCategoria() != null) {
                            selected = jogoDao.getObjetoSelecionado().getCategoria().getId().equals(e.getId())
                                    ? "selected" : "";
                        }
                %>
                <option value="<%=e.getId()%>" <%=selected%> > <%=e.getNome()%> </option>
                <%
                    }
                %>
            </select><br/>
            Classificação Indicativa: <input type="text" name="clasInd" value="<%=jogoDao.getObjetoSelecionado().getClassificacaoIndicativa() == null ? "" : jogoDao.getObjetoSelecionado().getClassificacaoIndicativa()%>"/><br/>
            Caminho para o manual: <input type="text" name="manual" value="<%=jogoDao.getObjetoSelecionado().getManual() == null ? "" : jogoDao.getObjetoSelecionado().getManual()%>"/><br/>
            Caminho para a imagem de capa: <input type="text" name="imagemCapa" value="<%=jogoDao.getObjetoSelecionado().getImagemCapa() == null ? "" : jogoDao.getObjetoSelecionado().getImagemCapa()%>"/><br/>
            Número Máximo de Players: <input type="text" name="nPlayers" value="<%=jogoDao.getObjetoSelecionado().getNumeroPlayers() == null ? "" : jogoDao.getObjetoSelecionado().getNumeroPlayers()%>"/><br/>
            Número de bits: <input type="text" name="bits" value="<%=jogoDao.getObjetoSelecionado().getBits() == null ? "" : jogoDao.getObjetoSelecionado().getBits()%>"/><br/>
            Tamanho: <input type="text" name="tamanho" value="<%=jogoDao.getObjetoSelecionado().getTamanhoTotal()== null ? "" : jogoDao.getObjetoSelecionado().getTamanhoTotal()%>"/><br/>
            Autor: <input type="text" name="autor" value="<%=jogoDao.getObjetoSelecionado().getAutor()== null ? "" : jogoDao.getObjetoSelecionado().getAutor().getId() %>"/><br/>
            Sinopse:<br/><textarea rows="5" cols="50" name="sinopse">
                <%=
                    jogoDao.getObjetoSelecionado().getSinopse()
                %>
            </textarea><br/><br/>
            
            <%
                if (jogoDao.getObjetoSelecionado().isStatus() == true) {
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
                if (jogoDao.getObjetoSelecionado().isPremium()== true) {
            %>
            Premium: <input type="checkbox" name="premium" checked=""/> <br/>       
            <%
            } else {
            %>
            Premium: <input type="checkbox" name="premium" /> <br/>       
            <%
                }
            %>
            
            <%
                if (jogoDao.getObjetoSelecionado().isOnline()== true) {
            %>
            Online: <input type="checkbox" name="online" checked=""/> <br/>       
            <%
            } else {
            %>
            Online: <input type="checkbox" name="online"/>  <br/>
            <%
                }
            %>
            
            Conquistas:
            <table border="1">
                <thead><td>ID</td><td>Descrição</td><td>Pontuação</td><td>Imagem</td><td>Status</td></thead>
                
            </table>
            <%
                for (int i = 0; i < jogoDao.getObjetoSelecionado().getConquistas().size(); i++) {
            %>
            <tr>
                <td><%jogoDao.getObjetoSelecionado().getConquistas().get(i).getConquistaID();%></td>
                <td><%jogoDao.getObjetoSelecionado().getConquistas().get(i).getDescricao();%></td>
                <td><%jogoDao.getObjetoSelecionado().getConquistas().get(i).getPontuacao();%></td>
                <td><%jogoDao.getObjetoSelecionado().getConquistas().get(i).getImagem();%></td>
                <td><%jogoDao.getObjetoSelecionado().getConquistas().get(i).isStatus();%></td>
            </tr>
            <%
                }
            %><br/>
            
            Imagens:
            <table border="1">
                <thead><td>ID</td><td>Descrição</td><td>Tamanho</td><td>Imagem</td><td>Status</td></thead>
                
            </table>
            <%
                 
                    for (Imagem i : imagemDao.getLista()) {
            %>
            <tr>
                <td><%imagemDao.getObjetoSelecionado().getId();%></td>
                <td><%imagemDao.getObjetoSelecionado().getDescricao();%></td>
                <td><%imagemDao.getObjetoSelecionado().getTamanho();%></td>
                <td><%imagemDao.getObjetoSelecionado().getCaminho();%></td>
                <td><%imagemDao.getObjetoSelecionado().isStatus();%></td>
            </tr>
            <%
                }
            %><br/>
            

            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>

        </form>
    </body>
</html>
