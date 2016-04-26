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
import rs.com.xucro.dao.AutorDAO;
import rs.com.xucro.dao.CategoriaDAO;
import rs.com.xucro.dao.ImagemDAO;
import rs.com.xucro.dao.JogoDAO;
import rs.com.xucro.modelo.Categoria;
import rs.com.xucro.modelo.Jogo;

/**
 *
 * @author gustavo
 */
@WebServlet(name = "ServletJogo", urlPatterns = {"/jogo/ServletJogo"})
public class ServletJogo extends HttpServlet {

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
        JogoDAO dao = (JogoDAO) request.getSession().getAttribute("jogoDao");
        if (dao == null) {
            dao = new JogoDAO();
        }

        CategoriaDAO daoCategoria = (CategoriaDAO) request.getSession().getAttribute("categoriaDao");
        if (daoCategoria == null) {
            daoCategoria = new CategoriaDAO();
        }

        ImagemDAO daoImagem = (ImagemDAO) request.getSession().getAttribute("imagemDao");
        if (daoImagem == null) {
            daoImagem = new ImagemDAO();
        }
        
        AutorDAO daoAutor = (AutorDAO) request.getSession().getAttribute("autorDao");
        if (daoAutor == null) {
            daoAutor = new AutorDAO();
        }

        String tela = "";
        String acao = request.getParameter("acao");
        System.out.println(acao);
        if (acao == null) {
            tela = "listar.jsp";
        } else if (acao.equals("incluir")) {
            dao.setObjetoSelecionado(new Jogo());
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("alterar")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            dao.setObjetoSelecionado(dao.localizar(id));
            dao.setMensagem("");
            tela = "formulario.jsp";
        } else if (acao.equals("excluir")) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            Jogo obj = dao.localizar(id);
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
            String premium = request.getParameter("premium");
            String online = request.getParameter("online");

            dao.getObjetoSelecionado().setId(id);
            dao.getObjetoSelecionado().setNome(request.getParameter("nome"));
            dao.getObjetoSelecionado().setBits(Integer.parseInt(request.getParameter("bits")));
            dao.getObjetoSelecionado().setClassificacaoIndicativa(request.getParameter("clasInd"));
            dao.getObjetoSelecionado().setDataUpload(Calendar.getInstance());
            dao.getObjetoSelecionado().setManual(request.getParameter("manual"));
            dao.getObjetoSelecionado().setSinopse(request.getParameter("sinopse"));
            dao.getObjetoSelecionado().setTamanhoTotal(Double.parseDouble(request.getParameter("tamanho")));

            Integer idCategoria = null;
            try {
                idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
            } catch (Exception e) {
                dao.setMensagem("Erro: " + rs.com.xucro.util.Util.getMensagemErro(e));
            }

            dao.getObjetoSelecionado().setCategoria(daoCategoria.localizar(idCategoria));
            dao.getObjetoSelecionado().setImagemCapa(request.getParameter("imagemCapa"));
            dao.getObjetoSelecionado().setAutor(daoAutor.localizar(Integer.parseInt(request.getParameter("autor"))));
            dao.getObjetoSelecionado().setNumeroPlayers(Integer.parseInt(request.getParameter("nPlayers")));
            
            if (status.equals("on")) {
                dao.getObjetoSelecionado().setStatus(true);
            } else {
                dao.getObjetoSelecionado().setStatus(false);
            }

            if (premium.equals("on")) {
                dao.getObjetoSelecionado().setPremium(true);
            } else {
                dao.getObjetoSelecionado().setPremium(false);
            }

            if (online.equals("on")) {
                dao.getObjetoSelecionado().setOnline(true);
            } else {
                dao.getObjetoSelecionado().setOnline(false);
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
        request.getSession().setAttribute("jogoDao", dao);
        request.getSession().setAttribute("categoriaDao", daoCategoria);
        request.getSession().setAttribute("imagemDao", daoImagem);
        request.getSession().setAttribute("autorDao", daoAutor);
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
