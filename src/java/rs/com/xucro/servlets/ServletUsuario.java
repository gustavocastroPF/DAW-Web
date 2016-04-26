/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rs.com.xucro.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import rs.com.xucro.dao.UsuarioDAO;
import rs.com.xucro.modelo.Usuario;

/**
 *
 * @author gustavo
 */
@WebServlet(name = "ServletUsuario", urlPatterns = {"/usuario/ServletUsuario"})
public class ServletUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsuarioDAO dao = (UsuarioDAO) request.getSession().getAttribute("usuarioDao");

        if (dao == null) {
            dao = new UsuarioDAO();
        }
        String tela = "";
        String acao = request.getParameter("acao");
        System.out.println(acao);
        if (acao == null) {
            tela = "listar.jsp";
        } else if (acao.equals("incluir")) {
            dao.setObjetoSelecionado(new Usuario());
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("alterar")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            dao.setObjetoSelecionado(dao.localizar(id));
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("excluir")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            Usuario obj = dao.localizar(id);
            if (obj != null) {
                dao.remover(obj);
            }
            tela = "listar.jsp";
        } else if (acao.equals("salvar")) {
            Integer id = null;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e) {
                dao.setMensagem("Erro: " + rs.com.xucro.util.Util.getMensagemErro(e));
            }

            String status = request.getParameter("status");
            String adm = request.getParameter("adm");
            String data = request.getParameter("data");

            try {
                DateFormat formatter;
                Date date;
                formatter = new SimpleDateFormat("dd/MM/yyyy");
                date = (Date) formatter.parse(data);
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                dao.getObjetoSelecionado().setDataNascimento(cal);
            } catch (Exception e) {

            }

            dao.getObjetoSelecionado().setId(id);
            dao.getObjetoSelecionado().setNome(request.getParameter("nome"));
            dao.getObjetoSelecionado().setImagem(request.getParameter("imagem"));
            dao.getObjetoSelecionado().setEmail(request.getParameter("email"));
            dao.getObjetoSelecionado().setLogin(request.getParameter("login"));
            dao.getObjetoSelecionado().setSenha(request.getParameter("senha"));
            

            if (status.equals("on")) {
                dao.getObjetoSelecionado().setStatus(true);
            } else {
                dao.getObjetoSelecionado().setStatus(false);
            }

            if (status.equals("on")) {
                dao.getObjetoSelecionado().setAdministrador(true);
            } else {
                dao.getObjetoSelecionado().setAdministrador(false);
            }

            if (dao.validaObjeto(dao.getObjetoSelecionado())) {
                dao.salvar(dao.getObjetoSelecionado());
                tela = "listar.jsp";
            } else {
                tela = "formulario.jsp";
            }

        } else if (acao.equals("cancelar")) {
            dao.setMensagem("");
            tela = "listar.jsp";
        }
        request.getSession().setAttribute("usuarioDao", dao);
        response.sendRedirect(tela);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
