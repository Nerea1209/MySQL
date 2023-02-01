/*
ESQUEMA RELACIONAL
-- 	PROFESORES(pk[numprof], despacho, fecnacim, fecingreso, 
	sueldo, nomprof, jefe*, numdepto*);
-- DEPTOS(pk[numdepto], presupuesto, nomdepto, ubicacion);
-- ASIGNATURAS(pk[numasigna], nomasigna, curso);
-- IMPARTEN(pk[numasigna*, numprof*], anio_acad, grupo);
*/

drop database if exists ejercicio2;
create database if not exists ejercicio2;
use ejercicio2;

-- ASIGNATURAS(pk[numasigna], nomasigna, curso);
drop table if exists asignaturas;
create table if not exists asignaturas
(
	numasigna int unsigned,
    nomasigna varchar(60),
    curso char(4),
    constraint pk_asignaturas primary key (numasigna)
);

-- DEPTOS(pk[numdepto], presupuesto, nomdepto, ubicacion);
drop table if exists deptos;
create table if not exists deptos
(
	numdepto int unsigned,
    nomdepto varchar(60),
    presupuesto double(10, 2),
    ubicacion varchar(100),
    constraint pk_deptos primary key (numdepto)
);

-- 	PROFESORES(pk[numprof], despacho, fecnacim, fecingreso, 
--  sueldo, nomprof, jefe*, numdepto*);
drop table if exists profesores;
create table if not exists profesores
(
	numprof int unsigned,
    despacho int unsigned,
    fecnacim date,
    fecingreso date,
    sueldo double(10, 2),
    nomprof varchar(60),
    numjefe int unsigned,
    numdepto int unsigned,
    constraint pk_profesores primary key (numprof),
    constraint fk_profesores_profesores foreign key (numjefe)
		references profesores (numprof)
        on delete no action on update cascade,
	constraint fk_profesores_deptos foreign key (numdepto)
		references deptos (numdepto)
        on delete no action on update cascade
);

-- IMPARTEN(pk[numasigna*, numprof*], anio_acad, grupo);
drop table if exists imparten;
create table if not exists imparten
(
	numprof int unsigned,
    numasigna int unsigned,
    anio_acad char(4),
    grupo char(4),
    constraint pk_imparten primary key (numprof, numasigna),
    constraint fk_imparten_asignaturas foreign key (numasigna)
		references asignaturas (numasigna)
        on delete no action on update cascade,
	constraint fk_imparten_profesores foreign key (numprof)
		references profesores (numprof)
        on delete no action on update cascade
);

alter table profesores
	drop foreign key fk_profesores_profesores,
    add constraint fk_jefes foreign key (numjefe)
		references profesores (numprof)
        on delete no action on update cascade;