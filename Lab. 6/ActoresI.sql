--- CLIENTE
CREATE OR REPLACE PACKAGE BODY PA_CLIENTE IS
    PROCEDURE ADD_SOLICITUD(
        xClienteId IN NUMBER,
        xPosicion2 IN NUMBER,
        xPosicion1 IN NUMBER
    ) IS
    BEGIN
        PKG_SOLICITUDES.ADD_SOLICITUD(NULL, 'A', NULL, NULL, NULL, xClienteId, xPosicion2, xPosicion1);
    END;

    PROCEDURE ADD_POSICION(
        xLongitud IN NUMBER,
        xLatitud IN NUMBER
    ) IS
    BEGIN
        PKG_CLIENT.ADD_POSICION(xLongitud, xLatitud);
    END;

    PROCEDURE ADD_FAV_UBICACION(
        xCliente IN NUMBER,
        xNombre IN VARCHAR,
        xDireccion IN VARCHAR,
        xPosicion IN NUMBER
        ) IS
    BEGIN
        PKG_CLIENT.ADD_FAV_UBICACION(xCliente, xNombre, xDireccion, xPosicion);
    END;

    PROCEDURE UPDATE_SOLICITUD(
        xClienteId IN NUMBER,
        xFechaViaje IN DATE,
        xPrecio IN NUMBER, 
        xEstado IN CHAR
    ) IS 
    BEGIN
        PKG_SOLICITUDES.UPDATE_SOLICITUD(xClienteId, xFechaViaje, xEstado, xPrecio);
    END;

    PROCEDURE DELETE_FAV_UBICACION(
        xCliente IN NUMBER,
        xNombre IN VARCHAR
        ) IS 
    BEGIN
        PKG_CLIENT.DELETE_FAV_UBICACION(xCliente, xNombre);
    END;

    -- READ FAV LOCATION
    FUNCTION READ_FAV_LOCATION(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR
    IS FAV_LOC SYS_REFCURSOR;
    BEGIN
        FAV_LOC := PKG_CLIENT.READ_FAV_LOCATION(xIdPersona);
        RETURN FAV_LOC; 
    END;    
        
END PA_CLIENTE ;
/

--- ANALISTA CLIENTES
CREATE OR REPLACE PACKAGE BODY PA_ANALISTA_CLIENTES IS
    FUNCTION READ_HIGHEST_MOUNTS
        RETURN SYS_REFCURSOR;

    FUNCTION READ_MOST_CANCELED_CLIENTS
        RETURN SYS_REFCURSOR;


        
END PA_ANALISTA_CLIENTES ;
/