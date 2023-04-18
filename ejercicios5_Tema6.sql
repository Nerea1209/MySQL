-- 1. Obtener todos los productos que comiencen por una letra determinada.
-- El % sirve para decir que sea cualquier caracter
delimiter $$
drop procedure if exists ej1 $$
create procedure ej1
	(
    letra char
    )
deterministic
begin
	select *
	from productos
	where descripcion like concat(letra, '%');
end $$
delimiter;

call ej1('C');

/*
2. Se ha diseñado un sistema para que los proveedores puedan acceder 
a ciertos datos, la contraseña que se les da es el teléfono de la empresa 
al revés. Se pide elaborar un procedimiento almacenado que dado un proveedor 
obtenga su contraseña y la muestre en los resultados.
*/

delimiter $$
drop procedure if exists ej2 $$
create procedure ej2
	(
	codProv int
	)
deterministic
begin
	select reverse(telefono) as 'Contraseña'
    from proveedores
    where codproveedor = codProv;
end $$
delimiter ;

call ej2(2);

/*
3. Obtener el mes previsto de entrega para los pedidos que no se han 
recibido aún y para una categoría determinada.
*/

delimiter $$
drop procedure if exists ej3 $$
create procedure ej3
	(
	codCat int
	)
deterministic
begin
	select pedidos.codpedido as 'Pedido', 
		monthname(pedidos.fecentrega) as 'Mes previsto de entrega'
    from categorias
		join productos on categorias.codcategoria = productos.codcategoria
			join pedidos on pedidos.codproducto = pedidos.codproducto
    where categorias.codcategoria = codCat and pedidos.fecentrega > curdate();
end $$
delimiter ;

call ej3(8);

/*
4. Obtener un listado con todos los productos, ordenados por categoría, 
en el que se muestre solo las tres primeras letras de la categoría.
*/

delimiter $$
drop procedure if exists ej4 $$
create procedure ej4
	(
		codCat int
	)
deterministic
begin
	select left(categorias.Nomcategoria, 3) as '3 primeras letras de Categoría', 
		productos.codproducto as 'Producto', 
        categorias.descripcion as 'Descripción'
    from productos
		join categorias on productos.codcategoria = categorias.codcategoria
    where categorias.codcategoria = codCat;
end $$
delimiter ;

call ej4(8);

-- 5. Obtener el cuadrado y el cubo de los precios de los productos.
select round(pow(productos.preciounidad, 2),2) as 'Precio del producto al cuadrado',
	round(pow(productos.preciounidad, 3),2) as 'Precio del producto al cubo'
from productos;

-- 6. Devuelve la fecha del mes actual. 
-- Devuelve el mes de una fecha NUMERO
delimiter $$
drop function if exists ej6_1 $$
create function ej6_1 
	(
		fecha date
	)
returns varchar(10)
deterministic
begin
	return (month(fecha));
end $$
delimiter ;

select ej6_1(curdate());

-- Devuelve el mes de una fecha NOMBRE
delimiter $$
drop function if exists ej6_2 $$
create function ej6_2 
	(
		fecha date
	)
returns varchar(10)
deterministic
begin
	return (monthname(fecha));
end $$
delimiter ;

select ej6_2(curdate());

-- 7. Para los pedidos entregados el mismo mes que el actual, 
-- obtener cuantos días hace que se entregaron.
select codpedido, fecentrega, 
	timestampdiff(day, fecentrega, curdate()) as 'Días que han pasado desde que se entregó'
from pedidos;

-- 8. En el nombre de los productos, sustituir “tarta” por “pastel”.
insert into productos
	(codproducto, descripcion)
values
	(2349864, 'tarta tarta jdhfiuhdf');

update productos
set descripcion = replace(descripcion, 'tarta', 'pastel');

-- 9. Obtener la población del código postal de los proveedores 
-- (los primeros dos caracteres se refieren a la provincia y los 
-- tres últimos a la población).








-- 10. Obtén el número de productos de cada categoría, haz que el nombre de 
-- la categoría se muestre en mayúsculas.
select categorias.codcategoria, upper(Nomcategoria) as 'Nombre Categoría', 
	count(codproducto) as 'Número de productos'
from categorias
	join productos on categorias.codcategoria = productos.codcategoria
group by categorias.codcategoria;

-- 11. Obtén un listado de productos por categoría y dentro de cada categoría 
-- del nombre de producto más corto al más largo.

select codcategoria, descripcion, length(descripcion) as size
from productos
order by codcategoria, size;

-- 12. Asegúrate de que los nombres de los productos no tengan espacios en blanco 
-- al principio o al final de dicho nombre.
select trim(descripcion)
from productos;

-- 13. Lo mismo que en el ejercicio 2, pero ahora, además, sustituye el 4 y 5 
-- número del resultado por las 2 últimas letras del nombre de la empresa.
delimiter $$
drop procedure if exists ej13 $$
create procedure ej13
	(
	codProv int
	)
deterministic
begin
	select insert(reverse(telefono), 4, 2, right(nomempresa, 2)) as 'Contraseña'
    from proveedores
    where codproveedor = codProv;
end $$
delimiter ;

call ej13(5);

-- 14. Obtén el 10 por ciento del precio de los productos redondeados a dos decimales.
select round((0.1 * preciounidad),2) as '10% precio producto'
from productos;

-- 15. Muestra un listado de productos en que aparezca el nombre del producto y 
-- el código de producto y el de categoría repetidos (por ejemplo para la tarta de 
-- azucar se mostrará “623623”).
