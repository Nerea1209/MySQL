/** ejemplo con subselect **/
select avg(salarem)
from empleados;

select numde, avg(salarem)
from empleados
group by numde;


select numde, count(distinct extelem), avg(salarem)
from empleados
group by numde

having avg(salarem) > (
					  select avg(salarem)
					  from empleados
						);
/* RELACIÓN 4 - EJERCICIO 22*/

drop procedure if exists proc_ejer_6_4_22;
delimiter $$

create procedure proc_ejer_6_4_22()
begin
	/* call proc_ejer_6_4_22();
	*/
    
    
    
/*SELECT empleados.numde, departamentos.nomde, 
	count(DISTINCT empleados.extelem)
FROM empleados JOIN departamentos 
	on departamentos.numde=empleados.numde
GROUP BY empleados.numde
HAVING avg(empelados.salarem)>
					(SELECT avg(salarem) 
					 FROM empleados)
ORDER BY 1;
*/
end $$
delimiter ;



/* RELACIÓN 4 - EJERCICIO 30*/

SELECT concat(ape1em, ' ', 
	ifnull(ape2em,''),', ', nomem) as nombre
FROM empleados
WHERE salarem >= (SELECT salarem *1.5
				  FROM empleados
				  WHERE concat(nomem, ' ', ape1em, 
							   ifnull(concat(' ', ape2em),'')
							   ) = 'Claudia Fierro');

drop procedure if exists proc_ejer_6_4_30;
delimiter $$

create procedure proc_ejer_6_4_30(in nombre varchar(92))
begin
	/* call proc_ejer_6_4_30('Claudia Fierro');
	*/

SELECT concat(ape1em, ' ', 
	ifnull(ape2em,''),', ', nomem) as nombre
FROM empleados
WHERE salarem >= (SELECT salarem *1.5
				  FROM empleados
				  WHERE concat(nomem, ' ', ape1em, 
							   ifnull(concat(' ', ape2em),'')
							   ) = nombre
				)
ORDER BY 1;
end $$
delimiter ;

/* RELACIÓN 4 - EJERCICIO 34 */
/*
SELECT CONCAT(ape1em , ifnull(concat(' ',ape2em),'') , ', ' , nomem) AS NOMBRE
FROM empleados
WHERE numde =(SELECT numde
			  FROM empleados
			  WHERE ape1em = 'GALVEZ' AND nomem = 'PILAR')
	OR numde = (SELECT numde
			    FROM empleados
				WHERE ape1em = 'FLOR' AND nomem = 'DOROTEA')
ORDER BY 1;
-- ORDER BY NOMBRE;
-- ORDER BY CONCAT(ape1em , ifnull(concat(' ',ape2em),'') , ', ' , nomem);
-- ORDER BY ape1em , ifnull(concat(' ',ape2em),''),nomem
*/
/* con la siguiente versión tendremos que utilizar un operador CUANTIFICADOS ==> SOME, ANY, ALL, [NOT] IN, [NOT] EXISTS)
*/
SELECT CONCAT(ape1em , ifnull(concat(' ',ape2em),'') , ', ' , nomem) AS NOMBRE
FROM empleados
/*
WHERE numde =SOME (SELECT numde
				   FROM empleados
			       WHERE (ape1em = 'GALVEZ' AND nomem = 'PILAR') or 
				      (ape1em = 'FLOR' AND nomem = 'DOROTEA'));*/
/*WHERE numde =ANY (SELECT numde
				   FROM empleados
			       WHERE (ape1em = 'GALVEZ' AND nomem = 'PILAR') or 
				      (ape1em = 'FLOR' AND nomem = 'DOROTEA'));
*/

WHERE numde IN (SELECT numde
			    FROM empleados
				WHERE (ape1em = 'GALVEZ' AND nomem = 'PILAR') or 
				      (ape1em = 'FLOR' AND nomem = 'DOROTEA'));

/* RELACIÓN 4 - EJERCICIO 35 */

SELECT nomem
FROM empleados
WHERE salarem >= (SELECT min(salarem)*3.5
				  FROM empleados
				  WHERE numde =122)
ORDER BY nomem;

/* RELACIÓN 4 - EJERCICIO 36 */

SELECT numhiem, count(*), max(salarem) as salario_max, min(salarem) as salario_min
FROM empleados
where numhiem >=1
group by numhiem
having count(*) > 1;

/* ejer 28 */

-- select nomem, year(curdate()), year(fecnaem), 
-- 	year(curdate()) -year(fecnaem) , datediff(curdate(), fecnaem)
create view jubilados
as 
select *
from empleados
-- los que cumplen 65 años en el año actual
-- where year(curdate()) -year(fecnaem) = 65

-- los que ya tienen cumplidos los 65 a fecha de hoy
where date_add(fecnaem, interval 65 year) <= curdate();

-- los que ya tienen cumplidos los 65 a fecha de hoy y los han
-- cumplido este año
-- where date_add(fecnaem, interval 65 year) <= curdate()
-- 	and year(curdate()) = year(date_add(fecnaem, interval 65 year))

-- en lugar de date_add, podríamos usar también date_sub:
-- where date_sub(curdate(), interval 65 year) >= fecnaem
select * from  jubilados;