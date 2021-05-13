-- CONDUCTOR
CREATE OR REPLACE PACKAGE BODY PKG_DRIVER AS
    PROCEDURE ADD_DRIVER(
        xTipoId IN VARCHAR,
        xNumeroId IN VARCHAR,
        xNombre IN VARCHAR,
        xCelular IN VARCHAR,
        xEmail IN VARCHAR,
        xLicencia IN VARCHAR,
        xNacimiento IN DATE,
        xIdioma IN VARCHAR
        ) IS
    BEGIN
        DECLARE
            xPersonaId NUMBER;

        BEGIN
        INSERT INTO PERSONA VALUES (
            NULL,
            xTipoId,
            xNumeroId,
            xNombre,
            NULL,
            NULL,
            xCelular,
            xEmail,
            NULL
        );

        SELECT persona_id INTO xPersonaId FROM PERSONA
        WHERE ROWNUM = 1
        ORDER BY persona_id DESC;

        INSERT INTO CONDUCTOR VALUES (
            xPersonaId,
            xLicencia,
            xNacimiento,
            NULL,
            NULL
        );

        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001,'ERROR AL INSERTAR EL CONDUCTOR');
        END;
    END;  

    -- READ ALL DRIVERS
    FUNCTION READ_DRIVER RETURN SYS_REFCURSOR 
    IS INF_DRIVERS SYS_REFCURSOR;
    BEGIN
        OPEN INF_DRIVERS FOR
            SELECT *
            FROM conductor
            JOIN PERSONA
            ON conductor.persona_id = PERSONA.persona_id;
        RETURN INF_DRIVERS ;
    END;

    -- READ SPECIFIC DRIVER
    FUNCTION READ_SPEC_DRIVER(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR  
    IS INF_SPECIFIC_DRIVER SYS_REFCURSOR;
    BEGIN
        OPEN INF_SPECIFIC_DRIVER FOR
            SELECT *
            FROM conductor
            JOIN PERSONA
            ON conductor.persona_id = PERSONA.persona_id
            WHERE conductor.persona_id = xIdPersona;
        RETURN INF_SPECIFIC_DRIVER ;
    END;

    PROCEDURE UPDATE_DRIVER(
        xIdPersona IN NUMBER,
        xEstrellas IN NUMBER,
        xEstado IN VARCHAR
        ) Is
    BEGIN
        UPDATE conductor
        SET
            estrellas = xEstrellas,
            estado = xEstado
        WHERE persona_id = xIdPersona;

        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002,'ERROR AL MODIFCAR EL CONDUCTOR'); 
    END;

END PKG_DRIVER;

/

