use empresaclase2021;
/* vamos a hacer la relación con procedimientos y con funciones (siempre
	que sea posible).
	En todos los casos, vamos a devolver lo que nos pide el ejercicio,
	mediante el valor que devuelve la función o, mediante parámetros 
	de salida
*/
/*ejer 1
*/
drop function if exists funcion_ejer_6_3_1;
delimiter $$

create function funcion_ejer_6_3_1()

returns decimal(7,2)
begin
	-- select funcion_ejer_6_3_1();
    
	declare maxsalario decimal(7,2);
    
	set maxsalario = 
					(select max(salarem)
					from empleados);
	/* o también:
		select max(salarem) into maxsalario
	   from empleados*/
    
    return maxsalario;
	/* o también:
	return (select  max(salarem)
			from empleados);
	*/

end $$
delimiter ;

/* con un procedimiento */
drop procedure if exists proc_ejer_6_3_1;
delimiter $$

create procedure proc_ejer_6_3_1(out maxsalario decimal(7,2))
begin
	/* USAR ESTA VERSIÓN VCUANDO EN EL ENUNCIADO NOS PIDAN QUE "DEVUELVA"*/
	/* call proc_ejer_6_3_1(@maximosalar);
		select @maximosalar;
	*/	
	set maxsalario = 
					(select max(salarem)
					from empleados);
/* también:
	select max(salarem) into maxsalario
	from empleados;
*/
end $$
delimiter ;

/* con un procedimiento sin parametros de salida*/
drop procedure if exists proc_ejer_6_3_1_ver2;
delimiter $$

create procedure proc_ejer_6_3_1_ver2()
begin
	/* call proc_ejer_6_3_1_ver2();
	*/	
	select max(salarem)
	from empleados;

end $$
delimiter ;

/* ejer 2 ==> igual cambiando la función max por min */
/* ejer 3 ==> igual cambiando la función max por avg */


/*ejer 4
¿podríamos hacerlo con una función ==> NO porque devuelve más de un rtdo.
*/
/* con un procedimiento */
drop procedure if exists proc_ejer_6_3_4;
delimiter $$

create procedure proc_ejer_6_3_4(out maxsalario decimal(7,2),
								 out minsalario decimal(7,2),
								 out salariomedio decimal(7,2)
								 )
begin
	/* call proc_ejer_6_3_4(@maxsalario,@minsalario, @salariomedio);
		select @maxsalario;
		select @minsalario;
		select @salariomedio;
	*/	
	select max(empleados.salarem), min(empleados.salarem),
		avg(empleados.salarem) into maxsalario, minsalario, salariomedio
	from empleados join departamentos 
		on empleados.numde = departamentos.numde
	where departamentos.nomde = 'Organización';
end $$
delimiter ;

/* con un procedimiento que únicamente muestre los resultados*/
drop procedure if exists proc_ejer_6_3_4_ver2;
delimiter $$

create procedure proc_ejer_6_3_4_ver2()
begin
	/* call proc_ejer_6_3_4_ver2();
	*/	
	select max(empleados.salarem), min(empleados.salarem),
		avg(empleados.salarem)
	from empleados join departamentos 
		on empleados.numde = departamentos.numde
	where departamentos.nomde = 'Organización';
end $$
delimiter ;


/*ejer 5
/* con un procedimiento */
drop procedure if exists proc_ejer_6_3_5;
delimiter $$

create procedure proc_ejer_6_3_5(in dpto varchar(60),
								 out maxsalario decimal(7,2),
								 out minsalario decimal(7,2),
								 out salariomedio decimal(7,2)
								 )
begin
	/* call proc_ejer_6_3_5('Organización',@maxsalario,@minsalario, @salariomedio);
		select @maxsalario;
        set @maxsalario = @maxsalario+ 1000;
		select @minsalario;
		select @salariomedio;
        select @maxsalario as maxSalario, @minsalario as minSalario, @salariomedio as medioSalario
	*/	
	select max(empleados.salarem), min(empleados.salarem),
		avg(empleados.salarem) into maxsalario, minsalario, salariomedio
	from empleados join departamentos 
		on empleados.numde = departamentos.numde
	where departamentos.nomde = dpto;
