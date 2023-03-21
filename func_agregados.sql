use empresaclase;

-- CUANTOS EMPLEADOS HAY
select count(*), count(numem), count(distinct numde) -- CUENTA CELDAS
from empleados;

-- cuanto me cuesta al mes pagar a mis empleados
select sum(salarem)
from empleados;

-- cual es el salario máximo
select max(salarem)
from empleados;

-- cual es el salario mínimo
select min(salarem)
from empleados;

-- cual es la media de salarios
select avg(salarem)
from empleados;

select count(*) as numEmpleados,
	sum(salarem) as totalSalarios,
    max(salarem) as maxSalario,
    min(salarem) as minSalario,
    avg(salarem) as mediaSalarios
from empleados;

select nomde , count(*) as numEmpleados,
	sum(salarem) as totalSalarios,
    max(salarem) as maxSalario,
    min(salarem) as minSalario,
    avg(salarem) as mediaSalarios
from empleados
group by departamentos;

-- una rutina que me devuleva el numero de extensiones 
-- que utiliza un departamento
delimiter $$
drop function if exists numExtDepto $$
create function numExtDepto (
	numDepto int)
returns int deterministic
begin
	return (select count(distinct empleados.extelem) as numExtensiones
    from empleados 
    where departamentos.numde = numDepto);
end $$

delimiter ;

select nomde, numExtDepto(numde)
from departamentos
order by nomde;
