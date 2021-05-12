--- TABLAS
CREATE TABLE cliente (
    persona_id  NUMBER(9) NOT NULL
);

CREATE TABLE conductor (
    persona_id       NUMBER(9) NOT NULL,
    licencia         VARCHAR2(10) NOT NULL,
    fechanacimiento  DATE NOT NULL,
    estado           CHAR(1 CHAR) NOT NULL,
    estrellas        NUMBER(1) NOT NULL
);

CREATE TABLE idioma (
    id_idioma   NUMBER(5) NOT NULL,
    nombre      VARCHAR2(50 CHAR) NOT NULL,
    cliente_id  NUMBER(9) NOT NULL
);

CREATE TABLE persona (
    persona_id    NUMBER(9) NOT NULL,
    tipo          VARCHAR2(2) NOT NULL,
    numero        VARCHAR2(20) NOT NULL,
    nombre        VARCHAR2(50) NOT NULL,
    apellidos     VARCHAR2(50),
    registro      DATE NOT NULL,
    celular       VARCHAR2(10) NOT NULL,
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
    descripcion         XMLType,
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

