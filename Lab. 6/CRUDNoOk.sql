-- CONDUCTOR
EXECUTE PKG_DRIVER.ADD_DRIVER('CI','329494070','Lorri Kydde','9844409387','lor.kydde@hotmail.com','90757100',to_date('10/06/74','DD/MM/RR'),'New Zealand Sign Language');
EXECUTE PKG_DRIVER.ADD_DRIVER('PS','386843088','Lida Dubs','4771773400','lid.dubs@hotmail.com','178615154',null,null);
EXECUTE PKG_DRIVER.ADD_DRIVER('CE','835701578','Kathy Richarz','6164006420','kat.richarz@hotmail.com','85164697',to_date('06/06/84','DD/MM/RR'),'Finnish');

-- CLIENTE
EXECUTE PKG_CLIENT.ADD_CLIENT('CC','483910418','Thibaut O''Longain','2221494903','thi.o''longain@hotmail.com','132214508',null,null);
EXECUTE PKG_CLIENT.ADD_CLIENT('CE','553145711','Forrest Stranahan',null,'for.stranahan@hotmail.com','85325412',null,'Aymara');


--- SOLICITUDES
EXECUTE PKG_SOLICITUDES.ADD_SOLICITUD(NULL, 'A', NULL, 'A', NULL, 70, 1, 2);
EXECUTE PKG_SOLICITUDES.ADD_SOLICITUD(to_date('20/05/21','DD/MM/RR'), 'A', NULL, 'A', NULL, 1440, 1, 3);
EXECUTE PKG_SOLICITUDES.ADD_SOLICITUD(to_date('7/07/21','DD/MM/RR'), NULL, NULL, 'A', NULL, 70, 2, 3);

EXECUTE PKG_SOLICITUDES.UPDATE_SOLICITUD(50000, to_date('26/08/21','DD/MM/RR'), NULL, 'A', 2, 3);
EXECUTE PKG_SOLICITUDES.UPDATE_SOLICITUD(2, to_date('27/05/21','DD/MM/RR'), NULL, NULL, 1, 3);
EXECUTE PKG_SOLICITUDES.UPDATE_SOLICITUD(1, NULL, NULL, 'A', 3, 3);


-- VEHICULOS (PROBAR UPDATE)
EXECUTE PKG_VEHICULOS.ADD_VEHICULO(NULL, 4, 1600, 2222, 'B', 'A', 4, 4, 4, 1);
EXECUTE PKG_VEHICULOS.ADD_VEHICULO('BBB222', 4, 2400, 2002, 'B', 'A', 4, 4, 4, 777777);
EXECUTE PKG_VEHICULOS.ADD_VEHICULO('CCC333222SSDFFVVSDFSDFE', 4, 2400, 2002, 'C', 'A', 4, 4, 4, 4);

EXECUTE PKG_VEHICULOS.UPDATE_VEHICULOS('AAA111', NULL, 2);
EXECUTE PKG_VEHICULOS.UPDATE_VEHICULOS('BBB222', 'I', 147852369);
EXECUTE PKG_VEHICULOS.UPDATE_VEHICULOS('CCC333', 'Z', 3);