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
	inciativa integer NOT NULL DEFAULT(0),
	percepcion integer NOT NULL DEFAULT(0),
  	armadura integer NOT NULL DEFAULT(10),
	toqueArmadura integer NOT NULL DEFAULT(10),
	desprevenidoArmadura integer NOT NULL DEFAULT(10),
	salud integer NOT NULL DEFAULT(4),
	fortaleza integer NOT NULL DEFAULT(0),
	reflejos integer NOT NULL DEFAULT(0),
	voluntad integer NOT NULL DEFAULT(0),
	resistenciaHechizo integer NOT NULL DEFAULT(0),
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

create TABLE Jugador(
 	id integer PRIMARY KEY NOT NULL,
	nombre varchar(32) UNIQUE NOT NULL,
	nivel integer NOT NULL DEFAULT(1),
	experiencia integer NOT NULL DEFAULT(0),
	oro integer NOT NULL DEFAULT(0),
	plata integer NOT NULL DEFAULT(0),
	cobre integer NOT NULL DEFAULT(0),
	inciativa integer NOT NULL DEFAULT(0),
	percepcion integer NOT NULL DEFAULT(0),
  	armaduraNatural integer NOT NULL DEFAULT(10),
	armaduraItem integer NOT NULL DEFAULT(0),
	evasion integer NOT NULL DEFAULT(0),
	salud integer NOT NULL DEFAULT(10),
	fortaleza integer NOT NULL DEFAULT(0),
	reflejos integer NOT NULL DEFAULT(0),
	voluntad integer NOT NULL DEFAULT(0),
	resistenciaHechizo integer NOT NULL DEFAULT(0),
	ataqueBase integer NOT NULL DEFAULT(0),
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
	claseId integer NOT NULL,
	alineacionId integer NOT NULL,
	razaId integer NOT NULL,
	tamanoId integer not null default(3),
	FOREIGN KEY(alineacionId) REFERENCES Alineacion(id),
	FOREIGN KEY(claseId) REFERENCES Clase(id),
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(tamanoId) REFERENCES Tamano(id)
);

INSERT INTO Jugador(nombre, nivel, claseId, alineacionId, razaId) values('Carlos', 4, 5, 1, 20);
INSERT INTO Jugador(nombre, nivel, claseId, alineacionId, razaId) values('Linares', 4, 4, 8, 20);
INSERT INTO Jugador(nombre, nivel, claseId, alineacionId, razaId, tamanoId) values('Morbo', 4, 2, 6, 23, 2);

create TABLE Reputacion(
	modificador INTEGER NOT NULL DEFAULT(0),
	jugadorId integer NOT NULL,
	faccionId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(faccionId) REFERENCES Faccion(id),
	PRIMARY KEY(jugadorId, faccionId)
);

insert into Reputacion(jugadorId, faccionId, modificador) values(1, 1, 2);
insert into Reputacion(jugadorId, faccionId, modificador) values(2, 1, 1);
insert into Reputacion(jugadorId, faccionId, modificador) values(3, 1, 0);
insert into Reputacion(jugadorId, faccionId, modificador) values(1, 2, -2);
insert into Reputacion(jugadorId, faccionId, modificador) values(2, 2, 1);
insert into Reputacion(jugadorId, faccionId, modificador) values(3, 2, 0);
insert into Reputacion(jugadorId, faccionId, modificador) values(1, 3, -2);
insert into Reputacion(jugadorId, faccionId, modificador) values(2, 3, -1);
insert into Reputacion(jugadorId, faccionId, modificador) values(3, 3, 0);
insert into Reputacion(jugadorId, faccionId, modificador) values(1, 4, 1);
insert into Reputacion(jugadorId, faccionId, modificador) values(2, 4, 1);
insert into Reputacion(jugadorId, faccionId, modificador) values(3, 4, 1);
insert into Reputacion(jugadorId, faccionId) values(1, 5);
insert into Reputacion(jugadorId, faccionId) values(2, 5);
insert into Reputacion(jugadorId, faccionId) values(3, 5);
insert into Reputacion(jugadorId, faccionId, modificador) values(1, 6, -1);
insert into Reputacion(jugadorId, faccionId, modificador) values(2, 6, -1);
insert into Reputacion(jugadorId, faccionId, modificador) values(3, 6, -1);
insert into Reputacion(jugadorId, faccionId, modificador) values(1, 7, -1);
insert into Reputacion(jugadorId, faccionId, modificador) values(2, 7, -1);
insert into Reputacion(jugadorId, faccionId, modificador) values(3, 7, -1);
insert into Reputacion(jugadorId, faccionId, modificador) values(1, 8, -1);
insert into Reputacion(jugadorId, faccionId, modificador) values(2, 8, -2);
insert into Reputacion(jugadorId, faccionId, modificador) values(3, 8, 0);

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

create TABLE Razgo_Jugador(
	jugadorId integer NOT NULL,
	razgoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(razgoId) REFERENCES Razgo(id),
	PRIMARY KEY(jugadorId, razgoId)
);

CREATE TABLE Proeza_Jugador(
 	jugadorId integer NOT NULL,
  	proezaId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	PRIMARY KEY(jugadorId, proezaId)
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
	FOREIGN KEY(jugadorId) REFERENCES Entidad(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(jugadorId, habilidadId)
);
CREATE TABLE Sentido_Jugador(
 	jugadorId integer NOT NULL,
  	sentidoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Entidad(id),
	FOREIGN KEY(sentidoId) REFERENCES Sentido(id),
	PRIMARY KEY(jugadorId, sentidoId)
);
CREATE TABLE Inmunidad_Jugador(
 	jugadorId integer NOT NULL,
  	estadoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Entidad(id),
	FOREIGN KEY(estadoId) REFERENCES CambioEstado(id),
	PRIMARY KEY(jugadorId, estadoId)
);
CREATE TABLE Velocidad_Jugador(
 	jugadorId integer NOT NULL,
  	movimientoId integer NOT NULL,
	cantidad integer NOT NULL default(5),
	FOREIGN KEY(jugadorId) REFERENCES Entidad(id),
	FOREIGN KEY(movimientoId) REFERENCES Movimiento(id),
	PRIMARY KEY(jugadorId, movimientoId)
);
CREATE TABLE Resistencia_Jugador(
 	jugadorId integer NOT NULL,
  	danoId integer NOT NULL,
	cantidad integer NOT NULL default(0),
	FOREIGN KEY(jugadorId) REFERENCES Entidad(id),
	FOREIGN KEY(danoId) REFERENCES TipoDano(id),
	PRIMARY KEY(jugadorId, danoId)
);

SELECT ArmaCompleta.id, ArmaCompleta.nombre, nivel, precio ,manos, tipo, grupo categoria, Razgo.nombre AS razgo, Razgo.descripcion AS razgoDesc FROM ArmaCompleta JOIN Razgo_Arma ON Razgo_Arma.armaId = ArmaCompleta.id JOIN Razgo ON Razgo_Arma.razgoId = Razgo.id;