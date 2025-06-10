INSERT INTO Razgo(nombre, descripcion) VALUES('letal x', 'esta arma agrega +1dx de daño al hacer un crítico, x depende del tamaño.');
INSERT INTO Razgo(nombre, descripcion) VALUES('recarga 0', 'esta arma no toma acciones extra para recargar, esta acción es parte del ataque.');
INSERT INTO Razgo(nombre, descripcion) VALUES('esqueleto', 'ser hecho apartir de energía del vacío aplicada a los huesos de un cadáver.');

INSERT INTO Proeza(nombre, descripcion, nivel) VALUES('dureza', 'incrementa en 1 la salud máxima y reduce en 1 la dificultad de los dados de recuperación', 1);
INSERT INTO Proeza(nombre, descripcion, nivel) VALUES('iniciativa mejorada', '+1 a dados de iniciativa', 1);

INSERT INTO CambioEstado(nombre, descripcion) VALUES('drenado x', 'el afectado recibe una penalización de estado de -x a los dados de constitución como fortaleza; también pierde salud y salud máxima de nivel*x; esto no cuenta como tomar daño');

DROP TABLE IF EXISTS Arma;
CREATE TABLE Arma(
 	id integer PRIMARY KEY NOT NULL,
	nombre varchar(32) UNIQUE NOT NULL,
  	precio integer NOT NULL DEFAULT(0),
	nivel integer NOT NULL DEFAULT(0),
	manos integer NOT NULL DEFAULT(1),
        efecto varchar(256) NULL,
	tipoId integer NOT NULL,
	grupoId integer NOT NULL,
	categoriaId integer NOT NULL,
	FOREIGN KEY(tipoId) REFERENCES Tipo(id),
	FOREIGN KEY(grupoId) REFERENCES Grupo(id),
	FOREIGN KEY(categoriaId) REFERENCES Categoria(id)
);

INSERT INTO Arma(nombre, tipoId, grupoId, categoriaId) VALUES('mandíbula', 1, 9, 1);

DROP TABLE IF EXISTS Razgo_Arma;
CREATE TABLE Razgo_Arma(
 	armaId integer NOT NULL,
  	razgoId integer NOT NULL,
	FOREIGN KEY(armaId) REFERENCES Arma(id),
	FOREIGN KEY(razgoId) REFERENCES Razgo(id),
	PRIMARY KEY(armaId, razgoId)
);
INSERT INTO Razgo_Arma(armaId, razgoId) VALUES(4, 11);
INSERT INTO Razgo_Arma(armaId, razgoId) VALUES(4, 12);

DROP TABLE IF EXISTS Hechizo;
CREATE TABLE Hechizo(
 	id integer PRIMARY KEY NOT NULL,
	nombre varchar(32) UNIQUE NOT NULL,
	requisito varchar(64),
	fallo varchar(1024),
	efecto varchar(1024) NOT NULL,
	critico varchar(1024),
  	demora integer NOT NULL DEFAULT(2),
	nivel integer NOT NULL DEFAULT(0),
	alcance integer NOT NULL DEFAULT(0),
	escuelaId integer NOT NULL,
	blancoId integer NOT NULL,
	FOREIGN KEY(escuelaId) REFERENCES Escuela(id),
	FOREIGN KEY(blancoId) REFERENCES Blanco(id)
);

INSERT INTO Hechizo(nombre, efecto, nivel, alcance, escuelaId, blancoId) VALUES('condena', 'los afectados en el area tomarán -1 penalización de estado en dados de ataque por un minuto; el usuario puede tomar 1 acción de la ronda siguiente para doblar el área de efecto. Elimina bendición.', 1, 5, 4, 7);
INSERT INTO Hechizo(nombre, efecto, nivel, alcance, escuelaId, blancoId) VALUES('bendición', 'los afectados en el area recibirán +1 bono de estado en dados de ataque por un minuto; el usuario puede tomar 1 acción de la ronda siguiente para doblar el área de efecto. Elimina condena.', 1, 5, 4, 8);

DROP TABLE IF EXISTS Razgo_Hechizo;
CREATE TABLE Razgo_Hechizo(
 	hechizoId integer NOT NULL,
  	razgoId integer NOT NULL,
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	FOREIGN KEY(razgoId) REFERENCES Razgo(id),
	PRIMARY KEY(hechizoId, razgoId)
);
INSERT INTO Razgo_Hechizo(hechizoId, razgoId) VALUES(1, 4);
INSERT INTO Razgo_Hechizo(hechizoId, razgoId) VALUES(1, 5);
INSERT INTO Razgo_Hechizo(hechizoId, razgoId) VALUES(2, 4);
INSERT INTO Razgo_Hechizo(hechizoId, razgoId) VALUES(2, 5);

DROP TABLE IF EXISTS Tradicion_Hechizo;
CREATE TABLE Tradicion_Hechizo(
 	hechizoId integer NOT NULL,
  	tradicionId integer NOT NULL,
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	FOREIGN KEY(tradicionId) REFERENCES Tradicion(id),
	PRIMARY KEY(hechizoId, tradicionId)
);
INSERT INTO Tradicion_Hechizo(hechizoId, tradicionId) VALUES(1, 2);
INSERT INTO Tradicion_Hechizo(hechizoId, tradicionId) VALUES(1, 3);
INSERT INTO Tradicion_Hechizo(hechizoId, tradicionId) VALUES(2, 2);
INSERT INTO Tradicion_Hechizo(hechizoId, tradicionId) VALUES(2, 3);

