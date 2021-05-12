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
            FROM conductor;
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
            WHERE persona_id = xIdPersona;
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

    -- READ ALL DRIVERS
    FUNCTION READ_CLIENT RETURN SYS_REFCURSOR 
    IS INF_CLIENT SYS_REFCURSOR;
    BEGIN
        OPEN INF_CLIENT FOR
            SELECT *
            FROM cliente;
        RETURN INF_CLIENT ;
    END;

    -- READ SPECIFIC DRIVER
    FUNCTION READ_SPEC_CLIENT(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR  
    IS INF_SPECIFIC_CLIENT SYS_REFCURSOR;
    BEGIN
        OPEN INF_SPECIFIC_CLIENT FOR
            SELECT *
            FROM cliente
            WHERE persona_id = xIdPersona;
        RETURN INF_SPECIFIC_CLIENT ;
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
        xCodigo IN NUMBER,
        xFechaViaje IN DATE,
        xDescripcion IN XMLType,
        xEstado IN CHAR,
        xPosicion2 IN NUMBER,
        xPosicion1 IN NUMBER
        ) Is
    BEGIN
        UPDATE solicitud
        SET
            fechaviaje = xFechaViaje,
            descripcion = xDescripcion,
            estado = xEstado,
            posicion_2 = xPosicion2,
            posicion_1 = xPosicion1
        WHERE codigo = xCodigo;

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
            FROM vehiculo;
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















