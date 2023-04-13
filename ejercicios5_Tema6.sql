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
create procedure ej4()
deterministic
begin
	select 
    from categorias
		join productos on categorias.codcategoria = productos.codcategoria
			
    where categorias.codcategoria = codCat and pedidos.fecentrega > curdate();
end $$
delimiter ;

call ej4(8);