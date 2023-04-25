/* P1 */

select *
from reservas
where fecreserva between '2021/01/01' and '2021/03/30' and numdiasestancia >=3;

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
drop procedure if exists badat_2020_2021_exam_6_1_G2_ejer_3;
delimiter $$
create procedure badat_2020_2021_exam_6_1_G2_ejer_3
(in caracteristica int ) 
-- call badat_2020_2021_exam_6_1_G2_ejer_3(1);
begin
	select casas.codcasa, casas.nomcasa, casas.poblacion, tiposcasa.nomtipo
    from casas join tiposcasa on casas.codtipocasa = tiposcasa.numtipo
		join caracteristicasdecasas on casas.codcasa = caracteristicasdecasas.codcasa
    where caracteristicasdecasas.codcaracter = caracteristica and caracteristicasdecasas.tiene = 1
    order by casas.poblacion, casas.m2 desc;
	
end $$
delimiter ;

/* P4 */
drop procedure if exists badat_2020_2021_exam_6_1_G2_ejer_4;
delimiter $$
create procedure badat_2020_2021_exam_6_1_G2_ejer_4
(in casa int ) 
-- call badat_2020_2021_exam_6_1_G2_ejer_4(1);
-- call badat_2020_2021_exam_6_1_G2_ejer_4(2);
begin
	select nomcaracter
    from caracteristicas join caracteristicasdecasas
		on caracteristicas.numcaracter = caracteristicasdecasas.codcaracter
    where caracteristicasdecasas.codcasa= casa and caracteristicasdecasas.tiene = 1;
end $$
delimiter ;

/* P5 */
drop procedure if exists badat_2020_2021_exam_6_1_G2_ejer_5;
delimiter $$
create procedure badat_2020_2021_exam_6_1_G2_ejer_5
(in nombrezona varchar(20),
 in descripzona varchar(200),
 out numerozona int
) 
/*
call badat_2020_2021_exam_6_1_G2_ejer_5('zona nueva', 'descripción de zona nueva',@zonaAsignada);
select concat_ws(' ','La zona asignada a zona nueva es:',@zonaAsignada);
*/

begin
	start transaction;
		select ifnull(max(numzona),0)+1 into numerozona
		from zonas;
        insert into zonas
			(numzona, nomzona, deszona)
		values
			(numerozona, nombrezona, descripzona);
	commit;
end $$
delimiter ;

/* P6 */
drop procedure if exists badat_2020_2021_exam_6_1_G2_ejer_6;
delimiter $$
create procedure badat_2020_2021_exam_6_1_G2_ejer_6
(in reserva int, 
out nombrepropi varchar(100),
out tlf_email_propi varchar(75)

) 
/*
call badat_2020_2021_exam_6_1_G2_ejer_6(1,@propietario, @tlf_email);
select concat('El teléfono y correo del propietario ', @propietario,' son: ',
	ifnull(@tlf_email,'el propietario no tiene teléfono/email')) as consulta;
*/
begin
	select propietarios.nompropietario, 
		concat_ws('//',propietarios.tlf_contacto, propietarios.correoelectronico) into nombrepropi, tlf_email_propi
    from reservas join casas on reservas.codcasa = casas.codcasa
		join propietarios on casas.codpropi = propietarios.codpropietario
    where reservas.codreserva = reserva;
end $$
delimiter ;

