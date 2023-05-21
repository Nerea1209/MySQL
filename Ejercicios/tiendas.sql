/*
	ESQUEMA RELACIONAL
-- categorias (pk[codcat], nomcat, descat);
-- articulos(pk[codart], nomart, desart, codcat*);
-- promociones(pk[codprom, codevent*], desprom);
-- eventos(pk[codevent], nomevent, desevent);
-- tiendas(pk[codtienda], nomtienda, destienda);
-- franquicias(pk[codfranq], datfranq, codtienda*);
-- propias(pk[codprop], datprop, codtienda*);
-- catalogopromos();
-- seaplicana(observaciones);   
*/

drop database if exists tiendas;
create database if not exists tiendas;
use tiendas;

drop table if exists categorias;
create table if not exists categorias
(
	codcat int unsigned,
    nomcat varchar(60),
    descat varchar(100),
    constraint pk_categorias primary key (codcat)
);

drop table if exists articulos;
create table if not exists articulos
(
	codart int unsigned,
    nomart varchar(60),
    desart varchar(100),
    codcat int unsigned,
    constraint pk_articulos primary key (codart),
    constraint fk_articulos_categorias foreign key (codcat)
		references categorias (codcat)
        on delete no action on update cascade
);

drop table if exists eventos;
create table if not exists eventos
(
	codevent int unsigned,
    nomevent varchar(60),
    desevent varchar(100),
    constraint pk_eventos primary key (codevent)
);

drop table if exists promociones;
create table if not exists promociones
(
	codprom int unsigned,
    codevent int unsigned,
    desprom varchar(100),
    constraint pk_promociones primary key (codprom, codevent),
    constraint fk_promociones_eventos foreign key (codevent)
		references eventos (codevent)
        on delete no action on update cascade
);

drop table if exists tiendas;
create table if not exists tiendas
(
	codtienda int unsigned,
    nomtienda varchar(60),
    destienda varchar(100),
    constraint pk_tiendas primary key (codtienda)
);

drop table if exists franquicias;
create table if not exists franquicias
(
	codfranquicia int unsigned,
    datosfranquicia varchar(120),
    codtienda int unsigned,
    constraint pk_franquicias primary key (codfranquicia),
    constraint fk_franquicias_tiendas foreign key (codtienda)
		references tiendas (codtienda)
        on delete no action on update cascade
);

drop table if exists propias;
create table if not exists propias
(
	codpropia int unsigned,
    datospropia varchar(120),
    codtienda int unsigned,
    constraint pk_propias primary key (codpropia),
    constraint fk_propias_tiendas foreign key (codtienda)
		references tiendas (codtienda)
        on delete no action on update cascade
);

drop table if exists catalogopromos;
create table if not exists catalogopromos
(
	codprom int unsigned,
    codevent int unsigned,
    codart int unsigned,
    observaciones varchar(100),
    constraint pk_catalogopromos primary key (codprom, codevent, codart),
    constraint fk_promociones_catalogopromos foreign key (codprom, codevent)
		references promociones (codprom, codevent)
        on delete no action on update cascade,
	constraint fk_articulos_catalogopromos foreign key (codart)
		references articulos (codart)
        on delete no action on update cascade
);

drop table if exists seaplicana;
create table if not exists seaplicana
(
	codprom int unsigned,
    codevent int unsigned,
    codtienda int unsigned,
    observaciones varchar(100),
    constraint pk_seaplicana primary key (codprom, codevent, codtienda),
    constraint fk_promociones_seaplicana foreign key (codprom, codevent)
		references promociones (codprom, codevent)
        on delete no action on update cascade,
	constraint fk_tiendas_seaplicana foreign key (codtienda)
		references tiendas (codtienda)
        on delete no action on update cascade
);

-- Convierte catalogopromos en 2 relaciones 1:N
alter table articulos
	add column codprom int unsigned,
    add column codevent int unsigned,
    add constraint fk_articulos_promociones foreign key (codprom, codevent)
		references promociones (codprom, codevent)
        on delete no action on update cascade;

drop table catalogopromos;