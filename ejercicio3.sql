create database if not exists ejercicio3;
use ejercicio3;

 create table if not exists categorias
 (
	numcat int unsigned not null,
    nomcategor varchar(60),
    proveedor varchar(60),
    constraint pk_categorias primary key (numcat)
 );
 
 create table if not exists productos
 (
	refprod int unsigned not null,
    codcat int unsigned not null,
    descripc varchar(60),
    precio decimal(10, 2),
    constraint pk_productos primary key (refprod, codcat),
    constraint fk_productos_categorias foreign key (codcat) references categorias (numcat)
		on delete no action on update cascade
 );
 
 create table if not exists ventas
 (
	codventa int unsigned not null,
    fecventa date,
    cliente varchar (60),
    constraint pk_ventas primary key (codventa)
 );
 
 drop table if exists ln_ventas;
 create table if not exists lin_ventas
 (
	codventa int unsigned not null,
    refprod int unsigned not null,
    codcat int unsigned not null,
    cantidad int,
    precioBaseAVenta decimal(10,2), -- desnomalizacion ==> pero lo necesito para saber el precio base 
    constraint pk_lin_ventas primary key (codventa, refprod, codcat),
    constraint fk_productos_lin_ventas foreign key (codventa) 
    references ventas (codventa)
		on delete no action on update cascade,
    constraint fk_ventas_lin_ventas foreign key (refprod, codcat) 
    references productos (refprod, codcat)
		on delete no action on update cascade  
 );
 
 