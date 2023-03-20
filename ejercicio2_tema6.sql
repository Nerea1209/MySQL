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