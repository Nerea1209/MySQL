/*
4.2.1 Añadir datos. Sentencia INSERT.
Sintaxis
INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]
[INTO] nom_tabla [(nom_colum,...)]
VALUES ({expr | DEFAULT},...),(...),...
| SET nom_colum={expr | DEFAULT}, ...
|SELECT ...
[ ON DUPLICATE KEY UPDATE nom_colum=expr, ... ]
4.2.2 Eliminar datos. Sentencia DELETE.
Sintaxis
DELETE [LOW_PRIORITY] [QUICK] [IGNORE] FROM nom_tabla
[ WHERE expres_condicional]
[ORDER BY ...]
[LIMIT num_filas]
4.2.3 Modificar datos. Sentencia UPDATE.
Sintaxis
UPDATE [LOW_PRIORITY] [IGNORE] nom_tabla
SET nom_colum1=expr1 [, nom_colum2=expr2 ...]
[WHERE def_condicional]
[ORDER BY ...]
[LIMIT num_filas]
*/

use ejercicio1;
-- centros(pk[numcentro], nomcentro, direccion);
insert into centros (numcentro, nomcentro, direccion)
values 
	(10, 'SEDE CENTRAL', 'C.ALCALA, 820, MADRID'),
	(20, 'RELACION CON CLIENTES', 'C.ATOCHA, 405, MADRID');

-- -- deptos(pk[numdepto, numcentro*], presupuesto, nomdepto, numdepto*);
insert into deptos (numdepto, numcentro, presupuesto, numdepto, nomdepto)
values 
	(100, 10, 129000, null , 'DIRECCION GENERAL'),
    (110, 20, 100000, 100 , 'DIRECC.COMERCIAL'),
    (111, 20, 90000, 110 , 'SECTOR INDUSTRIAL'),
    (112, 20, 175000, 110 , 'SECTOR SERVICIOS'),
    (120, 10, 50000, 100 , 'ORGANIZACION'),
    (121, 10, 74000, 120 , 'PERSONAL'),
    (122, 10, 68000, 120 , 'PROCESO DE DATOS'),
    (130, 10, 85000, 120 , 'FINANZAS');

-- -> empleados(pk[numempleado], extelefon, fecnacim, fecingreso, 
-- salario, comision, numhijos, nomemp);
insert into empleados (numem, numde, extelem, fecnaem, fecinem,
	salarem, comisem, numhiem, nomem , ape1em, ape2em, numce)
values 
	(110, 121, 350, '1965-04-30', '1985-03-15', 1000, null, 2, 'PEPA', 'PEREZ', null, null),
    (120, 112, 840, '1970-09-10', '1995-10-01', 1200, null, 3, 'JUAN', 'LOPEZ', null, null),
    (130, 112, 810, '1958-03-30', '1988-03-01', 987, null, 1, 'ANA', 'GARCIA', null, null),
    (150, 121, 340, '1972-01-15', '2001-01-15', 856, null, 0, 'JULIA', 'VARGAS', null, null),
    (160, 111, 740, '1969-03-18', '2002-03-18', 998, null, 4, 'PEPA', 'CANALES', null, null),
    (180, 110, 505, '1971-02-11', '1998-02-11', 1967, null, 5, 'JUANA', 'RODRIGUEZ', 'PEREZ', null),
    (190, 121, 350, '1969-01-22', '1997-01-22', 1174, null, 0, 'LUISA', 'GOMEZ', null, null),
    (210, 100, 200, '1964-02-24', '1986-02-24', 3000, null, 3, 'CESAR', 'PONS', null, null),
    (240, 111, 760, '1959-03-01', '1987-03-01', 2145, 110, 1, 'MARIO', 'LASA', null, null),
    (250, 100, 250, '1954-07-12', '1976-07-12', 3123, 110, 2, 'LUCIANO', 'TEROL', null, null);
    
    
    
    
    
    