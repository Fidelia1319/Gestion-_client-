package com.monentreprise.webappgestionclients.controller;

import com.monentreprise.webappgestionclients.dao.ClientDao;
import com.monentreprise.webappgestionclients.entity.Client;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.net.URI;
import java.util.List;

@Path("/clients")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ClientResource {

    private final ClientDao dao = new ClientDao();

    // GET /api/clients  -> liste JSON
    @GET
    public List<Client> list() {
        return dao.listerTous();
    }

    // GET /api/clients/{id} -> un client ou 404
    @GET @Path("/{id}")
    public Client getOne(@PathParam("id") long id) {
        Client c = dao.trouverParId(id);
        if (c == null) throw new NotFoundException("Client " + id + " introuvable");
        return c;
    }

    // POST /api/clients  -> crée et renvoie le client + Location
    @POST
    public Response create(Client c) {
        if (c == null || c.getNom() == null || c.getNom().isBlank()
                || c.getEmail() == null || c.getEmail().isBlank()) {
            throw new BadRequestException("nom et email sont obligatoires");
        }
        dao.creer(c); // ID généré par JPA
        return Response.created(URI.create("/api/clients/" + c.getId()))
                .entity(c)
                .build();
    }

    // PUT /api/clients/{id} -> met à jour et renvoie l'entité
    @PUT @Path("/{id}")
    public Client update(@PathParam("id") long id, Client c) {
        Client existant = dao.trouverParId(id);
        if (existant == null) throw new NotFoundException("Client " + id + " introuvable");

        // on impose l'ID du path
        c.setId(id);
        dao.mettreAJour(c);
        return dao.trouverParId(id); // renvoie l'état après update
    }

    // DELETE /api/clients/{id} -> 204 No Content si ok
    @DELETE @Path("/{id}")
    public Response delete(@PathParam("id") long id) {
        Client existant = dao.trouverParId(id);
        if (existant == null) throw new NotFoundException("Client " + id + " introuvable");

        dao.supprimer(id);
        return Response.noContent().build();
    }
}
