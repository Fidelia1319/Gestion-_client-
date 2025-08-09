package com.monentreprise.webappgestionclients.listener;

import com.monentreprise.webappgestionclients.util.JpaUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Ce Listener s'exécute au démarrage et à l'arrêt du contexte de l'application web.
 * Son rôle est d'initialiser et de détruire l'EntityManagerFactory.
 */
@WebListener // L'annotation @WebListener permet de l'enregistrer automatiquement auprès du serveur.
public class JpaListener implements ServletContextListener {

    // Méthode appelée au déploiement/démarrage de l'application.
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Force l'initialisation de l'EntityManagerFactory via notre classe utilitaire.
        JpaUtil.getEntityManagerFactory();
    }

    // Méthode appelée à l'arrêt/redéploiement de l'application.
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Appelle la méthode shutdown pour fermer la connexion à la base de données proprement.
        JpaUtil.shutdown();
    }
}