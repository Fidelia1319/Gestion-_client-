# WebApp de Gestion de Clients

Une application web full-stack pour la gestion de clients (CRUD - Create, Read, Update, Delete) construite avec Java Servlets, JSP et JPA.

## 📸 Aperçu

**Liste des Clients**
![Liste des Clients](https://www.facebook.com/share/p/1A5zqaYDG4/)
*La page principale affiche tous les clients présents dans la base de données avec des options pour les modifier ou les supprimer.*

**Formulaire d'Ajout**
![Formulaire d'Ajout](https://www.facebook.com/share/p/19aV5iyW4w/)
*Un formulaire simple et clair pour ajouter un nouveau client.*


## ✨ Fonctionnalités

-   **Lister** tous les clients avec leur ID, nom et email.
-   **Ajouter** un nouveau client via un formulaire dédié.
-   **Modifier** les informations d'un client existant.
-   **Supprimer** un client de la base de données.

## 🛠️ Technologies et Outils

-   **Backend** : Java, Servlets, JPA (Hibernate)
-   **Frontend** : JSP (JavaServer Pages), Tailwind CSS
-   **Base de données** : MySQL
-   **Serveur d'application** : Apache Tomcat
-   **Environnement local** : XAMPP
-   **Gestion de dépendances/Build** : Apache Maven
-   **IDE** : IntelliJ IDEA Ultimate

## 📋 Prérequis

Avant de commencer, assurez-vous d'avoir installé :
*   JDK 8 ou supérieur
*   Apache Maven
*   Apache Tomcat
*   XAMPP

## 🚀 Installation et Lancement

Suivez ces étapes pour lancer le projet en local :

1.  **Cloner le projet**
    ```bash
    git clone https://gitlab.com/mmlr/java-frontend.git
    cd java-frontend
    ```

2.  **Démarrer et Configurer la Base de Données**
    *   Lancez le panneau de contrôle **XAMPP** et démarrez les modules **Apache** et **MySQL**.
    *   Via `phpMyAdmin`, créez une nouvelle base de données (ex: `gestion_clients_db`).
    *   Mettez à jour le fichier `src/main/resources/META-INF/persistence.xml` pour qu'il corresponde à votre configuration locale.

3.  **Compiler le projet**
    Ouvrez un terminal à la racine du projet et exécutez la commande Maven :
    ```bash
    mvn clean package
    ```
    Cela générera un fichier `WebAppGestionClients-1.0-SNAPSHOT.war` dans le dossier `target/`.

4.  **Déployer sur Tomcat**
    Copiez le fichier `.war` généré et collez-le dans le répertoire `webapps` de votre installation Apache Tomcat (ex: `C:\apache-tomcat-10.1.44\webapps\`).

5.  **Lancer le serveur Tomcat**
    *   Ouvrez une invite de commande (cmd) et naviguez jusqu'au répertoire `bin` de Tomcat :
        ```bash
        cd C:\apache-tomcat-10.1.44\bin
        ```
    *   Exécutez le script de démarrage :
        ```bash
        startup.bat
        ```
    *   Tomcat va démarrer et déployer automatiquement votre application.

6.  **Accéder à l'application**
    Ouvrez votre navigateur web et allez à l'URL suivante pour voir la liste des clients :
    [http://localhost:8080/WebAppGestionClients-1.0-SNAPSHOT/clients](http://localhost:8080/WebAppGestionClients-1.0-SNAPSHOT/clients)

---

## 👤 Contributeur

*   **mamilalaina**