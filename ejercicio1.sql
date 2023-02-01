/*
ESQUEMA RELACIONAL
-> empleados(pk[numempleado], extelefon, fecnacim, fecingreso, 
salario, comision, numhijos, nomemp);
-> deptos(pk[numdepto, numcentro*], presupuesto, nomdepto, numdepto*);
-> centros(pk[numcentro], nomcentro, direccion);
-> dir(pk[numempleado, [numdepto, numcentro]*], feninidir, fecfindir);
*/

drop database if exists ejercicio1;
create database if not exists ejercicio1;
use ejercicio1;

-- -> empleados(pk[numempleado], extelefon, fecnacim, fecingreso, 
-- salario, comision, numhijos, nomemp);
drop table if exists empleados;
create table if not exists empleados
(
	numempleado int unsigned,
    extelefon char(12),
    fecnacim date,
    fecingreso date,
    salario double(10, 2),
    comision double(10, 2),
    numhijos int unsigned,
    nomemp varchar(60),
    constraint pk_empleados primary key (numempleado)
);

-- centros(pk[numcentro], nomcentro, direccion);
drop table if exists centros;
create table if not exists centros
(
	numcentro int unsigned,
    nomcentro varchar(60),
    direccion varchar(60),
    constraint pk_centros primary key (numcentro)
);

-- deptos(pk[numdepto, numcentro*], presupuesto, nomdepto, numdepto*);
drop table if exists deptos;
create table if not exists deptos
(
	numdepto int unsigned,
    numcentro int unsigned,
    nomdepto varchar(60),
    presupuesto decimal(10, 2),
    deptodepen int unsigned,
    constraint pk_deptos primary key (numdepto),
    constraint fk_deptos_deptos foreign key (deptodepen)
		references deptos (numdepto)
        on delete no action on update no action,
	constraint fk_deptos_centros foreign key (numcentro)
		references centros (numcentro)
        on delete no action on update cascade
);

-- dir(pk[numempleado, [numdepto, numcentro]*], fecinidir, fecfindir);
drop table if exists dir;
create table if not exists dir
(
	numdepto int unsigned,
    numcentro int unsigned,
    numempleado int unsigned,
    fecinidir date,
    fecfindir date null,
    constraint pk_dir primary key (numdepto, numcentro, numempleado, fecinidir),
    constraint fk_dir_deptos1 foreign key (numdepto)
		references deptos (numdepto)
        on delete no action on update cascade,
	constraint fk_dir_deptos2 foreign key (numcentro)
		references deptos (numcentro)
        on delete no action on update cascade,
	constraint fk_dir_empleados foreign key (numempleado)
		references empleados (numempleado)
        on delete no action on update cascade
);