/*
ESQUEMA RELACIONAL:
centros(pk[numce], nomce, dirce)
deptos(pk[numce*, numde],.... [deptodepen, centrodepen]*)
empleados(pk[numem], ...., [numce, numde]*)
dirigir(pk[numem*, [numce,numde]*, fecinidir], fecfindir)
*/

drop database if exists ejercicio1;
create database if not exists ejercicio1;
use ejercicio1;

/* CREAMOS LAS TABLAS ==> EL ORDEN ES IMPORTANTE (INTEGRIDAD REFERENCIAL) */
drop table if exists centros;
create table if not exists centros
    (numce int,
     nomce varchar(60) not null,
     dirce varchar(120),
    constraint pk_centros primary key (numce)
    );
    
drop table if exists deptos;
create table if not exists deptos
    (numde int,
     numce int,
     nomde varchar(60) not null,
     presude decimal (10,2),
    constraint pk_deptos primary key (numde, numce),
    constraint fk_deptos_centros foreign key (numce)
        references centros(numce) 
            on delete no action on update cascade
    );

drop table if exists empleados;
create table if not exists empleados
    (numem int,
     numde int,
     numce int,
     extelem char(3) null,
     fecnaem date null,
     fecinem date not null,
     salarem decimal (7,2),
     comisem decimal (4,2),
     numhiem tinyint unsigned,
     nomem varchar(20) not null,
     ape1em varchar(20) not null,
     ape2em varchar(20) null,
    constraint pk_empleados primary key (numem),
    constraint fk_empleados_deptos foreign key (numde, numce)
        references deptos (numde, numce)
            on delete no action on update cascade
    );
    
drop table if exists dirigir;
create table if not exists dirigir
    (numemdir int, -- wejfskjfsjkdf
     numde int,
     numce int,
     fecinidir date,
     fecfindir date null,
    constraint pk_dirigir primary key (numemdir, numde, numce, fecinidir),
    constraint fk_dirigir_empleados foreign key (numemdir)
        references empleados (numem) on delete no action on update cascade,
    constraint fk_dirigir_deptos foreign key (numde, numce)
        references deptos (numde, numce) on delete no action on update cascade
    );

/*  DESPUES DE EJECUTAR DESCUBRIMOS QUE NOS FALTA REPRESENTAR
    LA RELACIÓN DEP (deptos a deptos) */

ALTER TABLE deptos
	add column deptodepen int,
	add column centrodepen int,
	add constraint fk_deptos_deptos foreign key (deptodepen, centrodepen)
		references deptos (numde, numce)
			on delete no action on update cascade;
	



