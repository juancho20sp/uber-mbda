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

    PROCEDURE ADD_POSICION(
       xLongitud IN NUMBER,
        xLatitud IN NUMBER
        );

    PROCEDURE ADD_FAV_UBICACION(
        xCliente IN NUMBER,
        xNombre IN VARCHAR,
        xDireccion IN VARCHAR,
        xPosicion IN NUMBER
        );

    PROCEDURE DELETE_FAV_UBICACION(
        xCliente IN NUMBER,
        xNombre IN VARCHAR
        );



    
    
    
    -- READ POSITION
    FUNCTION READ_POSITION RETURN SYS_REFCURSOR;

    -- READ ALL CLIENT
    FUNCTION READ_CLIENT RETURN SYS_REFCURSOR;

    -- READ SPECIFIC DRIVER
    FUNCTION READ_SPEC_CLIENT(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR;

    -- READ FAV LOCATION
    FUNCTION READ_FAV_LOCATION(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR;

    -- READ SOLICITUD
    FUNCTION READ_SOLICITUD(
        xIdPersona IN NUMBER
    ) RETURN SYS_REFCURSOR;

END PKG_CLIENT;

/

-- SOLICITUDES
CREATE OR REPLACE PACKAGE PKG_SOLICITUDES AS
    PROCEDURE ADD_SOLICITUD(
        xFechaViaje IN DATE,
        xPlataforma IN CHAR,
        xPrecio IN NUMBER,
        xEstado IN CHAR,
        xDescripcion IN XMLType,
        xClienteId IN VARCHAR,
        xPosicion2 IN NUMBER,
        xPosicion1 IN NUMBER
        );

    -- READ ALL DRIVERS
    FUNCTION READ_SOLICITUDES RETURN SYS_REFCURSOR;

    PROCEDURE UPDATE_SOLICITUD(
        xCliente IN NUMBER,
        xFechaViaje IN DATE,
        xEstado IN CHAR,
        xPrecio IN NUMBER
        );

END PKG_SOLICITUDES;

/


-- VEHICULOS
CREATE OR REPLACE PACKAGE PKG_VEHICULOS AS
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
        );

    -- READ ALL VEHICLES
    FUNCTION READ_VEHICULOS RETURN SYS_REFCURSOR;

    PROCEDURE UPDATE_VEHICULOS(
        xPlaca IN VARCHAR,
        xEstado IN CHAR,
        xConductor IN NUMBER
        );

END PKG_VEHICULOS;

/