end $$
delimiter ;

/*  */
/* con un procedimiento que únicamente muestre los resultados*/
drop procedure if exists proc_ejer_6_3_5_ver2;
delimiter $$

create procedure proc_ejer_6_3_5_ver2(
									in dpto varchar(60)
									)
begin
	/* call proc_ejer_5_3_5_ver2('Organización');
	*/	
	select max(empleados.salarem), min(empleados.salarem),
		avg(empleados.salarem)
	from empleados join departamentos 
		on empleados.numde = departamentos.numde
	where departamentos.nomde = dpto;
end $$
delimiter ;

/*ejer 6
/* con una función */
drop function if exists func_ejer_6_3_6;
delimiter $$
create function func_ejer_6_3_6(numdpto int)
returns decimal(9,2)
begin
	/* select func_ejer_6_3_6(110);
	*/	
	return (select sum(empleados.salarem+ifnull(empleados.comisem,0))
			from empleados
			where numde = numdpto);
end $$
delimiter ;

/* con un procedimiento*/
drop procedure if exists proc_ejer_6_3_6;
delimiter $$
create procedure proc_ejer_6_3_6(in numdpto int, 
								 out coste_empleados decimal(9,2))
begin
	/* call proc_ejer_6_3_6(110, @coste_emp);
		select @coste_emp;
	*/	
	set coste_empleados = (select sum(empleados.salarem+ifnull(empleados.comisem,0))
						   from empleados
						   where numde = numdpto);
                           
	/*
    o también:
    select sum(empleados.salarem+ifnull(empleados.comisem,0)) into coste_empleados
	from empleados
	where numde = numdpto;
    
    */
end $$
delimiter ;

/* con un procedimiento que únicamente muestre el resultado*/
drop procedure if exists proc_ejer_6_3_6_ver2;
delimiter $$
create procedure proc_ejer_6_3_6_ver2(in numdpto int)
begin
	/* call proc_ejer_6_3_6_ver2(110);

	*/	
	select sum(empleados.salarem+ifnull(empleados.comisem,0))
	from empleados
	where numde = numdpto;
end $$
delimiter ;


/*ejer 6_ver_B (para todos los deptos)
/* con una función */
drop function if exists func_ejer_6_3_6_ver_B;
delimiter $$
create function func_ejer_6_3_6_ver_B()
returns decimal(9,2)
begin
	/* select func_ejer_6_3_6_ver_B();
	*/	
	return (select sum(empleados.salarem+ifnull(empleados.comisem,0))
			from empleados);
end $$
delimiter ;

/* con un procedimiento */
drop procedure if exists proc_ejer_6_3_6_ver_B;
delimiter $$
create procedure proc_ejer_6_3_6_ver_B(out total_salarios decimal(9,2))
begin
	/* call proc_ejer_6_3_6_ver_B(@total);
		select @total;
	*/	
	set total_salarios = (select sum(empleados.salarem+ifnull(empleados.comisem,0))
						  from empleados);
end $$
delimiter ;


/*ejer 7 
/* con una función */
drop function if exists func_ejer_6_3_7;
delimiter $$
create function func_ejer_6_3_7()
returns decimal(9,2)
begin
	/* select func_ejer_6_3_7();
	*/
	declare salarios, presupuestos decimal(9,2);
	
	-- set salarios = func_ejer_6_3_6_ver_B();
	/* llamando al proc_ejer_6_3_6_ver_B */
	call proc_ejer_6_3_6_ver_B(salarios);
	set presupuestos = (
						select sum(presude)
						from departamentos
					   );
	
	return (salarios + presupuestos);

	/* o también: 
	return func_ejer_6_3_6_ver_B() + (select sum(presude)
									  from departamentos);
*/
end $$
delimiter ;

/* con un procedimiento*/
drop procedure if exists proc_ejer_6_3_7;
delimiter $$
create procedure proc_ejer_6_3_7(out gasto decimal(9,2))

