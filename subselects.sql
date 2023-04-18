/*
set @depto = (select numde
			  from empleados
              where numem = 120);

insert into empleados
	(numem, numde, nomem, ape1em, .....)
value
	(1999, @depto, 'pepe', 'del campo', ....);

insert into empleados
	(numem, numde, nomem, ape1em, .....)
value
	(1999, (select numde
			  from empleados
              where numem = 120), 
	'pepe', 'del campo', ....);
*/
create table centros_new
	(numce int primary key,
     nomce varchar(60)
	);

-- Insertamos todos los datos de centros a centros_new
insert into centros_new
	(numce, nomce)
(select numce, nomce
 from centros
);

select *
from centros_new;

-- Asignamos el depto del empleado 120 al empleado 280
update empleados
set numde = (select numde
			 from empleados
             where numem=120)
where numem = 280;

-- No podemos asignarle a un numde un array de datos
-- tiene que ser un valor escalar
update empleados
set numde = (select numde
			 from empleados
             where salarem = 1200)
where numem = 280;

-- Busca los empleados que ganan más que todos los empleados del depto. 110
select numem, nomem, salarem
from empleados
where salarem > all (select salarem
				 from empleados
                 where numde = 110);
                 
-- En este caso, también se puede hacer así
select numem, nomem, salarem
from empleados
where salarem > (select max(salarem)
				 from empleados
                 where numde = 110);

-- Busca los empleados que ganan lo mismo que alguno de los del depto. 110
select numem, nomem, salarem
from empleados
where salarem = some (select salarem
				 from empleados)
	and numde <> 110;
    
select numem, nomem, salarem
from empleados
where salarem in (select salarem
				 from empleados)
	and numde <> 110;
 
-- Busca empleados que ganen diferente a los del depto 110
select numem, nomem, salarem, numde
from empleados
where salarem not in (select salarem
				 from empleados)
	and numde <> 110;

-- Busca empleados que ganen distinto de todos los empleados del depto 110
select numem, nomem, salarem
from empleados
where salarem <> all(select salarem
				 from empleados)
	and numde <> 110;

-- Añadir un nuevo centro 
start transaction;
set @nuevocentro = (select max(numce)+1 from centros);

insert into centros
	(numce, nomce, dirce)
values
	(@nuevocentro, 'prueba', 'dirce');
commit;