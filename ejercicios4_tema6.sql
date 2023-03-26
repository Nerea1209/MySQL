use empresaclase;
-- 1. Obtener por orden alfabético el nombre y los sueldos de los empleados con más de tres hijos.
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	empleados.salarem as 'Sueldo'
from empleados
where empleados.numhiem >= 3
order by nomem, ape1em, ape2em;
/* 2. Obtener la comisión, el departamento y el nombre de los empleados cuyo salario es inferior a 190.000 u.m., 
clasificados por departamentos en orden creciente y por comisión en orden decreciente dentro de cada departamento. */
select empleados.numde as 'Departamento',
	concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	empleados.comisem as 'Comisión',
    empleados.salarem as 'Salario'
from empleados
where empleados.salarem < 190000
-- group by empleados.numde
order by empleados.numde asc, empleados.comisem desc;
-- 3. Hallar por orden alfabético los nombres de los deptos cuyo director lo es en funciones y no en propiedad.
select departamentos.nomde
from departamentos
	join dirigir on departamentos.numde = dirigir.numdepto
where dirigir.tipodir = 'F' or dirigir.tipodir = 'f'
order by departamentos.nomde;
/* 4. Obtener un listín telefónico de los empleados del departamento 121 incluyendo el nombre del empleado, 
número de empleado y extensión telefónica. Ordenar alfabéticamente.*/
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	empleados.numem as 'Número',
    empleados.extelem as 'Extensión telefónica'
from empleados
where empleados.numde = 121
order by nomem, ape1em, ape2em;
/* 5. Hallar la comisión, nombre y salario de los empleados con más de tres hijos, clasificados por comisión y 
dentro de comisión por orden alfabético.*/
select empleados.comisem as 'Comisión',
	concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
    empleados.salarem as 'Salario'
from empleados
where empleados.numhiem > 3
group by empleados.comisem
order by nomem, ape1em, ape2em;
/* 6. Hallar por orden de número de empleado, el nombre y salario total (salario más comisión) de los 
empleados cuyo salario total supere las 300.000 u.m. mensuales. */
select empleados.numem as 'Número',
	concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
    (empleados.salarem + empleados.comisem) as 'Salario total'
from empleados
where (empleados.salarem + empleados.comisem) > 3000
order by numem;
-- 7. Obtener los números de los departamentos en los que haya algún empleado cuya comisión supere al 20% de su salario.
select distinct empleados.numde
from empleados
where empleados.comisem > ((empleados.salarem * 20)/100);
/* 8. Hallar por orden alfabético los nombres de los empleados tales que si se les da una gratificación de 100 u.m. 
por hijo el total de esta gratificación no supere a la décima parte del salario.*/
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	(empleados.salarem + (100 * ifnull(0, empleados.numhiem))) as 'SalarioConGratificación'
from empleados
where (100 * ifnull(0, empleados.numhiem)) < ((1/10) * empleados.salarem);
/* 9. Llamaremos presupuesto medio mensual de un depto. al resultado de dividir su presupuesto anual por 12. 
Supongamos que se decide aumentar los presupuestos medios de todos los deptos en un 10% a partir del mes de 
octubre inclusive. Para los deptos. cuyo presupuesto mensual anterior a octubre es de más de 500.000 u.m. 
Hallar por orden alfabético el nombre de departamento y su presupuesto anual total después del incremento.*/
select nomde,
	(departamentos.presude/12) as 'Presupuesto medio mensual',
	((departamentos.presude + 3*(0,1*(departamentos.presude/12)))/12) as 'Presupuesto con aumento'
from departamentos
where (departamentos.presude/12) > 500000
order by nomde, ((departamentos.presude + 3*(0,1*(departamentos.presude/12)))/12);

/* 10. Suponiendo que en los próximos tres años el coste de vida va a aumentar un 6% anual y que se suben los 
salarios en la misma proporción. Hallar para los empleados con más de cuatro hijos, su nombre y sueldo anual, 
actual y para cada uno de los próximos tres años, clasificados por orden alfabético.*/