DROP TABLE IF EXISTS Entidad;
CREATE TABLE Entidad(
 	id integer PRIMARY KEY NOT NULL,
	nombre varchar(64) UNIQUE NOT NULL,
	descripcion varchar(2048),
	tesoro varchar(512),
	nivel integer NOT NULL DEFAULT(0),
	experiencia integer NOT NULL DEFAULT(50),
	percepcion integer NOT NULL DEFAULT(0),
  	armadura integer NOT NULL DEFAULT(10),
	toqueArmadura integer NOT NULL DEFAULT(10),
	desprevenidoArmadura integer NOT NULL DEFAULT(10),
	salud integer NOT NULL DEFAULT(4),
	fortaleza integer NOT NULL DEFAULT(0),
	reflejos integer NOT NULL DEFAULT(0),
	voluntad integer NOT NULL DEFAULT(0),
	ataqueBase integer NOT NULL DEFAULT(0),
	fuerza integer NOT NULL DEFAULT(10),
	destreza integer NOT NULL DEFAULT(10),
	constitucion integer NOT NULL DEFAULT(10),
	inteligencia integer NOT NULL DEFAULT(10),
	sabiduria integer NOT NULL DEFAULT(10),
	carisma integer NOT NULL DEFAULT(10),
	acrobacia integer NOT NULL DEFAULT(0),
	arcana integer NOT NULL DEFAULT(0),
	atletismo integer NOT NULL DEFAULT(0),
	fabricacion integer NOT NULL DEFAULT(0),
	engano integer NOT NULL DEFAULT(0),
	diplomacia integer NOT NULL DEFAULT(0),
	intimidacion integer NOT NULL DEFAULT(0),
	tradicion integer NOT NULL DEFAULT(0),
	medicina integer NOT NULL DEFAULT(0),
	naturaleza integer NOT NULL DEFAULT(0),
	ocultismo integer NOT NULL DEFAULT(0),
	actuacion integer NOT NULL DEFAULT(0),
	religion integer NOT NULL DEFAULT(0),
	sociedad integer NOT NULL DEFAULT(0),
	sigilo integer NOT NULL DEFAULT(0),
	supervivencia integer NOT NULL DEFAULT(0),
	robo integer NOT NULL DEFAULT(0),
	dinero integer NOT NULL DEFAULT(0),
	razaId integer NOT NULL,
	terrenoId integer NOT NULL,
	tamanoId integer NOT NULL,
	climaId integer NOT NULL,
	alineacionId integer NOT NULL,
	claseId integer NOT NULL,
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(terrenoId) REFERENCES Terreno(id),
	FOREIGN KEY(tamanoId) REFERENCES Tamano(id),
	FOREIGN KEY(climaId) REFERENCES Clima(id),
	FOREIGN KEY(alineacionId) REFERENCES Alineacion(id),
	FOREIGN KEY(claseId) REFERENCES Clase(id)
);
INSERT INTO Entidad(nombre, experiencia, armadura, toqueArmadura, desprevenidoArmadura, salud, fortaleza, voluntad, maniobraDefensa, fuerza, destreza, constitucion, inteligencia, carisma, atletismo, razaId, terrenoId, tamanoId, climaId, alineacionId, claseId) VALUES('sabueso zombie', 135, 13, 12, 12, 6, 5, 3, 11, 13, 9, 0, 0, 6, 5, 12, 6, 4, 3, 3, 1);

DROP TABLE IF EXISTS Razgo_Entidad;
CREATE TABLE Razgo_Entidad(
 	entidadId integer NOT NULL,
  	razgoId integer NOT NULL,
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(razgoId) REFERENCES Razgo(id),
	PRIMARY KEY(entidadId, razgoId)
);
INSERT INTO Razgo_Entidad(entidadId, razgoId) VALUES(3, 6);
INSERT INTO Razgo_Entidad(entidadId, razgoId) VALUES(3, 8);

DROP TABLE IF EXISTS Sentido_Entidad;
CREATE TABLE Sentido_Entidad(
 	entidadId integer NOT NULL,
  	sentidoId integer NOT NULL,
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(sentidoId) REFERENCES Sentido(id),
	PRIMARY KEY(entidadId, sentidoId)
);
INSERT INTO Sentido_Entidad(entidadId, sentidoId) VALUES(3, 6);

DROP TABLE IF EXISTS Inmunidad;
CREATE TABLE Inmunidad(
 	entidadId integer NOT NULL,
  	estadoId integer NOT NULL,
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(estadoId) REFERENCES CambioEstado(id),
	PRIMARY KEY(entidadId, estadoId)
);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 6);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 7);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 10);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 11);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 18);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 20);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 21);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 22);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 23);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 25);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 26);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 28);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 34);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 36);
INSERT INTO Inmunidad(entidadId, estadoId) VALUES(3, 38);

DROP TABLE IF EXISTS Velocidad;
CREATE TABLE Velocidad(
 	entidadId integer NOT NULL,
  	movimientoId integer NOT NULL,
	cantidad integer Not NULL DEFAULT(5),
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(movimientoId) REFERENCES Movimiento(id),
	PRIMARY KEY(entidadId, movimientoId)
);
INSERT INTO Velocidad(entidadId, movimientoId, cantidad) VALUES(3, 1, 40);

DROP TABLE IF EXISTS Resistencia;
CREATE TABLE Resistencia(
 	entidadId integer NOT NULL,
  	danoId integer NOT NULL,
	cantidad integer Not NULL DEFAULT(0),
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(danoId) REFERENCES TipoDano(id),
	PRIMARY KEY(entidadId, danoId)
);
INSERT INTO Resistencia(entidadId, danoId, cantidad) VALUES(3, 4, -5);
INSERT INTO Resistencia(entidadId, danoId, cantidad) VALUES(3, 10, -5);
INSERT INTO Resistencia(entidadId, danoId) VALUES(3, 13);
INSERT INTO Resistencia(entidadId, danoId) VALUES(3, 14);

