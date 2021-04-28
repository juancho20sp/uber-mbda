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

-- SOLICITUD
CREATE OR REPLACE TRIGGER SOLICITUD_TRIGGER 
BEFORE INSERT ON SOLICITUD
FOR EACH ROW
BEGIN
    SELECT SOLICITUD_ID.NEXTVAL INTO :NEW.codigo FROM DUAL;
    :NEW.fechaCreacion := CURRENT_TIMESTAMP;
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
-- Solo se puede editar el nombre
CREATE OR REPLACE TRIGGER UPDATE_UBICACION 
BEFORE UPDATE ON UBICACION
FOR EACH ROW
BEGIN
    IF :new.id_ubicacion <> :old.id_ubicacion 
    OR :new.direccion <> :old.direccion 
    OR :new.cliente_id <> :old.cliente_id 
    OR :new.latitud <> :old.latitud 
    OR :new.longitud <> :old.longitud
    THEN RAISE_APPLICATION_ERROR(-20002, 'Solo se puede modificar el nombre de la ubicación');
    END IF; 
END;

/

