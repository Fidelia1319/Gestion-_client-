package com.monentreprise.webappgestionclients.api;

import jakarta.ws.rs.BadRequestException;
import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;

@Provider
public class ApiExceptionMapper implements ExceptionMapper<Throwable> {

    @Override
    public Response toResponse(Throwable ex) {
        int status;
        if (ex instanceof NotFoundException) {
            status = 404;
        } else if (ex instanceof BadRequestException) {
            status = 400;
        } else {
            status = 500;
        }

        String msg = (ex.getMessage() == null) ? "Erreur serveur" : ex.getMessage();
        // petite sanitation des guillemets
        msg = msg.replace("\"", "'");
        String json = "{\"error\":\"" + msg + "\"}";

        return Response.status(status)
                .type(MediaType.APPLICATION_JSON)
                .entity(json)
                .build();
    }
}
