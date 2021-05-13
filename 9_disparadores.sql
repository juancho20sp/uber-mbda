-- PERSONA
CREATE OR REPLACE TRIGGER PERSON_TRIGGER 
BEFORE INSERT ON PERSONA 
FOR EACH ROW
BEGIN
    SELECT PERSONA_ID.NEXTVAL INTO :NEW.persona_id FROM DUAL;
    :NEW.registro := sysdate;
  NULL;
END;

/

-- CONDUCTOR
CREATE OR REPLACE TRIGGER DRIVER_TRIGGER 
BEFORE INSERT ON conductor 
FOR EACH ROW
BEGIN    
    :NEW.estrellas := 3;
	:NEW.estado := 'I';
  NULL;
END;

/

-- IDIOMA
CREATE OR REPLACE TRIGGER LANGUAGE_TRIGGER 
BEFORE INSERT ON idioma 
FOR EACH ROW
BEGIN
    SELECT IDIOMA_ID.NEXTVAL INTO :NEW.id_idioma FROM DUAL;
  NULL;
END;

/

-- POSICION
CREATE OR REPLACE TRIGGER POSITION_TRIGGER 
BEFORE INSERT ON posicion 
FOR EACH ROW
BEGIN
    SELECT POSICION_ID.NEXTVAL INTO :NEW.posicion_id FROM DUAL;
  NULL;
END;

/

-- SOLICITUD
CREATE OR REPLACE TRIGGER SOLICITUD_TRIGGER 
BEFORE INSERT ON SOLICITUD
FOR EACH ROW
DECLARE
	num NUMBER;

BEGIN
	SELECT COUNT(*) INTO num FROM SOLICITUD WHERE cliente_id = :NEW.cliente_id AND estado IN ('P', 'A');


    SELECT SOLICITUD_ID.NEXTVAL INTO :NEW.codigo FROM DUAL;
    :NEW.fechaCreacion := CURRENT_TIMESTAMP;

	IF :NEW.fechaviaje < sysdate THEN
		RAISE_APPLICATION_ERROR(-20056, 'LA FECHA DE VIAJE DEBE SER SUPERIOR A LA FECHA ACTUAL');
	END IF;

	:NEW.estado := 'P';

	IF :NEW.posicion_2 = :NEW.posicion_1 THEN
		RAISE_APPLICATION_ERROR(-20056, 'LA POSICIÓN DE SALIDA Y LLEGADA DEBEN SER DIFERENTES');
	END IF;

	IF num > 0 THEN
		RAISE_APPLICATION_ERROR(-20056, 'SOLO PUEDE TENER UNA SOLICITUD ACTIVA');
	END IF;

	:NEW.fechaviaje := NULL;

	:NEW.precio :=NULL;
END;

/

-- SOLICITUD
CREATE OR REPLACE TRIGGER SOLICITUD_UPD_TRIGGER 
BEFORE UPDATE ON SOLICITUD
FOR EACH ROW
BEGIN
	IF (:NEW.codigo <> :OLD.codigo) OR
	(:NEW.fechacreacion <> :OLD.fechacreacion) OR
	(:NEW.plataforma <> :OLD.plataforma) OR
	(:NEW.cliente_id <> :OLD.cliente_id) OR
	(:NEW.posicion_2 <> :OLD.posicion_2) OR
	(:NEW.posicion_1 <> :OLD.posicion_1) THEN
		RAISE_APPLICATION_ERROR(-20056, 'SOLO SE PUEDE MODIFICAR LA FECHA DE VIAJE, EL PRECIO Y EL ESTADO');
	END IF;

	IF (:OLD.estado NOT LIKE 'P') AND (:NEW.estado <> :OLD.estado AND :NEW.fechaviaje <> :OLD.fechaviaje) THEN
		RAISE_APPLICATION_ERROR(-20056, 'SOLO SE PUEDE MODIFICAR LA FECHA DE VIAJE Y EL ESTADO SI EL ESTADO ES PENDIENTE');
	END IF;

	IF :NEW.fechaviaje < sysdate THEN
		RAISE_APPLICATION_ERROR(-20056, 'LA FECHA DE VIAJE DEBE SER SUPERIOR A LA FECHA ACTUAL');
	END IF;

	IF (:OLD.estado LIKE 'C') AND (:NEW.estado <> :OLD.estado) THEN
		RAISE_APPLICATION_ERROR(-20056, 'NO SE LE PUEDE CAMBIAR EL ESTADO A UNA SOLICITUD CANCELADA');
	END IF;
END;

/

