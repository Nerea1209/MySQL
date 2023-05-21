/* ejer p1 */
/* Obtén todos los datos de las obras de la sala 1 y de la sala 3. */
select obras.*
from obras
where obras.codsala = 1 or obras.codsala = 3;

/* ejer p2 */

/*Prepara una consulta que muestre en la primera columna el nombre de la obra 
y el autor de la misma entre paréntesis (por ejemplo “El Guernica (Picasso)” y,
en la segunda y tercera columnas, la sala y la valoración de dicha obra respectivamente. Queremos ver las obras más valoradas primero. 
Además los encabezados de las columnas deben tener un buen aspecto.*/

select concat(obras.nombreobra, ' (', artistas.nomartista,')') as 'Obra y Autor',
		salas.nomsala as Sala, obras.valoracion as ValorObra
from obras join artistas on obras.codartista = artistas.codartista
	join salas on obras.codsala = salas.codsala
order by obras.valoracion desc;
-- order by 3 desc;
-- order by ValorObra desc;

/** P3*/

/* Prepara un procedimiento que muestre, de la forma más eficiente posible, 
los nombres de las obras restauradas entre dos fechas dadas, 
así como el restaurador (su nombre) que realizó el trabajo.
*/

drop procedure if exists exam6_1_ejer3;
delimiter $$
create procedure exam6_1_ejer3 
	(in fecha1 date, 
     in fecha2 date
	)
begin 
 -- call exam6_1_ejer3('2010/1/2','2010/4/2')

	select obras.nomobra, restaurador.nomres
    from obras join restauraciones on obras.codobra = restauraciones.codobra
		join restaurador on restauraciones.codrestaurador = restaurador.codres
	where restauraciones.fecfinrest between fecha1 and fecha2;
end $$
delimiter ;

/* P4 */

/*
Prepara un procedimiento que, dado el nombre de una obra, devuelva el nombre de su autor/'obra anónima' 
su valoración.
*/

drop procedure if exists exam6_1_ejer4;
delimiter $$
create procedure exam6_1_ejer4 
	(in obra varchar(60),
	 out autor varchar(60),
	 out valor decimal (12,2)
	)
begin 
/* call exam6_1_ejer4('La masía',@autor,@valor)
	select @autor, @valor
*/
	select nomartista, valoracion into autor, valor
    from obras join artistas on obras.codartista = artistas.codartista
	where obras.nombreobra = obra;
end $$
delimiter ;

/* P5 */
/*
Prepara un procedimiento que muestre las obras (su nombre) y el nombre de su autor 
de aquellas restauradas entre 2 fechas.

*/

drop procedure if exists exam6_1_ejer5;
delimiter $$
create procedure exam6_1_ejer5 
	(in fecha1 date,
	 in fecha2 date
	)
begin 
 /* call exam6_1_ejer5('2010/1/2','2010/4/2');

*/
	select obras.nombreobra as nombre, artistas.nomartista as artista
    from  restauraciones join obras on restauraciones.codobra = obras.codobra
        join artistas on obras.codartista = artistas.codartista
	where restauraciones.fecfinrest between fecha1 and fecha2;
end $$
delimiter ;

/* P6 */
/*
Prepara un procedimiento que muestre el valor de todas las obras de cada sala 
(la obras de cada sala deben aparecer juntas y queremos que se muesre también el nombre de la obra).
Queremos que se muestre el nombre de la sala. Ten en cuenta que es posible desconocer el valor de algunas obras
*/

drop procedure if exists exam6_1_ejer6;
delimiter $$
create procedure exam6_1_ejer6()
begin 
 /* call exam6_1_ejer6();

*/
	select nomsala, nombreobra, ifnull(valoracion,'sin valorar') 
    from  salas join obras on salas.codsala = obras.codsala
	order by salas.nomsala, nombreobra
end $$
delimiter ;

/*** SI PARA EL EJERCICIO 6 SE PIDIERA QUE SE MOSTRARAN LAS SALAS QUE ESTÁN VACÍAS 
(NO HAY NINGUNA UBICADA EN ELLA) 

	select nomsala, nombreobra, ifnull(valoracion,'sin valorar') 
    from  salas LEFT join obras on salas.codsala = obras.codsala
	order by salas.nomsala, nombreobra

*/