begin
	/* call proc_ejer_6_3_7(@gasto_total);
	   select @gasto_total;
	*/
	declare salarios, presupuestos decimal(9,2);
	
	set salarios = func_ejer_6_3_6_ver_B();
	set presupuestos = (
						select sum(presude)
						from departamentos
					   );
	
	set gasto= salarios + presupuestos;

	/* o también: 
	set gasto= func_ejer_6_3_6_ver_B() + (select sum(presude)
									  from departamentos);*/
end $$
delimiter ;

/*****/
/* con un procedimiento qué unicamente muestre el resultado*/
drop procedure if exists proc_ejer_6_3_7_ver2;
delimiter $$
create procedure proc_ejer_6_3_7_ver2()

begin
	/* call proc_ejer_6_3_7_ver2();
	*/
	declare salarios, presupuestos decimal(9,2);
	
	set salarios = func_ejer_6_3_6_ver_B();
	set presupuestos = (
						select sum(presude)
						from departamentos
					   );
	
	select salarios + presupuestos;

	/* o también: 
	func_ejer_6_3_6_ver_B() + (select sum(presude)
									  from departamentos);*/
end $$
delimiter ;


/*ejer 8
*/
/* con un procedimiento */
drop procedure if exists proc_ejer_6_3_8;
delimiter $$

create procedure proc_ejer_6_3_8()
begin
	/* call proc_ejer_6_3_8();
	*/	
	select departamentos.nomde as departamento,
		  max(empleados.salarem) as maxsalario, 
		  min(empleados.salarem) as minsalario,
		avg(empleados.salarem) as salariomedio
	from empleados join departamentos 
		on empleados.numde = departamentos.numde
	group by departamentos.nomde;
end $$
delimiter ;


/*ejer 9*/

drop procedure if exists proc_ejer_6_3_9;
delimiter $$

create procedure proc_ejer_6_3_9()
begin
	/* call proc_ejer_6_3_9();
	*/	
	select count(distinct extelem) -- , count(*), count(extelem)
	from empleados
    group by extelem;

/** Si me pidieran 
"obtener cuantos empleados utilizan cada extensión telefónica"
sería:

select extelem, count(*)
from empleados
group by extelem;
    
*/    
end $$
delimiter ;

/*ejer 9 - con parámetros de salida*/

drop procedure if exists proc_ejer_6_3_9_ver2;
delimiter $$

create procedure proc_ejer_6_3_9_ver2(out numextensiones int)
begin
	/* call proc_ejer_6_3_9_ver2(@numextensiones);
		select @numextensiones;
	*/	
	set @numextensiones = (select count(distinct extelem)
						   from empleados);
end $$
delimiter ;



/*ejer 10
/* con una función */
drop function if exists func_ejer_6_3_10;
delimiter $$
create function func_ejer_6_3_10(numdpto int)
returns int
begin
	/* select concat('El depto 110 tiene ', func_ejer_6_3_10(110), ' extensiones');
	*/	
	return (select count(distinct extelem)
			from empleados
			where numde = numdpto);
end $$
delimiter ;

/* con un procedimiento*/
drop procedure if exists proc_ejer_6_3_10;
delimiter $$
create procedure proc_ejer_6_3_10(in numdpto int, 
								  out numexten int)
begin
	/* call proc_ejer_6_3_10(110, @numextensiones);
		select concat('El depto 110 tiene ', @numextensiones, ' extensiones');
	*/	
	/*set numexten = (select count(distinct extelem) 
					from empleados
					where numde = numdpto);
*/
	select count(distinct extelem) into numexten
	from empleados
	where numde = numdpto;
end $$
delimiter ;


/* con un procedimiento*/
drop procedure if exists proc_ejer_6_3_11;
delimiter $$
create procedure proc_ejer_6_3_11()
begin
	/* call proc_ejer_6_3_11();
	*/	
	select departamentos.nomde, count(distinct extelem) 
	from empleados join departamentos on empleados.numde = departamentos.numde
	group by departamentos.nomde ;
end $$
delimiter ;



