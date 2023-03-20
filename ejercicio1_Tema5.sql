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
set @fechaHoy = curdate();
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre Completo',
	(year(@fechaHoy) - year(fecinem)) as 'Experiencia',
    fecinem
from empleados
where (year(@fechaHoy) - year(fecinem)) > 1;

-- 10. Obtener el nombre completo y en una sola columna de los empleados
-- que llevan trabajando en nuestra empresa entre 1 y 3 años
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre Completo',
	(year(@fechaHoy) - year(fecinem)) as 'Experiencia',
    fecinem
from empleados
where (year(@fechaHoy) - year(fecinem)) > 1 and (year(@fechaHoy) - year(fecinem)) < 3;

-- 11. Prepara un procedimiento almacenado que ejecute la consulta 
-- del apartado 1 y otro que ejecute la del apartado 5.
delimiter $$
drop procedure if exists muestraEmpleados $$
create procedure muestraEmpleados()
begin

	SELECT * FROM empleados;

end $$

delimiter ;

call muestraEmpleados();


-- 12. Prepara un procedimiento almacenado que ejecute la consulta del 
-- apartado 2 de forma que nos sirva para averiguar la extensión del 
-- empleado que deseemos en cada caso.
delimiter $$
drop procedure if exists muestraExtension $$
create procedure muestraExtension
	(nombre varchar(60),
    ape1 varchar(60)
    )
begin

	select extelem
    from empleados
    where nomem = nombre and ape1em= ape1;

end $$

delimiter ;

call muestraExtension('Juan', 'López');

-- para que devuelva en vez de mostrar usamos funciones
-- SOLO PUEDE DEVOLVER UN VALOR
delimiter $$
drop function if exists devuelveExtension $$
create function devuelveExtension
	(nombre varchar(60),
    ape1 varchar(60)
    )
returns char(3)
deterministic
begin
	declare extension char(3);
    
    select extelem into extension
	from empleados
	where nomem = nombre and ape1em= ape1;
    
    return extension;
/*
    set extension = (select extelem
					from empleados
					where nomem = nombre and ape1em= ape1
					);
	return extension;
*/
/*
	return (select extelem
			from empleados
			where nomem = nombre and ape1em= ape1
			);
*/
end $$

delimiter ;

select devuelveExtension('Juan', 'López');
set @miExtension = devuelveExtension('Juan', 'López');
select @miExtension;

/*
rutina = procedimiento o funcion
mostrar = procedimiento
devulve un valor = funcion | procedimiento
devuelve mas de un valor = procedimiento
*/

/*
	13. Prepara un procedimiento almacenado que ejecute la consulta del 
	apartado 3 y otro para la del apartado 4 de forma que nos sirva para 
	averiguar el nombre de aquellos que tengan el número de hijos que 
	deseemos en cada caso.
*/
delimiter $$
drop procedure if exists muestraEmpleadosConHijos $$
create procedure muestraEmpleadosConHijos(
	numHijos tinyint)
begin

	SELECT concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre Empleado', numhiem as 'Número de hijos'
	FROM empleados
	where numhiem = numHijos;

end $$

delimiter ;

call muestraEmpleadosConHijos(3);

/*
	14. Prepara un procedimiento almacenado que, dado el nombre de un 
    centro de trabajo, nos devuelva su dirección.
*/
delimiter $$
drop procedure if exists direccionCentro $$
create procedure direccionCentro(
	nombreCentro varchar(60)
    )
begin
	select nomce, dirce
    from centros
    where nomce = nombreCentro;
end$$

delimiter ;

call direccionCentro(' SEDE CENTRAL');

/*
	15. Prepara un procedimiento almacenado que ejecute la consulta del apartado 7 
    de forma que nos sirva para averiguar, dada una cantidad, el nombre de los 
    departamentos que tienen un presupuesto superior a dicha cantidad.
*/
delimiter $$
drop procedure if exists presupuestoDeptos $$
create procedure presupuestoDeptos(
	cantidad decimal(10,2)
    )
begin
	select nomde, presude
    from departamentos
    where presude > cantidad;
end$$

delimiter ;

call presupuestoDeptos(5000);

/*
	16. Prepara un procedimiento almacenado que ejecute la consulta del apartado 8 
    de forma que nos sirva para averiguar, dada una cantidad, el nombre de los 
    departamentos que tienen un presupuesto igual o superior a dicha cantidad.
*/

delimiter $$
drop procedure if exists presupuestoDeptos2 $$
create procedure presupuestoDeptos2(
	cantidad decimal(10,2)
    )
begin
	select nomde, presude
    from departamentos
    where presude >= cantidad;
end$$

delimiter ;

call presupuestoDeptos2(5000);

/*
	17. Prepara un procedimiento almacenado que ejecute la consulta del 
    apartado 9 de forma que nos sirva para averiguar, dada una fecha, 
    el nombre completo y en una sola columna de los empleados que llevan 
    trabajando con nosotros desde esa fecha.
*/
delimiter $$
drop procedure if exists experienciaEmpleados1 $$
create procedure experienciaEmpleados1(
	fechaInicio date
    )
begin
	select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre Empleado', fecinem
    from empleados
    where fecinem <= fechaInicio;
end$$

delimiter ;

call experienciaEmpleados1('2018-09-12');

/*
	18. Prepara un procedimiento almacenado que ejecute la consulta del apartado 10 
    de forma que nos sirva para averiguar, dadas dos fechas, el nombre completo y 
    en una sola columna de los empleados que comenzaron a trabajar con nosotros en 
    el periodo de tiempo comprendido entre esas dos fechas.
*/

delimiter $$
drop procedure if exists experienciaEmpleados2 $$
create procedure experienciaEmpleados2(
	fecha1 date,
    fecha2 date
    )
begin
	select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre Empleado', fecinem
    from empleados
    where fecinem <= fecha2 and fecinem >= fecha1;
end$$

delimiter ;

call experienciaEmpleados2('1800-09-12', '2018-09-12');

/*
	19. Prepara un procedimiento almacenado que ejecute la consulta del apartado 10 
    de forma que nos sirva para averiguar, dadas dos fechas, el nombre completo y 
    en una sola columna de los empleados que comenzaron a trabajar con nosotros fuera 
    del periodo de tiempo comprendido entre esas dos fechas.
*/

delimiter $$
drop procedure if exists experienciaEmpleados3 $$
create procedure experienciaEmpleados3(
	fecha1 date,
    fecha2 date
    )
begin
	select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre Empleado', fecinem
    from empleados
    where fecinem >= fecha2 or fecinem <= fecha1;
end$$

delimiter ;

call experienciaEmpleados3('1800-09-12', '2000-09-12');