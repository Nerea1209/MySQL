-- 3. Obtener todos los datos de todos los empleados y 
-- el nombre del departamento al que pertenecen.
use empresaclase;

select empleados.numem, empleados.nomem, empleados.ape1em, empleados.ape2em,
	empleados.fecnaem, empleados.comisem, empleados.dniem, empleados.extelem,
    empleados.fecinem, empleados.numhiem, empleados.passem, empleados.salarem,
    empleados.userem, empleados.numde, departamentos.nomde
from empleados join departamentos on empleados.numde = departamentos.numde;

-- 4. Obtener la extensión telefónica y el nombre del centro de 
-- trabajo de “Juan López”.

select empleados.extelem, centros.nomce
from empleados 
	join departamentos on empleados.numde = departamentos.numde
    join centros on departamentos.numce = centros.numce
where empleados.nomem = 'Juan' and empleados.ape1em = 'López';

/*
	5. Obtener el nombre completo y en una sola columna de los 
    empleados del departamento “Personal” y “Finanzas”.
*/

select concat_ws(' ', empleados.nomem, empleados.ape1em, empleados.ape2em)
from empleados join departamentos on empleados.numde = departamentos.numde
where departamentos.nomde = 'Personal' or departamentos.nomde = 'Finanzas';

-- 6. Obtener el nombre del director actual del departamento “Personal”.
select concat_ws(' ', empleados.nomem, empleados.ape1em, empleados.ape2em)
from empleados 
	join dirigir on empleados.numem = dirigir.numempdirec
    join departamentos on dirigir.numdepto = departamentos.numde
where departamentos.nomde = 'Personal';

/*
	7. Obtener el nombre de los departamentos y el presupuesto 
    que están ubicados en la “ SEDE CENTRAL”.
*/

select departamentos.nomde, departamentos.presude
from departamentos join centros on departamentos.numce = centros.numce
where centros.nomce = ' SEDE CENTRAL';

/*
	8. Obtener el nombre de los centros de trabajo cuyo presupuesto 
    esté entre 100000 € y 150000 €.
*/

select centros.nomce
from centros join departamentos on centros.numce = departamentos.numce
where departamentos.presude > 100000 and departamentos.presude < 150000; 

/*
	9. Obtener las extensiones telefónicas del departamento “Finanzas”. 
    No deben salir extensiones repetidas.
*/

select distinct empleados.extelem 
from empleados join departamentos on empleados.numde = departamentos.numde
where departamentos.nomde = 'Finanzas';

/*
	10. Obtener el nombre completo y en una sola columna de todos los 
    directores que ha tenido el departamento cualquiera.
*/


select concat_ws(' ', empleados.nomem, empleados.ape1em, empleados.ape2em)
	as 'Nombre Completo'
from empleados 
	join dirigir on empleados.numem = dirigir.numempdirec
	join departamentos on dirigir.numdepto = departamentos.numde;

/*
	11. Como el apartado 2, pero, ahora, generalízalo para el 
    empleado que queramos en cada caso.
*/



/*
	12. Como el apartado 3 pero generalízalo para que podamos buscar 
    los empleados de un solo departamento.
*/

delimiter $$
drop procedure if exists empleadosDepto $$
create procedure empleadosDepto(
	numDepto int)
begin
	select empleados.nomem
    from empleados 
		left join departamentos on empleados.numde = departamentos.numde
	where departamentos.numde = numDepto;
end $$
delimiter ;

call empleadosDepto(110);
/*
	13. Como el apartado 4. pero generalízalo para buscar el director del 
    departamento que queramos en cada caso.
*/

delimiter $$
drop function if exists dirDepto $$
create function dirDepto (
	numDepto int)
returns varchar(20) deterministic
begin
	return (select empleados.nomem
			from departamentos
				join dirigir on departamentos.numde = dirigir.numdepto
					join empleados on dirigir.numempdirec = empleados.numem
			where departamentos.numde = numDepto 
				and fecfindir is null 
					or fecfindir >= curdate()
            );
end $$

delimiter ;

select dirDepto(110);

-- 14. Como el apartado 5 pero generalízalo para buscar por el centro que queramos.
delimiter $$

drop procedure if exists empleadosPorDepto $$
create procedure empleadosPorDepto (
	numCentro int)
begin
	select concat_ws(' ', empleados.nomem, empleados.ape1em, empleados.ape2em) as 'Nombre Completo'
    from empleados
		join departamentos on empleados.numde = departamentos.numde
			join centros on departamentos.numce = centros.numce
	where centros.numce = numCentro;
end $$
delimiter ;

call empleadosPorDepto(10);

-- 15. Como el apartado 6 pero generalizado para poder buscar el rango que deseemos.
delimiter $$
drop procedure if exists directorDepto $$
create procedure directorDepto(
	numDepto int, fechaInicio date, fechaFin date)
begin
	select concat_ws(' ', empleados.nomem, empleados.ape1em, empleados.ape2em) as 'Nombre director'
    from departamentos
		join dirigir on departamentos.numde = dirigir.numdepto
			join empleados on dirigir.numempdirec = empleados.numem
	where departamentos.numde = numDepto and dirigir.fecinidir >= fechaInicio and dirigir.fecfindir <= fechaFin;
end $$
delimiter ;
select * from dirigir;
call directorDepto(110, '1999-01-01', curdate());

/*
	16. Como el apartado 7 pero generalizado para poder buscar las extensiones 
    del departamento que queramos.
*/
delimiter $$
drop procedure if exists extDeptos $$
create procedure extDeptos (
	numDepto int)
begin
	select empleados.extelem
    from empleados
		join departamentos on empleados.numde = departamentos.numde
	where departamentos.numde = numDepto;
end $$
delimiter ;
-- ¿Cómo controlar que no se repitan?
call extDeptos(120);




