package com.monentreprise.webappgestionclients;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

@ApplicationPath("/api")   // toutes tes routes REST commenceront par /api
public class JaxrsConfig extends Application { }
