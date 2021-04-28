--- TABLAS
CREATE TABLE cliente (
    persona_id  NUMBER(9) NOT NULL,
    tarjeta     NUMBER(15) NOT NULL
);

CREATE TABLE conductor (
    persona_id       NUMBER(9) NOT NULL,
    licencia         VARCHAR2(10) NOT NULL,
    fechanacimiento  DATE NOT NULL,
    estado           CHAR(1 CHAR) NOT NULL
);

CREATE TABLE idioma (
    id_idioma   NUMBER(5) NOT NULL,
    nombre      VARCHAR2(50 CHAR) NOT NULL,
    cliente_id  NUMBER(9) NOT NULL
);

CREATE TABLE persona (
    persona_id    NUMBER(9) NOT NULL,
    tipo          VARCHAR2(2 CHAR) NOT NULL,
    numero        NUMBER(20) NOT NULL,
    nombre        VARCHAR2(50 CHAR) NOT NULL,
    apellidos     VARCHAR2(50 CHAR) NOT NULL,
    registro      DATE NOT NULL,
    celular       NUMBER(10) NOT NULL,
    correo        VARCHAR2(50 CHAR) NOT NULL,
    nacionalidad  VARCHAR2(50 CHAR)
);

CREATE TABLE posicion (
    longitud  NUMBER(9) NOT NULL,
	latitud   NUMBER(9) NOT NULL    
);

CREATE TABLE solicitud (
    codigo              NUMBER(9) NOT NULL,
    fechacreacion       DATE NOT NULL,
    fechaviaje          DATE,
    plataforma          CHAR(1 CHAR) NOT NULL,
    precio              NUMBER(5),
    estado              CHAR(1 CHAR) NOT NULL,
    descripcion         varchar(50 CHAR),
    cliente_id          NUMBER(9) NOT NULL,
    posicion_longitud2  NUMBER(9) NOT NULL,
    posicion_latitud2   NUMBER(9) NOT NULL,
    posicion_longitud   NUMBER(9) NOT NULL,
    posicion_latitud    NUMBER(9) NOT NULL
);

CREATE TABLE tarjeta (
    numero       NUMBER(15) NOT NULL,
    entidad      VARCHAR2(10 CHAR) NOT NULL,
    vencimiento  DATE NOT NULL,
	cliente_id   NUMBER(9) NOT NULL
);

CREATE TABLE ubicacion (
    id_ubicacion       NUMBER(9) NOT NULL,
	cliente_id  	   NUMBER(9) NOT NULL,
    nombre             VARCHAR2(50 CHAR) NOT NULL,
    direccion          VARCHAR2(20) NOT NULL,
	longitud           NUMBER(9) NOT NULL,
    latitud            NUMBER(9) NOT NULL
    
);

CREATE TABLE vehiculo (
    placa         VARCHAR2(30) NOT NULL,
    llantas       NUMBER(1) NOT NULL,
    cilindraje    NUMBER(4) NOT NULL,
    a_o           NUMBER(4) NOT NULL,
    tipo          CHAR(1 CHAR) NOT NULL,
    estado        CHAR(1 CHAR) NOT NULL,
    puertas       NUMBER(1),
    pasajeros     NUMBER(3),
    carga         NUMBER(3),
    conductor_id  NUMBER(9) NOT NULL
);
	
	
/* ------ Llaves primarias  ------ */ 
 
 ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( persona_id );
 
 ALTER TABLE conductor ADD CONSTRAINT conductor_pk PRIMARY KEY ( persona_id );
 
 ALTER TABLE idioma ADD CONSTRAINT idioma_pk PRIMARY KEY ( id_idioma );
 
 ALTER TABLE persona ADD CONSTRAINT persona_pk PRIMARY KEY ( persona_id );
 
 ALTER TABLE posicion ADD CONSTRAINT posicion_pk PRIMARY KEY ( longitud,
                                                              latitud );
															  
ALTER TABLE solicitud ADD CONSTRAINT solicitud_pk PRIMARY KEY ( codigo );	

ALTER TABLE tarjeta ADD CONSTRAINT tarjeta_pk PRIMARY KEY ( numero );

ALTER TABLE ubicacion ADD CONSTRAINT ubicacion_pk PRIMARY KEY ( id_ubicacion );

ALTER TABLE vehiculo ADD CONSTRAINT vehiculo_pk PRIMARY KEY ( placa );														  

 
 
 /* ------ Llaves foráneas  ------ */
ALTER TABLE cliente
    ADD CONSTRAINT cliente_persona_fk FOREIGN KEY ( persona_id )
        REFERENCES persona ( persona_id );

ALTER TABLE conductor
    ADD CONSTRAINT conductor_persona_fk FOREIGN KEY ( persona_id )
        REFERENCES persona ( persona_id );
		
ALTER TABLE idioma
    ADD CONSTRAINT idioma_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( persona_id );
		
ALTER TABLE solicitud
    ADD CONSTRAINT solicitud_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( persona_id );

