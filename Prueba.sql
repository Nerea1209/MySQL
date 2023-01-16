create database if not exists bdclases;
use bdclases;

create table if not exists deptos
(
	coddepto int unsigned not null, -- primary key,
    nomdepto varchar(30),
    constraint pk_deptos primary key (coddepto)
);

create table if not exists profesorado
(
	coddepto int unsigned not null, -- primary key,
    codprof int unsigned not null, -- primary key,
    nomprof varchar(30) not null,
    ape1prof varchar(30) not null,
    ape2prof varchar(30) null,
    fecincorporacion date null,
    codpostal char(5) null,
    telefono char(9) null, -- char(13) si permitiésemos internacionales
    constraint pk_profesorado primary key (coddepto, codprof),
    constraint fk_profesorado_deptos foreign key (coddepto) references deptos (coddepto)
		on delete no action on update cascade
);

create table if not exists asignaturas
(
	codasigna int unsigned not null, -- primary key,
    nomasigna varchar(30) not null,
    curso varchar(10) null,
    constraint pk_asignaturas primary key (codasigna)
);

create table if not exists impartir
(
	codasigna int unsigned not null, -- primary key,
    coddepto int unsigned not null, -- primary key,
    codprof int unsigned not null, -- primary key,
    observaciones varchar(60) null,
    constraint pk_impartir primary key (codasigna, coddepto, codprof),
    constraint fk_impartir_asignaturas foreign key (codasigna) references asignaturas (codasigna)
		on delete no action on update cascade,
	constraint fk_impartir_profesorado foreign key (coddepto, codprof) references profesorado (coddepto, codprof)
		on delete no action on update cascade
);


