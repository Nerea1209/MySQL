/*
Queremos saber el importe de las ventas de artículos a cada uno de nuestros clientes 
(muestra el nombre). Queremos que cada cliente se muestre una sola vez y que aquellos 
a los que hayamos vendido más se muestren primero.
*/

select distinct clientes.codcli, concat_ws(nomcli, ape1cli, ape2cli) as 'Nombre cliente',
	sum(detalleventa.precioventa) as 'Importe ventas'
from clientes
	join ventas on clientes.codcli = ventas.codcli
		join detalleventa on ventas.codventa = detalleventa.codventa
group by codcli
order by sum(detalleventa.precioventa) desc;

/*
Muestra un listado de todos los artículos vendidos, queremos mostrar la descripción del 
artículo y entre paréntesis la descripción de la categoría a la que pertenecen y la 
fecha de la venta con el formato “march - 2016, 1 (tuesday)”. Haz que se muestren 
todos los artículos de la misma categoría juntos.
*/

select articulos.desart as 'Descripción artículo',
	concat('(', categorias.descat)