-- VEHÍCULO
-- EL VEHICULO SE ADICIONA EN ESTADO INACTIVO Y SIN CONDUCTOR
CREATE OR REPLACE TRIGGER ADD_VEHICLE_TRIGGER 
BEFORE INSERT ON vehiculo
FOR EACH ROW
BEGIN
    IF :new.estado = NULL AND :new.conductor_id = NULL	
	THEN :new.estado := 'I'; 
		 :new.conductor_id := NULL; 
	END IF; 
END;

/

-- VEHÍCULO
-- Las motos no deben tener información sobre puertas, pasajeros ni carga. 
CREATE OR REPLACE TRIGGER ADD_MOTO_TRIGGER 
BEFORE INSERT ON vehiculo
FOR EACH ROW
BEGIN
    IF :new.tipo = 'M'
	THEN :new.puertas := NULL; 
		 :new.pasajeros := NULL; 
		 :new.carga := NULL; 
	END IF; 
END;

/

-- VEHÍCULO
/*Los automóviles deben tener información de puertas y pasajeros, no de carga.*/
CREATE OR REPLACE TRIGGER ADD_AUTOMOVIL_TRIGGER 
BEFORE INSERT ON vehiculo
FOR EACH ROW
BEGIN
    IF :new.tipo = 'A' AND (:new.pasajeros = NULL OR :new.puertas = NULL)
	THEN 
		RAISE_APPLICATION_ERROR(-20006, 'Es necesaria la cantidad de pasajeros y el número de puertas'); 
	END IF; 
END;

/

-- VEHÍCULO
/*Los camiones deben tener la información completa*/
CREATE OR REPLACE TRIGGER ADD_CAMION_TRIGGER 
BEFORE INSERT ON vehiculo 
FOR EACH ROW
BEGIN
    IF :new.tipo = 'C' AND (:new.pasajeros = NULL OR :new.puertas = NULL OR :new.carga = NULL)
	THEN 
		RAISE_APPLICATION_ERROR(-20007, 'Es necesario tener la información completa'); 
	END IF; 
END;

/

-- VEHÍCULO
/* Los datos que se pueden modificar son el conductor y el estado del vehiculo */ 
CREATE OR REPLACE TRIGGER MD_VEHICULO_TRIGGER 
BEFORE UPDATE ON vehiculo
FOR EACH ROW
BEGIN
    IF :new.placa <> :old.placa OR  
	   :new.llantas <> :old.llantas OR 
	   :new.cilindraje <> :old.cilindraje OR 
	   :new.a_o <> :old.a_o OR 
	   :new.tipo <> :old.tipo OR 
	   :new.placa <> :old.placa OR 
	   :new.puertas <> :old.puertas OR
	   :new.pasajeros <> :old.pasajeros OR 
	   :new.carga <> :old.carga 
	THEN 
		RAISE_APPLICATION_ERROR(-20008, 'Unicamente es posible modificar el conductor  y el estado del vehiculo'); 
	END IF; 
END;

/

-- VEHÍCULO
/* Los cambios de estado permitidos son activo < - > inactivo, inactivo < - > retirado, ocupado < - > activo */ 
CREATE OR REPLACE TRIGGER MD_ESTADO_VEHICULO_TRIGGER 
BEFORE UPDATE ON vehiculo 
FOR EACH ROW
BEGIN
    IF NOT((:old.estado = 'A' AND :new.estado = 'I') OR  (:old.estado = 'I' AND :new.estado = 'R') 
		OR (:old.estado = 'O' AND :new.estado = 'A')) 
	THEN 
		RAISE_APPLICATION_ERROR(-20009, 'No es posible realizar ese cambio de estado'); 
	END IF; 

    IF :new.estado = 'A' AND :old.conductor_id = NULL 
	THEN 
		RAISE_APPLICATION_ERROR(-20010, 'Un vehiculo no puede estar activo sin tener un conductor'); 
	END IF; 
END;

/

-- UBICACIÓN
CREATE OR REPLACE TRIGGER UPDATE_UBICACION 
BEFORE INSERT ON UBICACION
FOR EACH ROW
BEGIN
    SELECT UBICACION_ID.NEXTVAL INTO :NEW.id_ubicacion FROM DUAL;
END;

/

-- UBICACIÓN
-- Solo se puede editar el nombre
CREATE OR REPLACE TRIGGER UPDATE_UBICACION 
BEFORE UPDATE ON UBICACION
FOR EACH ROW
BEGIN
    IF :new.id_ubicacion <> :old.id_ubicacion 
    OR :new.direccion <> :old.direccion 
    OR :new.cliente_id <> :old.cliente_id 
    OR :new.posicion_1 <> :old.posicion_1 
    THEN RAISE_APPLICATION_ERROR(-20002, 'Solo se puede modificar el nombre de la ubicación');
    END IF; 
END;

/

