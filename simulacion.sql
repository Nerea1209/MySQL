/*
tipoCasos(pk[idTipoCaso], desTipoCaso);
casos(pk[idCaso, idTipoCaso*], desCaso, precio, idCliente*);
clientela(pk[idCliente], estadoCivil, idSujeto*);
abogados(pk[idAbogado], numColegiado, idSujeto*);
sujetos(pk[idSujeto], nombre, apellidos, dni, direccionPostal, 
direccionElectronica, telefono);
llevan(pk[idAbogado*,[idCaso, idTipoCaso]*, fecinicio], numDias);
*/

drop database if exists bufeteAbogados;
create database if not exists bufeteAbogados;
use bufeteAbogados;

drop table if exists tipoCasos;
create table if not exists tipoCasos
(
    idTipoCaso int unsigned, -- int(4)
	desTipoCaso varchar(120),
	constraint pk_tipoCasos primary key (idTipoCaso)
);

drop table if exists sujetos;
create table if not exists sujetos
(
    idSujeto int unsigned, -- int(4)
	nomSujeto varchar(20),
    ape1Sujeto varchar(20),
    ape2Sujeto varchar(20),
    dni char(9),
    dirPostal char(5),
    email varchar(100) unique,
    tlfcontacto char(12),
	constraint pk_sujetos primary key (idSujeto)
);

drop table if exists clientela;
create table if not exists clientela
(
    idCli int unsigned, -- int(4)
	estadoCivil enum('S', 'C', 'D', 'V'),
    idSujeto int unsigned,
	constraint pk_clientela primary key (idCli),
    constraint fk_clientela_sujetos foreign key (idSujeto)
		references sujetos (idSujeto)
        on delete no action on update cascade
);

drop table if exists abogados;
create table if not exists abogados
(
    idAbogado int unsigned, -- int(4)
	numColegiado int,
    idSujeto int unsigned,
	constraint pk_abogados primary key (idAbogado),
    constraint fk_abogados_sujetos foreign key (idSujeto)
		references sujetos (idSujeto)
        on delete no action on update no action
);

drop table if exists casos;
create table if not exists casos
(
    idCaso int unsigned, -- int(4)
	idTipoCaso int unsigned,
    idAbogado int unsigned,
    idCli int unsigned,
    desCaso varchar(120),
    presupuesto decimal(10,2),
	constraint pk_casos primary key (idCaso, idTipoCaso),
    constraint fk_abogados_tipoCasos foreign key (idTipoCaso)
		references tipoCasos (idTipoCaso)
        on delete no action on update no action
);
    
