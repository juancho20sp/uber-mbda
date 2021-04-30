INSERT INTO conductor VALUES(
	123456789, 
	NULL,
	TO_DATE('10/10/2021', 'MM/DD/YYYY'),
	'4',
	'A');

INSERT INTO vehiculo VALUES (
	NULL,
	2,
	144,
	2015,
	'A',
	'A',
	NULL,
	NULL,
	NULL,
	NULL
);

INSERT INTO persona VALUES (
	NULL,
	'CC',
	1000245589,
	'Carlos José',
	TO_DATE('04/04/2021', 'DD/MM/YYYY'),
	3003015896,
	'mail@mail.com'
	
);

INSERT INTO idiomas VALUES (
	NULL,
	'Inglés'
);

INSERT INTO ubicacion VALUES (
	'Casa',
	'Calle 123 #45 - 56',
	1000147625,
	NULL,
	NULL
);

INSERT INTO persona VALUES (
	-123456789,
	'CC',
	1000245589,
	'Carlos José',
	TO_DATE('04/04/2021', 'DD/MM/YYYY'),
	3003015896,
	'mail@mail.com'
	
);

INSERT INTO vehiculo VALUES (
	NULL,
	2,
	144,
	2015,
	'A',
	'A',
	NULL,
	NULL,
	NULL,
	123456789
);

INSERT INTO vehiculo VALUES (
	NULL,
	2,
	144,
	2015,
	'A',
	'A',
	NULL,
	NULL,
	NULL,
	22222222
);


INSERT INTO vehiculo VALUES (
	NULL,
	2,
	144,
	2015,
	'A',
	'A',
	NULL,
	NULL,
	NULL,
	333333333
);

INSERT INTO solicitud VALUES (
	000000002,
	TO_DATE('20/02/2021', 'DD/MM/YYYY'),
	NULL,
	'A',
	125.33,
	'X',
	'<TRequerimiento>
    <DireccionOrigen>
        Calle 123 # 45 - 56
    </DireccionOrigen>
    <DireccionDestino>
        Calle 165 # 54 - 65
    </DireccionDestino>
</TRequerimiento>',
	10.0,
	10.0,
	11.0,
	11.0
);

INSERT INTO vehiculo VALUES (
	NULL,
	2,
	144,
	2015,
	'A',
	'A',
	NULL,
	NULL,
	NULL,
	333333333
);

INSERT INTO conductor VALUES(
	123456789, 
	NULL,
	TO_DATE('10/10/2021', 'MM/DD/YYYY'),
	'4',
	'X');