DROP TABLE IF EXISTS Proeza_Entidad;
CREATE TABLE Proeza_Entidad(
 	entidadId integer NOT NULL,
  	proezaId integer NOT NULL,
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	PRIMARY KEY(entidadId, proezaId)
);
INSERT INTO Proeza_Entidad(entidadId, proezaId) VALUES(2, 2);

DROP TABLE IF EXISTS Lenguaje_Entidad;
CREATE TABLE Lenguaje_Entidad(
 	entidadId integer NOT NULL,
  	lenguajeId integer NOT NULL,
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(lenguajeId) REFERENCES Lenguaje(id),
	PRIMARY KEY(entidadId, lenguajeId)
);

DROP TABLE IF EXISTS Hechizo_Entidad;
CREATE TABLE Hechizo_Entidad(
 	entidadId integer NOT NULL,
  	hechizoId integer NOT NULL,
	metamagia VARCHAR(512),
	cantidad integer DEFAULT(1),
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	PRIMARY KEY(entidadId, hechizoId)
);

DROP TABLE IF EXISTS Ataque;
CREATE TABLE Ataque(
 	entidadId integer NOT NULL,
  	armaId integer NOT NULL,
	monto VARCHAR(64) NOT NULL DEFAULT('1d4'),
	alcance integer DEFAULT(1),
	critico VARCHAR(512),
	demora integer NOT NULL DEFAULT(1),
	bono integer NOT NULL DEFAULT(0),
	danoId integer NOT NULL,
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(armaId) REFERENCES Arma(id),
	FOREIGN KEY(danoId) REFERENCES TipoDano(id),
	PRIMARY KEY(entidadId, armaId)
);
INSERT INTO Ataque(entidadId, armaId, monto, critico, bono, danoId) VALUES(3, 5, '1d4+2', 'hace una maniobra lanzando un dado de atletismo contra los reflejos del objetivo; éxito: el objetivo está tumbado; crítico: hace 1d6 de daño contundente; fallo: el usuario está tumbado', 2, 4);

DROP TABLE IF EXISTS HabilidadEspecial;
CREATE TABLE HabilidadEspecial(
 	id integer PRIMARY KEY NOT NULL,
	nombre VARCHAR(32) UNIQUE NOT NULL,
	efecto VARCHAR(2048) NOT NULL,
	requisito VARCHAR(512),
	critico VARCHAR(512),
	demora integer NOT NULL DEFAULT(1),
	alcance integer NOT NULL DEFAULT(0)
);
INSERT INTO HabilidadEspecial(nombre, efecto, demora) VALUES('rasgador de carne', 'el sabueso zombie agrega 1d4 de daño a ataques contra criaturas tumbadas', -2);
INSERT INTO HabilidadEspecial(nombre, efecto, demora) VALUES('tambaleante', 'el usuario tiene lentitud 1', -2);

DROP TABLE IF EXISTS Razgo_Habilidad;
CREATE TABLE Razgo_Habilidad(
 	razgoId integer NOT NULL,
  	habilidadId integer NOT NULL,
	FOREIGN KEY(razgoId) REFERENCES Razgo(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(razgoId, habilidadId)
);

DROP TABLE IF EXISTS Habilidad_Entidad;
CREATE TABLE Habilidad_Entidad(
 	entidadId integer NOT NULL,
  	habilidadId integer NOT NULL,
	FOREIGN KEY(entidadId) REFERENCES Entidad(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(entidadId, habilidadId)
);
INSERT INTO Habilidad_Entidad(entidadId, habilidadId) VALUES(1, 3);
INSERT INTO Habilidad_Entidad(entidadId, habilidadId) VALUES(3, 2);

InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 3);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 6);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 14);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 15);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 16);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 17);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 18);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 19);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 20);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 21);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 22);
InseRT INTO Hechizo_Entidad(entidadId, hechizoId) VALUES(14, 23);

CREATE TABLE Herencia(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL,
	descripcion varchar(256) NOT NULL,
  	razaId integer NOT NULL,
	rarezaId integer NOT NULL DEFAULT(1),
	FOREIGN KEY(rarezaId) REFERENCES Rareza(id)
	FOREIGN KEY(razaId) REFERENCES Raza(id)
);

CREATE TABLE TipoSubclase(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL
);

CREATE TABLE Subclase(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL,
	tipoSubclaseId varchar(64) NOT NULL,
	descripcion varchar(512) NOT NULL,
  	claseId integer NOT NULL,
	FOREIGN KEY(tipoSubclaseId) REFERENCES TipoSubclase(id),
	FOREIGN KEY(claseId) REFERENCES Clase(id)
);

CREATE TABLE Transfondo(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL,
	descripcion varchar(256) NOT NULL,
	rarezaId integer NOT NULL DEFAULT(1),
	FOREIGN KEY(rarezaId) REFERENCES Rareza(id)
);

