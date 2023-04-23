/*
Para la bd promociones:
Prepara una vista que se llamará CATALOGOPRODUCTOS  que tenga la referencia del artículo,
código y nombre de categoría, nombre del artículo, el precio base y el precio de venta HOY 
*/

drop view if exists CATALOGOPRODUCTOS;
create view CATALOGOPRODUCTOS as
select articulos.refart, articulos.codcat, categorias.nomcat, articulos.nomart, articulos.preciobase, articulos.precioventa
from articulos
	join categorias on articulos.codcat = categorias.codcat;

/* Para la bd de empresaclase:
Prepara una vista que se llamerá LISTINTELEFONICO en la que cada usuario podrá consultar la extensión
telefónica de los empleados de SU DEPARTAMENTO
PISTA ==> USAR FUNCIÓN DE MYSQL USER()
AL CREAR LA VISTA TENER EN CUENTA ESTO:
[SQL SECURITY { DEFINER | INVOKER }]
*/

drop view if exists LISTINTELEFONICO;
create  sql security invoker view LISTINTELEFONICO as
select empleados.nomem, empleados.extelem
from empleados
where (select empleados.numde
	   from empleados
       where empleados.userem = user()) = empleados.numde;