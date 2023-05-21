/* ejercicio 1*/
select * 
from empleados;

/* ejercicio 2*/
select empleados.extelem 
from empleados
where nomem = 'Juan' and ape1em = 'López'; -- equivale a lo siguiente:
-- where concat(empleados.nomem, ' ', empleados.ape1em) = 'Juan López';
-- where concat_ws(' ', empleados.nomem, empleados.ape1em) = 'Juan López';

/* ejercicio 3*/
select empleados.nomem, empleados.ape1em, empleados.ape2em -- , empleados.numhiem
from empleados
where numhiem > 1;
-- si quisiéramos aquellos empleados con menos de 1 hijo
-- e interpretamos que los que el campo numhiem es nulo
-- es como si no tuvieran hijos:
select empleados.nomem, empleados.ape1em, empleados.ape2em, 
	empleados.numhiem as 'número Hijos', ifnull(numhiem,0) as conversión
from empleados
-- where numhiem <1;
where numhiem is null or numhiem <1;
-- where ifnull(numhiem,0) < 1;

/* ejercicio 4*/

select CONCAT(nomem, ' ',ape1em, ' ',ape2em) as nomcompleto_concat_null_sin_tratar,
		CONCAT(nomem, ' ',
			  ape1em, ' ',
			 ifnull(ape2em,'')
			) as nomcompleto_concat_null_tratados, 
        concat_ws(' ', nomem, ape1em, ape2em) as nomcompleto_concat_ws
from empleados
-- where numhiem >= 1 and numhiem <= 3;
where numhiem between 1 and 3; -- es más eficiente
-- where ifnull(numhiem,0) not between 1 and 3; -- nos quedamos con todos los que el numhiem esté fuera del rango (1,3)
-- where ifnull(numhiem,0) <1 or numhiem >3;

/* ejercicio 5*/
select CONCAT(nomem, ' ',
			  ape1em, ' ',
			 ifnull(ape2em, '') 
		) as nombreCompleto, comisem
from empleados

-- where comisem is null or comisem =0;
where ifnull(comisem,0) = 0;

/* ejercicio 6*/
select dirce
from centros
-- where centros.nomce = ' SEDE CENTRAL';
-- El anterior no obtiene resultados porque los nombres
-- de centro tienen espacios en blanco
-- para quitar los espacios usamos ltrim y rtrim:
-- where rtrim(ltrim(centros.nomce)) = 'Sede Central';
where lower(trim(nomce)) = 'sede central';


-- Pregunta ==> ¿una sentencia select llevará from siempre?
-- Respuesta==> cuando queremos obtener algo de una bd si, pero SELECT (sola) puede ser como la función 'System.out.println()' de java
select 3*56 +(SELECT ifnull(comisem,0) from empleados where numem =110) as resultado;

/* Estas funciones deben usarse en el insert,
para asegurarnos que los datos son introducidos
sin espacios antes o después de la cadena */


insert into centros
(numce, nomce, dirce)
values
(40, rtrim(ltrim('  centro nuevo  ')), 
	ltrim(rtrim('   C/ Pepe Sánchez   ')));

/* ejercicio propuesto:
En la tabla centros existen centros cuyo nombre y
dirección contienen espacios en blanco a la izq. y/o
derecha de la cadena. Modifícalos */

update centros
set nomce = ltrim(rtrim(nomce)), 
	-- o también nomce = rtrim(ltrim(nomce))
	dirce = ltrim(rtrim(dirce))  
    -- o también dirce = rtrim(ltrim(dirce))
;

/* EJERCICIO 7 */

select nomde
from departamentos
where presude > 6000;

/* EJERCICIO 8 */

select nomde
from departamentos
where presude >= 6000;
-- para obtener aquellos cuyo presupuesto sea distinto a 6000:
select nomde
from departamentos
where presude <> 6000;

/* EJERCICIO 9 */
select CONCAT(nomem, ' ',
			  ape1em, ' ',
			 ifnull(ape2em,'')
		) -- , fecinem
from empleados
where fecinem <= '2021/2/14';
-- where fecinem <= date_sub(curdate(), interval 1 year);
-- where fecinem <= subdate(curdate(), interval 1 year);
-- where fecinem <= adddate(curdate(), interval -1 year);
-- where fecinem <= date_add(curdate(), interval -1 year);


/* EJERCICIO 10 */
select CONCAT(nomem, ' ',
			  ape1em, ' ',
			 ifnull(ape2em,'')
		)
from empleados
-- where fecinem >= '2018/2/14' and fecinem <= '2021/2/14';
-- where fecinem between '2018/2/14' and '2021/2/14';
where fecinem between date_sub(curdate(), interval 3 year) 
				and date_sub(curdate(), interval 1 year);
