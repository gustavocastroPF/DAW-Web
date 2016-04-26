/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rs.com.xucro.dao;

import java.util.List;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import rs.com.xucro.jpa.EntityManagerUtil;
import rs.com.xucro.modelo.Jogo;
import rs.com.xucro.util.Util;

/**
 *
 * @author gustavo
 */
public class JogoDAO {

    private Jogo objetoSelecionado;
    private String mensagem = "";
    private EntityManager em;

    public Jogo getObjetoSelecionado() {
        return objetoSelecionado;
    }

    public void setObjetoSelecionado(Jogo objetoSelecionado) {
        this.objetoSelecionado = objetoSelecionado;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public EntityManager getEm() {
        return em;
    }

    public void setEm(EntityManager em) {
        this.em = em;
    }

    public JogoDAO() {
       
        em = EntityManagerUtil.getEntityManager();
    }

    public boolean validaObjeto(Jogo obj) {
        Validator validador = Validation.buildDefaultValidatorFactory().getValidator();
        Set<ConstraintViolation<Jogo>> erros = validador.validate(obj);

        if (erros.size() > 0) {
            mensagem = "";
            mensagem += "Objeto com erros:<br/>";
            for (ConstraintViolation<Jogo> erro : erros) {
                mensagem += "Erro: " + erro.getMessage() + "<br/>";
            }
            return false;
        } else {
            return true;
        }

    }

    public List<Jogo> getLista() {
        return em.createQuery("from Jogo order by nome").getResultList();
    }

    public boolean salvar(Jogo obj) {
        try {
            em.getTransaction().begin();
            if (obj.getId() == null) {
                em.persist(obj);
            } else {
                em.merge(obj);
            }
            em.getTransaction().commit();
            mensagem = "Objeto persistido";
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive() == false) {
                em.getTransaction().begin();
            }
            em.getTransaction().rollback();
            mensagem = "Erro ao persistir objeto: " + Util.getMensagemErro(e);
            return false;
        }
    }

    public boolean remover(Jogo obj) {
        try {
            em.getTransaction().begin();
            em.remove(obj);
            em.getTransaction().commit();
            mensagem = "Objeto removido";
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive() == false) {
                em.getTransaction().begin();
            }
            em.getTransaction().rollback();
            mensagem = "Erro ao remover objeto: " + Util.getMensagemErro(e);
            return false;
        }
    }

    public Jogo localizar(Integer id) {
        return em.find(Jogo.class, id);
    }

}