CREATE TABLE IF NOT EXISTS Ataque_Estandar (
  armaId integer NOT NULL PRIMARY KEY,
  monto varchar(64) NOT NULL DEFAULT('1d4'),
  alcance integer DEFAULT(1),
  efecto varchar(512),
  demora integer NOT NULL DEFAULT(1),
  bono integer NOT NULL DEFAULT(0),
  danoId integer NOT NULL,
  FOREIGN KEY (armaId) REFERENCES Arma(id),
  FOREIGN KEY (danoId) REFERENCES TipoDano(id)
);
INSERT INTO Ataque_Estandar(armaId, danoId) VALUES(1, 2);
INSERT INTO Ataque_Estandar(armaId, danoId) VALUES(2, 4);
INSERT INTO Ataque_Estandar(armaId, monto, danoId) VALUES(3, '1d6', 4);
INSERT INTO Ataque_Estandar(armaId, monto, alcance, danoId) VALUES(4, '1d6', 60, 3);
INSERT INTO Ataque_Estandar(armaId, danoId) VALUES(5, 3);
INSERT INTO Ataque_Estandar(armaId, monto, alcance, danoId) VALUES(6, '1d8', 10, 4);
INSERT INTO Ataque_Estandar(armaId, monto, alcance, danoId) VALUES(7, '1d8', 60, 3);
INSERT INTO Ataque_Estandar(armaId, alcance, danoId) VALUES(8, 30, 3);
INSERT INTO Ataque_Estandar(armaId, monto, alcance, danoId) VALUES(9, '1d10', 10, 4);
INSERT INTO Ataque_Estandar(armaId, monto, danoId) VALUES(10, '1d10', 2);
INSERT INTO Ataque_Estandar(armaId, monto, alcance, danoId) VALUES(11, '1d8', 60, 3);
INSERT INTO Ataque_Estandar(armaId, monto, danoId) VALUES(12, '1d6', 2);
INSERT INTO Ataque_Estandar(armaId, monto, danoId) VALUES(13, '1d8 t(1d12)', 4);
INSERT INTO Ataque_Estandar(armaId, danoId) VALUES(14, 3);
INSERT INTO Ataque_Estandar(armaId, monto, danoId) VALUES(15, '1d6', 3);

CREATE TABLE Atributo(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL
);

insert into Atributo(nombre) values('fuerza');
insert into Atributo(nombre) values('destreza');
insert into Atributo(nombre) values('constitución');
insert into Atributo(nombre) values('inteligencia');
insert into Atributo(nombre) values('sabiduría');
insert into Atributo(nombre) values('carisma');
insert into Atributo(nombre) values('fortaleza');
insert into Atributo(nombre) values('reflejos');
insert into Atributo(nombre) values('voluntad');
insert into Atributo(nombre) values('acrobacia');
insert into Atributo(nombre) values('actuación');
insert into Atributo(nombre) values('atletismo');
insert into Atributo(nombre) values('diplomacia');
insert into Atributo(nombre) values('engaño');
insert into Atributo(nombre) values('fabricación');
insert into Atributo(nombre) values('intimidación');
insert into Atributo(nombre) values('latrocinio');
insert into Atributo(nombre) values('medicina');
insert into Atributo(nombre) values('naturaleza');
insert into Atributo(nombre) values('ocultismo');
insert into Atributo(nombre) values('religión');
insert into Atributo(nombre) values('sigilo');
insert into Atributo(nombre) values('sociedad');
insert into Atributo(nombre) values('supervivencia');
insert into Atributo(nombre) values('tradición');
insert into Atributo(nombre) values('percepción');
insert into Atributo(nombre) values('iniciativa');

create TABLE Faccion(
 	id integer PRIMARY KEY NOT NULL,
	nombre varchar(128) UNIQUE NOT NULL,
	alineacionId integer NOT NULL,
	FOREIGN KEY(alineacionId) REFERENCES Alineacion(id)
);

INSERT INTO Faccion(nombre, alineacionId) values('pueblo Hallein', 1);
INSERT INTO Faccion(nombre, alineacionId) values('villa Goblin', 7);
INSERT INTO Faccion(nombre, alineacionId) values('caballeros infernales de la orden de la Garra de Dios', 6);
INSERT INTO Faccion(nombre, alineacionId) values('cruzados de Mendev', 5);
INSERT INTO Faccion(nombre, alineacionId) values('caballeros de Muralla Final', 5);
INSERT INTO Faccion(nombre, alineacionId) values('Camino Susurrante', 9);
INSERT INTO Faccion(nombre, alineacionId) values('vampiros de Caliphas', 3);
INSERT INTO Faccion(nombre, alineacionId) values('los antiguos', 4);
CREATE TABLE Usuario(
 	id integer PRIMARY KEY,
  	nombre varchar(64) UNIQUE NOT NULL,
	clave varchar(256) NOT NULL,
	permiso integer NOT NULL DEFAULT(0)
);

INSERT INTO Usuario(nombre, clave) VALUES('Carlos', 'Chugui');
INSERT INTO Usuario(nombre, clave) VALUES('Linares', 'Chugui');
INSERT INTO Usuario(nombre, clave) VALUES('Morbo', 'Chugui');
INSERT INTO Usuario(nombre, clave, permiso) VALUES('Nobza', 'Chugorbo', 1);

DROP TABLE Reputacion;
create TABLE Reputacion(
	modificador INTEGER NOT NULL DEFAULT(0),
	usuarioId integer NOT NULL,
	faccionId integer NOT NULL,
	FOREIGN KEY(usuarioId) REFERENCES Usuario(id),
	FOREIGN KEY(faccionId) REFERENCES Faccion(id),
	PRIMARY KEY(usuarioId, faccionId)
);

