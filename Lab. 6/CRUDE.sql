-- CONDUCTOR
CREATE OR REPLACE PACKAGE PKG_DRIVER AS
    PROCEDURE ADD_DRIVER(
        xTipoId IN VARCHAR,
        xNumeroId IN VARCHAR,
        xNombre IN VARCHAR,
        xCelular IN VARCHAR,
        xEmail IN VARCHAR,
        xLicencia IN VARCHAR,
        xNacimiento IN DATE,
        xIdioma IN VARCHAR
        );

    -- READ ALL DRIVERS
    FUNCTION READ_DRIVER RETURN SYS_REFCURSOR;

    -- READ SPECIFIC DRIVER
    FUNCTION READ_SPEC_DRIVER(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR;

    PROCEDURE UPDATE_DRIVER(
        xIdPersona IN NUMBER,
        xEstrellas IN NUMBER,
        xEstado IN VARCHAR
        );

END PKG_DRIVER;

/

-- CLIENTE
CREATE OR REPLACE PACKAGE PKG_CLIENT AS
    PROCEDURE ADD_CLIENT(
        xTipoId IN VARCHAR,
        xNumeroId IN VARCHAR,
        xNombre IN VARCHAR,
        xCelular IN VARCHAR,
        xEmail IN VARCHAR,
        xLicencia IN VARCHAR,
        xNacimiento IN DATE,
        xIdioma IN VARCHAR
        );

    -- READ ALL DRIVERS
    FUNCTION READ_CLIENT RETURN SYS_REFCURSOR;

    -- READ SPECIFIC DRIVER
    FUNCTION READ_SPEC_CLIENT(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR;

END PKG_CLIENT;

/