ALTER TABLE solicitud
    ADD CONSTRAINT solicitud_posicion_fk FOREIGN KEY ( posicion_longitud,
                                                       posicion_latitud )
        REFERENCES posicion ( longitud,
                              latitud );

ALTER TABLE solicitud
    ADD CONSTRAINT solicitud_posicion_fkv2 FOREIGN KEY ( posicion_longitud2,
                                                         posicion_latitud2 )
        REFERENCES posicion ( longitud,
                              latitud );	

ALTER TABLE tarjeta
    ADD CONSTRAINT tarjeta_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( persona_id );	

ALTER TABLE ubicacion
    ADD CONSTRAINT ubicacion_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( persona_id );

ALTER TABLE ubicacion
    ADD CONSTRAINT ubicacion_posicion_fk FOREIGN KEY ( longitud,
                                                       latitud )
        REFERENCES posicion ( longitud,
                              latitud );	

ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_conductor_fk FOREIGN KEY ( conductor_id )
        REFERENCES conductor ( persona_id );							  





-- /* ------ SECUENCIAS  ------ */
-- CREATE SEQUENCE  "BD2172577"."PERSONA_ID"  
-- MINVALUE 1 
-- MAXVALUE 9999999999999999999999999999 
-- INCREMENT BY 1 
-- START WITH 1 
-- CACHE 20 
-- NOORDER  
-- NOCYCLE ;
 
 
-- -- DISPARADORES

-- -- PERSONA
-- CREATE OR REPLACE TRIGGER PERSON_TRIGGER 
-- BEFORE INSERT ON PERSONA 
-- FOR EACH ROW
-- BEGIN
--     SELECT "BD2172577"."PERSONA_ID".NEXTVAL INTO :NEW.persona_id FROM DUAL;
--     :NEW.registro := sysdate;
--   NULL;
-- END;



-- -- Caso 1
-- /* ------ SECUENCIAS  ------ */
--  CREATE SEQUENCE  "BD2172577"."SOLICITUD_ID"  
--  MINVALUE 1 
--  MAXVALUE 9999999999999999999999999999 
--  INCREMENT BY 1 
--  START WITH 1 
--  CACHE 20 
--  NOORDER  
--  NOCYCLE ;
 
-- -- Disparador
-- CREATE OR REPLACE TRIGGER SOLICITUD_TRIGGER 
-- BEFORE INSERT ON  SOLICITUD
-- FOR EACH ROW
-- BEGIN
--     SELECT "BD2172577"."SOLICITUD_ID".NEXTVAL INTO :NEW.codigo FROM DUAL;
--     :NEW.fechaCreacion := CURRENT_TIMESTAMP;
-- END;
 


-- ------CICLO 2 ----------------
-- ---------------- ADICIONAR -------------------
-- /* EL VEHICULO SE ADICIONA EN ESTADO INACTIVO Y SIN CONDUCTOR */
-- CREATE OR REPLACE TRIGGER ADD_VEHICLE_TRIGGER 
-- BEFORE INSERT ON vehiculos 
-- FOR EACH ROW
-- BEGIN
--     IF :new.estado = NULL AND :new.conductorid = NULL	
-- 	THEN :new.estado := "I"; 
-- 		 :new.conductorid := NULL; 
-- 	END IF; 
-- END;

-- /* Las motos no deben tener información sobre puertas, pasajeros ni carga. */ 
-- CREATE OR REPLACE TRIGGER ADD_MOTO_TRIGGER 
-- BEFORE INSERT ON vehiculos 
-- FOR EACH ROW
-- BEGIN
--     IF :new.tipo = "M"
-- 	THEN :new.puertas = NULL; 
-- 		 .new.pasajeros = NULL; 
-- 		 .new.carga = NULL; 
-- 	END IF; 
-- END;

-- /*Los automóviles deben tener información de puertas y pasajeros, no de carga.*/
-- CREATE OR REPLACE TRIGGER ADD_AUTOMOVIL_TRIGGER 
-- BEFORE INSERT ON vehiculos 
-- FOR EACH ROW
-- BEGIN
--     IF :new.tipo = "A" AND (:new.pasajeros = NULL OR :new.puertas = NULL)
-- 	THEN 
-- 		RAISE_APPLICATION_ERROR(-20006, "Es necesaria la cantidad de pasajeros y el número de puertas"); 
-- 	END IF; 
-- END;

-- /*Los camiones deben tener la información completa*/
-- CREATE OR REPLACE TRIGGER ADD_CAMION_TRIGGER 
-- BEFORE INSERT ON vehiculos 
-- FOR EACH ROW
-- BEGIN
--     IF :new.tipo = "C" AND (:new.pasajeros = NULL OR :new.puertas = NULL OR :new.carga = NULL)
-- 	THEN 
-- 		RAISE_APPLICATION_ERROR(-20007, "Es necesario tener la información completa"); 
-- 	END IF; 
-- END;