insert into Reputacion(usuarioId, faccionId, modificador) values(1, 1, 2);
insert into Reputacion(usuarioId, faccionId, modificador) values(2, 1, 1);
insert into Reputacion(usuarioId, faccionId, modificador) values(3, 1, 0);
insert into Reputacion(usuarioId, faccionId, modificador) values(1, 2, -2);
insert into Reputacion(usuarioId, faccionId, modificador) values(2, 2, 1);
insert into Reputacion(usuarioId, faccionId, modificador) values(3, 2, 0);
insert into Reputacion(usuarioId, faccionId, modificador) values(1, 3, -2);
insert into Reputacion(usuarioId, faccionId, modificador) values(2, 3, -1);
insert into Reputacion(usuarioId, faccionId, modificador) values(3, 3, 0);
insert into Reputacion(usuarioId, faccionId, modificador) values(1, 4, 1);
insert into Reputacion(usuarioId, faccionId, modificador) values(2, 4, 1);
insert into Reputacion(usuarioId, faccionId, modificador) values(3, 4, 1);
insert into Reputacion(usuarioId, faccionId) values(1, 5);
insert into Reputacion(usuarioId, faccionId) values(2, 5);
insert into Reputacion(usuarioId, faccionId) values(3, 5);
insert into Reputacion(usuarioId, faccionId, modificador) values(1, 6, -1);
insert into Reputacion(usuarioId, faccionId, modificador) values(2, 6, -1);
insert into Reputacion(usuarioId, faccionId, modificador) values(3, 6, -1);
insert into Reputacion(usuarioId, faccionId, modificador) values(1, 7, -1);
insert into Reputacion(usuarioId, faccionId, modificador) values(2, 7, -1);
insert into Reputacion(usuarioId, faccionId, modificador) values(3, 7, -1);
insert into Reputacion(usuarioId, faccionId, modificador) values(1, 8, -1);
insert into Reputacion(usuarioId, faccionId, modificador) values(2, 8, -2);
insert into Reputacion(usuarioId, faccionId, modificador) values(3, 8, 0);

create TABLE Jugador(
 	id integer PRIMARY KEY NOT NULL,
	nombre varchar(32) UNIQUE NOT NULL,
	nivel integer NOT NULL DEFAULT(1),
	experiencia integer NOT NULL DEFAULT(0),
	dinero integer NOT NULL DEFAULT(0),
	percepcion integer NOT NULL DEFAULT(0),
  	armaduraRopa integer NOT NULL DEFAULT(0),
  	armaduraLigera integer NOT NULL DEFAULT(0),
  	armaduraMedia integer NOT NULL DEFAULT(0),
  	armaduraPesada integer NOT NULL DEFAULT(0),
	salud integer NOT NULL DEFAULT(10),
	fortaleza integer NOT NULL DEFAULT(0),
	reflejos integer NOT NULL DEFAULT(0),
	voluntad integer NOT NULL DEFAULT(0),
	ataqueNatural integer NOT NULL DEFAULT(0),
	ataqueSimple integer NOT NULL DEFAULT(0),
	ataqueMarcial integer NOT NULL DEFAULT(0),
	fuerza integer NOT NULL DEFAULT(0),
	destreza integer NOT NULL DEFAULT(0),
	constitucion integer NOT NULL DEFAULT(0),
	inteligencia integer NOT NULL DEFAULT(0),
	sabiduria integer NOT NULL DEFAULT(0),
	carisma integer NOT NULL DEFAULT(0),
	acrobacia integer NOT NULL DEFAULT(0),
	arcana integer NOT NULL DEFAULT(0),
	atletismo integer NOT NULL DEFAULT(0),
	fabricacion integer NOT NULL DEFAULT(0),
	engano integer NOT NULL DEFAULT(0),
	diplomacia integer NOT NULL DEFAULT(0),
	intimidacion integer NOT NULL DEFAULT(0),
	medicina integer NOT NULL DEFAULT(0),
	naturaleza integer NOT NULL DEFAULT(0),
	ocultismo integer NOT NULL DEFAULT(0),
	actuacion integer NOT NULL DEFAULT(0),
	religion integer NOT NULL DEFAULT(0),
	sociedad integer NOT NULL DEFAULT(0),
	sigilo integer NOT NULL DEFAULT(0),
	supervivencia integer NOT NULL DEFAULT(0),
	robo integer NOT NULL DEFAULT(0),
	claseId integer NOT NULL,
	subclaseId integer,
	subclaseId2 integer,
	alineacionId integer NOT NULL,
	herenciaId integer NOT NULL,
	atributoId integer NOT NULL default(1),
	tamanoId integer not null default(3),
	transfondoId integer NOT NULL,
	FOREIGN KEY(alineacionId) REFERENCES Alineacion(id),
	FOREIGN KEY(claseId) REFERENCES Clase(id),
	FOREIGN KEY(subclaseId) REFERENCES Subclase(id),
	FOREIGN KEY(subclaseId2) REFERENCES Subclase(id),
	FOREIGN KEY(herenciaId) REFERENCES Herencia(id),
	FOREIGN KEY(tamanoId) REFERENCES Tamano(id),
	FOREIGN KEY(transfondoId) REFERENCES Transfondo(id),
	FOREIGN KEY(atributoId) REFERENCES Atributo(id)
);

INSERT INTO Jugador(nombre, nivel, claseId, alineacionId, razaId) values('Carlos', 4, 5, 1, 20);
INSERT INTO Jugador(nombre, nivel, claseId, alineacionId, razaId) values('Linares', 4, 4, 8, 20);
INSERT INTO Jugador(nombre, nivel, claseId, alineacionId, razaId, tamanoId) values('Morbo', 4, 2, 6, 23, 2);

CREATE TABLE Lenguaje_Jugador(
 	jugadorId integer NOT NULL,
  	lenguajeId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(lenguajeId) REFERENCES Lenguaje(id),
	PRIMARY KEY(jugadorId, lenguajeId)
);

