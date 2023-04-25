/* P1 */

select *
from casas
where minpersonas >=4 and maxpersonas <=6 and provincia = 'Sevilla';

/* P2 */
/****************** OJO ******************************/
/** solo aparecerán las que hayan tenido devolución **/
/*****************************************************/
/***************** RAZÓN: *******************************************/
/***** LAS QUE NO HAYAN TENIDO DEVOLUCIÓN NO ESTARÁN INCLUIDAS ******/
/***** EN EL CONJUNTO DE RESULTADOS OBTENIDO EN EL FROM        ******/
/********************************************************************/

/***************** SOLUCIÓN: ****************************************/
/************** RIGHT/LEFT JOIN *************************************/
/******** (no entraba en este examen) *******************************/
/********************************************************************/

select reservas.codreserva as CódigoReserva, 
	concat_ws(' ',clientes.nomcli, clientes.ape1cli, clientes.ape2cli) as NombreCliente, 
	ifnull(devoluciones.importedevol ,0) as Devolución
from reservas join clientes on reservas.codcliente = clientes.codcli 
	join devoluciones on reservas.codreserva = devoluciones.codreserva 
	
where reservas.fecanulacion>='2021/1/1';

/* P3 */
drop procedure if exists badat_2020_2021_exam_6_1_G1_ejer_3;
delimiter $$
create procedure badat_2020_2021_exam_6_1_G1_ejer_3
(in caracteristica int ) 
-- call badat_2020_2021_exam_6_1_G1_ejer_3(1);
begin
	select casas.codcasa, casas.nomcasa, casas.poblacion, tiposcasa.nomtipo
    from casas join tiposcasa on casas.codtipocasa = tiposcasa.numtipo
		join caracteristicasdecasas on casas.codcasa = caracteristicasdecasas.codcasa
    where caracteristicasdecasas.codcaracter = caracteristica
    order by casas.poblacion, casas.preciobase desc;
	
end $$
delimiter ;

/* P4 */
drop procedure if exists badat_2020_2021_exam_6_1_G1_ejer_4;
delimiter $$
create procedure badat_2020_2021_exam_6_1_G1_ejer_4
(in zona int ) 
-- call badat_2020_2021_exam_6_1_G1_ejer_4(1);
begin
	select nomcasa, poblacion
    from casas
    where codzona = zona;
end $$
delimiter ;

/* P5 */
drop procedure if exists badat_2020_2021_exam_6_1_G1_ejer_5;
delimiter $$
create procedure badat_2020_2021_exam_6_1_G1_ejer_5
(in numzona int, -- inout numzona int
 out nomzona varchar(20),
 out deszona varchar(200)
) 
/*
call badat_2020_2021_exam_6_1_G1_ejer_5(1, @nombreZona, @descripZona);
select @nombreZona, @descripZona;

-- o también (si el código de zona es inout:
set @cod
call badat_2020_2021_exam_6_1_G1_ejer_5(1, @nombreZona, @descripZona);
select @nombreZona, @descripZona;

*/
begin
	select zonas.nomzona, count(*), avg(casas.preciobase)
    from zonas left join casas
		on zonas.numzona = casas.codzona
    group by zonas.nomzona;
end $$
delimiter ;

/* P6 */
drop procedure if exists badat_2019_2020_exam_6_1_ejer_6;
delimiter $$
create procedure badat_2019_2020_exam_6_1_ejer_6
(in reserva int, 
out telefono char(9)
) 
/*
call badat_2019_2020_exam_6_1_ejer_6(1,@telefono);
select concat('El teléfono del cliente es: ',ifnull(@telefono,'el cliente no tiene teléfono')) as consulta;
*/
begin
	select clientes.tlf_contacto into telefono
    from reservas join clientes on reservas.codcliente = clientes.codcli
    where reservas.codreserva = reserva;
end $$
delimiter ;

