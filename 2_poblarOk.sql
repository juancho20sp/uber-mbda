--- CRUD Persona
INSERT INTO persona  VALUES (1, 'CC', 1002234221, 'Wilie', 'Pattingson', '3/10/2020', 3327526077, 'wpattingson0@google.ru', 'Colombiana');
INSERT INTO persona  VALUES (2, 'TI', 1002234234, 'Tristam', 'Almack', '10/09/2020', 3826062430, 'talmack1@google.pl', 'Colombiana');
INSERT INTO persona  VALUES (3, 'CE', 1002234223, 'Dallas', 'St. Ledger', '2/2/2021', 3208234820, 'dst2@noaa.gov', 'Colombiana');
INSERT INTO persona  VALUES (4, 'CC', 1002234213, 'Susy', 'Biasioli', '10/4/2020', 3288592329, 'sbiasioli3@smugmug.com', 'Colombiana');
INSERT INTO persona  VALUES (5, 'CE', 1002234256, 'Shena', 'Elgy', '6/7/2020', 3806461899, 'selgy4@delicious.com', 'Colombiana');
INSERT INTO persona  values (6, 'TI', 1002234200, 'Rodie', 'Jimpson', '6/11/2020', 3251480871, 'rjimpson5@businessweek.com', 'Colombiana');

--- CRUD Conductor 
INSERT INTO conductor  VALUES (1, '6941572508', '3/10/1990', 'A');
INSERT INTO conductor  VALUES (2, '8799585457', '4/11/2010', 'I');
INSERT INTO conductor  VALUES (3, '1328242232', '3/12/2000', 'R');

--- CRUD cliente
INSERT INTO cliente VALUES (4, '123654789685745');
INSERT INTO cliente VALUES (5, '357333867554250');
INSERT INTO cliente VALUES (6, '510014127862799');

INSERT INTO tarjeta VALUES ('123654789685745', 'switch', '8/10/2027', 4);
INSERT INTO tarjeta VALUES ('357333867554250', 'jcb', '2/11/2025', 5);
INSERT INTO tarjeta VALUES ('510014127862799', 'mastercard', '12/12/2021', 6);	

--- CRUD vehiculo 
INSERT INTO vehiculo  VALUES ('BQS286', 4, 1600, 2011, 'A', 'A', 4, 3, 61, 1);
INSERT INTO vehiculo  VALUES ('YFK530', 4, 1600, 2012, 'I', 'I', 4, 4, 119, 2);
INSERT INTO vehiculo  VALUES ('AEB758', 4, 1600, 2013, 'C', 'R', 4, 5, 182, 3);

--- CRUD posicion 
INSERT INTO posicion VALUES (121.49, 31.25);
INSERT INTO posicion VALUES (108.21, -7.35);
INSERT INTO posicion VALUES (37.76, 12.98);

--- CRUD ubicacion
INSERT INTO ubicacion VALUES (1, 4, 'Oyope', '4 Pepper Wood Way',121.49, 31.25);
INSERT INTO ubicacion VALUES (2, 5, 'Mynte', '2 Mifflin Lane', 108.21, -7.35);
INSERT INTO ubicacion VALUES (3, 6, 'Pixope', '97 Farwell Hill', 37.76, 12.98);

--- CRUD solicitud 
INSERT INTO solicitud VALUES (49166259, '11/8/2020', '6/8/2020', 'M', 7.54, 'P', NULL, 4, 121.49, 31.25, 108.21, -7.35);
INSERT INTO solicitud VALUES (16789271, '6/5/2020', '3/3/2021', 'W', 6.3, 'A', NULL, 5, 37.76, 12.98, 121.49, 31.25);
INSERT INTO solicitud VALUES (91769475, '2/3/2021', '1/11/2021', 'M', 6.88, 'C', NULL, 6, 108.21, -7.35, 121.49, 31.25);

/*
INSERT INTO PERSONA VALUES(null, 'CC', 12345, 'pepe', 'el pepe', null, '1234567891', 'email@email.com', 'Colombia');

INSERT INTO CONDUCTOR VALUES (1, '1234567891', TO_DATE('13.09.2007','DD.MM.YYYY'), 'A');

INSERT INTO TARJETA VALUES (123456789123456, 'BANCO1', TO_DATE(09.2027, 'MM.YYYY'));

INSERT INTO CLIENTE VALUES (1, 123456789123456);

INSERT INTO POSICION VALUES(2.2, 2.2);
INSERT INTO POSICION VALUES(3.3, 3.3);

INSERT INTO SOLICITUD VALUES(null, null, null, 'P', null, 'A', null, 6, 2.2, 2.2, 3.3, 3.3);*/