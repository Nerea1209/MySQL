/*
ESQUEMA RELACIONAL
-- CIUDADANOS(pk[codciu], nomciu, apellidosciu);
-- PROFESORES(pk[codprof, coddepto*], datprof, codciudadano*, coddepto*);
-- ALUMNOS(pk[codalum], datalum, codciudadano*, codgrupo*);
-- DEPTOS(pk[coddepto], nomdepto);
-- GRUPOS(pk[codgrupo], nomgrupo);
-- ASIGNATURAS(pk[codasigna], desasigna)
-- IMPARTIR(pk[codasigna*, codgrupo*, [codprof, coddepto]*, observaciones]);
*/

drop database if exists relacionNMP;
create database if not exists relacionNMP;
use relacionNMP;

drop table if exists ciudadanos;
create table if not exists ciudadanos
(
	codciu int unsigned,
    nomciu varchar(60),
    apellidos varchar(60),
    constraint pk_ciudadanos primary key (codciu)
);

drop table if exists deptos;
create table if not exists deptos
(
	coddepto int unsigned,
    nomdepto varchar(60),
    constraint pk_deptos primary key (coddepto)
);

drop table if exists grupos;
create table if not exists grupos
(
	codgrupo int unsigned,
    nomgrupo varchar(60),
    constraint pk_grupos primary key (codgrupo)
);

drop table if exists asignaturas;
create table if not exists asignaturas
(
	codasigna int unsigned,
    desasigna varchar(60),
    constraint pk_asignaturas primary key (codasigna)
);

drop table if exists alumnos;
create table if not exists alumnos
(
	codalum int unsigned,
    datalum varchar(60),
    codciu int unsigned,
    codgrupo int unsigned,
    constraint pk_alumnos primary key (codalum),
    constraint fk_alumnos_ciudadanos foreign key (codciu)
		references ciudadanos (codciu)
        on delete no action on update cascade,
	constraint fk_alumnos_grupos foreign key (codgrupo)
		references grupos (codgrupo)
        on delete no action on update cascade
);

-- PROFESORES(pk[codprof, coddepto*], datprof, codciudadano*;
drop table if exists profesores;
create table if not exists profesores
(
	codprof int unsigned,
    coddepto int unsigned,
    datprof varchar(60),
    codciu int unsigned,
    constraint pk_profesores primary key (codprof, coddepto),
    constraint fk_profesores_ciudadanos foreign key (codciu)
		references ciudadanos (codciu)
        on delete no action on update cascade,
	constraint fk_profesores_deptos foreign key (coddepto)
		references deptos (coddepto)
        on delete no action on update cascade
);

-- IMPARTIR(pk[codasigna*, codgrupo*, [codprof, coddepto]*, observaciones]);
drop table if exists impartir;
create table if not exists impartir
(
	codprof int unsigned,
    coddepto int unsigned,
    codasigna int unsigned,
    codgrupo int unsigned,
    observaciones text,
    constraint pk_impartir primary key (codprof, coddepto, codasigna, codgrupo),
    constraint fk_impartir_profesores foreign key (codprof, coddepto)
		references profesores (codprof, coddepto)
        on delete no action on update cascade,
	constraint fk_impartir_asignaturas foreign key (codasigna)
		references asignaturas (codasigna)
        on delete no action on update cascade,
	constraint fk_impartir_grupos foreign key (codgrupo)
		references grupos (codgrupo)
        on delete no action on update cascade
);

/*
alter table profesores
	add column codgrupo int unsigned,
    add constraint fk_profesores_grupos foreign key (codgrupo)
		references grupos (codgrupo);
*/

alter table grupos
	add column codprof int unsigned,
    add column coddepto int unsigned,
    add constraint fk_grupos_profesores foreign key (codprof, coddepto)
		references profesores (codprof, coddepto);