-- ---------------- MODIFICAR -------------------
-- /* Los datos que se pueden modificar son el conductor y el estado del vehiculo */ 
-- CREATE OR REPLACE TRIGGER MD_VEHICULO_TRIGGER 
-- BEFORE UPDATE ON vehiculos 
-- FOR EACH ROW
-- BEGIN
--     IF :new.placa <> :old.placa OR  
-- 	   :new.llantas <> :old.llantas OR 
-- 	   :new.cilindraje <> :old.cilindraje OR 
-- 	   :new.a_o <> :old.a_o OR 
-- 	   :new.tipo <> :old.tipo OR 
-- 	   :new.placa <> :old.placa OR 
-- 	   :new.puertas <> :old.puertas OR
-- 	   :new.pasajeros <> :old.pasajeros OR 
-- 	   :new.carga <> :old.carga 
-- 	THEN 
-- 		RAISE_APPLICATION_ERROR(-20008, "Unicamente es posible modificar el conductor  y el estado del vehiculo"); 
-- 	END IF; 
-- END;

-- /* Los cambios de estado permitidos son activo < - > inactivo, inactivo < - > retirado, ocupado < - > activo */ 
-- CREATE OR REPLACE TRIGGER MD_ESTADO_VEHICULO_TRIGGER 
-- BEFORE UPDATE ON vehiculos 
-- FOR EACH ROW
-- BEGIN
--     IF NOT((:old.estado = "A" AND :new.estado = "I") OR  (:old.estado = "I" AND :new.estado = "R") 
-- 		OR (:old.estado = "O" AND :new.estado = "A")) 
-- 	THEN 
-- 		RAISE_APPLICATION_ERROR(-20009, "No es posible realizar ese cambio de estado"); 
-- 	END IF; 
-- END;

-- /* Para que un vehiculo pueda estar en estado activo debe pertenecer a un conductor. */ 
-- CREATE OR REPLACE TRIGGER MD_ESTADO_VEHICULO_TRIGGER 
-- BEFORE UPDATE ON vehiculos 
-- FOR EACH ROW
-- BEGIN
--     IF :new.estado = "A" AND :old.conductorid = NULL 
-- 	THEN 
-- 		RAISE_APPLICATION_ERROR(-20010, "Un vehiculo no puede estar activo sin tener un conductor"); 
-- 	END IF; 
-- END;

-- /* Un conductor no puede tener más de un vehículo en estado activo. */




-- ---------------- ELIMINAR -------------------
-- /* Para que un vehículo se pueda eliminar debe ser un vehículo viejo (más de 10 años) y estar en estado retirado. */ 
-- CREATE OR REPLACE TRIGGER MD_ESTADO_VEHICULO_TRIGGER 
-- BEFORE DELETE ON vehiculos 
-- FOR EACH ROW
-- BEGIN
--     IF :old.a_o = 
-- 	THEN 
-- 		RAISE_APPLICATION_ERROR(-20011, "Un vehiculo no puede estar activo sin tener un conductor"); 
-- 	END IF; 
-- END;


-- -- CASO 3
-- -- CREAR
-- -- Secuencia para el ID
-- CREATE SEQUENCE  "BD2172577"."UBICACION_ID"
-- MINVALUE 1 
-- MAXVALUE 9999999999999999999999999999 
-- INCREMENT BY 1 
-- START WITH 1
-- CACHE 20 
-- NOORDER  
-- NOCYCLE ;

-- -- Automatización del código
-- CREATE OR REPLACE TRIGGER CREAR_UBICACION 
-- BEFORE INSERT ON UBICACION
-- FOR EACH ROW
-- BEGIN
--     SELECT "BD2172577"."UBICACION_ID".NEXTVAL INTO :NEW.id_ubicacion FROM DUAL;
-- END;
 

-- -- EDITAR
-- -- Solo se puede editar el nombre
-- CREATE OR REPLACE TRIGGER UPDATE_UBICACION 
-- BEFORE UPDATE ON UBICACION
-- FOR EACH ROW
-- BEGIN
--     IF :new.id_ubicacion <> :old.id_ubicacion 
--     OR :new.direccion <> :old.direccion 
--     OR :new.cliente <> :old.cliente 
--     OR :new.latitud <> :old.latitud 
--     OR :new.longitud <> :old.longitud
--     THEN RAISE_APPLICATION_ERROR(-20002, 'Solo se puede modificar el nombre de la ubicación');
--     END IF; 
-- END;


-- -- ELIMINAR
-- -- Se puede eliminar sin problema
-- ALTER TABLE ubicacion
--     ADD CONSTRAINT ubicacion_cliente_fk FOREIGN KEY ( cliente_id )
--         REFERENCES cliente ( persona_id );
-- 		ON DELETE CASCADE

-- ALTER TABLE ubicacion
--     ADD CONSTRAINT ubicacion_posicion_fk FOREIGN KEY ( posicion_longitud,
--                                                        posicion_latitud )
--         REFERENCES posicion ( longitud,
--                               latitud );
-- 		ON DELETE CASCADE
