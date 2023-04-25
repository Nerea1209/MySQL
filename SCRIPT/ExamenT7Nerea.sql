-- EXAMEN U.7: MANIPULACIÓN DE DATOS EN UNA BD EN MYSQL SERVER III
-- Nerea López Sánchez
-- 25/04/2023

-- 1. Solo resto los meses, necesito restar fechas
select tests.codtest, materias.nommateria, tests.feccreacion, tests.fecpublic,
	(datediff(tests.fecpublic, tests.feccreacion)/30) as 'Diferencia fechas'
from tests
	join materias on tests.codmateria = materias.codmateria
where (datediff(tests.fecpublic, tests.feccreacion)/30) >= 3;

/*
insert into tests
(codtest, codmateria, feccreacion, fecpublic)
values
	(6, 1, '2010-06-1', '2020-08-2');
*/
    
-- 2. 
delimiter $$
drop function if exists ej2 $$
create function ej2
	(numExp char(12))
returns varchar(60)
deterministic
begin
	return(select concat(left(alumnos.nomalum,1),right(alumnos.nomalum,1),
		left(mid(alumnos.ape1alum, length(ape1alum)/2),3),
		month(alumnos.fecnacim), '@micentro.es')
	from alumnos
    where alumnos.numexped = numExp);
end$$
delimiter ;
select ej2('10');

-- 3.
delimiter $$
drop procedure if exists ej3 $$
create procedure ej3
	(numExp char(12))
deterministic
begin
	select numexped, codtest, numrepeticion, count(respuesta)
	from respuestas
    where respuesta in (select resvalida
						from preguntas
							join respuestas on preguntas.codtest = respuestas.codtest
								and preguntas.numpreg = respuestas.numpreg
						where numexped = numExp)
	 -- and (select coun)
	group by numexped, codtest, numrepeticion;
   -- having numexped = numExp;
end $$
delimiter ;
call ej3('1');

-- 4.
-- Tests que tiene cada materia
select nommateria, cursomateria, count(tests.codtest)
from materias
    join tests on materias.codmateria = tests.codmateria
group by nommateria, cursomateria;
/*
		
			join preguntas on test.codtest = preguntas.codtest
				join respuestas on preguntas.codtest = respuestas.codtest
					and preguntas.numpreg = respuestas.numpreg
where respuestas.numexped
*/

-- 5.
delimiter $$
drop procedure if exists ej5 $$
create procedure ej5
	()
deterministic
begin
	select numexped, concat_ws(nomalum, ape1alum, ape2alum) as 'Nombre Completo'
	from alumnos
	where (numexped not in (select numexped from matriculas))
		and (numexped in (select numexped from respuestas));
end $$
delimiter ;
call ej5();

-- 6
drop view if exists ej6;
create view ej6 
	(codMateria, nomMateria, codTest, desTest, textoValida, numPreg, esRepetible) as
select materias.codmateria, materias.nommateria, tests.codtest, tests.descrip,
	respuestaValida(preguntas.resvalida, preguntas.resa, preguntas.resb, preguntas.resc), 
    (select count(codtest) from preguntas), ifnull(tests.repetible, 0)
from materias
	join tests on materias.codmateria = tests.codmateria
		join preguntas on tests.codtest = preguntas.codtest;






DELIMITER $$
drop function if exists respuestaValida $$
CREATE FUNCTION respuestaValida (r char(1), a varchar(100), b varchar(100), c varchar(100))
RETURNS VARCHAR(100)
deterministic
BEGIN
	DECLARE texto VARCHAR(100);
	IF r = 'a' THEN SET texto = a;
	ELSEIF r = 'b' THEN SET texto = b;
	ELSE SET texto = c;
    end if;
    return texto;
END $$
DELIMITER ;



