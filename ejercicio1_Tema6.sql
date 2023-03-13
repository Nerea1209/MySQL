use empresaclase;
-- 1. Obtener todos los datos de todos los empleados
SELECT * FROM empleados;
-- 2. Obtener la extensión telefónica de "Juan López"
SELECT extelem FROM empleados
where nomem = "Juan" and ape1em = "López";
-- 3. Obtener el nombre completo de los empleados que tienen más de un hijo
SELECT nomem, ape1em, ape2em, numhiem as 'Número de hijos'
FROM empleados
where numhiem > 1;
-- 4. Obtener el nombre completo y en una sola columna de los empleados
-- que tienen entre 1 y 3 hijos
SELECT concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre Completo',
numhiem as 'Número de hijos'
from empleados
where numhiem >= 1 and numhiem <= 3;
-- 5. Obtener nombre completo y en una sola columna de los empleados
-- sin comisión
SELECT concat_ws(' ',nomem, ape1em, ape2em) as 'Nombre Completo',
comisem as 'Comisión'
from empleados
where comisem is null or comisem = 0;
-- 6. Obtener la dirección del centro de tabrajo "Sede Central"
select * from centros;
select nomce as 'Nombre Centro', dirce as 'Dirección'
from centros
where nomce = ' SEDE CENTRAL';
-- 7. Obtener el nombre de los departamentos que tienen más de
-- 6000€ de presupuesto
select * from departamentos;
select nomde as 'Nombre Departamento',
	presude as 'Presupuesto'
from departamentos
where presude > 6000;
-- 8. Obtener el nombre de los departamentos que tienen de presupuesto
-- 6000€ o más
select nomde as 'Nombre Departamento',
	presude as 'Presupuesto'
from departamentos
where presude >= 6000;
-- 9. Obtener el nombre completo y en una sola columna de los empleados
-- que llevan trabajando en nuestra empresa más de 1 año
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre Completo',
	datediff(year, fecinem, curdate())  as 'Experiencia'
from empleados
where datediff(year, fecinem, curdate()) > 1;
-- PREGUNTAR POR QUÉ NO FUNCIONA

-- 10. Obtener el nombre completo y en una sola columna de los empleados
-- que llevan trabajando en nuestra empresa entre 1 y 3 años