INSERT INTO Lenguaje_Jugador(jugadorId, lenguajeId) values(1, 1);
INSERT INTO Lenguaje_Jugador(jugadorId, lenguajeId) values(2, 1);
INSERT INTO Lenguaje_Jugador(jugadorId, lenguajeId) values(3, 1);
INSERT INTO Lenguaje_Jugador(jugadorId, lenguajeId) values(1, 6);
INSERT INTO Lenguaje_Jugador(jugadorId, lenguajeId) values(2, 6);
INSERT INTO Lenguaje_Jugador(jugadorId, lenguajeId) values(3, 6);
INSERT INTO Lenguaje_Jugador(jugadorId, lenguajeId) values(3, 7);

create TABLE TradicionAdicional(
	modificador INTEGER NOT NULL DEFAULT(0),
	jugadorId integer NOT NULL,
	razgoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(razgoId) REFERENCES Razgo(id),
	PRIMARY KEY(jugadorId, razgoId)
);

CREATE TABLE Proeza_Jugador(
 	jugadorId integer NOT NULL,
  	proezaId integer NOT NULL,
	variables integer NOT NULL DEFAULT(0),
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	PRIMARY KEY(jugadorId, proezaId, variables)
);

CREATE TABLE Hechizo_Jugador(
	cantidad integer NOT NULL DEFAULT(1),
	metamagia int NULL,
 	jugadorId integer NOT NULL,
  	hechizoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	PRIMARY KEY(jugadorId, hechizoId)
);
CREATE TABLE Habilidad_Jugador(
 	jugadorId integer NOT NULL,
  	habilidadId integer NOT NULL,
	variables varchar(128),
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(jugadorId, habilidadId)
);
CREATE TABLE Sentido_Jugador(
 	jugadorId integer NOT NULL,
  	sentidoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(sentidoId) REFERENCES Sentido(id),
	PRIMARY KEY(jugadorId, sentidoId)
);
CREATE TABLE Inmunidad_Jugador(
 	jugadorId integer NOT NULL,
  	estadoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(estadoId) REFERENCES CambioEstado(id),
	PRIMARY KEY(jugadorId, estadoId)
);
CREATE TABLE Velocidad_Jugador(
 	jugadorId integer NOT NULL,
  	movimientoId integer NOT NULL,
	cantidad integer NOT NULL default(5),
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(movimientoId) REFERENCES Movimiento(id),
	PRIMARY KEY(jugadorId, movimientoId)
);
CREATE TABLE Resistencia_Jugador(
 	jugadorId integer NOT NULL,
  	danoId integer NOT NULL,
	cantidad integer NOT NULL default(0),
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(danoId) REFERENCES TipoDano(id),
	PRIMARY KEY(jugadorId, danoId)
);

CREATE TABLE IF NOT EXISTS TipoItem (
  id integer NOT NULL PRIMARY KEY,
  nombre varchar(64) NOT NULL
);
INSERT INTO TipoItem(nombre) VALUES('arma');
INSERT INTO TipoItem(nombre) VALUES('armadura');
INSERT INTO TipoItem(nombre) VALUES('escudo');
INSERT INTO TipoItem(nombre) VALUES('casco');
INSERT INTO TipoItem(nombre) VALUES('calzado');
INSERT INTO TipoItem(nombre) VALUES('guantes');
INSERT INTO TipoItem(nombre) VALUES('anillo');
INSERT INTO TipoItem(nombre) VALUES('collar');
INSERT INTO TipoItem(nombre) VALUES('consumible');
INSERT INTO TipoItem(nombre) VALUES('reliquia');
INSERT INTO TipoItem(nombre) VALUES('miscelaneo');

DROP TABLE Inventario;
CREATE TABLE IF NOT EXISTS Inventario (
  jugadorId integer NOT NULL,
  itemId integer NOT NULL,
  tipoItemId integer NOT NULL,
  cantidad integer NOT NULL DEFAULT(1),
  equipado integer NOT NULL DEFAULT(0) CHECK (equipado IN (0, 1)),
  FOREIGN KEY (jugadorId) REFERENCES Jugador(id),
  FOREIGN KEY (tipoItemId) REFERENCES TipoItem(id),
  PRIMARY KEY(jugadorId, itemId, tipoItemId)
);
CREATE TABLE ClaseNivel(
 	claseId integer NOT NULL,
	nivel integer NOT NULL,
	proezaClase integer NOT NULL DEFAULT(0),
	proezaHabilidad integer NOT NULL DEFAULT(0),
	proezaGeneral integer NOT NULL DEFAULT(0),
	proezaHerencia integer NOT NULL DEFAULT(0),
	incrementoHabilidad integer NOT NULL DEFAULT(0),
	incrementoAtributo integer NOT NULL DEFAULT(0),
	FOREIGN KEY(claseId) REFERENCES Clase(id),
	PRIMARY KEY(claseId, nivel)
);

CREATE TABLE ClaseNivel_Habilidad(
 	claseId integer NOT NULL,
  	habilidadId integer NOT NULL,
	nivel integer NOT NULL,
	FOREIGN KEY(claseId) REFERENCES Clase(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(claseId, habilidadId)
);

CREATE TABLE SubclaseNivel_Habilidad(
 	subclaseId integer NOT NULL,
  	habilidadId integer NOT NULL,
	nivel integer NOT NULL,
	FOREIGN KEY(subclaseId) REFERENCES Subclase(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(subclaseId, habilidadId)
);

CREATE TABLE ClaseNivel_Proeza(
 	claseId integer NOT NULL,
  	proezaId integer NOT NULL,
	nivel integer NOT NULL,
	FOREIGN KEY(claseId) REFERENCES Clase(id),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	PRIMARY KEY(claseId, proezaId)
);

CREATE TABLE Raza_Inmunidad(
 	razaId integer NOT NULL,
  	estadoId integer NOT NULL,
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(estadoId) REFERENCES CambioEstado(id),
	PRIMARY KEY(razaId, estadoId)
);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 6);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 7);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 10);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 11);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 18);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 20);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 21);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 22);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 23);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 25);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 26);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 28);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 34);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 36);
INSERT INTO Raza_Inmunidad(razaId, estadoId) VALUES(12, 38);

