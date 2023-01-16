create database if not exists ejercicio2;
use ejercicio2;

create table if not exists deptos
(
	numdepto int unsigned not null, -- primary key,
    presupuesto double(6,2),
    nomdepto varchar(60),
    ubicacion varchar(30),
    constraint pk_deptos primary key (numdepto)
);

create table if not exists asignaturas
(
	numasigna int unsigned not null, -- primary key
    nomasigna varchar(60),
    curso varchar(6),
    constraint pk_asignaturas primary key (numasigna)
);

create table if not exists profesorado
(
	numprof int unsigned not null, -- primary key,
    despacho varchar(30),
    fecnacim date null,
    fecingreso date null,
    sueldo double(6,2),
    nomprof varchar(60),
    jefe int unsigned,
    numdepto int unsigned,
    constraint pk_profesorado primary key (numprof),
    constraint fk_jefes foreign key (jefe) references profesorado (numprof)
		on delete no action on update cascade,
	constraint fk_profesorado_deptos foreign key (numdepto) references deptos (numdepto)
		on delete no action on update cascade
);

create table if not exists imparten
(
	numasigna int unsigned not null,
    numprof int unsigned not null,
    anio_acad char(4),
    grupo varchar(6),
    constraint pk_imparten primary key (numasigna, numprof),
    constraint fk_imparten_asignaturas foreign key (numasigna) references asignaturas (numasigna)
		on delete no action on update cascade,
	constraint fk_imparten_profesorado foreign key (numprof) references profesorado (numprof)
		on delete no action on update cascade
);