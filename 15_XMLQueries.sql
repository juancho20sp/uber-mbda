--- Todas las direcciones de origen
SELECT xt.* FROM 
    solicitud sol, 
    XMLTABLE('/TRequerimiento/DireccionDestino' 
        passing sol.descripcion
        COLUMNS 
            DireccionDestino VARCHAR(200) PATH 'text()'
    ) xt;

--- Viajes con requerimientos de música
--- El primer parámetro de EXISTSNODE es la columna donde
--- está el XML
SELECT * FROM solicitud
WHERE EXISTSNODE(
    descripcion,
     '/TRequerimiento/Requerimientos/Musica') = 1;


--- Viajes con requerimiento de vehículos
SELECT * FROM solicitud
WHERE EXISTSNODE(descripcion, '/TRequerimiento/Requerimientos/Vehiculo') = 1;


--- Viajes con un vehículo rojo
SELECT * FROM solicitud
WHERE EXISTSNODE(descripcion, '/TRequerimiento/Requerimientos/Vehiculo[@color = "rojo"]') = 1;