CREATE TABLE Raza_Resistencia(
 	razaId integer NOT NULL,
  	danoId integer NOT NULL,
	cantidad integer NOT NULL DEFAULT(0),
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(danoId) REFERENCES TipoDano(id),
	PRIMARY KEY(razaId, danoId)
);

INSERT INTO Raza_Resistencia(razaId, danoId) VALUES(12, 13);
INSERT INTO Raza_Resistencia(razaId, danoId) VALUES(12, 14);

CREATE TABLE Raza_Lenguaje(
 	razaId integer NOT NULL,
  	lenguajeId integer NOT NULL,
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(lenguajeId) REFERENCES Lenguaje(id),
	PRIMARY KEY(razaId, lenguajeId)
);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(14, 1);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(14, 8);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(15, 1);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(15, 9);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(16, 1);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(16, 7);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(16, 10);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(17, 1);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(17, 11);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(18, 1);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(18, 12);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(19, 1);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(20, 1);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(20, 6);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(23, 1);
INSERT INTO Raza_Lenguaje(razaId, lenguajeId) VALUES(23, 7);


CREATE TABLE Raza_Velocidad(
 	razaId integer NOT NULL,
  	movimientoId integer NOT NULL,
	cantidad integer NOT NULL,
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(movimientoId) REFERENCES Movimiento(id),
	PRIMARY KEY(razaId, movimientoId)
);
INSERT INTO Raza_Velocidad(razaId, movimientoId, cantidad) VALUES(14, 1, 20);
INSERT INTO Raza_Velocidad(razaId, movimientoId, cantidad) VALUES(15, 1, 30);
INSERT INTO Raza_Velocidad(razaId, movimientoId, cantidad) VALUES(16, 1, 25);
INSERT INTO Raza_Velocidad(razaId, movimientoId, cantidad) VALUES(17, 1, 25);
INSERT INTO Raza_Velocidad(razaId, movimientoId, cantidad) VALUES(18, 1, 25);
INSERT INTO Raza_Velocidad(razaId, movimientoId, cantidad) VALUES(19, 1, 25);
INSERT INTO Raza_Velocidad(razaId, movimientoId, cantidad) VALUES(20, 1, 25);
INSERT INTO Raza_Velocidad(razaId, movimientoId, cantidad) VALUES(23, 1, 25);

CREATE TABLE Raza_Habilidad(
 	razaId integer NOT NULL,
  	habilidadId integer NOT NULL,
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(razaId, habilidadId)
);

INSERT INTO Raza_Habilidad(razaId, habilidadId) VALUES(14, 34);
INSERT INTO Raza_Habilidad(razaId, habilidadId) VALUES(23, 35);

CREATE TABLE Raza_Sentido(
 	razaId integer NOT NULL,
  	sentidoId integer NOT NULL,
	rango integer NOT NULL DEFAULT(0),
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(sentidoId) REFERENCES Sentido(id),
	PRIMARY KEY(razaId, sentidoId)
);
INSERT INTO Raza_Sentido(razaId, sentidoId) VALUES(14, 6);
INSERT INTO Raza_Sentido(razaId, sentidoId) VALUES(15, 7);
INSERT INTO Raza_Sentido(razaId, sentidoId) VALUES(16, 7);
INSERT INTO Raza_Sentido(razaId, sentidoId) VALUES(17, 6);
INSERT INTO Raza_Sentido(razaId, sentidoId, rango) VALUES(18, 9, 30);
INSERT INTO Raza_Sentido(razaId, sentidoId) VALUES(20, 6);
INSERT INTO Raza_Sentido(razaId, sentidoId) VALUES(23, 7);

CREATE TABLE TipoDeidad(
 	id integer PRIMARY KEY NOT NULL,
	nombre VARCHAR(32) UNIQUE NOT NULL
);
INSERT INTO TipoDeidad(nombre) VALUES('dioses del mar interno');
INSERT INTO TipoDeidad(nombre) VALUES('archidemonios');
INSERT INTO TipoDeidad(nombre) VALUES('reinas de la noche');
INSERT INTO TipoDeidad(nombre) VALUES('señores demonio');
INSERT INTO TipoDeidad(nombre) VALUES('los mayores');
INSERT INTO TipoDeidad(nombre) VALUES('señores elementales');
INSERT INTO TipoDeidad(nombre) VALUES('señores empíreos');
INSERT INTO TipoDeidad(nombre) VALUES('los 4 jinetes');
INSERT INTO TipoDeidad(nombre) VALUES('monitores semidioses');
INSERT INTO TipoDeidad(nombre) VALUES('los grandes antiguos y dioses exteriores');
INSERT INTO TipoDeidad(nombre) VALUES('dioses egipcios');

CREATE TABLE Dominio(
 	id integer PRIMARY KEY NOT NULL,
	nombre VARCHAR(32) UNIQUE NOT NULL
);
INSERT INTO Dominio(nombre) VALUES('confianza');
INSERT INTO Dominio(nombre) VALUES('destrucción');
INSERT INTO Dominio(nombre) VALUES('fuerza');
INSERT INTO Dominio(nombre) VALUES('celo');
INSERT INTO Dominio(nombre) VALUES('fuego');
INSERT INTO Dominio(nombre) VALUES('astucia');
INSERT INTO Dominio(nombre) VALUES('tiranía');
INSERT INTO Dominio(nombre) VALUES('deber');
INSERT INTO Dominio(nombre) VALUES('glifo');
INSERT INTO Dominio(nombre) VALUES('trabajo');

