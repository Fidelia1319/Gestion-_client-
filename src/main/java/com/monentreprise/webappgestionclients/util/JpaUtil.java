package com.monentreprise.webappgestionclients.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Classe utilitaire pour gérer l'unique instance de l'EntityManagerFactory.
 * C'est le point d'entrée central pour toute interaction avec la base de données.
 */
public class JpaUtil {

    // Le nom de l'unité de persistance, doit correspondre à celui dans persistence.xml
    private static final String PERSISTENCE_UNIT_NAME = "gestClient-pu";

    // L'unique instance de l'EntityManagerFactory pour toute l'application.
    private static EntityManagerFactory factory;

    /**
     * Crée (si nécessaire) et retourne l'instance unique de l'EntityManagerFactory.
     * Cette méthode est "thread-safe" car la fabrique est créée une seule fois.
     * @return L'instance de EntityManagerFactory.
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        if (factory == null) {
            // Persistence.createEntityManagerFactory() lit le fichier persistence.xml
            // et configure l'EntityManagerFactory en fonction de ses propriétés.
            factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        }
        return factory;
    }

    /**
     * Méthode à appeler à la fermeture de l'application pour libérer les ressources.
     * Ferme l'EntityManagerFactory et toutes ses connexions.
     */
    public static void shutdown() {
        if (factory != null) {
            factory.close();
            factory = null;
        }
    }
}