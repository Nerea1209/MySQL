/* ejer 1*/
delimiter $$
drop procedure if exists ejer_u6_r5_e1 $$
create procedure ejer_u6_r5_e1(in inicial char(1))
begin
	-- call ejer_u6_r5_e1('a')
	
select *
from productos
where left(descripcion,1) = inicial;
end $$
delimiter ;

/* ejer 2*/
delimiter $$
drop procedure if exists ejer_u6_r5_e2 $$
create procedure ejer_u6_r5_e2(in proveedor int, out contraseña char(9))
begin
	/* call ejer_u6_r5_e2(1, @contraseña);
	   select @contraseña;
	*/
	
select reverse(telefono) into contraseña
from proveedores
where codproveedor = proveedor;
end $$
delimiter ;

/* ejer 3*/
delimiter $$
drop procedure if exists ejer_u6_r5_e3 $$
create procedure ejer_u6_r5_e3(in categoria int)
begin
	/* call ejer_u5_r5_e3(1);
	*/
	
select pedidos.codpedido, convert(ifnull(month(fecentrega),'sin especificar'), char(15))
	-- ifnull(month(fecentrega),'sin especificar') /* funcionaría así también, solo que por cuestines de aspecto es mejor con convert*/
from pedidos join productos on pedidos.codproducto = productos.codproducto
where productos.codcategoria=categoria and 
	(pedidos.fecentrega >= curdate() or pedidos.fecentrega is null);
end $$
delimiter ;

/* ejer 4*/

select Nomcategoria, left(Nomcategoria, 3),
	substring(Nomcategoria, 1, 3)
from categorias;

/* ejer 5*/

select descripcion, preciounidad, power(preciounidad, 2) as CUADRADO,
	power(preciounidad, 3) as CUBO
from productos;

/* ejer 6*/

select month(curdate()), monthname(curdate());

/* 7. Para los pedidos entregados el mismo mes que el 
actual, obtener cuantos días hace que se entregaron.
*/

select fecentrega, datediff(curdate(), fecentrega),
	datediff(fecentrega, curdate())
from pedidos
where month(fecentrega) = month(curdate())
	and year(fecentrega) = year(curdate());

/* ejer 8*/

select descripcion from productos
where descripcion like '%pastel%';

update productos
set descripcion = replace(descripcion, 'Tarta', 'pastel');
-- where descripcion like '%Tarta%';

/* ejercicio 9 */
select codpostal,right(codpostal,3),
	substring(codpostal, 3,3), ciudad
from proveedores;

/* ejemplos con subcadenas */
select right('hola que tal', 3);
select right('29680', 3);

set @cadena = '29680';
select length(@cadena);

select substring(@cadena, length(@cadena)-2,3);

/* ejercicio 10*/

select upper(categorias.Nomcategoria), count(*) as numProductos
from productos join categorias on categorias.codcategoria = productos.codcategoria
group by categorias.Nomcategoria;


/* ejercicio 11*/

select Nomcategoria, productos.descripcion
from categorias join productos on
	productos.codcategoria = categorias.codcategoria
order by Nomcategoria, length(productos.descripcion);

/* ejercicio 12 */

update productos
set descripcion= trim(descripcion);


/*
13. Lo mismo que en el ejercicio 2, pero ahora, además, sustituye el 4 y 5 número del resultado por las 2 últimas letras del nombre de la empresa.
*/

select telefono, reverse(telefono),
	   substring(reverse(telefono), 4,2),
		right(nomempresa,2),
		replace(reverse(telefono),
				substring(reverse(telefono), 4,2),
				right(nomempresa,2))
from proveedores;

/* ejercicio 14 */

select descripcion, round(preciounidad*0.10,2)
from productos;

/* ejercicio 15*/
-- NOTA.- Convertir a char(12) es simplemente por cuestiones de formato, no es necesario
select descripcion, convert(repeat(concat(codproducto, codcategoria),2), char(12)) as resultado,
	repeat(concat(codproducto, codcategoria),2) as SinFormato
from productos;

