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

CREATE TABLE TipoDragon(
	id INTEGER NOT NULL PRIMARY KEY,
	nombre VARCHAR(32) NOT NULL UNIQUE,
	tradicionId INTEGER NOT NULL,
	danoId INTEGER NOT NULL,
	salvacion INTEGER NOT NULL,
	FOREIGN KEY(tradicionId) REFERENCES Tradicion(id),
	FOREIGN KEY(danoId) REFERENCES TipoDano(id),
	FOREIGN KEY(salvacion) REFERENCES Atributo(id)
);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('adamantino', 4, 2, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('marino', 4, 2, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('negro', 4, 6, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de salmuera', 1, 6, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de cobre', 4, 6, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('azul', 3, 8, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de bronce', 3, 8, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de las nubes', 4, 8, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('celestiales', 2, 8, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('diabólico', 2, 7, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de latón', 1, 7, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de oro', 1, 7, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('magmático', 4, 7, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('rojo', 4, 7, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('del inframundo', 2, 7, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de crital', 1, 3, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('selvátivo', 4, 3, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('conspirador', 3, 13, 7);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('cornudo', 4, 13, 7);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('verde', 4, 13, 7);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de plata', 1, 5, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('blanc', 4, 5, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('espejismo', 1, 18, 9);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('del presagio', 3, 18, 9);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('soverano', 3, 18, 9);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('del umbral', 2, 11, 7);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('empireal', 2, 19, 8);
INSERT INTO TipoDragon(nombre, tradicionId, danoId, salvacion) VALUES('de la fortuna', 1, 12, 8);

CREATE TABLE Jugador(
 	id integer PRIMARY KEY NOT NULL,
	nombre varchar(64) UNIQUE NOT NULL,
	nivel integer NOT NULL DEFAULT(1),
	experiencia integer NOT NULL DEFAULT(0),
	dinero integer NOT NULL DEFAULT(0),
	percepcion integer NOT NULL DEFAULT(0),
  	armaduraRopa integer NOT NULL DEFAULT(0),
  	armaduraLigera integer NOT NULL DEFAULT(0),
  	armaduraMedia integer NOT NULL DEFAULT(0),
  	armaduraPesada integer NOT NULL DEFAULT(0),
	claseDC integer NOT NULL DEFAULT(0),
	hechizoDC integer NOT NULL DEFAULT(0),
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
	retrato VARCHAR(128),
	claseId integer NOT NULL,
	subclaseId integer,
	subclaseId2 integer,
	alineacionId integer NOT NULL,
	razaId integer NOT NULL,
	herenciaId integer NOT NULL,
	atributoId integer NOT NULL default(1),
	tamanoId integer not null default(3),
	transfondoId integer NOT NULL,
	deidadId INTEGER,
	dragonId INTEGER,
	FOREIGN KEY(alineacionId) REFERENCES Alineacion(id),
	FOREIGN KEY(claseId) REFERENCES Clase(id),
	FOREIGN KEY(subclaseId) REFERENCES Subclase(id),
	FOREIGN KEY(subclaseId2) REFERENCES Subclase(id),
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(herenciaId) REFERENCES Herencia(id),
	FOREIGN KEY(tamanoId) REFERENCES Tamano(id),
	FOREIGN KEY(transfondoId) REFERENCES Transfondo(id),
	FOREIGN KEY(atributoId) REFERENCES Atributo(id),
	FOREIGN KEY(deidadId) REFERENCES Deidad(id),
	FOREIGN KEY(dragonId) REFERENCES TipoDragon(id)
);
CREATE TABLE Jugador_Habilidad(
 	jugadorId integer NOT NULL,
  	habilidadId integer NOT NULL,
	variables varchar(128),
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(jugadorId, habilidadId)
);
CREATE TABLE JugadorTradicion(
	id INTEGER PRIMARY KEY NOT NULL,
	nombre VARCHAR(64) NOT NULL,
	modificador INTEGER NOT NULL DEFAULT(1),
	jugadorId INTEGER NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id)
);
CREATE TABLE Jugador_Hechizo(
	cantidad integer NOT NULL DEFAULT(1),
	jugadorId integer NOT NULL,
  	hechizoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	PRIMARY KEY(jugadorId, hechizoId)
);
CREATE TABLE Jugador_Inmunidad(
 	jugadorId integer NOT NULL,
  	estadoId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(estadoId) REFERENCES CambioEstado(id),
	PRIMARY KEY(jugadorId, estadoId)
);
CREATE TABLE Jugador_Lenguaje(
 	jugadorId integer NOT NULL,
  	lenguajeId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(lenguajeId) REFERENCES Lenguaje(id),
	PRIMARY KEY(jugadorId, lenguajeId)
);
CREATE TABLE Jugador_Proeza(
 	jugadorId integer NOT NULL,
  	proezaId integer NOT NULL, variables varchar(128),
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	PRIMARY KEY(jugadorId, proezaId)
);
CREATE TABLE Jugador_Resistencia(
 	jugadorId integer NOT NULL,
  	danoId integer NOT NULL,
	cantidad integer NOT NULL default(0),
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(danoId) REFERENCES TipoDano(id),
	PRIMARY KEY(jugadorId, danoId)
);
CREATE TABLE Jugador_Sentido(
 	jugadorId integer NOT NULL,
  	sentidoId integer NOT NULL,
	rango integer,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(sentidoId) REFERENCES Sentido(id),
	PRIMARY KEY(jugadorId, sentidoId)
);
CREATE TABLE Jugador_Velocidad(
 	jugadorId integer NOT NULL,
  	movimientoId integer NOT NULL,
	cantidad integer NOT NULL default(5),
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(movimientoId) REFERENCES Movimiento(id),
	PRIMARY KEY(jugadorId, movimientoId)
);

CREATE TABLE Jugador_Usuario(
 	jugadorId integer NOT NULL,
  	usuarioId integer NOT NULL,
	FOREIGN KEY(jugadorId) REFERENCES Jugador(id),
	FOREIGN KEY(usuarioId) REFERENCES Usuario(id),
	PRIMARY KEY(jugadorId, usuarioId)
);

CREATE TABLE Transfondo(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL,
	descripcion varchar(256) NOT NULL,
	tradicion varchar(64),
	rarezaId INTEGER NOT NULL DEFAULT(1),
	atributoId INTEGER,
	atributoId2 INTEGER,
	habilidadId INTEGER,
	proezaId INTEGER,
	FOREIGN KEY(rarezaId) REFERENCES Rareza(id),
	FOREIGN KEY(atributoId) REFERENCES Atributo(id),
	FOREIGN KEY(atributoId2) REFERENCES Atributo(id),
	FOREIGN KEY(habilidadId) REFERENCES Atributo(id),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id)
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

CREATE TABLE TipoSubclase(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL,
	claseId INT NOT NULL,
	FOREIGN KEY(claseId) REFERENCES Clase(id)
);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('doctrina', 2);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('tesis arcana', 3);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('escuela arcana', 3);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('ventaja de cazador', 11);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('musa', 4);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('instinto', 5);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('campo de investigación', 7);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('fraude', 6);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('causa', 8);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('orden druídica', 9);
INSERT INTO TipoSubclase (nombre, claseId) VALUES ('linaje', 12);
CREATE TABLE Subclase(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL,
	tipoSubclaseId integer NOT NULL,
	descripcion varchar(512) NOT NULL,
	FOREIGN KEY(tipoSubclaseId) REFERENCES TipoSubclase(id)
);
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('clérigo de claustro', 1, 'clérigos especializados en magia divina conectados a los dominios de su deidad');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('sacerdote de guerra', 1, 'clérigos entrenados también en proezas militare, se enfocan tanto en batalla como en hechizos divinos');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('modelado de hechizos experimental', 2, 'promueve la práctica del modelado de hehcizos y promueve su práctica basada en el uso que le han dado sus ancestros');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('sintonización con familiar mejorada', 2, 'magos que forman un pacto más fuerte con sus familiares y les permiten ganar mayores beneficios de estos ganando un familiar reemplazando su ítem vinculado por su familiar');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('mezcla de hechizos', 2, 'el usuario ha investigado a profundidad la jerarquía d elos hechizos y ha aprendido a combinarlos en hechizos más poderosos');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('sustitución de hechizos', 2, 'el usuario ha estudiado la forma de sustituir hechizos ya preparados sin necesidad de descanso');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('nexo de bastón', 2, 'el usuario ha entrenado con su bastón desde el principio creando un vínculo con este y brindándole poderosas propiedades');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela mágica de la mantis roja', 3, 'enseñado en la ciudadela roja, los asesinos de la mantis roja aprenden una serie de ehchizos que les ayudan a asesinar con precisión y sutileza');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de Ars Grammatica', 3, 'enseñada por la sociedad Pathfinder, constituye el poder de uso de palabras, letras, números y guardas para desestabilizar al oponente con elegancia');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de magia de batalla', 3, 'enseñada en la amyoría de academias militares, se espcializa en el uso de energías destructivas para erradicar ejércitos completos de forma táctica');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de magia cívica', 3, 'se enseña en el occularium de Manaket o la academia de magia aplicada, se especializa en la construcción y demolición de infraestructuras');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de mentalismo', 3, 'enseñada en la torre del vidente o la piedra de los videntes, enseña la forma de moldear y alterar la mente con magia');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de la forma proteana', 3, 'enseñada en la academia de Kintargo Alabaster o en las forjas de carne de Nex, esta escuela se enfoca en la relación de la magia y el cuerpo y en como esta puede modelar el cuerpo a conveniencia');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de la sabiduría podrida', 3, 'enseñada por profesores nómadas de Magaambya, enseña una de las formas mágicas más antigua de Golarion');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de magia rúnica Thassiloniana', 3, 'enseñada en selectas academias de Nuevo Thassilon, se enfoca en la enseñanza a traves de las 7 runas del pecado usadas por los señores de las runas en el extinto Azlanti');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela del límite', 3, 'enseñada en la escuela de estudios dimensionales de Katapesh o en escuelas clandestinas de Ustalav, se enfoca en manipular fuerzas antiguas y fantasmales a las que los mortales temen');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de la reclamación', 3, 'enseñada por los reclamantes de Sarkoris, se enfoca en el conocimiento perdido y de lugares olvidados');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('escuela de la teoría mágica unificada', 3, 'esta escuela toma un poco de todas las escuelas buscando un conocimiento más universal y continuo. No tienerepertorio de hechizos');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('ráfaga', 4, 'el usuario descarga una furia de golpes sobre el objetivo marcado');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('burlar', 4, 'el usuario es hábil engañando y evadiendo a la criatura marcada');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('precisión', 4, 'el usuario apunta a los puntos débiles de la criatura marcada');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('enigma', 5, 'esta musa se inspira en criaturas desconocidas o extraplanares que buscan inspirar la búsqueda de las verdades ocultas del universo');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('maestro', 5, 'se inspira en un profesor o rival y busca que el usuario mejore constantemente superando sus propios límites');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('erudito', 5, 'se puede inspirar en muchos personajes diferentes o en alguna criatura que viva eternamente e inspira la composición basada en temas diferentes y variados');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('guerrero', 5, 'se inspira en un general o un guerrero excepcional o alguna guerra o arma legendaria, busca transmitir el fragor de la batalla y el verdadero espíritu del guerrero');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('instinto animal', 6, 'manifiesta su rabia a partir de una conexión animal con alguno de los siguientes animales: simio: puño 1d10 contusión (agarre), oso: mandíbula 1d10 penetración y garra 1d6 corte (ágil), toro: cuernos 1d10 penetración (empuje), gato: mandíbula 1d10 penetración, garras 1d6 corte (ágil), siervo: cuernos 1d10 penetración (agarre), sapo: mandíbula 1d10 contución y lengua 1d4 contución(ágil), tiburón mandíbula 1d10 penetración (agarre), serpiente: colmillos 1d10 penetración (agarre), lobo: mandíbula 1d10 penetración (tumbar) ');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('instinto de dragón', 6, 'manifiesta rabia a partir de la fuerza de un tipo de dragón que el usuario haya asesinado y escoge entre adamantino: contundente, conspirador: veneno, diabólico: fuego, empireal: espiritual, de la fortuna: fuerza, con cuernos: veneno, espejismo: mental, del presagio: mental');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('instinto de furia', 6, 'la rabia del usuario proviene del interior solamente');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('instinto de gigante', 6, 'la rabia proporciona al usuario la fuerza de los gigantes');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('instinto espiritual', 6, 'la rabia viene de conexiones espirituales con ancestros o espectros');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('bombardero', 7, 'se especializa en explosiones y reacciones alquímicas violentas');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('cirujano', 7, 'fabricaciones alquímicas enfocadas al uso medicinal');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('mutagenista', 7, 'uso de transformaciones mutagenistas para mejorar ciertos aspectos físicos a costa de otros');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('toxicólogo', 7, 'especialización en la preparación de venenos y toxinas');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('rufian', 8, 'prefiere afrontar enemigos de forma directa o con intimidación tal como un jefe criminal o un noble corrupto');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('canalla', 8, 'usa diplomacia y cumplidos para salirse con la suya tal como un estafador o diplomático');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('ladrón', 8, 'se camufla y toma las pertenencias de los demás tal como un ladrón de calle o alguien que se infiltra a robar por entre las ventanas');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('desecración (impío)', 9, 'sublevar y corromper todo lo que sea puro y sagrado, sembrar duda entre los que guardan ideales de pureza y santidad');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('grandeza (sagrado)', 9, 'proveer ejemplo a los demás, disfrutar y compartir de la belleza del mundo y mantenerse impecable y bien presentado; anatema: arruinarse al asociarse con demonios o fuerzas impías');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('injusticia (impío)', 9, 'destruir cualquier cosa en su camino, tomar ventaja de los demás, robar o hacer trampa; anatema: seguir la ley fuera d ela ley dictada por el dios que siga');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('justicia', 9, 'seguir la ley y respetar las autoridades o liderazgos legítimos; anatema: tomar ventaja de los demás, hacer trampa');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('liberación', 9, 'oponerse a la esclabitud o tiranía, pelear por la libertad de los demás, respetar elecciones de los demás; anatema: amneanzar a alguien o forzarlo a que actúe de cierta manera o impulsar la tiranía y esclavitud');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('obediencia', 9, 'hacer cumplir las jerarquías, eliminar jerarquías ilegítimas, procurar tomar el liderazgo; anatema: permitir que alguien con menos poder imponga orden sobre quienes tiene más');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('redención (sagrado)', 9, 'intentar redimir a quienes cometen actos malvados, mostrar compasión por los demás independientemente de su autoridad; anatema: matar a un enemigo inteligente sin ofrecerle primero un chance de redención');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('animal', 10, 'tiene fuerte conexión con los animales tanto que forjó un vínculo profundo con un compañero animal');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('flama', 10, 'tiene conexión con las llamas y puede manipularlas a su antojo');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('hoja', 10, 'busca las recompensas de la naturaleza y le sirve como jardinero y guardian, además se sirve de un leshy como familiar');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('piedra', 10, 'fuerte como una piedra y siente paz en presencia de las piedras tanto naturales como esculpidas');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('tormenta', 10, 'nacido bajo la tempestad o sobreviviente de un relámpago, ahora porta la furia de la tormanta en su corazón y canaliza su fierza destructiva');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('salvaje', 10, 'la fuerza de la naturaleza corre por su cuerpo, criado por animales, ahora la magia primitiva le brinda la habilidad de transformarse en una criatura');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('ola', 10, 'ha aprendido el flujo y la forma el agua como recurso de vida');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('aberrante', 11, 'alguna entidad más allá de las estrellas proporciona magia de tradición (oculto)');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('angelical', 11, 'compare ancestros con el reino celestial o alguno de sus ancestros tenía devoción tal que su linaje fue bendecido haciendo que pudiera usar magia de tradición (divino)');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('demónico', 11, 'uno de sus ancestros fue corrompido por demonios trayendo el peso de una maldición y hace que pueda usar magia de tradición (divino)');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('diabólico', 11, 'alguno de sus ancestros hizo un pacto con alguna entidad infernal haciendo que pueda usar magia de tradición (divino)');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('dracónico', 11, 'comparte sangre con algún tipo de dragón tales como latón, oro o rojo(fuego), bronce o azul(electricidad), cobre o negro(ácido), plata o blanco(frío), verde(veneno) lo que permite usar magia de tradición (arcano)');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('elemental (fuego)', 11, 'la influencia elemental imbuye su sangre con la furia del fuego haciendo que pueda usar magia de tradición (primitivo) y que su magia de sangre haga daño por fuego');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('elemental (agua)', 11, 'la influencia elemental imbuye su sangre con la furia de los torrentes y las olas haciendo que pueda usar magia de tradición (primitivo) y que su magia de sangre haga daño por contusión');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('elemental (viento)', 11, 'la influencia elemental imbuye su sangre con la furia de las corrientes y las tormentas haciendo que pueda usar magia de tradición (primitivo) y que su magia de sangre haga daño por corte');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('elemental (tierra)', 11, 'la influencia elemental imbuye su sangre con la furia de las rocas haciendo que pueda usar magia de tradición (primitivo) y que su magia de sangre haga daño por contusión');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('fey', 11, 'su linaje viene de la influencia fey o del Primer mundo lo que hace que pueda usar magia de tradición (primitivo)');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('bruja', 11, 'una bruja maldijo a su familia o es decendiente de una bruja lo que hace que pueda usar magia de tradición (oculto)');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('imperial', 11, 'es decendiente de un maestro de la magia lo que hace que pueda usar magia de tradición (arcano)');
INSERT INTO Subclase (nombre, tipoSubclaseId, descripcion) VALUES ('no-muerto', 11, 'es decendiente de algún no-muerto poderoso einteligente tal como un vampiro lo que hace que pueda usar magia de tradición (divino)');
CREATE TABLE SubclaseNivel_Habilidad(
 	subclaseId integer NOT NULL,
  	habilidadId integer NOT NULL,
	nivel integer NOT NULL,
	FOREIGN KEY(subclaseId) REFERENCES Subclase(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	PRIMARY KEY(subclaseId, habilidadId)
);
CREATE TABLE SubclaseNivel_Proeza(
 	subclaseId integer NOT NULL,
  	proezaId integer NOT NULL,
	nivel integer NOT NULL,
	FOREIGN KEY(subclaseId) REFERENCES Subclase(id),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	PRIMARY KEY(subclaseId, proezaId)
);
CREATE TABLE Subclase_Hechizo(
 	hechizoId integer NOT NULL,
  	subclaseId integer NOT NULL,
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	FOREIGN KEY(subclaseId) REFERENCES Subclase(id),
	PRIMARY KEY(hechizoId, subclaseId)
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

CREATE TABLE ItemMiscelaneo (
  id integer PRIMARY KEY NOT NULL,
  nombre varchar(32) UNIQUE NOT NULL,
  precio integer NOT NULL DEFAULT(0),
  nivel integer NOT NULL DEFAULT(0),
  peso REAL NOT NULL DEFAULT(0.1),
  efecto varchar(2048) NOT NULL,
  tipoId integer NOT NULL,
  FOREIGN KEY (tipoId) REFERENCES TipoItem(id)
);
CREATE TABLE Razgo_Item(
 	itemId integer NOT NULL,
  	razgoId integer NOT NULL,
	FOREIGN KEY(itemId) REFERENCES ItemMiscelaneo(id),
	FOREIGN KEY(razgoId) REFERENCES Razgo(id),
	PRIMARY KEY(itemId, razgoId)
);

CREATE TABLE Item_Atributo(
 	itemId integer NOT NULL,
  	atributoId integer NOT NULL,
	cantidad integer NOT NULL DEFAULT(1),
	FOREIGN KEY(itemId) REFERENCES ItemMiscelaneo(id),
	FOREIGN KEY(atributoId) REFERENCES Atributo(id),
	PRIMARY KEY(itemId, atributoId)
);

INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 1', 'gasta 1 acción: cura 1d8 de salud', 1, 300, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 2', 'gasta 1 acción: cura 2d8 de salud', 3, 1800, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 3', 'gasta 1 acción: cura 3d8 de salud', 5, 4800, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 4', 'gasta 1 acción: cura 4d8 de salud', 7, 7800, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 5', 'gasta 1 acción: cura 5d8 de salud', 9, 10800, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 6', 'gasta 1 acción: cura 6d8 de salud', 11, 18300, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 7', 'gasta 1 acción: cura 7d8 de salud', 13, 27300, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 8', 'gasta 1 acción: cura 8d8 de salud', 15, 37800, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 9', 'gasta 1 acción: cura 9d8 de salud', 17, 49800, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, precio, tipoId) VALUES('poción de curación 10', 'gasta 1 acción: cura 10d8 de salud', 19, 63300, 9);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, peso, precio, tipoId) VALUES('Necronomicón', '+8 de ocultismo y religión, -4 de sigilo, diplomacia, engaño, naturaleza y voluntad. Maldición: Cuando el usuario vaya a dormir: tira 1 dado de voluntad de 25 o el usuario tendrá pesadillas inducidas por el libro y al despertar estará exhausto, en fallo crítico toma 6d6 de daño mental. Para remover la maldición el usuario puede tirar un dado de voluntad igual a 10+2 x nivel del jugador: el jugador tira el libro a 5 metros de distancia librándose de la maldición, en fallo toma 6d6 de daño mental y tiene estupidez 2 por 1 hora, en fallo crítico toma doble daño y el libro se combina con su mano por 1 semana haciendo imposible usar esa mano y remover el libro. Esta maldición no se puede eliminar de ninguna otra forma. 1 vez al día Puede gastar 1 acción: tira 1 dado de ocultismo de 27 para preguntar al libro cualquiera de sus conocimientos', 20, 1, 10000000, 10);
INSERT INTO Razgo_Item(itemId, razgoId) VALUES(11, 55);
INSERT INTO Razgo_Item(itemId, razgoId) VALUES(11, 54);
INSERT INTO Razgo_Item(itemId, razgoId) VALUES(11, 32);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(11, 20, 8);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(11, 21, 8);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(11, 9, -4);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(11, 13, -4);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(11, 14, -4);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(11, 19, -4);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(11, 22, -4);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, peso, precio, tipoId) VALUES('botas de la muerte horripilante', '+5 de sigilo, el usuario puede usar el hechizo de invisibilidad 1 vez al día', 7, 0.1, 140000, 5);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(12, 22, 5);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, peso, precio, tipoId) VALUES('anillo del comandante natural', '+3 de engaño, diplomacia e intimidación', 3, 0, 90000, 7);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(13, 13, 3);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(13, 14, 3);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(13, 16, 3);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, peso, precio, tipoId) VALUES('casco de los caballeros infernales', '+5 de voluntad contra criaturas caóticas, +5 de resistencia al daño por vacío, solo puede ser usado por personajes legales', 3, 1, 85000, 4);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(14, 36, 5);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, peso, precio, tipoId) VALUES('casco de guía', '+5 de de percepción y naturaleza, el usuario puede usar el hechizo golpe seguro 3 veces al día', 8, 1, 400000, 4);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(15, 26, 5);
INSERT INTO Item_Atributo(itemId, atributoId, cantidad) VALUES(15, 19, 5);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, peso, precio, tipoId) VALUES('flechas', 'munición para arcos', 0, 0.01, 10, 12);
INSERT INTO ItemMiscelaneo(nombre, efecto, nivel, peso, precio, tipoId) VALUES('saetas', 'munición para ballestas', 0, 0.01, 10, 12);
INSERT INTO ClaseNivel (claseId, nivel, incrementoAtributo) VALUES (4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (4, 2, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (4, 3, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (4, 4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (4, 5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (4, 6, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (4, 7, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (4, 8, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (4, 9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (4, 10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (4, 11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (4, 12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (4, 13, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (4, 14, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (4, 15, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (4, 16, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (4, 17, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (4, 18, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (4, 19, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (4, 20, 1, 1, 1);

INSERT INTO ClaseNivel (claseId, nivel, proezaClase, incrementoAtributo) VALUES (5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (5, 2, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (5, 3, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (5, 4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (5, 5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (5, 6, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (5, 7, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (5, 8, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (5, 9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (5, 10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (5, 11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (5, 12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (5, 13, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (5, 14, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (5, 15, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (5, 16, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (5, 17, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (5, 18, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (5, 19, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (5, 20, 1, 1, 1);

INSERT INTO ClaseNivel (claseId, nivel, proezaClase, incrementoAtributo, proezaHabilidad) VALUES (6, 1, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoHabilidad) VALUES (6, 2, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad, proezaHabilidad) VALUES (6, 3, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoHabilidad) VALUES (6, 4, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo, proezaHabilidad) VALUES (6, 5, 1, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoHabilidad) VALUES (6, 6, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad, proezaHabilidad) VALUES (6, 7, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoHabilidad) VALUES (6, 8, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, proezaHabilidad) VALUES (6, 9, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo, proezaHabilidad, incrementoHabilidad) VALUES (6, 10, 1, 1, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad, proezaHabilidad) VALUES (6, 11, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoHabilidad) VALUES (6, 12, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, proezaHabilidad) VALUES (6, 13, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoHabilidad) VALUES (6, 14, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo, proezaHabilidad) VALUES (6, 15, 1, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoHabilidad) VALUES (6, 16, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, proezaHabilidad) VALUES (6, 17, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoHabilidad) VALUES (6, 18, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad, proezaHabilidad) VALUES (6, 19, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo, incrementoHabilidad) VALUES (6, 20, 1, 1, 1, 1);

INSERT INTO ClaseNivel (claseId, nivel, proezaClase, incrementoAtributo) VALUES (7, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (7, 2, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (7, 3, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (7, 4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (7, 5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (7, 6, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (7, 7, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (7, 8, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (7, 9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (7, 10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (7, 11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (7, 12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (7, 13, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (7, 14, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (7, 15, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (7, 16, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (7, 17, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (7, 18, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (7, 19, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (7, 20, 1, 1, 1);

INSERT INTO ClaseNivel (claseId, nivel, proezaClase, incrementoAtributo) VALUES (8, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (8, 2, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (8, 3, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (8, 4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (8, 5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (8, 6, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (8, 7, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (8, 8, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (8, 9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (8, 10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (8, 11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (8, 12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (8, 13, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (8, 14, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (8, 15, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (8, 16, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (8, 17, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (8, 18, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (8, 19, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (8, 20, 1, 1, 1);

INSERT INTO ClaseNivel (claseId, nivel, incrementoAtributo) VALUES (9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (9, 2, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (9, 3, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (9, 4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (9, 5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (9, 6, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (9, 7, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (9, 8, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (9, 9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (9, 10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (9, 11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (9, 12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (9, 13, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (9, 14, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (9, 15, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (9, 16, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (9, 17, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (9, 18, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (9, 19, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (9, 20, 1, 1, 1);

INSERT INTO ClaseNivel (claseId, nivel, proezaClase, incrementoAtributo) VALUES (10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (10, 2, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (10, 3, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (10, 4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (10, 5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (10, 6, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (10, 7, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (10, 8, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (10, 9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (10, 10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (10, 11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (10, 12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (10, 13, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (10, 14, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (10, 15, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (10, 16, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (10, 17, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (10, 18, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (10, 19, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (10, 20, 1, 1, 1);

INSERT INTO ClaseNivel (claseId, nivel, incrementoAtributo) VALUES (11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (11, 2, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (11, 3, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (11, 4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (11, 5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (11, 6, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (11, 7, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (11, 8, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (11, 9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (11, 10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (11, 11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (11, 12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (11, 13, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (11, 14, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (11, 15, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (11, 16, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (11, 17, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (11, 18, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (11, 19, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (11, 20, 1, 1, 1);

INSERT INTO ClaseNivel (claseId, nivel, incrementoAtributo) VALUES (12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (12, 2, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (12, 3, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (12, 4, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (12, 5, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (12, 6, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (12, 7, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (12, 8, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (12, 9, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (12, 10, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (12, 11, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (12, 12, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (12, 13, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (12, 14, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad, incrementoAtributo) VALUES (12, 15, 1, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (12, 16, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaHerencia, incrementoHabilidad) VALUES (12, 17, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad) VALUES (12, 18, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaGeneral, incrementoHabilidad) VALUES (12, 19, 1, 1);
INSERT INTO ClaseNivel (claseId, nivel, proezaClase, proezaHabilidad, incrementoAtributo) VALUES (12, 20, 1, 1, 1);
CREATE TABLE ClaseNivel_Hechizo(
 	hechizoId integer NOT NULL,
  	claseId integer NOT NULL,
	nivel integer NOT NULL DEFAULT(1),
	FOREIGN KEY(hechizoId) REFERENCES Hechizo(id),
	FOREIGN KEY(claseId) REFERENCES Clase(id),
	PRIMARY KEY(hechizoId, claseId)
);
INSERT INTO ClaseNivel_Hechizo(hechizoId, claseId) VALUES(81, 4);
INSERT INTO ClaseNivel_Hechizo(hechizoId, claseId) VALUES(82, 4);
--general 59
--Habilidad 60
--Herencia 61
--clase 62
--dedicación 63
insert into Proeza_Clase(proezaId, claseId) VALUES(18, 3);
insert into Proeza_Clase(proezaId, claseId) VALUES(18, 9);
insert into Proeza_Clase(proezaId, claseId) VALUES(18, 12);
insert into Proeza_Clase(proezaId, claseId) VALUES(19, 3);
insert into Proeza_Clase(proezaId, claseId) VALUES(19, 9);
insert into Proeza_Clase(proezaId, claseId) VALUES(19, 12);

insert into Razgo_Proeza(proezaId, razgoId) VALUES(1, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(2, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(3, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(4, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(5, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(6, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(7, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(8, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(9, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(10, 59);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(11, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(12, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(13, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(14, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(15, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(16, 59);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(16, 60);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(17, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(18, 62);
insert into Razgo_Proeza(proezaId, razgoId) VALUES(19, 62);

insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 134, 5);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 135, 7);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 136, 9);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 137, 9);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 62, 9);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 41, 11);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 109, 13);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 40, 13);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 138, 15);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 48, 15);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 139, 17);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 140, 17);
insert into ClaseNivel_Habilidad(claseId, habilidadId, nivel) VALUES(7, 112, 19);

insert into Habilidad_Atributo(habilidadId, atributoId, cantidad) VALUES(135, 33, 2);
insert into Habilidad_Atributo(habilidadId, atributoId, cantidad) VALUES(135, 34, 2);
insert into Habilidad_Atributo(habilidadId, atributoId, cantidad) VALUES(136, 27, 2);
insert into Habilidad_Atributo(habilidadId, atributoId, cantidad) VALUES(138, 33, 3);
insert into Habilidad_Atributo(habilidadId, atributoId, cantidad) VALUES(138, 34, 3);
insert into Habilidad_Atributo(habilidadId, atributoId, cantidad) VALUES(140, 27, 3);

insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(52, 235, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(53, 236, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(54, 237, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(55, 238, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(56, 238, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(57, 240, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(58, 240, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(59, 240, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(60, 240, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(61, 241, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(62, 242, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(63, 243, 1);
insert into SubclaseNivel_Habilidad(subclaseId, habilidadId, nivel) VALUES(64, 244, 1);

insert into SubclaseNivel_Proeza(subclaseId, proezaId, nivel) VALUES(45, 22, 1);
insert into SubclaseNivel_Proeza(subclaseId, proezaId, nivel) VALUES(46, 23, 1);
insert into SubclaseNivel_Proeza(subclaseId, proezaId, nivel) VALUES(47, 24, 1);
insert into SubclaseNivel_Proeza(subclaseId, proezaId, nivel) VALUES(48, 25, 1);
insert into SubclaseNivel_Proeza(subclaseId, proezaId, nivel) VALUES(49, 26, 1);
insert into SubclaseNivel_Proeza(subclaseId, proezaId, nivel) VALUES(50, 27, 1);
insert into SubclaseNivel_Proeza(subclaseId, proezaId, nivel) VALUES(51, 28, 1);

insert into Subclase_Hechizo(subclaseId, hechizoId) VALUES(45, 86);
insert into Subclase_Hechizo(subclaseId, hechizoId) VALUES(46, 87);
insert into Subclase_Hechizo(subclaseId, hechizoId) VALUES(47, 88);
insert into Subclase_Hechizo(subclaseId, hechizoId) VALUES(48, 89);
insert into Subclase_Hechizo(subclaseId, hechizoId) VALUES(49, 90);
insert into Subclase_Hechizo(subclaseId, hechizoId) VALUES(50, 92);
insert into Subclase_Hechizo(subclaseId, hechizoId) VALUES(51, 93);
CREATE TABLE Herencia(
 	id integer PRIMARY KEY,
  	nombre varchar(56) UNIQUE NOT NULL,
	descripcion varchar(256) NOT NULL,
  	razaId integer,
	rarezaId integer NOT NULL DEFAULT(1),
	habilidadId integer,
	proezaId integer,
	proezaId2 integer,
	sentidoId integer,
	FOREIGN KEY(rarezaId) REFERENCES Rareza(id),
	FOREIGN KEY(habilidadId) REFERENCES HabilidadEspecial(id),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	FOREIGN KEY(proezaId2) REFERENCES Proeza(id),
	FOREIGN KEY(razaId) REFERENCES Raza(id),
	FOREIGN KEY(sentidoId) REFERENCES Sentido(id)
);

INSERT INTO Herencia (nombre, descripcion, sentidoId, rarezaId)
VALUES ('aasimar', 'descendiente de seres celestiales, gana visión en poca luz o visión en oscuridad si ya tiene visión en poca luz, además puede elegir dotes de aasimar', 7, 2);
INSERT INTO Herencia (nombre, descripcion, sentidoId)
VALUES ('aiuvarin', 'cruce de sangre con la sangre de elfo, gana visión en poca luz o visión en oscuridad si ya tiene visión en poca luz, además puede elegir dotes de elfo o aiuvarin', 7);
INSERT INTO Herencia (nombre, descripcion, sentidoId, rarezaId)
VALUES ('cambiante', 'hijo de una bruja, posee heterocromía además de piel más pálida y cabello más oscuro; gana visión en poca luz o visión en oscuridad si ya tiene visión en poca luz, además puede elegir dotes de cambiante', 7, 2);
INSERT INTO Herencia (nombre, descripcion, sentidoId, rarezaId)
VALUES ('dhampir', 'descendiente de un vampiro y un mortal dotado de piel pálida además de gracia y elegancia, gana visión en poca luz o visión en oscuridad si ya tiene visión en poca luz, además puede elegir dotes de dhampir', 7, 2);
INSERT INTO Herencia (nombre, descripcion, sentidoId)
VALUES ('dromaar', 'cruce de sangre con la sangre de orco, gana visión en poca luz o visión en oscuridad si ya tiene visión en poca luz, además puede elegir dotes de orco o dromaar', 7);
INSERT INTO Herencia (nombre, descripcion, habilidadId, rarezaId)
VALUES ('sangre de dragón', 'descendiente de algún dragón puede tener rasgos físicos como cuernos, piel escamosa o cola, gana acceso al lenguaje dracónico además de los dotes de sangre de dragón', 251, 2);
INSERT INTO Herencia (nombre, descripcion, sentidoId, rarezaId)
VALUES ('caminante del crepúsculo', 'descendiente renacido de los psychopomps que nunca puede volverse un no-muerto, gana visión en poca luz o visión en oscuridad si ya tiene visión en poca luz, además puede elegir dotes de caminante del crepúsculo', 7, 2);
INSERT INTO Herencia (nombre, descripcion, sentidoId, rarezaId)
VALUES ('nephilim', 'influenciado por celestiales, demonios o monitore spuede tener rasgos como una aureola, cuernos, cola u ojos dorados, gana visión en poca luz o visión en oscuridad si ya tiene visión en poca luz, además puede elegir dotes de nephilim', 7, 2);
INSERT INTO Herencia (nombre, descripcion, sentidoId, rarezaId)
VALUES ('tiefling', 'descendiente de demonios o poseedor de su marca puede tener rasgos como cuernos o cola, gana visión en poca luz o visión en oscuridad si ya tiene visión en poca luz, además puede elegir dotes de tiefling', 7, 2);

INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('enano de sangre antigua', 'descendiente de antiguos héroes enanos que eran capaces de reducir la maia de sus enemigos', 14, 246);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('enano guardián de la muerte', 'descendiente de guardianes de tumbas expertos en protegerse de los muertos', 14, 247);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('enano de forja', 'criado en forjas ha ganado adaptaciones y resistencias especiales al calor', 14, 248);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('enano de roca', 'descendiente de enanos que vivían dentro de montañas dedicándose a la excavación o labrado de rocas ganando así equilibrio firme', 14, 249);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('enano de sangre fuerte', 'posee sangre abundante y fuerte que puede remover toxinas', 14, 250);

INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('orco de las tierras yermas', 'originarios de tierras quemadas por el sol, deben viajar continuamente bajo condiciones climáticas extremas', 20, 245);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId, proezaId)
VALUES ('orco listo para la batalla', 'descendiente de una línea de aterradores comandantes de guerra', 20, 212, 33);
INSERT INTO Razgo_Proeza(razgoId, proezaId) VALUES(59, 34);
INSERT INTO Razgo_Proeza(razgoId, proezaId) VALUES(60, 34);
INSERT INTO Razgo_Proeza(razgoId, proezaId) VALUES(59, 35);
INSERT INTO Razgo_Proeza(razgoId, proezaId) VALUES(60, 35);
INSERT INTO Proeza_RequisitoAtributo(proezaId, atributoId) VALUES(34, 24);
INSERT INTO Proeza_RequisitoAtributo(proezaId, atributoId) VALUES(35, 12);
INSERT INTO Herencia (nombre, descripcion, razaId, proezaId, proezaId2)
VALUES ('orco profundo', 'criado en la profunda oscuridad de cavernas subterraneas aprendió a sobrevivir con mínimos recursos y a luchar en riscos pedregosos', 20, 34, 35);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('orco de la tumba', 'expuesto a energías necróticas que debieron matarle, pero sobrevivió ganando resitencia a estas presentando una piel gris y fría', 20, 252);
INSERT INTO Razgo_Proeza(razgoId, proezaId) VALUES(59, 36);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId, proezaId)
VALUES ('orco marcado con cicatrices', 'perteneciente a una tribu que hacía rituales de sacrificio o de tatuajes que muestran su gran dureza y vitalidad', 20, 253, 36);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('orco de la lluvia', 'nacido en la selva húmeda protegido de la humedad solo por hojas y lianas, adaptado ala humedad selvática y sus enfermedades', 20, 254);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('orco de invierno', 'criado en climas fríos y adaptado para sobrevivir a estos', 20, 255);

INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('humano habilidoso', 'su ingenuidad le permite entrenarse mejor en más habilidades', 19, 256);
INSERT INTO Herencia (nombre, descripcion, razaId)
VALUES ('humano versátil', 'la gran ambición y adaptabilidad de la humanidad le ha permitido extenderse por todo Golarion haciendo que pueda escoger 1 dote general adicional a nivel 1', 19);

INSERT INTO Herencia (nombre, descripcion, razaId)
VALUES ('elfo antiguo', 'elfos que han vivido al menos 100 años y poseen gran experiencia', 15);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('elfo ártico', 'proveniente del norte helado que garantiza reistencia a los climas fríos', 15, 257);
INSERT INTO Herencia (nombre, descripcion, razaId, sentidoId)
VALUES ('elfo de la caverna', 'habitantes de cavernas profundas que adaptaron su visión a la oscuridad', 15, 6);
INSERT INTO Herencia (nombre, descripcion, razaId, hechizoId)
VALUES ('elfo vidente', 'nacido con una habilidad innata de entender la magia, es capaz de usar detectar magia como un hechizo arano innato', 15, 3);
INSERT INTO Herencia (nombre, descripcion, razaId, sentidoId)
VALUES ('elfo de los susurros', 'posee oídos altamente desarrollados que le permiten detectar cualquier susurro o ruido', 15, 10);
INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('elfo del bosque', 'proveniente de un bosque o una selva profunda, especializado en escalar árboles y usar la vegetación como ventaja', 15, 258);

INSERT INTO Herencia (nombre, descripcion, razaId, habilidadId)
VALUES ('gnomo camaleón', 'por la influencia dle primer mundo puede cambiar su cabello de color y el todo de su piel a todo tipo de colores, se puede hacer a voluntad con 1 acción para 1 cambio pequeño o 1 hora para 1 cambio total, al dormir cambia de color dependiendo de sus sueños dando un color aleatorio cada mañana', 16, 259);
INSERT INTO Herencia (nombre, descripcion, razaId)
VALUES ('gnomo tocado por los fey', 'descendiente de los fey lo cual provee capacidades mágicas haciendo que pueda elegir un truco primitivo como hechizo innato', 16);
INSERT INTO Herencia (nombre, descripcion, razaId, sentidoId)
VALUES ('gnomo sensato', 've los colores más brillantes, escucha mejor los sonidos y detalla mejor los olores ganando así olfato impreciso', 16, 11);
INSERT INTO Herencia (nombre, descripcion, razaId, sentidoId)
VALUES ('gnomo del umbral', 'descendiente de los fey sombríos dde las profundidades otorgandole visión en la oscuridad', 16, 6);
INSERT INTO Herencia (nombre, descripcion, razaId)
VALUES ('gnomo del manantial', 'posee una conexión con algún otro plano de la existencia o algún poder aculto tales como deidades, seres celestiales o demonios ganando así un truco arcano, divino u oculto que puede usar como un hechizo innato', 16);

CREATE TABLE Proeza_Sentido(
 	proezaId integer NOT NULL,
  	sentidoId integer NOT NULL,
	tipo integer NOT NULL DEFAULT(0),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	FOREIGN KEY(sentidoId) REFERENCES Sentido(id),
	PRIMARY KEY(proezaId, sentidoId)
);

CREATE TABLE Proeza_Velocidad(
 	proezaId integer NOT NULL,
  	movimientoId integer NOT NULL,
	cantidad integer NOT NULL DEFAULT(5),
	FOREIGN KEY(proezaId) REFERENCES Proeza(id),
	FOREIGN KEY(movimientoId) REFERENCES Movimiento(id),
	PRIMARY KEY(proezaId, movimientoId)
);

INSERT INTO Proeza(nombre, descripcion, nivel)
VALUES('tenacidad','el usuario gana salud igual a su nivel, también reduce su DC de salvación cuando está muriendo de 10+valor de muriendo a 9+valor de muriendo',1);
INSERT INTO Razgo_Proeza(razgoId, proezaId) VALUES(59, 53);
INSERT INTO Proeza_Atributo(proezaId, atributoId, cantidad, tipo) VALUES(53, 41, 1, 6);
INSERT INTO Razgo_Proeza(razgoId, proezaId) VALUES(60, 46);

INSERT INTO Proeza(nombre, descripcion, nivel, habilidadId)
VALUES('plegaria empática','el usuario puede mostrarse vulnerable ante su atacante para provocar empatía',1, 294);
INSERT INTO Proeza_Raza(proezaId, razaId) VALUES(81, 16);
INSERT INTO Razgo_Proeza(proezaId, razgoId) VALUES(73, 61);
INSERT INTO Proeza_Atributo(proezaId, atributoId, cantidad, tipo) VALUES(73, 34, 1, -11);
INSERT INTO Proeza_Atributo(proezaId, atributoId, cantidad, tipo) VALUES(73, 35, 1, -11);
INSERT INTO Proeza_Atributo(proezaId, atributoId, cantidad, tipo) VALUES(73, 43, 1, -11);
INSERT INTO Proeza_Proeza(proezaId, requisitoId, tipoRelacion) VALUES(65, 41, 1);
INSERT INTO Proeza_Sentido(proezaId, sentidoId, tipo) VALUES(50, 6, 0);
INSERT INTO Proeza_Sentido(proezaId, sentidoId, tipo) VALUES(50, 12, 1);
INSERT INTO Proeza_Velocidad(proezaId, movimientoId, cantidad) VALUES(78, 4, 10);