/* 15. Hallar los nombres de los empleados que no tienen comisión, clasificados de manera que aparezcan 
primero aquellos cuyos nombres son más cortos.*/
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	empleados.comisem as 'Comisión'
from empleados
where empleados.comisem is null or empleados.comisem = 0
order by length(nomem);
-- 18. Hallar la diferencia entre el salario más alto y el más bajo.
select max(empleados.salarem) as 'Salario máximo',
	min(empleados.salarem) as 'Salario mínimo',
    (max(empleados.salarem) - min(empleados.salarem)) as 'Diferencia'
from empleados;
-- 19. Hallar el número medio de hijos por empleado para todos los empleados que no tienen más de dos hijos.
select avg(empleados.numhiem) as 'numMedioHijos'
from empleados
where empleados.numhiem <= 2;
-- 21. Para cada extensión telefónica, hallar cuantos empleados la usan y el salario medio de éstos.
select empleados.extelem as 'Extensión telefónica',
	count(empleados.numem) as 'numEmpleados',
    avg(empleados.salarem) as 'Salario medio'
from empleados
group by empleados.extelem;
-- 24. Hallar por orden alfabético, los nombres de los empleados que son directores en funciones.
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	dirigir.tipodir as 'Tipo'
from empleados
	join dirigir on empleados.numem = dirigir.numempdirec
where dirigir.tipodir = 'F' or dirigir.tipodir = 'f'
order by nomem, ape1em, ape2em;
/* 25. A los empleados que son directores en funciones se les asignará una gratificación del 5% de su salario. 
Hallar por orden alfabético, los nombres de estos empleados y la gratificación correspondiente a cada uno.*/
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	dirigir.tipodir as 'Tipo',
	(0.05 * empleados.salarem) as 'Gratificación'
from empleados
	join dirigir on empleados.numem = dirigir.numempdirec
where dirigir.tipodir = 'F' or dirigir.tipodir = 'f'
order by nomem, ape1em, ape2em;
-- 29. Seleccionar los nombres de los  departamentos que no dependan de ningún otro.
select departamentos.nomde, departamentos.depende
from departamentos
where departamentos.depende is null or departamentos.depende = 0;
-- 33. Obtener los nombres y salarios de los empleados cuyo salario coincide con la comisión de algún otro o la suya propia.
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	empleados.salarem as 'Salario',
    empleados.comisem as 'Comisión'
from empleados
where empleados.salarem = empleados.comisem; -- No se como hacerlo para que coincida con algun otro
/* 34. Obtener por orden alfabético los nombres de los empleados que trabajan en el mismo departamento 
que Pilar Gálvez o Dorotea Flor.*/
select concat_ws(' ', nomem, ape1em, ape2em) as 'Nombre',
	empleados.numde as 'Departamento'
from empleados
where empleados.numde = (empleados.numde and nomem = 'Pilar' and ape1em = 'Gálvez')
	or empleados.numde = (empleados.numde and nomem = 'Dorotea' and ape1em = 'Flor')
order by nomem, ape1em, ape2em;
-- 37. Hallar el centro de trabajo (nombre y dirección) de los empleados sin comisión.
select distinct centros.nomce, centros.dirce
from centros
	join departamentos on centros.numce = departamentos.numce
		join empleados on departamentos.numde = empleados.numde
where empleados.comisem is null or empleados.comisem = 0;
-- 38. Hallar cuantos empleados no tienen comisión en un centro dado.
delimiter $$
drop procedure if exists empSinCom $$
create procedure empSinCom (
	numCentro int)
begin
	select count(empleados.numem)
	from empleados
    where empleados.comisem is null or empleados.comisem = 0;
end $$
delimiter ;
call empSinCom(10);
-- 39. Hallar cuantos empleados no tienen comisión por cada centro de trabajo.
-- Es igual al anterior