CREATE TABLE Deidad(
 	id integer PRIMARY KEY NOT NULL,
	nombre varchar(64) UNIQUE NOT NULL,
	edicto varchar(512) NOT NULL,
	anatema varchar(512),
	simbolo varchar(64),
	fuente integer NOT NULL DEFAULT(0),
  	tipoId integer NOT NULL DEFAULT(1),
	atributoId integer,
	atributoId2 integer,
	armaId integer NOT NULL,
	alineacionId integer NOT NULL,
	FOREIGN KEY(tipoId) REFERENCES TipoDeidad(id),
	FOREIGN KEY(atributoId) REFERENCES Atributo(id),
	FOREIGN KEY(atributoId2) REFERENCES Atributo(id),
	FOREIGN KEY(armaId) REFERENCES Arma(id),
	FOREIGN KEY(alineacionId) REFERENCES Alineacion(id)
);

INSERT INTO Deidad(nombre, edicto, anatema, simbolo, atributoId, atributoId2, armaId, alineacionId) VALUES('Gorum', 'obtener victoria en la batalla aunque llegue a sus límites y usando armadura', 'matar prisioneros o enemigos que se rindan, evitar conflictos mediante negociación o ganar el combate de manera no honorable o con magia', 'espada en la montaña', 1, 3, 17, 7);
INSERT INTO Deidad(nombre, edicto, anatema, simbolo, armaId, alineacionId) VALUES('Asmodeus', 'negociar contratos para ganar ventajas, mandar tiránicamente y torturar a los débiles, mostar subordinación ante los superiores', 'infringir un contrato, ayudar a los débiles y mostrar piedad ante el enemigo', 'pentagrama rojo', 18, 6);
INSERT INTO Deidad(nombre, edicto, anatema, simbolo, fuente, habilidadId, atributoId, atributoId2, armaId, alineacionId)
VALUES('Sarenrae(la flor del amanecer)', 'destruir al engendro de Rovagug, proteger aliados, ayudar a los enfermos y heridos, buscar y proveer redención', 'crear no-muertos, mentir, negar redención a criaturas arrepentidas, no destruir criaturas malvadas', 'ankh angelical', 1, 18, 3, 5, 3, 2);

CREATE TABLE Deidad_Hechizo(
 	hechizoId integer NOT NULL,
  	deidadId integer NOT NULL,
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	FOREIGN KEY(deidadId) REFERENCES Deidad(id),
	PRIMARY KEY(hechizoId, deidadId)
);

CREATE TABLE Dominio_Deidad(
 	dominioId integer NOT NULL,
  	deidadId integer NOT NULL,
	FOREIGN KEY(dominioId) REFERENCES Dominio(id),
	FOREIGN KEY(deidadId) REFERENCES Deidad(id),
	PRIMARY KEY(dominioId, deidadId)
);

INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(1, 1);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(2, 1);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(3, 1);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(4, 1);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(1, 2);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(5, 2);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(6, 2);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(7, 2);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(8, 2);
INSERT INTO Dominio_Deidad(dominioId, deidadId) VALUES(9, 2);

CREATE TABLE Dominio_Hechizo(
 	hechizoId integer NOT NULL,
  	dominioId integer NOT NULL,
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	FOREIGN KEY(dominioId) REFERENCES Dominio(id),
	PRIMARY KEY(hechizoId, dominioId)
);

CREATE TABLE Habilidad_Atributo(
 	habilidadId integer NOT NULL,
  	atributoId integer NOT NULL,
	cantidad integer NOT NULL DEFAULT(1),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	FOREIGN KEY(atributoId) REFERENCES Atributo(id),
	PRIMARY KEY(habilidadId, atributoId)
);
CREATE TABLE Armadura (
  id integer PRIMARY KEY NOT NULL,
  nombre varchar(32) UNIQUE NOT NULL,
  precio integer NOT NULL DEFAULT(0),
  nivel integer NOT NULL DEFAULT(0),
  ac integer NOT NULL DEFAULT(0),
  penalizacion integer NOT NULL DEFAULT(0),
  limite integer NOT NULL DEFAULT(5),
  requisito integer NOT NULL DEFAULT(0),
  velocidad integer NOT NULL DEFAULT(0),
  peso REAL NOT NULL DEFAULT(0.1),
  efecto varchar(512),
  grupoId integer NOT NULL,
  categoriaId integer NOT NULL,
  FOREIGN KEY (grupoId) REFERENCES Grupo(id),
  FOREIGN KEY (categoriaId) REFERENCES Categoria(id)
);

CREATE TABLE Razgo_Armadura(
 	armaduraId integer NOT NULL,
  	razgoId integer NOT NULL,
	monto integer NULL,
	FOREIGN KEY(armaduraId) REFERENCES Armadura(id),
	FOREIGN KEY(razgoId) REFERENCES Razgo(id),
	PRIMARY KEY(armaduraId, razgoId)
);
INSERT INTO Armadura(nombre, precio, categoriaId, grupoId) VALUES('ropa de explorador', 100, 5, 18);
INSERT INTO Armadura(nombre, precio, categoriaId, grupoId) VALUES('túnica de pergaminos', 10500, 5, 18);

INSERT INTO Razgo_Armadura(armaduraId, razgoId) VALUES(1, 41);
INSERT INTO Razgo_Armadura(armaduraId, razgoId) VALUES(2, 42);



