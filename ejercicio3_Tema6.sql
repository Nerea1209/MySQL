use empresaclase;
-- 1. Prepara un procedimiento almacenado que obtenga el salario máximo de la empresa.
delimiter $$
drop function if exists salariomax $$
create function salariomax()
returns decimal(10, 2) deterministic
begin
	return (select max(empleados.salarem) from empleados);
end $$
delimiter ;
select salariomax();

-- 2. Prepara un procedimiento almacenado que obtenga el salario mínimo de la empresa
delimiter $$
drop function if exists salariomin $$
create function salariomin()
returns decimal(10, 2) deterministic
begin
	return (select min(empleados.salarem) from empleados);
end $$
delimiter ;
select salariomin();

-- 3. Prepara un procedimiento almacenado que obtenga el salario medio de la empresa.
delimiter $$
drop function if exists salariomedio $$
create function salariomedio()
returns decimal(10, 2) deterministic
begin
	return (select avg(empleados.salarem) from empleados);
end $$
delimiter ;
select salariomedio();

-- 4. Prepara 1 procedimiento almacenado que obtenga el salario máximo, mínimo y medio del departamento “Organización”.
delimiter $$
drop procedure if exists datosSalarioOrg $$
create procedure datosSalarioOrg ()
begin
	select max(empleados.salarem) as 'Salario máximo',
		   min(empleados.salarem) as 'Salario mínimo',
		   avg(empleados.salarem) as 'Salario medio'
	from empleados
		join departamentos on empleados.numde = departamentos.numde
	where departamentos.nomde = 'ORGANIZACIÓN';
end $$

delimiter ;
call datosSalarioOrg();

/*
	5. Prepara un procedimiento almacenado que obtenga lo mismo que el del apartado anterior pero de forma 
    que podamos cambiar el departamento para el que se obtiene dichos resultados.
*/ 
delimiter $$
drop procedure if exists datosSalario $$
create procedure datosSalario (
	nomDepto varchar(60))
begin
	select max(empleados.salarem) as 'Salario máximo',
		   min(empleados.salarem) as 'Salario mínimo',
		   avg(empleados.salarem) as 'Salario medio'
	from empleados
		join departamentos on empleados.numde = departamentos.numde
	where departamentos.nomde = nomDepto;
end $$

delimiter ;
call datosSalario('ORGANIZACIÓN');

-- 6. Prepara un procedimiento almacenado que obtenga lo que se paga en salarios para un departamento en cuestión.
delimiter $$
drop procedure if exists pagoSalarioDepto $$
create procedure pagoSalarioDepto (
	nomDepto varchar(60))
begin
	select sum(empleados.salarem) as 'Paga en salarios'
	from empleados
		join departamentos on empleados.numde = departamentos.numde
	where departamentos.nomde = nomDepto;
end $$

delimiter ;
call pagoSalarioDepto('ORGANIZACIÓN');

-- 7. Prepara un procedimiento almacenado nos dé el presupuesto total de la empresa.
delimiter $$
drop procedure if exists presuTotal $$
create procedure presuTotal ()
begin
	select sum(departamentos.presude) as 'Presupuesto'
	from departamentos;
end $$

delimiter ;
call presuTotal();

-- 8. Prepara un procedimiento almacenado que obtenga el salario máximo, mínimo y medio para cada departamento.
delimiter $$
drop procedure if exists datosSalarioDeptos $$
create procedure datosSalarioDeptos ()
begin
	select departamentos.nomde as 'Departamento',
		   max(empleados.salarem) as 'Salario máximo',
		   min(empleados.salarem) as 'Salario mínimo',
		   avg(empleados.salarem) as 'Salario medio'
	from empleados
		join departamentos on empleados.numde = departamentos.numde
	group by departamentos.nomde;
end $$

delimiter ;
call datosSalarioDeptos();

-- 9. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que hay en la empresa.
delimiter $$
drop procedure if exists extensiones $$
create procedure extensiones ()
begin
	select count(distinct empleados.extelem) as 'Extensiones telefónicas'
	from empleados;
end $$

delimiter ;
call extensiones();

-- 10. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza un departamento.
delimiter $$
drop procedure if exists extensionesDepto $$
create procedure extensionesDepto (
	nomDepto varchar(60))
begin
	select count(distinct empleados.extelem) as 'Extensiones telefónicas'
	from empleados
		join departamentos on empleados.numde = departamentos.numde
    where departamentos.nomde = nomDepto;
end $$

delimiter ;
call extensionesDepto('ORGANIZACIÓN');

-- 11. Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza cada departamento.
delimiter $$
drop procedure if exists extensionesByDepto $$
create procedure extensionesByDepto ()
begin
	select departamentos.nomde as 'Departamento',
		count(distinct empleados.extelem) as 'Extensiones telefónicas'
	from empleados
		join departamentos on empleados.numde = departamentos.numde
    group by departamentos.nomde;
end $$

delimiter ;
call extensionesByDepto();