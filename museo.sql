drop database if exists BDMUSEO;
CREATE DATABASE if not exists BDMUSEO;
USE BDMUSEO;
/* CREAMOS LAS TABLAS ==> EL ORDEN ES IMPORTANTE (INTEGRIDAD REFERENCIAL) */
/************************************/
drop table if exists artistas;
create table if not exists artistas
    (codartista int unsigned, -- int(4)
     nomartista varchar(60),
     biografia text,
	 edad tinyint unsigned, -- int(1)
	 fecnacim date,
    constraint pk_artistas primary key (codartista)
    );
    
drop table if exists tipobras;
create table if not exists tipobras
    (codtipobra int unsigned,
     destipobra varchar(20),
    constraint pk_tipobras primary key (codtipobra)
    );
create table if not exists estilos
    (codestilo int unsigned,
     nomestilo varchar(20),
     desestilo varchar(250),
    constraint pk_estilos primary key (codestilo)
    );

drop table if exists salas;
create table if not exists salas
    (codsala int unsigned,
     nomsala varchar(20),
    constraint pk_salas primary key (codsala)
    );

drop table if exists obras;
create table if not exists obras
    (codobra int unsigned,
     nomobra varchar(20),
     desobra varchar(100),
     feccreacion date null,
     fecadquisicion date null,
     valoracion decimal (12,2) unsigned,
     codestilo int unsigned,
     codtipobra int unsigned,
     codubicacion int unsigned, -- sala en la que está
    constraint pk_obras primary key (codobra),
    constraint fk_obras_tipobras foreign key (codtipobra)
        references tipobras(codtipobra) 
        on delete no action on update cascade,
    constraint fk_obras_estilos  foreign key (codestilo)
        references estilos(codestilo) 
        on delete no action on update cascade,
    constraint fk_obras_salas foreign key (codubicacion)
        references salas(codsala) 
        on delete no action on update cascade
    );
    
alter table obras add column codartista int unsigned,
	add constraint fk_obras_artistas foreign key (codartista)
		references artistas(codartista) 
        on delete no action on update cascade;
      
drop table if exists empleados;
create table if not exists empleados
    (codemple int unsigned,
     nomemle varchar(20),
     ape1emple varchar(20),
     ape2emple varchar(20) null,
     fecincorp date,
	 tlfempleado char(12),
     numsegsoc char(15),
    constraint pk_empleados primary key (codemple)
    );

drop table if exists seguridad;
create table if not exists seguridad
    (codseguridad int unsigned,
     codemple int unsigned,
	 codsala int unsigned,
     observaciones varchar(200),
    constraint pk_seguridad primary key (codseguridad),
    constraint fk_seguridad_empleados foreign key (codemple)
        references empleados (codemple) on delete no action on update cascade,
	constraint fk_seguridad_salas foreign key (codsala)
        references salas (codsala) on delete no action on update cascade
    );
    
drop table if exists restauradores;
create table if not exists restauradores
    (codrestaurador int unsigned,
     codemple int unsigned,
     especialidad varchar(60),
    constraint pk_restauradores primary key (codrestaurador),
    constraint fk_restauradores_empleados foreign key (codemple)
        references empleados (codemple) on delete no action on update cascade
    );
    
drop table if exists restauraciones;
create table if not exists restauraciones
    (codrestaurador int unsigned,
     codobra int unsigned,
     fecinirestauracion date,
     fecfinrestauracion date null,
	 observaciones text,
    constraint pk_restauraciones primary key 
		(codrestaurador,codobra, fecinirestauracion),
    constraint fk_restestilosestilosauraciones_restauradores foreign key (codrestaurador)
        references restauradores (codrestaurador) on delete no action on update cascade,
    constraint fk_restauraciones_obras foreign key (codobra)
        references obras (codobra) on delete no action on update cascade
    
    );

drop table if exists turnos;
create table if not exists turnos
(
	codturno int unsigned,
	horaini time,
    horafin time,
    constraint pk_turnos primary key (codturno)
);

drop table if exists vigilar;
create table if not exists vigilar
(
	codvigilancia int unsigned, -- desnormalización
    codsala int unsigned,
    codsegur int unsigned,
    codturno int unsigned,
    fecini date,
    fecfin date,
    /*constraint pk_vigilar primary key 
    (codsala, codsegur, codturno, fecini)*/ -- desnormalización
    constraint pk_vigilar primary key (codvigilancia), -- desnormalización
	constraint fk_vigilar_seguridad
		foreign key (codsegur)
        references seguridad (codseguridad)
        on delete no action on update cascade,
	constraint fk_vigilar_salas foreign key (codsala)
		references salas (codsala)
        on delete no action on update cascade,
	constraint fk_vigilar_turnos foreign key (codturno)
		references turnos (codturno)
        on delete no action on update cascade
    
);

/*Inserción de datos ==> pendiente hasta unidad 5*/

alter table seguridad
	drop foreign key fk_seguridad_salas,
    drop column codsala;
    
/*Apartado B ==> Cambiar el nombre de una clave
foránea: Consulta ejercicio_5_1_2*/

alter table restauradores
	drop foreign key fk_restauradores_empleados,
    add constraint fk_restaudador_emple foreign key (codemple)
    references empleados (codemple) on delete no action on update cascade;
    
/*Apartado C ==> Los empleados pertenecen a un depto*/

drop table if exists deptos;
create table if not exists deptos
(
	coddepto int unsigned,
    nomdepto varchar(60),
    constraint pk_deptos primary key (coddepto)
);

alter table empleados
	add column coddepto int unsigned,
	add constraint fk_empleados_deptos foreign key (coddepto)
    references deptos (coddepto) on delete no action on update cascade;

/*** CAMBIOS EN FOREIGN KEY  ****/

/* A. Queremos que si se elimina un empleado,
      se elimine el
      restaurador/vigilante relacionado
*/

alter table restauradores
	drop foreign key fk_restauradores_empleados,
    add constraint fk_restauradores_empleados
		foreign key (codemple) references empleados (codemple)
			on delete cascade on update cascade;
            
alter table seguridad
	drop foreign key fk_restauradores_seguridad,
	add constraint fk_restauradores_seguridad
		foreign key (codemple) references empleados (codemple)
			on delete cascade on update cascade;

/* B. No vamos a permitir que se modifique
    el código de estilo
      de una obra, en todo caso se le asignará el valor nulo
*/

alter table obras
	drop foreign key fk_obras_estilos,
    add constraint fk_obras_estilos foreign key (codestilo)
    references estilos (codestilo)
    on delete no action
    on update SET NULL;
/* C. Vamos a permitir que se eliminen artistas, en este caso
      las obras se quedarán sin autor
*/



/* D. Vamos a permitir que se eliminen artistas, en este caso
      las obras se quedarán sin autor, pero, una vez que demos
    de alta una obra, el código de artista no podrá cambiar
*/

alter table obras
	drop foreign key fk_obras_artistas,
    add constraint fk_obras_artistas foreign key (codartista)
    references artistas (codartista)
    on delete set null on update no action;
    
/*Apartado D ==> Cambiamos a la opcion B en la jerarquía*/