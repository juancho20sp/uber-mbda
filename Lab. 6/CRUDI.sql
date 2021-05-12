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







