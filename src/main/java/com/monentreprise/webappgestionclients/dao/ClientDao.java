// Fichier: src/main/java/com/monentreprise/webappgestionclients/dao/ClientDao.java

package com.monentreprise.webappgestionclients.dao;

import com.monentreprise.webappgestionclients.entity.Client;
import com.monentreprise.webappgestionclients.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ClientDao {

    public void creer(Client client) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(client);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (em != null) em.close();
        }
    }

    public void mettreAJour(Client client) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(client); // merge() est la méthode pour mettre à jour une entité.
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (em != null) em.close();
        }
    }

    public void supprimer(long id) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Client client = em.find(Client.class, id);
            if (client != null) {
                em.remove(client);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (em != null) em.close();
        }
    }

    public Client trouverParId(long id) {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Client.class, id);
        } finally {
            if (em != null) em.close();
        }
    }

    public List<Client> listerTous() {
        EntityManager em = JpaUtil.getEntityManagerFactory().createEntityManager();
        try {
            TypedQuery<Client> query = em.createQuery("SELECT c FROM Client c ORDER BY c.nom", Client.class);
            return query.getResultList();
        } finally {
            if (em != null) em.close();
        }
    }
}