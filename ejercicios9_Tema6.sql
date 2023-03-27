-- PARA EMPRESACLASE
use empresaclase;
/*
	1. Queremos obtener un listado en el que se muestren los nombres de departamento y 
    el número de empleados de cada uno. Ten en cuenta que algunos departamentos no tienen 
    empleados, queremos que se muestren también estos departamentos sin empleados. 
    En este caso, el número de empleados se mostrará como null.
*/
select departamentos.nomde, 
	count(empleados.numde)
from departamentos
	left join empleados on departamentos.numde = empleados.numde
group by departamentos.nomde;

/*
	2. Queremos averiguar si tenemos algún departamento sin dirección, para ello queremos 
    mostrar el nombre de cada departamento y el nombre del director actual, para aquellos 
    departamentos que en la actualidad no tengan director, queremos mostrar el nombre del 
    departamento y el nombre de la dirección como null.
*/
select departamentos.nomde as 'Departamento',
	ifnull(null, concat_ws(nomem, ape1em, ape2em)) as 'Director'
from departamentos
	left join dirigir on departamentos.numde = dirigir.numdepto
		left join empleados on dirigir.numempdirec = empleados.numem
where dirigir.fecfindir is null or dirigir.fecfindir >= curdate()
group by departamentos.nomde;
