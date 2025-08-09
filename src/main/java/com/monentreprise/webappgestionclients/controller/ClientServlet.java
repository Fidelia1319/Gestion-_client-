// Fichier: src/main/java/com/monentreprise/webappgestionclients/controller/ClientServlet.java

package com.monentreprise.webappgestionclients.controller;

import com.monentreprise.webappgestionclients.dao.ClientDao;
import com.monentreprise.webappgestionclients.entity.Client;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/clients")
public class ClientServlet extends HttpServlet {
    private ClientDao clientDao;

    @Override
    public void init() throws ServletException {
        this.clientDao = new ClientDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // --- GESTION DU MESSAGE TOASTER (FLASH) ---
        HttpSession session = request.getSession();
        if (session.getAttribute("toastMessage") != null) {
            request.setAttribute("toastMessage", session.getAttribute("toastMessage"));
            session.removeAttribute("toastMessage"); // On le retire pour ne l'afficher qu'une fois
        }

        // --- GESTION DE LA MODIFICATION ---
        String action = request.getParameter("action");
        if ("modifier".equals(action) && request.getParameter("id") != null) {
            try {
                long idAModifier = Long.parseLong(request.getParameter("id"));
                Client clientAModifier = clientDao.trouverParId(idAModifier);
                request.setAttribute("clientAModifier", clientAModifier);
            } catch (NumberFormatException e) {
                // Gérer l'erreur si l'ID n'est pas un nombre
                e.printStackTrace();
            }
        }

        List<Client> clients = clientDao.listerTous();
        request.setAttribute("clients", clients);

        request.getRequestDispatcher("/WEB-INF/views/clients.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "ajouter":
                    creerClient(request);
                    session.setAttribute("toastMessage", "Client ajouté avec succès !");
                    break;
                case "modifier":
                    modifierClient(request);
                    session.setAttribute("toastMessage", "Client mis à jour avec succès !");
                    break;
                case "supprimer":
                    supprimerClient(request);
                    session.setAttribute("toastMessage", "Client supprimé avec succès !");
                    break;
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Erreur: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/clients");
    }

    private void creerClient(HttpServletRequest request) {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        Client nouveauClient = new Client();
        nouveauClient.setNom(nom);
        nouveauClient.setEmail(email);
        clientDao.creer(nouveauClient);
    }

    private void modifierClient(HttpServletRequest request) {
        long id = Long.parseLong(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        Client client = new Client();
        client.setId(id);
        client.setNom(nom);
        client.setEmail(email);
        clientDao.mettreAJour(client);
    }

    private void supprimerClient(HttpServletRequest request) {
        long id = Long.parseLong(request.getParameter("clientIdToDelete"));
        clientDao.supprimer(id);
    }
}