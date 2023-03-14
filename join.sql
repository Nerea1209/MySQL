use empresaclase;
-- averiguar los nombres de los empleados que trabajan en la c/ atocha:
select empleados.numem, empleados.nomem, empleados.numde,
	   departamentos.numde, departamentos.numce, centros.numce
from centros join departamentos on centros.numce = departamentos.numce
			 join empleados on departamentos.numde = empleados.numde
where centros.dirce like '%atocha%';

-- Obtén una lista de nombres de centros y nombres de departamento
-- (El departamento en el que están)
select centros.numce, nomce, nomde
from centros join departamentos on centros.numce = departamentos.numce
order by nomce;

-- Obtén una lista de nombres de centros y nombres de departamento
-- (El departamento en el que están) queremos que nos muestren
-- todos los centros y si no tienen departamentos ponga null
select centros.numce, nomce, nomde
from centros left join departamentos on centros.numce = departamentos.numce
order by nomce;

-- averiguar los nombres de los empleados que trabajan en la c/ atocha:
-- Incluir el nombre del director de cada departamento
select centros.nomce, departamentos.nomde, empleados.nomem, dirigir.numempdirec,
e1.nomem
from centros join departamentos on centros.numce = departamentos.numce
			 join empleados on departamentos.numde = empleados.numde
             join dirigir on departamentos.numde = dirigir.numdepto
             join empleados as e1 on dirigir.numempdirec = e1.numem
where fecfindir is null
order by nomce, nomde, empleados.nomem;