/*
1. Prepara una rutina que, dado el número de un departamento, devuelva el presupuesto del mismo.
*/
delimiter $$
drop function if exists devPresuDepto $$
create function devPresuDepto	
    (
    numdepto int
    )
returns decimal(10,2)
deterministic
begin
	/*
    declare presupuesto decimal(10,2);
    
    select presude into presupuesto
		from departamentos
		where numde = numdepto;
    return presupuesto;
    */
	return (select presude
			from departamentos
			where numde = numdepto
            );
end $$
delimiter ;

select devPresuDepto(100);
/*
2. Prepara una rutina que, dado el número de un empleado, nos devuelva la fecha de ingreso 
en la empresa y el nombre de su director/a (si no lo consigues, obtén su número).
*/
/* VERSIÓN 1: MOSTRAMOS EL NÚMERO DEL EMPLEADO DIRECTOR */
delimiter $$
drop procedure if exists devIngresoDirectorV1 $$
create procedure devIngresoDirectorV1
	(in empleado int,
    out fechaIngreso date,
    out director int
    -- out director varchar(100)
    )
begin
	select fecinem, 
		dirigir.numempdirec
        -- concat_ws(' ',e1.nomem, e1.ape1em, e1.ape2em)
        into fechaIngreso, director
	from empleados join departamentos on empleados.numde = departamentos.numde
		join dirigir on departamentos.numde = dirigir.numdepto
			-- join empleados as e1 on dirigir.numempdirec = e1.numem
	where numem = empleado
		and (dirigir.fecfindir is null or dirigir.fecfindir >= curdate());

end $$
delimiter ;

call devIngresoDirectorV1(110,@ingreso, @dir);
select concat('Fecha ingreso: ', @ingreso, ' director: ',ifnull(@dir, 'sin director'));
select concat('Fecha ingreso: ', date_format(@ingreso,'%e/%c/%Y'), ' director: ',ifnull(@dir, 'sin director'));

call devIngresoDirectorV1(510,@ingreso, @dir);
select concat('Fecha ingreso: ', @ingreso, ' director: ',ifnull(@dir, 'sin director'));
select concat('Fecha ingreso: ', date_format(@ingreso,'%e/%c/%Y'), ' director: ',ifnull(@dir, 'sin director'));

/* VERSIÓN 2: MOSTRAMOS EL NOMBRE DEL DIRECTOR/A */
delimiter $$
drop procedure if exists devIngresoDirectorV2 $$
create procedure devIngresoDirectorV2
	(in empleado int,
    out fechaIngreso date,
	-- out director int
    out director varchar(100)
    )
begin
	select empleados.fecinem, 
		-- dirigir.numempdirec
        concat_ws(' ',e1.nomem, e1.ape1em, e1.ape2em)
        into fechaIngreso, director
	from empleados join departamentos on empleados.numde = departamentos.numde
		join dirigir on departamentos.numde = dirigir.numdepto
			join empleados as e1 on dirigir.numempdirec = e1.numem
	where empleados.numem = empleado
		and (dirigir.fecfindir is null or dirigir.fecfindir >= curdate());

end $$
delimiter ;

call devIngresoDirectorV2(110,@ingreso, @dir);
select concat('Fecha ingreso: ', @ingreso, ' director: ',ifnull(@dir, 'sin director'));
select concat('Fecha ingreso: ', date_format(@ingreso,'%e/%c/%Y'), ' director: ',ifnull(@dir, 'sin director'));

call devIngresoDirectorV2(510,@ingreso, @dir);
select concat('Fecha ingreso: ', @ingreso, ' director: ',ifnull(@dir, 'sin director'));
select concat('Fecha ingreso: ', date_format(@ingreso,'%e/%c/%Y'), ' director: ',ifnull(@dir, 'sin director'));
/*
3. Prepara una rutina que muestre el nombre de todos los empleados y el nombre del último 
departamento que ha dirigido (si es que  ha dirigido alguno)
*/

delimiter $$
drop procedure if exists muestraEmpleados $$
create procedure muestraEmpleados ()
begin
	-- call muestraEmpleados();
    select empleados.nomem, departamentos.nomde, dirigir.fecinidir, dirigir.fecfindir
    from empleados left join dirigir on empleados.numem = dirigir.numempdirec
		left join departamentos on dirigir.numdepto = departamentos.numde
	/* 
    where dirigir.numdepto = (select d1.numdepto
							  from dirigir as d1
							  where d1.numdepto = dirigir.numdepto
                              order by d1.fecinidir desc
                              limit 1) or dirigir.numdepto is null
	*/
    order by empleados.nomem;
end $$
delimiter ;