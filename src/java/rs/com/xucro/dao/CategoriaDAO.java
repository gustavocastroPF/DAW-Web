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
import rs.com.xucro.modelo.Categoria;
import rs.com.xucro.util.Util;

/**
 *
 * @author gustavo
 */
public class CategoriaDAO {

    private Categoria objetoSelecionado;
    private String mensagem = "";
    private EntityManager em;

    public Categoria getObjetoSelecionado() {
        return objetoSelecionado;
    }

    public void setObjetoSelecionado(Categoria objetoSelecionado) {
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

    public CategoriaDAO() {
       
        em = EntityManagerUtil.getEntityManager();
    }

    public boolean validaObjeto(Categoria obj) {
        Validator validador = Validation.buildDefaultValidatorFactory().getValidator();
        Set<ConstraintViolation<Categoria>> erros = validador.validate(obj);

        if (erros.size() > 0) {
            mensagem = "";
            mensagem += "Objeto com erros:<br/>";
            for (ConstraintViolation<Categoria> erro : erros) {
                mensagem += "Erro: " + erro.getMessage() + "<br/>";
            }
            return false;
        } else {
            return true;
        }

    }

    public List<Categoria> getLista() {
        return em.createQuery("from Categoria order by nome").getResultList();
    }

    public boolean salvar(Categoria obj) {
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

    public boolean remover(Categoria obj) {
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

    public Categoria localizar(Integer id) {
        return em.find(Categoria.class, id);
    }

}