-- CLIENTE
CREATE OR REPLACE PACKAGE BODY PKG_CLIENT AS
    PROCEDURE ADD_CLIENT(
        xTipoId IN VARCHAR,
        xNumeroId IN VARCHAR,
        xNombre IN VARCHAR,
        xCelular IN VARCHAR,
        xEmail IN VARCHAR,
        xLicencia IN VARCHAR,
        xNacimiento IN DATE,
        xIdioma IN VARCHAR
        ) IS
    BEGIN
        DECLARE
            xPersonaId NUMBER;

        BEGIN
        INSERT INTO PERSONA VALUES (
            NULL,
            xTipoId,
            xNumeroId,
            xNombre,
            NULL,
            NULL,
            xCelular,
            xEmail,
            NULL
        );

        SELECT persona_id INTO xPersonaId FROM PERSONA
        WHERE ROWNUM = 1
        ORDER BY persona_id DESC;

        INSERT INTO cliente VALUES (
            xPersonaId
        );

        IF xIdioma IS NOT NULL THEN
            INSERT INTO IDIOMA VALUES(NULL, xIdioma, xPersonaId);
        END IF;

        INSERT INTO IDIOMA VALUES(NULL, 'Castellano', xPersonaId);


        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001,'ERROR AL INSERTAR EL CLIENTE');
        END;
    END;  


    PROCEDURE ADD_POSICION(
        xLongitud IN NUMBER,
        xLatitud IN NUMBER
        ) IS
    BEGIN 
        INSERT INTO posicion VALUES (
            NULL,
            xLongitud,
            xLatitud        
        );

        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001,'ERROR AL INSERTAR LA SOLICITUD');
    END;  


    PROCEDURE ADD_FAV_UBICACION(
        xCliente IN NUMBER,
        xNombre IN VARCHAR,
        xDireccion IN VARCHAR,
        xPosicion IN NUMBER
        ) IS 
    BEGIN        
        INSERT INTO ubicacion VALUES (NULL, xCliente, xNombre, xDireccion, xPosicion);
        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001,'ERROR AL INSERTAR LA UBICACIÓN FAVORITA');
    END;


    PROCEDURE DELETE_FAV_UBICACION(
        xCliente IN NUMBER,
        xNombre IN VARCHAR
        ) IS 
    BEGIN    
        DELETE FROM UBICACION WHERE cliente_id = xCliente AND nombre = xNombre;
        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001,'ERROR AL ELIMINAR LA UBICACIÓN FAVORITA');
    END;

    -- READ POSITION
    FUNCTION READ_POSITION RETURN SYS_REFCURSOR
     IS RES SYS_REFCURSOR;
    BEGIN
        OPEN RES FOR
            SELECT *
            FROM posicion;
        RETURN RES ;
    END;

    -- READ ALL CLIENTS
    FUNCTION READ_CLIENT RETURN SYS_REFCURSOR 
    IS INF_CLIENT SYS_REFCURSOR;
    BEGIN
        OPEN INF_CLIENT FOR
            SELECT *
            FROM cliente
            JOIN PERSONA
            ON CLIENTE.persona_id = PERSONA.persona_id;
        RETURN INF_CLIENT ;
    END;

    -- READ SPECIFIC CLIENT
    FUNCTION READ_SPEC_CLIENT(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR  
    IS INF_SPECIFIC_CLIENT SYS_REFCURSOR;
    BEGIN
        OPEN INF_SPECIFIC_CLIENT FOR
            SELECT *
            FROM cliente
            JOIN PERSONA
            ON CLIENTE.persona_id = PERSONA.persona_id
            WHERE CLIENTE.persona_id = xIdPersona;
        RETURN INF_SPECIFIC_CLIENT ;
    END;

    -- READ FAV LOCATION
    FUNCTION READ_FAV_LOCATION(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR
    IS INF_FAV_LOCATION SYS_REFCURSOR;
    BEGIN
        OPEN INF_FAV_LOCATION FOR
            SELECT *
            FROM UBICACION
            WHERE CLIENTE_ID = xIdPersona;
        RETURN INF_FAV_LOCATION ;
    END;

    -- READ SOLICITUD
    FUNCTION READ_SOLICITUD(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR 
    IS RES SYS_REFCURSOR;
    BEGIN
        OPEN RES FOR
            SELECT *
            FROM SOLICITUD
            JOIN persona 
            ON SOLICITUD.cliente_id = persona.persona_id
            WHERE SOLICITUD.cliente_id = xIdPersona;
        RETURN RES ;
    END;



END PKG_CLIENT;

/

-- SOLICITUD
CREATE OR REPLACE PACKAGE BODY PKG_SOLICITUDES AS
    PROCEDURE ADD_SOLICITUD(
        xFechaViaje IN DATE,
        xPlataforma IN CHAR,
        xPrecio IN NUMBER,
        xEstado IN CHAR,
        xDescripcion IN XMLType,
        xClienteId IN VARCHAR,
        xPosicion2 IN NUMBER,
        xPosicion1 IN NUMBER
        ) IS
    BEGIN      
        INSERT INTO solicitud VALUES (
            NULL,
            NULL,
            xFechaViaje,
            xPlataforma,
            xPrecio,
            xEstado,
            xDescripcion,
            xClienteId,
            xPosicion2,
            xPosicion1
        );

        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001,'ERROR AL INSERTAR LA SOLICITUD');
        
    END;  

    -- READ ALL SOLICITUDES
    FUNCTION READ_SOLICITUDES RETURN SYS_REFCURSOR 
    IS INF_SOLICITUD SYS_REFCURSOR;
    BEGIN
        OPEN INF_SOLICITUD FOR
            SELECT *
            FROM solicitud;
        RETURN INF_SOLICITUD ;
    END;

    PROCEDURE UPDATE_SOLICITUD(
        xCliente IN NUMBER,
        xFechaViaje IN DATE,
        xEstado IN CHAR,
        xPrecio IN NUMBER
        ) Is
    BEGIN
        UPDATE solicitud
        SET
            fechaviaje = xFechaViaje,
            estado = xEstado,
            precio = xPrecio
        WHERE cliente_id = xCliente;

        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002,'ERROR AL MODIFCAR LA SOLICITUD'); 
    END;
END PKG_SOLICITUDES;

/

-- VEHICULOS
CREATE OR REPLACE PACKAGE BODY PKG_VEHICULOS AS
    PROCEDURE ADD_VEHICULO(
        xPlaca IN VARCHAR,
        xLlantas IN NUMBER,
        xCilindraje IN NUMBER,
        xYear IN NUMBER,
        xTipo IN CHAR,
        xEstado IN CHAR,
        xPuertas IN NUMBER,
        xPasajeros IN NUMBER,
        xCarga IN NUMBER,
        xConductor_id IN NUMBER
        ) IS
    BEGIN      
        INSERT INTO vehiculo VALUES (
            xPlaca,
            xLlantas,
            xCilindraje,
            xYear,
            xTipo,
            xEstado,
            xPuertas,
            xPasajeros,
            xCarga,
            xConductor_id
            
        );

        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001,'ERROR AL INSERTAR EL VEHÍCULO');
        
    END;  

    -- READ ALL VEHICLES
    FUNCTION READ_VEHICULOS RETURN SYS_REFCURSOR 
    IS INF_VEHICULO SYS_REFCURSOR;
    BEGIN
        OPEN INF_VEHICULO FOR
            SELECT *
            FROM vehiculo
            JOIN CONDUCTOR 
            ON VEHICULO.conductor_id = CONDUCTOR.persona_id;
        RETURN INF_VEHICULO ;
    END;

    PROCEDURE UPDATE_VEHICULOS(
        xPlaca IN VARCHAR,
        xEstado IN CHAR,
        xConductor IN NUMBER
        ) Is
    BEGIN
        UPDATE vehiculo
        SET
            estado = xEstado,
            conductor_id = xConductor
        WHERE placa = xPlaca;

        COMMIT;

        EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002,'ERROR AL MODIFCAR EL VEHÍCULO '); 
    END;
END PKG_VEHICULOS;

/















