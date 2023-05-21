/*
COMPRUEBO LO APRENDIDO
1. Prepara una rutina que, dado el número de un departamento, devuelva el presupuesto del mismo.
2. Prepara una rutina que, dado el número de un empleado, nos devuelva la fecha de ingreso en la 
empresa y el nombre de su director/a.
3. Prepara una rutina que nos devuelva el nombre de todos los empleados y el nombre del último 
departamento que ha dirigido (si es que  ha dirigido alguno)
*/
select * from empleados;
select * from dirigir;
select * from departamentos;
-- 1
use empresaclase;
delimiter $$
drop function if exists presupuestoDeptos $$
create function presupuestoDeptos(
	nomDepto varchar(60))
returns decimal(10, 2) deterministic
begin
	declare presupuesto decimal(10,2);
    select departamentos.presude into presupuesto
		from departamentos
        where departamentos.nomde = nomDepto;
	return presupuesto;
end $$
delimiter ;

select presupuestoDeptos('DIRECCION GENERAL');

-- 2
delimiter $$
drop procedure if exists fechaIngresoYDireccion $$
create procedure fechaIngresoYDireccion(
	numEmpleado int, out fechaInicio date, out nomDirector varchar(20))
begin
	select empleados.fecinem, e.nomem
    into fechaInicio, nomDirector
    from empleados 
		join departamentos on empleados.numde = departamentos.numde
        join dirigir on departamentos.numde = dirigir.numdepto
        join empleados as e on dirigir.numempdirec = e.numem
	where empleados.numem = numEmpleado
    and (dirigir.fecfindir is null or dirigir.fecfindir >= curdate());
end $$
delimiter ;

call fechaIngresoYDireccion(180, @fecingreso, @nomDirector);
select 'La fecha de ingreso de numem = 180';
select @fecingreso;
select 'El nombre de su director es: ';
select @nomDirector;

-- 3 Prepara una rutina que nos muestra el nombre de todos los empleados y el nombre del último 
-- departamento que ha dirigido (si es que  ha dirigido alguno)

delimiter $$
drop procedure if exists nombreDeptoDir $$
create procedure nombreDeptoDir()
begin
	select empleados.nomem, departamentos.nomde 
    from departamentos 
		join dirigir on departamentos.numde = dirigir.numdepto
		right join empleados on empleados.numem = dirigir.numempdirec;
end $$
delimiter ;

call nombreDeptoDir();
