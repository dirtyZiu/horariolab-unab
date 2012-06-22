-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 22-06-2012 a las 09:52:27
-- Versión del servidor: 5.5.20
-- Versión de PHP: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `hsc`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `abrirSemestreAnterior`(codigoSemestre INT, fecha DATETIME)
BEGIN
  UPDATE Semestre
   SET Fecha_Termino = NULL
  WHERE Codigo_Semestre = codigoSemestre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `abrirTrimestreAnterior`(codigoTrimestre INT, fecha DATETIME)
BEGIN
  UPDATE Trimestre
   SET Fecha_Termino = NULL
  WHERE Codigo_Trimestre = codigoTrimestre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_login`(username VARCHAR(40),password VARCHAR(32))
BEGIN
  SELECT u.Nombre_Usuario,u.Nombre
   FROM Usuario AS u
  WHERE u.Nombre_Usuario = username AND u.Password = password AND u.Id_tipo = 2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarProfesor`(rutProfesor INT, nombreProfesor VARCHAR(50))
BEGIN
  INSERT INTO Profesor(Rut_Profesor,Nombre) VALUES (rutProfesor,nombreProfesor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_carrera`(cod VARCHAR(9),nombre VARCHAR(100),period INT,semestre INT)
BEGIN
  INSERT INTO Carrera(Codigo,Nombre_Carrera,Periodo,Numero) VALUES (cod,nombre,period,semestre);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_carrera2`(cod VARCHAR(7),nombre VARCHAR(100))
BEGIN
  INSERT INTO Carrera(Codigo,RUT_Jefe_Carrera,Nombre_Carrera) VALUES (cod,'0',nombre);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_jefe_carrera`(rut VARCHAR(10),nombre VARCHAR(40),nombreusuario VARCHAR(40),pass VARCHAR(32))
BEGIN
  INSERT INTO Usuario(Nombre_Usuario,RUT,Nombre,Password,Id_Tipo) VALUES (nombreusuario,rut,nombre,pass,1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_ramo`(codigoRamo VARCHAR(6),nombreRamo VARCHAR(50),hTeoricas INT,hAyudantia INT,hLaboratorio INT,hTaller INT,credito INT)
BEGIN
  INSERT INTO Ramo(Codigo,Nombre,Teoria,Ayudantia,Laboratorio,Taller,Creditos) VALUES (codigoRamo,nombreRamo,hTeoricas,hAyudantia,hLaboratorio,hTaller,credito);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `asignar_jdc`(codigoCarrera VARCHAR(9),nombreUsuario VARCHAR(40))
BEGIN
  UPDATE Carrera AS c SET c.NombreUsuario_JC = nombreUsuario WHERE c.Codigo = codigoCarrera;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cambiar_jdc`(codigoCarrera VARCHAR(9),nombreUsuario VARCHAR(40))
BEGIN
  UPDATE Carrera AS c SET c.NombreUsuario_JC = nombreUsuario WHERE c.Codigo = codigoCarrera;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cerrarSemestre`(codigoSemestre INT,fecha DATETIME)
BEGIN
  UPDATE Semestre 
   SET Fecha_Termino = fecha
  WHERE Codigo_Semestre = codigoSemestre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cerrarTrimestre`(codigoTrimestre INT,fecha DATETIME)
BEGIN
  UPDATE Trimestre 
   SET Fecha_Termino = fecha
  WHERE Codigo_Trimestre = codigoTrimestre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `comenzarSemestre`(codigoSemestre INT, numeroSemestre INT, annoSemestre INT, fechaInicio DATETIME)
BEGIN
  INSERT INTO Semestre(Codigo_Semestre,Numero,Anho,Fecha_Inicio,Fecha_Termino) VALUES(codigoSemestre,numeroSemestre,annoSemestre,fechaInicio,NULL);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `comenzarTrimestre`(codigoTrimestre INT, numeroTrimestre INT, annoSemestre YEAR, fechaInicio DATETIME)
BEGIN
  INSERT INTO Trimestre(Codigo_Trimestre,Numero,Anho,Fecha_Inicio,Fecha_Termino) VALUES(codigoTrimestre,numeroTrimestre,annoSemestre,fechaInicio,NULL);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `comprobarSolicitudExiste`(codigoCarreraSolicitante VARCHAR(9), codigoCarreraDestinatario VARCHAR(9), codigoSemestre INT, codigoRamo VARCHAR(6))
BEGIN
  SELECT s.Id
   FROM Solicitud AS s
  WHERE s.Codigo_Semestre = codigoSemestre AND s.Carrera_Solicitante = codigoCarreraSolicitante AND s.Codigo_Ramo = codigoRamo AND s.Carrera = codigoCarreraDestinatario AND s.Estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crearSeccion`(codigoRamo VARCHAR(6), codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN
  INSERT INTO Seccion(Codigo_Ramo,Codigo_Carrera,RUT_Profesor,Codigo_Semestre) VALUES(codigoRamo,codigoCarrera,NULL,codigoSemestre);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarSolicitud`(idSolicitud INT)
BEGIN
  DELETE FROM Solicitud WHERE Id = idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_jdc`(nombreUsuario VARCHAR(40))
BEGIN
  IF ((SELECT COUNT(c.nombreUsuario_JC) FROM carrera AS c WHERE c.nombreUsuario_JC = nombreUsuario) > 0) THEN
    UPDATE Carrera AS c SET c.NombreUsuario_JC = NULL WHERE c.nombreUsuario_JC = nombreUsuario;
    DELETE FROM usuario WHERE Nombre_Usuario = nombreUsuario;
  ELSE
    DELETE FROM usuario WHERE Nombre_Usuario = nombreUsuario;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `horarioSeccion`(codigoCarrera VARCHAR(10), codigoRamo VARCHAR(6), codigoSemestre INT)
BEGIN
  SELECT s.Horario_Inicio,s.Horario_Termino
   FROM Seccion AS s
  WHERE s.Codigo_Carrera = codigoCarrera AND s.Codigo_Ramo = codigoRamo AND s.Codigo_Semestre = codigoSemestre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `impartirRamo`(codigoCarrera VARCHAR(9), codigoRamo VARCHAR(6), codigoSemestre INT, impartir INT)
BEGIN

  INSERT INTO ramos_impartidos(codigo_carrera,codigo_ramo,codigo_semestre,impartido) VALUES(codigoCarrera,codigoRamo,codigoSemestre,impartir);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarSolicitud`(idSolicitud INT, numeroVacantes INT)
BEGIN
  UPDATE Solicitud SET Vacantes = numeroVacantes WHERE Id = idSolicitud AND Estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerHorarioActual`(codigoSeccion INT)
BEGIN
  SELECT s.Horario_Inicio,s.Horario_Termino
   FROM Seccion AS s
  WHERE s.NRC = codigoSeccion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerHorarios`(codigoCarrera VARCHAR(9))
BEGIN
  SELECT m.Modulo,m.Regimen,m.Inicio,m.Termino 
   FROM Modulo AS m 
   INNER JOIN Carrera AS c ON c.Codigo = codigoCarrera 
  WHERE m.Regimen = c.Regimen;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerPeriodoCarrera`(codigoCarrera VARCHAR(9))
BEGIN
  SELECT c.Periodo
   FROM Carrera AS c
  WHERE c.Codigo = codigoCarrera;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerSemestre`()
BEGIN
  SELECT s.Codigo_Semestre,s.Numero,s.Anho,s.Fecha_Inicio,s.Fecha_Termino
   FROM Semestre AS s
  WHERE s.Codigo_Semestre = (SELECT MAX(s.Codigo_Semestre) FROM Semestre AS s);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTrimestre`()
BEGIN
  SELECT t.Codigo_Trimestre,t.Numero,t.Anho,t.Fecha_Inicio,t.Fecha_Termino
   FROM Trimestre AS t
  WHERE t.Codigo_Trimestre = (SELECT MAX(t.Codigo_Trimestre) FROM Trimestre AS t);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ramoDictado`(codigoCarrera VARCHAR(9), codigoRamo VARCHAR(6), codigoSemestre INT)
BEGIN

  SELECT ri.Codigo_Ramo,ri.Impartido

   FROM ramos_impartidos AS ri

  WHERE ri.Codigo_Carrera = codigoCarrera AND ri.Codigo_Ramo = codigoRamo AND ri.Codigo_Semestre = codigoSemestre;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ramosSemestre`(codigoCarrera VARCHAR(10), codigoRamo VARCHAR(6), codigoSemestre INT, semestreRamo INT)
BEGIN
  SELECT ri.Codigo_Ramo
   FROM Carrera_Tiene_Ramos AS ctr
   INNER JOIN Ramos_Impartidos AS ri ON ri.Codigo_Carrera = codigoCarrera AND ri.Codigo_Ramo = ctr.Codigo_Ramo AND ri.Codigo_Semestre = codigoSemestre AND ri.Impartido = 1
  WHERE ctr.Codigo_Carrera = codigoCarrera AND ctr.Semestre = semestreRamo AND ctr.Codigo_Ramo != codigoRamo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `relacionar_cramos`(codigoRamo VARCHAR(6),codigoCarrera VARCHAR(9),semest INT)
BEGIN
  IF((SELECT ctr.Codigo_Ramo FROM carrera_tiene_ramos AS ctr WHERE ctr.Codigo_Carrera = codigoCarrera AND ctr.Codigo_Ramo = codigoRamo) IS NULL) THEN
    INSERT INTO carrera_tiene_ramos (Codigo_Carrera,Codigo_Ramo,Semestre) VALUES (codigoCarrera,codigoRamo,semest);
    SELECT 1;
  ELSE
    SELECT 0;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `responderSolicitud`(idSolicitud INT, respuesta INT, vacantes INT, fecharespuesta DATETIME)
BEGIN
  IF(respuesta = 2) THEN
    UPDATE Solicitud SET estado = 2, vacantes_asignadas = vacantes, fecha_respuesta = fecharespuesta WHERE id = idSolicitud;
  ELSE
    UPDATE Solicitud SET estado = 3, vacantes_asignadas = 0, fecha_respuesta = fecharespuesta WHERE id = idSolicitud;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `revisarSolicitud`(idSolicitud INT)
BEGIN
  SELECT s.Id,s.Codigo_Ramo,s.Carrera,s.Carrera_Solicitante,s.Vacantes,s.Codigo_Semestre,s.Fecha_Envio,s.Fecha_Respuesta,s.Estado
   FROM Solicitud AS s
  WHERE s.Id = idSolicitud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seccionesCreadas`(codigoRamo VARCHAR(6), codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN
  SELECT s.NRC,s.Codigo_Ramo,s.Codigo_Carrera,s.RUT_Profesor,s.Codigo_Semestre
   FROM Seccion AS s
  WHERE s.Codigo_Ramo = codigoRamo AND s.Codigo_Carrera = codigoCarrera AND s.Codigo_Semestre = codigoSemestre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seccionesCreadasNumero`(codigoRamo VARCHAR(6), codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN
  SELECT COUNT(s.NRC)
   FROM Seccion AS s
  WHERE s.Codigo_Ramo = codigoRamo AND s.Codigo_Carrera = codigoCarrera AND s.Codigo_Semestre = codigoSemestre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seccionesCreadasOtroNumero`(codigoRamo VARCHAR(6), codigoCarrera VARCHAR(9), codigoSemestre INT, regimen VARCHAR(1))
BEGIN
  SELECT COUNT(s.NRC)
   FROM Seccion AS s
   INNER JOIN Carrera AS c ON c.Codigo = s.Codigo_Carrera AND c.Regimen = regimen
  WHERE s.Codigo_Ramo = codigoRamo AND s.Codigo_Carrera != codigoCarrera AND s.Codigo_Semestre = codigoSemestre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectCarrera`(codigoCarrera VARCHAR(9))
BEGIN
  SELECT c.Codigo,c.Nombre_Carrera,c.Periodo
   FROM Carrera AS c
  WHERE c.Codigo = codigoCarrera;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_carreras`()
BEGIN
DECLARE Nombre_JC VARCHAR(40);
DECLARE Rut_JC VARCHAR(10);
SET Nombre_JC = 'No asignado';
SET Rut_JC = 'No asignado';
  (SELECT c.Codigo,c.Nombre_Carrera AS nombreCarrera,c.NombreUsuario_JC,c.Periodo,c.Numero,u.Nombre,u.RUT
    FROM Carrera AS c
    INNER JOIN Usuario AS u ON u.Nombre_Usuario = c.NombreUsuario_JC AND (u.Id_Tipo = 1 OR u.Id_Tipo = 3))
  UNION
  (SELECT c.Codigo,c.Nombre_Carrera AS nombreCarrera,c.NombreUsuario_JC,c.Periodo,c.Numero,Nombre_JC,Rut_JC
    FROM Carrera AS c
   WHERE c.NombreUsuario_JC IS NULL) ORDER BY nombreCarrera;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_ccarreras`(codigoRamo VARCHAR(6))
BEGIN
  SELECT c.Codigo,c.Nombre_Carrera
   FROM Carrera AS c
  WHERE c.Codigo NOT IN (SELECT Codigo_Carrera FROM Carrera_Tiene_Ramos WHERE Codigo_Ramo = codigoRamo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_cramos`(codigoRamo VARCHAR(6))
BEGIN
  SELECT r.Codigo,r.Nombre
   FROM Ramo AS r
  WHERE r.Codigo = codigoRamo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_jefe_carrera`()
BEGIN
  SELECT u.Nombre_Usuario,u.RUT,u.Nombre
   FROM Usuario AS u
  WHERE u.Id_Tipo = 1 OR u.Id_Tipo = 3 ORDER BY u.Nombre;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_ramoCarrera`(codigoRamo VARCHAR(6))
BEGIN
  SELECT c.Codigo,c.Nombre_Carrera
   FROM Carrera AS c
   INNER JOIN Carrera_Tiene_Ramos AS ctr ON ctr.Codigo_Ramo = codigoRamo
  WHERE c.Codigo = ctr.Codigo_Carrera ORDER BY c.Codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_ramos`()
BEGIN
  SELECT r.Codigo,r.Nombre,r.Teoria,r.Ayudantia,r.Laboratorio,r.Taller,r.Creditos
   FROM Ramo AS r
  ORDER by r.Codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `select_ramoscarreras`(codigoCarrera VARCHAR(9))
BEGIN
  SELECT r.Codigo,r.Nombre,ctr.Semestre
   FROM Carrera_Tiene_Ramos AS ctr
   INNER JOIN Ramo AS r ON r.Codigo = ctr.Codigo_Ramo
  WHERE ctr.Codigo_Carrera = codigoCarrera ORDER BY ctr.Semestre,r.Codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semestreRamo`(codigoCarrera VARCHAR(10), codigoRamo VARCHAR(6))
BEGIN
  SELECT ctr.Semestre
   FROM Carrera_Tiene_Ramos AS ctr
  WHERE ctr.Codigo_Carrera = codigoCarrera AND ctr.Codigo_Ramo = codigoRamo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `solicitarVacantes`(codigoRamo VARCHAR(6), codigoCarrera VARCHAR(9), codigoCarreraSolicitante VARCHAR(9), numeroVacantes INT, codigoSemestre INT, fechaEnvio DATETIME)
BEGIN
  INSERT INTO Solicitud(Codigo_Ramo,Carrera,Carrera_Solicitante,Vacantes,Codigo_Semestre,Fecha_Envio,Fecha_Respuesta,Estado) VALUES (codigoRamo,codigoCarrera,codigoCarreraSolicitante,numeroVacantes,codigoSemestre,fechaEnvio,NULL,1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verRamosImpartidos`(codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN

  SELECT r.Codigo,r.Nombre,r.Tipo,ctr.Semestre,c.Periodo

   FROM ramos_impartidos AS ri

   INNER JOIN ramo AS r ON r.Codigo = ri.Codigo_Ramo

   INNER JOIN carrera_tiene_ramos AS ctr ON ctr.Codigo_Carrera = ri.Codigo_Carrera AND ctr.Codigo_Ramo = ri.Codigo_Ramo

   INNER JOIN carrera AS c ON c.Codigo = ctr.Codigo_Carrera

  WHERE ri.Codigo_Carrera = codigoCarrera AND ri.Codigo_Semestre = codigoSemestre AND ri.Impartido = 1 ORDER BY ctr.Semestre,r.Codigo;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verSeccionesCreadas`(codigoRamo VARCHAR(6), codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN

  SELECT s.NRC,s.Codigo_Ramo,r.Nombre,s.Codigo_Carrera,s.RUT_Profesor,s.Horario_Inicio,s.Horario_Termino,s.Codigo_Semestre

   FROM Seccion AS s

   INNER JOIN Ramo AS r ON r.Codigo = s.Codigo_Ramo

  WHERE s.Codigo_Ramo = codigoRamo AND s.Codigo_Carrera = codigoCarrera AND s.Codigo_Semestre = codigoSemestre ORDER BY s.NRC;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verSeccionesCreadasOtro`(codigoRamo VARCHAR(6), codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN
  SELECT s.NRC,s.Codigo_Ramo,r.Nombre,s.Codigo_Carrera,s.RUT_Profesor,s.Codigo_Semestre
   FROM Seccion AS s
   INNER JOIN Ramo AS r ON r.Codigo = s.Codigo_Ramo
  WHERE s.Codigo_Ramo = codigoRamo AND s.Codigo_Carrera != codigoCarrera AND s.Codigo_Semestre = codigoSemestre ORDER BY s.Codigo_Carrera,s.NRC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verSeccionesSinProfesor`(codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN
  SELECT r.Codigo,r.Nombre,s.NRC
   FROM Carrera_Tiene_Ramos AS ctr
   INNER JOIN Ramo AS r ON r.Codigo = ctr.Codigo_Ramo
   INNER JOIN Seccion AS s ON s.Codigo_Ramo = r.Codigo AND s.Codigo_Carrera = codigoCarrera AND s.Codigo_Semestre = codigoSemestre AND s.RUT_Profesor IS NULL
  WHERE ctr.Codigo_Carrera = codigoCarrera;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verSolicitudesMias`(codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN
  SELECT s.Id,s.Codigo_Ramo,r.Nombre,s.Carrera,s.Vacantes,s.Vacantes_Asignadas,s.Fecha_Envio,s.Fecha_Respuesta,s.Estado,sec.Numero_Seccion
   FROM Solicitud AS s
   INNER JOIN Ramo AS r ON r.Codigo = s.Codigo_Ramo
   INNER JOIN Seccion AS sec ON sec.Id = s.Seccion_Asignada
  WHERE s.Codigo_Semestre = codigoSemestre AND s.Carrera_Solicitante = codigoCarrera ORDER BY s.Estado,s.Fecha_Envio,s.Carrera_Solicitante,s.Codigo_Ramo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verSolicitudesOtros`(codigoCarrera VARCHAR(9), codigoSemestre INT)
BEGIN
  SELECT s.Id,s.Codigo_Ramo,r.Nombre,s.Carrera_Solicitante,s.Vacantes,s.Vacantes_Asignadas,s.Fecha_Envio,s.Fecha_Respuesta,s.Estado
   FROM Solicitud AS s
   INNER JOIN Ramo AS r ON r.Codigo = s.Codigo_Ramo
  WHERE s.Codigo_Semestre = codigoSemestre AND s.Carrera = codigoCarrera ORDER BY s.Estado,s.Fecha_Envio,s.Carrera_Solicitante,s.Codigo_Ramo;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrera`
--

CREATE TABLE IF NOT EXISTS `carrera` (
  `Codigo` varchar(9) NOT NULL,
  `NombreUsuario_JC` varchar(40) DEFAULT NULL COMMENT 'Nombre de usuario del jefe de carrera.',
  `Nombre_Carrera` varchar(100) NOT NULL COMMENT 'Nombre de la carrera.',
  `Periodo` int(1) NOT NULL COMMENT '1 = Semestral, 2 = Trimestral.',
  `Regimen` varchar(1) NOT NULL COMMENT 'D = Diurno, V = Vespertino.',
  `Numero` int(2) NOT NULL COMMENT 'Duración de la carrera en semestres o trimestres.',
  PRIMARY KEY (`Codigo`),
  KEY `NombreUsuario_JC` (`NombreUsuario_JC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `carrera`
--

INSERT INTO `carrera` (`Codigo`, `NombreUsuario_JC`, `Nombre_Carrera`, `Periodo`, `Regimen`, `Numero`) VALUES
('UNAB11500', 'carolina.toro', 'Ingenieria en Computacion e Informatica', 1, 'D', 8),
('UNAB11502', 'carolina.toro', 'Ingenieria en Telecomunicaciones', 1, 'D', 8),
('UNAB12200', 'carolina.toro', 'Ingenieria Civil en Computacion e Informatica', 1, 'D', 12),
('UNAB19200', 'carolina.toro', 'Ingenieria en Gestion Informatica', 1, 'D', 8),
('UNAB21500', 'miguel.gutierrez', 'Ingenieria en Computacion e Informatica', 1, 'V', 8),
('UNAB21502', 'miguel.gutierrez', 'Ingenieria en Telecomunicaciones', 1, 'V', 8),
('UNAB29200', 'miguel.gutierrez', 'Ingenieria en Gestion Informatica', 1, 'V', 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrera_tiene_ramos`
--

CREATE TABLE IF NOT EXISTS `carrera_tiene_ramos` (
  `Codigo_Carrera` varchar(9) NOT NULL COMMENT 'Código de la carrera.',
  `Codigo_Ramo` varchar(7) NOT NULL COMMENT 'Código del ramo que pertenece a la carrera.',
  `Semestre` int(2) NOT NULL COMMENT 'Semestre o trimestre en el que se imparte el ramo.',
  KEY `Codigo_Carrera` (`Codigo_Carrera`),
  KEY `Codigo_Ramo` (`Codigo_Ramo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `carrera_tiene_ramos`
--

INSERT INTO `carrera_tiene_ramos` (`Codigo_Carrera`, `Codigo_Ramo`, `Semestre`) VALUES
('UNAB21502', 'FMM012', 1),
('UNAB21502', 'ITC140', 1),
('UNAB21502', 'FMF024', 1),
('UNAB21502', 'FIC160', 1),
('UNAB21502', 'FIC160', 1),
('UNAB21502', 'FMM112', 2),
('UNAB21502', 'INF120', 2),
('UNAB21502', 'FMF025', 2),
('UNAB21502', 'QUI070', 2),
('UNAB21502', 'FMM214', 3),
('UNAB21502', 'INF120', 3),
('UNAB21502', 'FMF144', 3),
('UNAB21502', 'FIC160', 3),
('UNAB21502', 'ING119', 3),
('UNAB21502', 'FMM312', 4),
('UNAB21502', 'ITC160', 4),
('UNAB21502', 'ITC170', 4),
('UNAB21502', 'FMF086', 4),
('UNAB21502', 'ING129', 4),
('UNAB21502', 'IND210', 5),
('UNAB21502', 'ITC260', 5),
('UNAB21502', 'ITC270', 5),
('UNAB21502', 'ITC240', 5),
('UNAB21502', 'ING239', 5),
('UNAB21502', 'IND210', 6),
('UNAB21502', 'ITC270', 6),
('UNAB21502', 'ITC240', 6),
('UNAB21502', 'ITC240', 6),
('UNAB21502', 'ING249', 6),
('UNAB21502', 'IND210', 7),
('UNAB21502', 'ITC280', 7),
('UNAB21502', 'ITC270', 7),
('UNAB21502', 'ITC240', 7),
('UNAB21502', 'ITC290', 7),
('UNAB21502', 'ITC280', 8),
('UNAB21502', 'FIC160', 8),
('UNAB21502', 'ITC270', 8),
('UNAB21502', 'ITC240', 8),
('UNAB21502', 'ITC290', 8),
('UNAB11502', 'FMM012', 1),
('UNAB11502', 'ITC140', 1),
('UNAB11502', 'FMF024', 1),
('UNAB11502', 'FIC160', 1),
('UNAB11502', 'FIC160', 1),
('UNAB11502', 'FMM112', 2),
('UNAB11502', 'INF120', 2),
('UNAB11502', 'FMF025', 2),
('UNAB11502', 'QUI070', 2),
('UNAB11502', 'FMM214', 3),
('UNAB11502', 'INF120', 3),
('UNAB11502', 'FMF144', 3),
('UNAB11502', 'FIC160', 3),
('UNAB11502', 'ING119', 3),
('UNAB11502', 'FMM312', 4),
('UNAB11502', 'ITC160', 4),
('UNAB11502', 'ITC170', 4),
('UNAB11502', 'FMF086', 4),
('UNAB11502', 'ING129', 4),
('UNAB11502', 'IND210', 5),
('UNAB11502', 'ITC260', 5),
('UNAB11502', 'ITC270', 5),
('UNAB11502', 'ITC240', 5),
('UNAB11502', 'ING239', 5),
('UNAB11502', 'IND210', 6),
('UNAB11502', 'ITC270', 6),
('UNAB11502', 'ITC240', 6),
('UNAB11502', 'ITC240', 6),
('UNAB11502', 'ING249', 6),
('UNAB11502', 'IND210', 7),
('UNAB11502', 'ITC280', 7),
('UNAB11502', 'ITC270', 7),
('UNAB11502', 'ITC240', 7),
('UNAB11502', 'ITC290', 7),
('UNAB11502', 'ITC280', 8),
('UNAB11502', 'FIC160', 8),
('UNAB11502', 'ITC270', 8),
('UNAB11502', 'ITC240', 8),
('UNAB11502', 'ITC290', 8),
('UNAB11500', 'FMM010', 1),
('UNAB11500', 'FMM030', 1),
('UNAB11500', 'IET001', 1),
('UNAB11500', 'FMF021', 2),
('UNAB11500', 'FMF081', 2),
('UNAB11500', 'FMM130', 2),
('UNAB11500', 'IEC119', 2),
('UNAB11500', 'IET020', 2),
('UNAB11500', 'FMF121', 3),
('UNAB11500', 'FMF181', 3),
('UNAB11500', 'FMM110', 3),
('UNAB11500', 'IET030', 3),
('UNAB11500', 'IET100', 3),
('UNAB11500', 'IET121', 3),
('UNAB11500', 'FMF141', 4),
('UNAB11500', 'FMM230', 4),
('UNAB11500', 'IEC122', 4),
('UNAB11500', 'IET101', 4),
('UNAB11500', 'IET110', 4),
('UNAB11500', 'FMS175', 5),
('UNAB11500', 'IEC220', 5),
('UNAB11500', 'IEC210', 5),
('UNAB11500', 'IEC130', 5),
('UNAB11500', 'IET102', 5),
('UNAB11500', 'IET140', 6),
('UNAB11500', 'IET170', 6),
('UNAB11500', 'IEC230', 6),
('UNAB11500', 'IET221', 6),
('UNAB11500', 'IEC211', 6),
('UNAB11500', 'IET300', 7),
('UNAB11500', 'IEC330', 7),
('UNAB11500', 'IEC320', 7),
('UNAB11500', 'IEC301', 7),
('UNAB11500', 'IET103', 7),
('UNAB11500', 'IEC302', 8),
('UNAB11500', 'IEC325', 8),
('UNAB11500', 'IET310', 8),
('UNAB11500', 'IET104', 8),
('UNAB21500', 'FMM010', 1),
('UNAB21500', 'FMM030', 1),
('UNAB21500', 'IET001', 1),
('UNAB21500', 'FMF021', 2),
('UNAB21500', 'FMF081', 2),
('UNAB21500', 'FMM130', 2),
('UNAB21500', 'IEC119', 2),
('UNAB21500', 'IET020', 2),
('UNAB21500', 'FMF121', 3),
('UNAB21500', 'FMF181', 3),
('UNAB21500', 'FMM110', 3),
('UNAB21500', 'IET030', 3),
('UNAB21500', 'IET100', 3),
('UNAB21500', 'IET121', 3),
('UNAB21500', 'FMF141', 4),
('UNAB21500', 'FMM230', 4),
('UNAB21500', 'IEC122', 4),
('UNAB21500', 'IET101', 4),
('UNAB21500', 'IET110', 4),
('UNAB21500', 'FMS175', 5),
('UNAB21500', 'IEC220', 5),
('UNAB21500', 'IEC210', 5),
('UNAB21500', 'IEC130', 5),
('UNAB21500', 'IET102', 5),
('UNAB21500', 'IET140', 6),
('UNAB21500', 'IET170', 6),
('UNAB21500', 'IEC230', 6),
('UNAB21500', 'IET221', 6),
('UNAB21500', 'IEC211', 6),
('UNAB21500', 'IET300', 7),
('UNAB21500', 'IEC330', 7),
('UNAB21500', 'IEC320', 7),
('UNAB21500', 'IEC301', 7),
('UNAB21500', 'IET103', 7),
('UNAB21500', 'IEC302', 8),
('UNAB21500', 'IEC325', 8),
('UNAB21500', 'IET310', 8),
('UNAB21500', 'IET104', 8),
('UNAB12200', 'FMM013', 1),
('UNAB12200', 'FMM033', 1),
('UNAB12200', 'ICI111', 1),
('UNAB12200', 'QUI104', 1),
('UNAB12200', 'QUI105', 1),
('UNAB12200', 'ICI019', 1),
('UNAB12200', 'FMM133', 2),
('UNAB12200', 'FMF023', 2),
('UNAB12200', 'FMF082', 2),
('UNAB12200', 'ICC111', 2),
('UNAB12200', 'ICI021', 2),
('UNAB12200', 'FMM113', 3),
('UNAB12200', 'FMM235', 3),
('UNAB12200', 'FMF122', 3),
('UNAB12200', 'FMF182', 3),
('UNAB12200', 'ICC120', 3),
('UNAB12200', 'FMM254', 4),
('UNAB12200', 'FMS176', 4),
('UNAB12200', 'FMF241', 4),
('UNAB12200', 'FMF282', 4),
('UNAB12200', 'ICC121', 4),
('UNAB12200', 'FMM232', 5),
('UNAB12200', 'ICC130', 5),
('UNAB12200', 'FMF226', 5),
('UNAB12200', 'ICC234', 5),
('UNAB12200', 'ICI030', 5),
('UNAB12200', 'ICC133', 6),
('UNAB12200', 'ICC235', 6),
('UNAB12200', 'ICC233', 6),
('UNAB12200', 'ICI135', 6),
('UNAB12200', 'ICC236', 6),
('UNAB12200', 'ICI248', 7),
('UNAB12200', 'ICI249', 7),
('UNAB12200', 'ICC247', 7),
('UNAB12200', 'ICC244', 7),
('UNAB12200', 'ICC248', 7),
('UNAB12200', 'ICI245', 8),
('UNAB12200', 'ICC245', 8),
('UNAB12200', 'ICC243', 8),
('UNAB12200', 'ICC249', 8),
('UNAB12200', 'ICC246', 8),
('UNAB12200', 'ICC252', 9),
('UNAB12200', 'ICI041', 9),
('UNAB12200', 'ICC255', 9),
('UNAB12200', 'ICC256', 9),
('UNAB12200', 'ICI050', 10),
('UNAB12200', 'ICC254', 10),
('UNAB12200', 'ICC253', 10),
('UNAB12200', 'ICC354', 10),
('UNAB12200', 'ICC352', 10),
('UNAB12200', 'ICI031', 10),
('UNAB12200', 'ICC260', 11),
('UNAB12200', 'ICC360', 11),
('UNAB12200', 'ICC361', 11),
('UNAB12200', 'ICC362', 11),
('UNAB12200', 'ICC261', 12),
('UNAB12200', 'ICC363', 12),
('UNAB19200', 'FMM010', 1),
('UNAB19200', 'FMM030', 1),
('UNAB19200', 'IET001', 1),
('UNAB19200', 'FMM130', 2),
('UNAB19200', 'IET090', 2),
('UNAB19200', 'IET020', 2),
('UNAB19200', 'IET100', 2),
('UNAB19200', 'FMM110', 3),
('UNAB19200', 'IET180', 3),
('UNAB19200', 'IET030', 3),
('UNAB19200', 'IET121', 3),
('UNAB19200', 'IET101', 3),
('UNAB19200', 'IEG281', 4),
('UNAB19200', 'IEG270', 4),
('UNAB19200', 'IEG122', 4),
('UNAB19200', 'IET110', 4),
('UNAB19200', 'IET102', 4),
('UNAB19200', 'FMS175', 5),
('UNAB19200', 'IET091', 5),
('UNAB19200', 'IEG230', 5),
('UNAB19200', 'IEG210', 5),
('UNAB19200', 'IET103', 5),
('UNAB19200', 'IET140', 6),
('UNAB19200', 'IEG271', 6),
('UNAB19200', 'IET190', 6),
('UNAB19200', 'IET221', 6),
('UNAB19200', 'IET104', 6),
('UNAB19200', 'IET300', 7),
('UNAB19200', 'IET181', 7),
('UNAB19200', 'IEG192', 7),
('UNAB19200', 'IEG191', 7),
('UNAB19200', 'IET105', 7),
('UNAB19200', 'IEG300', 8),
('UNAB19200', 'IET193', 8),
('UNAB19200', 'IET310', 8),
('UNAB19200', 'IET106', 8),
('UNAB29200', 'FMM010', 1),
('UNAB29200', 'FMM030', 1),
('UNAB29200', 'IET001', 1),
('UNAB29200', 'FMM130', 2),
('UNAB29200', 'IET090', 2),
('UNAB29200', 'IET020', 2),
('UNAB29200', 'IET100', 2),
('UNAB29200', 'FMM110', 3),
('UNAB29200', 'IET180', 3),
('UNAB29200', 'IET030', 3),
('UNAB29200', 'IET121', 3),
('UNAB29200', 'IET101', 3),
('UNAB29200', 'IEG281', 4),
('UNAB29200', 'IEG270', 4),
('UNAB29200', 'IEG122', 4),
('UNAB29200', 'IET110', 4),
('UNAB29200', 'IET102', 4),
('UNAB29200', 'FMS175', 5),
('UNAB29200', 'IET091', 5),
('UNAB29200', 'IEG230', 5),
('UNAB29200', 'IEG210', 5),
('UNAB29200', 'IET103', 5),
('UNAB29200', 'IET140', 6),
('UNAB29200', 'IEG271', 6),
('UNAB29200', 'IET190', 6),
('UNAB29200', 'IET221', 6),
('UNAB29200', 'IET104', 6),
('UNAB29200', 'IET300', 7),
('UNAB29200', 'IET181', 7),
('UNAB29200', 'IEG192', 7),
('UNAB29200', 'IEG191', 7),
('UNAB29200', 'IET105', 7),
('UNAB29200', 'IEG300', 8),
('UNAB29200', 'IET193', 8),
('UNAB29200', 'IET310', 8),
('UNAB29200', 'IET106', 8),
('UNAB21500', 'IET002', 1),
('UNAB11500', 'IET002', 1),
('UNAB11500', 'ZZZ001', 2),
('UNAB21500', 'ZZZ001', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase`
--

CREATE TABLE IF NOT EXISTS `clase` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Clase_Tipo` varchar(20) NOT NULL COMMENT 'Tipo de la clase.',
  `Seccion_Id` int(11) NOT NULL COMMENT 'Id de la sección a la cual pertenece la clase.',
  `RUT_Profesor` int(10) DEFAULT NULL COMMENT 'Rut del profesor que dicta la clase.',
  `Modulo_Inicio` int(11) DEFAULT NULL COMMENT 'Módulo de inicio de la clase.',
  `Modulo_Termino` int(11) DEFAULT NULL COMMENT 'Módulo de término de la clase.',
  `Dia` varchar(12) DEFAULT NULL COMMENT 'Día de la clase.',
  `Codigo_Semestre` int(11) NOT NULL COMMENT 'Codigo del semestre al cual pertenece la clase.',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Volcado de datos para la tabla `clase`
--

INSERT INTO `clase` (`Id`, `Clase_Tipo`, `Seccion_Id`, `RUT_Profesor`, `Modulo_Inicio`, `Modulo_Termino`, `Dia`, `Codigo_Semestre`) VALUES
(1, 'Teoria', 1, 163546027, NULL, NULL, NULL, 201220),
(2, 'Teoria', 1, NULL, NULL, NULL, NULL, 201220),
(3, 'Ayudantia', 1, NULL, NULL, NULL, NULL, 201220),
(4, 'Laboratorio', 1, NULL, NULL, NULL, NULL, 201220),
(5, 'Teoria', 2, NULL, NULL, NULL, NULL, 201220),
(6, 'Teoria', 2, NULL, NULL, NULL, NULL, 201220),
(7, 'Ayudantia', 2, NULL, NULL, NULL, NULL, 201220),
(8, 'Teoria', 3, NULL, NULL, NULL, NULL, 201220),
(9, 'Teoria', 3, NULL, NULL, NULL, NULL, 201220),
(10, 'Ayudantia', 3, NULL, NULL, NULL, NULL, 201220),
(11, 'Laboratorio', 3, NULL, NULL, NULL, NULL, 201220),
(12, 'Teoria', 4, NULL, NULL, NULL, NULL, 201220),
(13, 'Teoria', 4, NULL, NULL, NULL, NULL, 201220),
(14, 'Ayudantia', 4, NULL, NULL, NULL, NULL, 201220),
(15, 'Laboratorio', 4, NULL, NULL, NULL, NULL, 201220),
(16, 'Teoria', 5, NULL, NULL, NULL, NULL, 201220),
(17, 'Teoria', 5, NULL, NULL, NULL, NULL, 201220),
(18, 'Ayudantia', 5, NULL, NULL, NULL, NULL, 201220),
(19, 'Teoria', 6, NULL, 7, 8, 'Miercoles', 201220),
(20, 'Teoria', 6, NULL, NULL, NULL, NULL, 201220),
(21, 'Ayudantia', 6, NULL, NULL, NULL, NULL, 201220),
(22, 'Laboratorio', 6, NULL, 7, 8, 'Lunes', 201220),
(23, 'Teoria', 7, NULL, NULL, NULL, NULL, 201220),
(24, 'Teoria', 7, NULL, NULL, NULL, NULL, 201220),
(25, 'Ayudantia', 7, NULL, NULL, NULL, NULL, 201220),
(26, 'Laboratorio', 7, NULL, NULL, NULL, NULL, 201220);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase_tipo`
--

CREATE TABLE IF NOT EXISTS `clase_tipo` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id del tipo de clase.',
  `Tipo` varchar(50) NOT NULL COMMENT 'Tipo del profesor.',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase_usa_lab`
--

CREATE TABLE IF NOT EXISTS `clase_usa_lab` (
  `Id` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibilidad`
--

CREATE TABLE IF NOT EXISTS `disponibilidad` (
  `id_mod_disp` int(11) NOT NULL,
  `nrc_disp` varchar(8) NOT NULL,
  PRIMARY KEY (`id_mod_disp`,`nrc_disp`),
  KEY `nrc_disp` (`nrc_disp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imparte`
--

CREATE TABLE IF NOT EXISTS `imparte` (
  `id_lab_imp` int(11) NOT NULL,
  `id_mod_imp` int(11) NOT NULL,
  `id_clase_imp` int(11) NOT NULL,
  `periodo` int(11) NOT NULL,
  PRIMARY KEY (`id_lab_imp`,`id_mod_imp`,`id_clase_imp`,`periodo`),
  KEY `id_mod_imp` (`id_mod_imp`),
  KEY `id_asig_imp` (`id_clase_imp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `laboratorio`
--

CREATE TABLE IF NOT EXISTS `laboratorio` (
  `id_lab` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador del laboratorio para el software',
  `edificio` varchar(3) NOT NULL COMMENT 'edificio en donde se encuentra el laboratorio (ex: R3)',
  `sala` varchar(6) NOT NULL COMMENT 'sala en donde se encuentra (ex: lab402)',
  PRIMARY KEY (`id_lab`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `laboratorio`
--

INSERT INTO `laboratorio` (`id_lab`, `edificio`, `sala`) VALUES
(10, 'R3', '406'),
(11, 'R3', '401');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE IF NOT EXISTS `modulo` (
  `Modulo` int(11) NOT NULL COMMENT 'Número de módulo.',
  `Regimen` varchar(1) NOT NULL COMMENT 'D = Diurno, V = Vespertino.',
  `Inicio` time NOT NULL COMMENT 'Hora de inicio de módulo.',
  `Termino` time NOT NULL COMMENT 'Hora de término de módulo.'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`Modulo`, `Regimen`, `Inicio`, `Termino`) VALUES
(1, 'D', '08:30:00', '09:15:00'),
(2, 'D', '09:25:00', '10:10:00'),
(3, 'D', '10:20:00', '11:05:00'),
(4, 'D', '11:15:00', '12:00:00'),
(5, 'D', '12:10:00', '12:55:00'),
(6, 'D', '13:05:00', '13:50:00'),
(7, 'D', '14:00:00', '14:45:00'),
(8, 'D', '14:55:00', '15:40:00'),
(9, 'D', '15:50:00', '16:35:00'),
(10, 'D', '16:45:00', '17:30:00'),
(11, 'D', '17:40:00', '18:25:00'),
(12, 'D', '18:35:00', '19:20:00'),
(13, 'D', '19:30:00', '20:15:00'),
(14, 'D', '20:25:00', '21:10:00'),
(7, 'V', '19:00:00', '19:45:00'),
(8, 'V', '19:46:00', '20:30:00'),
(9, 'V', '20:40:00', '21:25:00'),
(10, 'V', '21:26:00', '22:10:00'),
(11, 'V', '22:20:00', '23:05:00'),
(12, 'V', '23:06:00', '23:50:00'),
(1, 'V', '08:30:00', '09:15:00'),
(2, 'V', '09:25:00', '10:10:00'),
(3, 'V', '10:20:00', '11:05:00'),
(4, 'V', '11:15:00', '12:00:00'),
(5, 'V', '12:10:00', '12:55:00'),
(6, 'V', '13:05:00', '13:50:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuesto`
--

CREATE TABLE IF NOT EXISTS `presupuesto` (
  `Codigo_Carrera` varchar(9) NOT NULL COMMENT 'Código de la carrera a la que le pertenece el presupuesto.',
  `Codigo_Semestre` int(11) NOT NULL COMMENT 'Código del semestre en el que es válido el presupuesto.',
  `Presupuesto` int(11) DEFAULT NULL COMMENT 'Monto.',
  KEY `Codigo_Carrera` (`Codigo_Carrera`,`Codigo_Semestre`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE IF NOT EXISTS `profesor` (
  `RUT_Profesor` int(10) NOT NULL COMMENT 'Rut del profesor.',
  `Nombre` varchar(50) NOT NULL COMMENT 'Nombre del profesor.',
  `Profesor_Grado` int(11) NOT NULL COMMENT 'Grado del profesor.',
  PRIMARY KEY (`RUT_Profesor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`RUT_Profesor`, `Nombre`, `Profesor_Grado`) VALUES
(6188369, 'LUIS M. OLIVEROS ACEVEDO', 2),
(7671021, 'JESSICA E. MEZA JAQUE', 2),
(8813947, 'MARIA C. SILVA PAREJAS', 2),
(8828559, 'SERGIO PAREDES TORRES', 2),
(9524095, 'PEDRO A. MONTECINOS GAETE', 2),
(10306726, 'PEDRO A. VELOSO HERNANDEZ', 2),
(13868119, 'JAIME H. ALUCEMA VARGAS', 2),
(14310656, 'RODRIGO ROMERO PASTEN', 2),
(15434019, 'JUAN P. ESCOBAR GUTIERREZ', 2),
(15634558, 'KARINA D. MADSEN FUENTES', 2),
(16473210, 'ANIBAL I. BENAVIDES MATTE', 2),
(16660706, 'FELIPE I. GONZALEZ ALFARO', 2),
(16979457, 'MAURICIO A. VARGAS SEPULVEDA', 2),
(17004262, 'XIMENA A. VARGAS VARGAS', 2),
(17671302, 'MATIAS A. MORENO MANCILLA', 2),
(17958297, 'FABIÃN A. GUAJARDO ARMIJO', 2),
(18085004, 'NICOLÃS E. HORMAZÃBAL SANTIBÃÃ‘EZ', 2),
(45393887, 'MILTON CARVAJAL BARRIOS', 2),
(46335511, 'FLORENCIO O. VALVERDE PERALTA', 2),
(53621988, 'RAUL ATILIO ADASME GALLEGOS', 2),
(59560867, 'EMILIO RIFFO HENRIQUEZ', 2),
(60281696, 'EDUARDO A. CASTAÃ‘EDA NUDELMAN', 2),
(60286841, 'VICENTE E. ARANDA CHACON', 2),
(63426822, 'MIGUEL A. GONZALEZ LORENZO', 2),
(65431416, 'JUAN L. PINO OPORTO', 2),
(65563185, 'ANA M. DIAZ ARAYA', 2),
(66228096, 'MAFALDA E. CARRENO MORCHIO', 2),
(66846377, 'RUBEN ESCANILLA CAMUS', 2),
(70011352, 'PABLO FELIX GONZALEZ LEVER', 2),
(71171507, 'DANIEL MANUEL CAMPOS DOMINGUEZ', 2),
(75404166, 'JUAN LUIS JIMENEZ OROZCO', 2),
(76458243, 'HECTOR PUENTE TRIANTAFILO', 2),
(76948291, 'CECILIA M. LARRAIN ROA', 2),
(78950188, 'FRANCISCO CASTILLO TAPIA', 2),
(81677956, 'DENIS MARKUSOVIC MARDONES', 2),
(83144556, 'RICHARD C. BRICEÃ‘O VILLAGRA', 2),
(86786354, 'CARLOS BEYZAGA MEDEL', 2),
(87721043, 'ALBERTO FERNANDO OLIVARES ALVAREZ', 2),
(89616026, 'CARLOS CURIN RETAMAL', 2),
(90449001, 'NIBALDO M. CABRINI VELOZO', 2),
(90933663, 'JORGE M. IBARRA HUGUET', 2),
(91532751, 'MARCOS W. ESTRELLA GONZALEZ', 2),
(93795539, 'RICARDO F. GARCES LAGOS', 2),
(94762995, 'FRANCISCO J. GALLARDO GONZÃLEZ', 2),
(95094643, 'JAN P. ONETO MANUEL', 2),
(99097515, 'OSCAR ANTONIO PINTO GARRALAGA', 2),
(99733837, 'JOSE A. ARAVENA ROJAS', 2),
(101816230, 'GUILLERMO ENRIQUE BADILLO ASTUDILLO', 2),
(102724690, 'CINTHYA A. ACOSTA SEPULVEDA', 2),
(103191521, 'ALFONSO TORO MARIN', 2),
(103641780, 'DANIEL ANDRES ZAMORA MARIN', 2),
(104655157, 'MARIO TOBAR SAAVEDRA', 2),
(105988303, 'LUIS A. RUIZ VALLEJOS', 2),
(109109355, 'MARCELA A. GODOY PINILLA', 2),
(109721255, 'CLAUDIO E. CARMONA CONCHA', 2),
(112582606, 'MARCELO A. CORTEZ SAN MARTIN', 2),
(113398744, 'WALTER A. URIBE LARA', 2),
(116367009, 'DANIEL ROZAS ARREDONDO', 2),
(116377586, 'ALEJANDRO DELFIN LLANQUIHUEN MARTINEZ', 2),
(116477823, 'MARCELA EDITH MEZA FACUSE', 2),
(118595904, 'DAVID RATINOFF VENEGAS', 2),
(119734487, 'VICTOR PEÃ‘A LATORRE', 2),
(122621707, 'HECTOR AGUILERA GONZALEZ', 2),
(123140656, 'JEAN P. RIVAS ZUMARAN', 2),
(124852854, 'LEONARDO C. HERRERA MENA', 2),
(126320957, 'CRISTIAN CACERES SILVA', 2),
(128225773, 'PILAR E. LÃ“PEZ LIRA', 2),
(128529349, 'MITZY CORTEZ ARROS', 2),
(130215890, 'MONTSERRAT N. SOTO FULLA', 2),
(131837852, 'SOFIA LEPE VERGARA', 2),
(133428577, 'JUAN J. GONZALEZ FAUNDEZ', 2),
(134050292, 'EDUARDO ANDRES VYHMEISTER BASTIDAS', 2),
(134447907, 'EDUARDO A. AVENDAÃ‘O CONTRERAS', 2),
(134547596, 'MARIA C. CORDERO REBOLLEDO', 2),
(134743484, 'SYLVIA D. CAMPOS AGUIRRE', 2),
(136711261, 'ALBERTO A. CEBALLOS RIVERA', 2),
(136725092, 'JACQUELINE KÃ–HLER CASASEMPERE', 2),
(137206560, 'FRANCISCO JAVIER CRUZ NARANJO', 2),
(138328449, 'MARIA C. CHAMORRO AHUMADA', 2),
(138990222, 'MAURICIO A. CANCINO ZÃšÃ‘IGA', 2),
(140617008, 'CARLOS W. NEIRA CARRASCO', 2),
(140935204, 'EMILIO J. CASTRO NAVARRO', 2),
(141489348, 'ALVARO N. ESPINOZA RAMIREZ', 2),
(141685376, 'HUMBERTO A. VILLAVICENCIO WASTAVINO', 2),
(141693573, 'GLORIA ANDREA LOPEZ VACKFLORES', 2),
(141815547, 'ALEXIS E. ARAVENA COLIÃ‘IR', 2),
(142442566, 'DAVID ALFREDO RUETE ZUÃ‘IGA', 2),
(142722445, 'MARTHA G. VIDAL SEPÃšLVEDA', 2),
(143002799, 'MARCIA MORENO ROA', 2),
(144015150, 'GUSTAVO ESTEBAN GATICA GONZALEZ', 2),
(145556007, 'JAVIER OLIVAS LINARES', 2),
(146334385, 'GORDANA STOJKOVIC', 2),
(146479588, 'PEREDA GALVEZ ALFONSO RUBEN', 2),
(146601642, 'OTTO C. PETERSSEN ENTRALGO', 2),
(146618855, 'JUAN . VIDAL ROJAS', 2),
(147398034, 'GLORIA CHAPARRO MEDINA', 2),
(147489757, 'JOSE ANGEL ACEITUNO GONZALEZ', 2),
(150284740, 'CARLOS L. CAÃ‘AS RIVERA', 2),
(150677491, 'FRANCISCO M. IBARRA GONZALEZ', 2),
(153175675, 'CAROLINA ANDREA TORO MENDOZA', 2),
(153696764, 'PATRICIO F. ORREGO CONTRERAS', 2),
(154684441, 'CRISTIAN ALEJANDRO OLIVARES RODRIGUEZ', 2),
(157747894, 'CARLOS E. DUQUE JAUREGUI', 2),
(158248212, 'ARIEL H. DEVAUD GONZALEZ', 2),
(158407337, 'JOSÃ‰ L. ALLENDE REIHER', 2),
(161029602, 'MIGUEL GUTIÃ‰RREZ GAITÃN', 2),
(161924318, 'MARIO A. GARRIDO GONZALEZ', 2),
(161935441, 'LUIS E. ZUÃ‘IGA MOYA', 2),
(162087754, 'JOSE MIGUEL OÃ‘ATE ARAYA', 2),
(162610635, 'ESTEBAN DE LA FUENTE RUBIO', 2),
(163546027, 'ALVARO A. CLOUET CASTÃ‰', 2),
(163556871, 'JUAN P. TORRES FERRADA', 2),
(163578980, 'DANIEL T. REYES PIZARRO', 2),
(163797704, 'JUAN E. ZUMARAN SALVATIERRA', 2),
(164747166, 'ROBERTO C. ARENAS QUEZADA', 2),
(164942937, 'CARLOS F. MUÃ‘OZ DE LA BARRA', 2),
(165713753, 'SEBASTIAN A. CABEZAS RIOS', 2),
(166153255, 'EDGARDO S. FUENTES CACERES', 2),
(166620724, 'RODRIGO A. CABALLERO VIVANCO', 2),
(167508456, 'MARCELO A. SALAZAR VERGARA', 2),
(167999387, 'EMANUEL J. LEIVA NAVARRO', 2),
(168760213, 'ROBERTO MORALES PONCE', 2),
(169073147, 'MANUEL A. TORRES PEREIRA', 2),
(169400202, 'EDUARDO TORTELLO WILLIAMSOM', 2),
(169533490, 'NOLAZCO A. CANDIA SAN MARTIN', 2),
(170221346, 'DENISSE R. OLGUIN ARIAS', 2),
(170289129, 'FELIPE A. VERGARA GARRIDO', 2),
(170482859, 'CLAUDIO FIGUEROA NUÃ‘EZ', 2),
(170837401, 'HERNAN FELIPE CORRAL RAMIREZ', 2),
(171906768, 'JOSE M. CERECEDA CACERES', 2),
(172456820, 'JORGE A. ESPINOSA ALDANA', 2),
(173218257, 'RAFAEL N. VALENZUELA TORRES', 2),
(173387393, 'LEFTARO M. COLIÃ‘IR VILCHES', 2),
(173753764, 'RODRIGO A. UGALDE PEÃ‘A Y LILLO', 2),
(175179224, 'GABRIEL E. CASTILLO CARDENAS', 2),
(176627581, 'ALVARO A. ARAVENA REBOLLEDO', 2),
(176726369, 'JUAN O. ZÃšÃ‘IGA SILVA', 2),
(176803959, 'CAMILO G. SANDOVAL SOVINO', 2),
(177067504, 'LUIS A. WEBSTER TORO', 2),
(177885940, 'RODRIGO A. PINO VALENZUELA', 2),
(178374834, 'CAMILA F. RETAMAL BUSTAMANTE', 2),
(179511428, 'JORGE M. TORRES GARCIA', 2),
(179833239, 'DANIEL E. PALOMERA STEVENS', 2),
(181154276, 'VIVIANNE K. OLGUIN ARIAS', 2),
(181667109, 'MIGUEL J. ACEVEDO CADIZ', 2),
(225587094, 'MONICA MANCERA RODRIGUEZ', 2),
(231773312, 'CESAR C. ALVIZ CHOQUE', 2),
(232277122, 'JOSE A. JOVEL ORTIZ', 2),
(236969509, 'DIANA MARSELA MORALES ARANGO', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor_grado`
--

CREATE TABLE IF NOT EXISTS `profesor_grado` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id del grado.',
  `Grado` varchar(40) NOT NULL COMMENT 'Grado.',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `profesor_grado`
--

INSERT INTO `profesor_grado` (`Id`, `Grado`) VALUES
(1, 'Egresado o estudiante'),
(2, 'Titulado'),
(3, 'Magister'),
(4, 'Doctorado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor_tiene_ramos`
--

CREATE TABLE IF NOT EXISTS `profesor_tiene_ramos` (
  `RUT_Profesor` int(10) NOT NULL COMMENT 'Rut profesor que dicta ramo.',
  `Codigo_Ramo` varchar(7) NOT NULL COMMENT 'Ramo dictado por el profesor.',
  PRIMARY KEY (`RUT_Profesor`),
  KEY `Codigo_Ramo` (`Codigo_Ramo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ramo`
--

CREATE TABLE IF NOT EXISTS `ramo` (
  `Codigo` varchar(7) NOT NULL COMMENT 'Código identificador de cada ramo.',
  `Nombre` varchar(50) NOT NULL COMMENT 'Nombre del ramo.',
  `Teoria` int(2) NOT NULL COMMENT 'Horas teoricas.',
  `Tipo` int(1) NOT NULL COMMENT 'Tipo del ramo, C = carrera, F = depto. física, Q = depto. química, M = depto. matemáticas, I = inglés, O = formación general y P = formación profesional. ',
  `Periodo` int(1) NOT NULL COMMENT '1 = Semestral, 2 = Trimestral.',
  `Ayudantia` int(2) NOT NULL COMMENT 'Horas de ayudantia.',
  `Laboratorio` int(2) NOT NULL COMMENT 'Horas de laboratorio.',
  `Taller` int(2) NOT NULL COMMENT 'Horas de taller.',
  `Creditos` int(2) NOT NULL COMMENT 'Creditos del ramo.',
  `SepAyu` tinyint(1) NOT NULL COMMENT 'Indica si se debe separar en dos la ayudantía de dicho ramo.',
  `SepLab` tinyint(1) NOT NULL COMMENT 'Indica si se debe separar en dos el laboratorio de dicho ramo.',
  `SepTal` tinyint(1) NOT NULL COMMENT 'Indica si se debe separar en dos el taller de dicho ramo.',
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ramo`
--

INSERT INTO `ramo` (`Codigo`, `Nombre`, `Teoria`, `Tipo`, `Periodo`, `Ayudantia`, `Laboratorio`, `Taller`, `Creditos`, `SepAyu`, `SepLab`, `SepTal`) VALUES
('CEG001', 'ELECTIVO DE FORMACIÃ“N GENERAL I', 2, 4, 1, 0, 0, 0, 2, 0, 0, 0),
('CEG002', 'ELECTIVO DE FORMACIÃ“N GENERAL II', 2, 4, 1, 0, 0, 0, 2, 0, 0, 0),
('CEG003', 'ELECTIVO DE FORMACIÃ“N GENERAL III', 2, 4, 1, 0, 0, 0, 2, 0, 0, 0),
('CEG004', 'ELECTIVO DE FORMACIÃ“N GENERAL IV', 2, 4, 1, 0, 0, 0, 2, 0, 0, 0),
('FIC1601', 'METODOLOGÃAS DE APRENDIZAJE Y ESTUDIO', 0, 4, 1, 0, 0, 3, 3, 0, 0, 0),
('FIC1602', 'ETICA, SOCIEDAD Y TRABAJO', 0, 4, 1, 0, 0, 3, 3, 0, 0, 0),
('FIC1603', 'TECNOLOGÃAS DE LA INFORMACIÃ“N', 0, 1, 1, 0, 0, 3, 3, 0, 0, 0),
('FIC1604', 'COMUNICACIÃ“N EFECTIVA', 0, 4, 1, 0, 0, 3, 3, 0, 0, 0),
('FMF021', 'FISICA I', 4, 2, 1, 2, 0, 0, 6, 0, 0, 0),
('FMF023', 'INTRODUCCION A LA FISICA', 4, 2, 1, 2, 0, 0, 6, 0, 0, 0),
('FMF024', 'FÃSICA GENERAL', 4, 2, 1, 0, 0, 2, 6, 0, 0, 0),
('FMF025', 'INTRODUCCIÃ“N A LA MECANICA', 4, 2, 1, 0, 0, 2, 6, 0, 0, 0),
('FMF081', 'DESARROLLO EXPERIMENTAL I', 0, 2, 1, 0, 2, 0, 2, 0, 0, 0),
('FMF082', 'MOD.EXPERIMENTAL I', 0, 2, 1, 0, 4, 0, 4, 0, 0, 0),
('FMF086', 'FISICA EXPERIMENTAL', 0, 2, 1, 0, 4, 0, 4, 0, 0, 0),
('FMF121', 'FÃSICA II', 4, 2, 1, 2, 0, 0, 6, 0, 0, 0),
('FMF122', 'MECANICA', 4, 2, 1, 2, 0, 0, 6, 0, 0, 0),
('FMF141', 'ELECTRICIDAD, MAGNETISMO Y ONDAS', 4, 2, 1, 2, 0, 0, 6, 0, 0, 0),
('FMF144', 'ELECTRICIDAD Y MAGNETISMO', 4, 2, 1, 0, 0, 2, 6, 0, 0, 0),
('FMF181', 'DESARROLLO EXPERIMENTAL II', 0, 2, 1, 0, 2, 0, 2, 0, 0, 0),
('FMF182', 'MOD.EXPERIMENTAL II', 0, 2, 1, 0, 4, 0, 4, 0, 0, 0),
('FMF226', 'FISICA MODERNA', 4, 2, 1, 2, 0, 0, 6, 0, 0, 0),
('FMF241', 'ELECTROMAGNETISMO', 4, 2, 1, 2, 0, 0, 6, 0, 0, 0),
('FMF282', 'MOD. EXPERIMENTAL III', 0, 2, 1, 0, 4, 0, 4, 0, 0, 0),
('FMM010', 'ALGEBRA I', 4, 6, 1, 2, 0, 0, 6, 0, 0, 0),
('FMM012', 'INTRODUCCIÃ“N A LAS MATEMATICAS', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM013', 'ALGEBRA I', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM030', 'CÃLCULO I', 4, 6, 1, 2, 0, 0, 6, 0, 0, 0),
('FMM033', 'CALCULO I', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM110', 'ALGEBRA LINEAL', 4, 6, 1, 2, 0, 0, 6, 0, 0, 0),
('FMM112', 'CÃLCULO DIFERENCIAL', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM113', 'ALGEBRA LINEAL', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM130', 'CÃLCULO II', 4, 6, 1, 2, 0, 0, 6, 0, 0, 0),
('FMM133', 'CALCULO II', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM214', 'CALCULO INTEGRAL Y PROBABILIDADES', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM230', 'CÃLCULO III', 4, 6, 1, 2, 0, 0, 6, 0, 0, 0),
('FMM232', 'CALCULO NUMERICO', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM235', 'CALCULO EN VARIAS VARIABLES', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM254', 'ECUACIONES DIFERENCIALES', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMM312', 'SISTEMAS Y ECUACIONES DIFERENCIALES LINEALES', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('FMS175', 'PROBABILIDAD Y ESTADISTICA', 4, 6, 1, 2, 0, 0, 6, 0, 0, 0),
('FMS176', 'PROBABILIDADES Y ESTADISTICA', 6, 6, 1, 2, 0, 0, 8, 0, 0, 0),
('ICC111', 'ELEMENTOS DE COMPUTACIÃ“N', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC120', 'MODELAMIENTO Y PROGRAMACIÃ“N', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC121', 'ESTRUCTURA DE DATOS', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC130', 'CIRCUITOS ELÃ‰CTRICOS Y ELECTRÃ“NICOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICC133', 'PROCESAMIENTO DE SEÃ‘ALES', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICC233', 'AUTOMATAS Y COMPILADORES', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICC234', 'LÃ“GICA Y ANÃLISIS DE ALGORITMOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICC235', 'ARQUITECTURA DE COMPUTADORES', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC236', 'MODELAMIENTO DE DATOS', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC243', 'SISTEMAS OPERATIVOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICC244', 'INTELIGENCIA ARTIFICIAL', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC245', 'REDES DE DATOS II', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC246', 'INGENIERÃA DE SOFTWARE I', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC247', 'REDES DE DATOS I', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC248', 'BASE DE DATOS', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC249', 'MODELAMIENTO Y SIMULACIÃ“N', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC252', 'EVALUACIÃ“N Y ADMINISTRACIÃ“N DE PROYECTOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICC253', 'TECNOLOGÃAS DE SISTEMAS DE INFORMACIÃ“N', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC254', 'SISTEMAS DE INFORMACIÃ“N DE GESTIÃ“N', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICC255', 'ARQUITECTURA DE SISTEMAS', 4, 1, 1, 2, 2, 0, 8, 0, 0, 0),
('ICC256', 'INGENIERIA DE SOFTWARE II', 4, 1, 1, 2, 2, 0, 8, 0, 0, 0),
('ICC260', 'TALLER DE TITULO I', 5, 1, 1, 0, 0, 0, 5, 0, 0, 0),
('ICC261', 'TALLER DE TITULO II', 6, 1, 1, 0, 0, 0, 6, 0, 0, 0),
('ICC352', 'ELECTIVO DE FORMACION PROFESIONAL III', 4, 5, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC353', 'ELECTIVO DE FORMACION PROFESIONAL I', 4, 5, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC354', 'ELECTIVO DE FORMACION PROFESIONAL II', 4, 5, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC360', 'ELECTIVO DE FORMACION PROFESIONAL IV', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC361', 'ELECTIVO DE FORMACION PROFESIONAL V', 4, 5, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC362', 'ELECTIVO DE FORMACION PROFESIONAL VI', 4, 5, 1, 0, 2, 0, 6, 0, 0, 0),
('ICC363', 'ELECTIVO DE FORMACION PROFESIONAL VII', 4, 5, 1, 0, 2, 0, 6, 0, 0, 0),
('ICI041', 'ADMINISTRACIÃ“N DE RECURSOS HUMANOS', 3, 1, 1, 0, 0, 0, 3, 0, 0, 0),
('ICI050', 'TALLER DE HABILIDADES GERENCIALES', 3, 1, 1, 0, 0, 0, 3, 0, 0, 0),
('ICI111', 'INTRODUCCION A LA INGENIERIA', 2, 1, 1, 0, 0, 0, 2, 0, 0, 0),
('ICI135', 'TEORIA DE SISTEMAS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICI245', 'INGENIERIA ECONOMICA', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICI248', 'ECONOMIA', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('ICI249', 'CONTABILIDAD Y FINANZAS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEC119', 'LENGUAJE DE PROGRAMACION', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEC122', 'MODELAMIENTO DE DATOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEC130', 'TRANSMISIÃ“N DE DATOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEC210', 'SISTEMA DE INFORMACIÃ“N I', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IEC211', 'SISTEMA DE INFORMACIÃ“N II', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEC220', 'BASE DE DATOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEC230', 'INGENIERÃA DE REDES I', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEC301', 'SISTEMA DE GESTIÃ“N TECNOLÃ“GICA', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IEC302', 'PROYECTO DE TÃTULO', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IEC320', 'TALLER DE DESARROLLO DE SOFTWARE I', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IEC325', 'TALLER DE DESARROLLO DE SOFTWARE II', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IEC330', 'INGENIERÃA DE REDES II', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEG122', 'BASE DE DATOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEG191', 'PLANIFICACIÃ“N ESTRATÃ‰GICA', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IEG192', 'ADMINISTRACIÃ“N DE LA PRODUCCIÃ“N', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IEG210', 'SISTEMAS DE INFORMACIÃ“N', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IEG230', 'INTRODUCCIÃ“N A LAS REDES', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEG270', 'MICROECONOMÃA', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEG271', 'MACROECONOMÃA', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEG281', 'COSTOS Y PRESUPUESTOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IEG300', 'PROYECTO DE TÃTULO', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IET001', 'ELEMENTOS DE COMPUTACIÃ“N', 4, 1, 1, 2, 2, 0, 8, 0, 0, 0),
('IET020', 'METODOLOGÃA DE PROGRAMACIÃ“N', 4, 1, 1, 2, 2, 0, 8, 0, 0, 0),
('IET030', 'ORGANIZAC. DE COMPUTADORES', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IET090', 'INTRODUCCIÃ“N A LA ADMINISTRACIÃ“N', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IET091', 'ADMINISTRACIÃ“N DE RRHH', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IET100', 'ELECTIVO F. PROFESIONAL I', 4, 5, 1, 0, 0, 0, 4, 0, 0, 0),
('IET101', 'ELECTIVO F. PROFESIONAL II', 4, 5, 1, 0, 0, 0, 4, 0, 0, 0),
('IET102', 'ELECTIVO DE F. PROFESIONAL III', 4, 5, 1, 0, 0, 0, 4, 0, 0, 0),
('IET103', 'ELECTIVO F. PROFESIONAL IV', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IET104', 'ELECTIVO DE F. PROFESIONAL V', 4, 5, 1, 0, 0, 0, 4, 0, 0, 0),
('IET105', 'ELECTIVO F. PROFESIONAL VI', 4, 5, 1, 0, 0, 0, 4, 0, 0, 0),
('IET106', 'ELECTIVO FORM. PROFESIONAL VII', 4, 5, 1, 0, 0, 0, 4, 0, 0, 0),
('IET110', 'SISTEMAS OPERATIVOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IET121', 'ESTRUCTURAS DE DATOS', 4, 1, 1, 2, 2, 0, 8, 0, 0, 0),
('IET140', 'INVESTIGACIÃ“N OPERATIVA', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IET170', 'ECONOMÃA', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IET180', 'CONTABILIDAD', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IET181', 'FINANZAS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IET190', 'DESARROLLO ORGANIZACIONAL', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IET193', 'MERCADOS', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IET221', 'INGENIERÃA DE SOFTWARE', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IET300', 'PREP. Y EVALUACIÃ“N DE PROYECTOS', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IET310', 'AUDITORIA COMPUTACIONAL', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IND2102', 'COSTOS Y PRESUPUESTOS', 4, 1, 1, 0, 0, 0, 4, 0, 0, 0),
('IND2103', 'INGENIERÃA ECONOMICA', 4, 1, 1, 2, 0, 0, 6, 0, 0, 0),
('IND2104', 'FORMULACIÃ“N Y EVALUACIÃ“N DE PROYECTOS', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('INF1201', 'PROGRAMACIÃ“N', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('INF1203', 'SISTEMAS OPERATIVOS', 0, 1, 1, 0, 0, 4, 4, 0, 0, 0),
('ING119', 'INGLÃ‰S I', 0, 3, 1, 0, 0, 6, 6, 0, 0, 0),
('ING129', 'INGLÃ‰S II', 0, 3, 1, 0, 0, 6, 6, 0, 0, 0),
('ING239', 'INGLÃ‰S III', 0, 3, 1, 0, 0, 6, 6, 0, 0, 0),
('ING249', 'INGLÃ‰S IV', 0, 3, 1, 0, 0, 6, 6, 0, 0, 0),
('ITC1401', 'INTRODUCCIÃ“N A LOS SISTEMAS DE TELECOMUNICACIONES', 4, 1, 1, 0, 0, 2, 6, 0, 0, 0),
('ITC1601', 'ELECTRONICA', 0, 1, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC1701', 'REDES DE COMPUTADORES', 0, 1, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC2401', 'SEÃ‘ALES Y SISTEMAS', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ITC2402', 'COMUNICACIONES DIGITALES', 0, 1, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC2403', 'SISTEMAS DE COMUNICACIONES', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ITC2404', 'REDES DE TELECOMUNICACIONES', 4, 1, 1, 0, 2, 0, 6, 0, 0, 0),
('ITC2405', 'TOPICOS DE ESPECIALIDAD EN TELECOMUNICACIONES', 0, 5, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC2601', 'SISTEMAS DE CONTROL', 0, 1, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC2702', 'REDES DE DATOS', 0, 1, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC2704', 'COMUNICACIONES OPTICAS', 0, 1, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC2705', 'COMUNICACIONES INALAMBRICAS', 0, 1, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC2706', 'TOPICOS DE ESPECIALIDAD EN REDES', 0, 5, 1, 0, 0, 4, 4, 0, 0, 0),
('ITC2802', 'INGENIERIA DE PROYECTOS', 6, 1, 1, 0, 0, 0, 6, 0, 0, 0),
('ITC2803', 'PROYECTO DE TITULO', 6, 1, 1, 0, 0, 0, 6, 0, 0, 0),
('ITC2901', 'FORMACIÃ“N PROFESIONAL COMPLEMENTARIA I', 0, 5, 1, 0, 0, 3, 3, 0, 0, 0),
('ITC2902', 'FORMACIÃ“N PROFESIONAL COMPLEMENTARIA II', 0, 5, 1, 0, 0, 3, 3, 0, 0, 0),
('QUI070', 'QUIMICA Y AMBIENTE', 4, 7, 1, 2, 0, 0, 6, 0, 0, 0),
('QUI104', 'QUIMICA', 4, 7, 1, 2, 0, 0, 6, 0, 0, 0),
('QUI105', 'LABORATORIO DE QUIMICA', 0, 7, 1, 0, 2, 0, 2, 0, 0, 0),
('ZZDEPTO', 'fisica depto', 4, 2, 1, 2, 4, 0, 10, 1, 1, 0),
('ZZZ001', 'Ultimo Ramo', 4, 1, 1, 2, 2, 2, 10, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ramos_impartidos`
--

CREATE TABLE IF NOT EXISTS `ramos_impartidos` (
  `Codigo_Carrera` varchar(9) NOT NULL COMMENT 'Código de la carrera en la cual se imparte el ramo.',
  `Codigo_Ramo` varchar(7) NOT NULL COMMENT 'Codigo del ramo impartido.',
  `Codigo_Semestre` int(11) NOT NULL COMMENT 'Semestre o trimestre en el cual se imparte.',
  `Impartido` int(1) NOT NULL COMMENT '1 = Impartido, 2 = No impartido.',
  KEY `Codigo_Ramo` (`Codigo_Ramo`),
  KEY `Codigo_Semestre` (`Codigo_Semestre`),
  KEY `Codigo_Carrera` (`Codigo_Carrera`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ramos_impartidos`
--

INSERT INTO `ramos_impartidos` (`Codigo_Carrera`, `Codigo_Ramo`, `Codigo_Semestre`, `Impartido`) VALUES
('UNAB21500', 'IET001', 201220, 1),
('UNAB21500', 'IET020', 201220, 1),
('UNAB21500', 'IEC119', 201220, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ramo_tipo`
--

CREATE TABLE IF NOT EXISTS `ramo_tipo` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id del tipo.',
  `Tipo` varchar(50) NOT NULL COMMENT 'Tipo del ramo.',
  `Abreviacion` varchar(3) NOT NULL COMMENT 'Abreviación del tipo de ramo.',
  `soloDepto` tinyint(1) NOT NULL COMMENT 'Indica con true si es un ramo que solamente puede ser dictado por usuario departamento.',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `ramo_tipo`
--

INSERT INTO `ramo_tipo` (`Id`, `Tipo`, `Abreviacion`, `soloDepto`) VALUES
(1, 'Carrera', 'C', 0),
(2, 'Fisica', 'F', 1),
(3, 'Ingles', 'I', 1),
(4, 'Formacion general', 'O', 0),
(5, 'Formacion profesional', 'P', 0),
(6, 'Matematicas', 'M', 1),
(7, 'Quimica', 'Q', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ramo_usa_lab`
--

CREATE TABLE IF NOT EXISTS `ramo_usa_lab` (
  `codigo` varchar(11) NOT NULL,
  `teoria` varchar(11) NOT NULL,
  `ayudantia` varchar(11) NOT NULL,
  `laboratorio` varchar(11) NOT NULL,
  `taller` varchar(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ramo_usa_lab`
--

INSERT INTO `ramo_usa_lab` (`codigo`, `teoria`, `ayudantia`, `laboratorio`, `taller`) VALUES
('ICC248', 'si', '', 'si', ''),
('ICC249', 'no', '', 'si', ''),
('ITC1401', 'si', '', '', 'no');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion`
--

CREATE TABLE IF NOT EXISTS `seccion` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id de la sección.',
  `Numero_Seccion` int(11) NOT NULL COMMENT 'Número de la sección.',
  `NRC` int(11) NOT NULL COMMENT 'Código identificador de cada sección.',
  `Codigo_Ramo` varchar(7) NOT NULL COMMENT 'Código del ramo al cual pertenece la sección.',
  `Codigo_Carrera` varchar(9) NOT NULL COMMENT 'Código de la carrera a la cual le pertenece esta sección.',
  `Codigo_Semestre` int(11) NOT NULL COMMENT 'Semestre al que pertenece la sección.',
  `Regimen` varchar(1) NOT NULL COMMENT 'D = Diurno, V = Vespertino.',
  `Vacantes` int(11) NOT NULL COMMENT 'Vacantes de la sección.',
  `Vacantes_utilizadas` int(11) NOT NULL COMMENT 'Cantidad de vacantes utilizadas por el jefe de carrera.',
  PRIMARY KEY (`Id`),
  KEY `Codigo_Ramo` (`Codigo_Ramo`),
  KEY `Numero_Seccion` (`Numero_Seccion`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `seccion`
--

INSERT INTO `seccion` (`Id`, `Numero_Seccion`, `NRC`, `Codigo_Ramo`, `Codigo_Carrera`, `Codigo_Semestre`, `Regimen`, `Vacantes`, `Vacantes_utilizadas`) VALUES
(1, 100, 1524, 'IET001', 'UNAB21500', 201220, 'V', 50, 0),
(2, 100, 1524, 'IEC119', 'UNAB21500', 201220, 'V', 50, 0),
(3, 100, 1524, 'IET020', 'UNAB21500', 201220, 'V', 50, 0),
(4, 101, 1524, 'IET001', 'UNAB21500', 201220, 'V', 50, 0),
(5, 101, 1524, 'IEC119', 'UNAB21500', 201220, 'V', 50, 0),
(6, 102, 1524, 'IET001', 'UNAB21500', 201220, 'V', 50, 0),
(7, 101, 1524, 'IET020', 'UNAB21500', 201220, 'V', 50, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `semestre`
--

CREATE TABLE IF NOT EXISTS `semestre` (
  `Codigo_Semestre` int(11) NOT NULL COMMENT 'Código del semestre.',
  `Numero` int(1) NOT NULL COMMENT 'Número del semestre, 1 o 2.',
  `Anho` int(4) NOT NULL COMMENT 'Año en que tuvo lugar el esmestre.',
  `Fecha_Inicio` datetime NOT NULL COMMENT 'Fecha de inicio de programación de semestre.',
  `Fecha_Termino` datetime DEFAULT NULL COMMENT 'Fecha de término de programación de semestre.',
  PRIMARY KEY (`Codigo_Semestre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `semestre`
--

INSERT INTO `semestre` (`Codigo_Semestre`, `Numero`, `Anho`, `Fecha_Inicio`, `Fecha_Termino`) VALUES
(201220, 2, 2012, '2012-05-14 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `software`
--

CREATE TABLE IF NOT EXISTS `software` (
  `id_sw` int(11) NOT NULL AUTO_INCREMENT,
  `nom_sw` varchar(30) NOT NULL,
  `version` varchar(30) NOT NULL,
  PRIMARY KEY (`id_sw`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `software`
--

INSERT INTO `software` (`id_sw`, `nom_sw`, `version`) VALUES
(1, 'Java', '7');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `software_asignado`
--

CREATE TABLE IF NOT EXISTS `software_asignado` (
  `id_sw_asigna` int(11) NOT NULL,
  `nrc_asigna` varchar(8) NOT NULL,
  PRIMARY KEY (`id_sw_asigna`,`nrc_asigna`),
  KEY `nrc_asigna` (`nrc_asigna`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud`
--

CREATE TABLE IF NOT EXISTS `solicitud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Codigo_Ramo` varchar(7) NOT NULL COMMENT 'Código del ramo pedido.',
  `Seccion_asignada` int(11) DEFAULT NULL COMMENT 'Sección a la cual se le asignó la cantidad de vacantes.',
  `Carrera` varchar(9) NOT NULL COMMENT 'Carrera dueña del ramo.',
  `Carrera_Solicitante` varchar(9) NOT NULL COMMENT 'Carrera solicitante de vacantes.',
  `Vacantes` int(11) NOT NULL COMMENT 'Número de vacantes solicitadas.',
  `Vacantes_Asignadas` int(11) DEFAULT NULL COMMENT 'Cantidad de vacantes asignadas.',
  `Codigo_Semestre` int(11) NOT NULL COMMENT 'Código del semestre al cual pertenece esta solicitud.',
  `Fecha_Envio` datetime NOT NULL COMMENT 'Fecha en la que se envío esta solicitud.',
  `Fecha_Respuesta` datetime DEFAULT NULL COMMENT 'Fecha en la cual se respondio a la solicitud.',
  `Estado` int(11) NOT NULL COMMENT '1 = Esperando, 2 = Aceptada y 3 = Denegada.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE IF NOT EXISTS `tipo_usuario` (
  `Id` int(1) NOT NULL,
  `Tipo` varchar(32) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`Id`, `Tipo`) VALUES
(1, 'Jefe de carrera'),
(2, 'Administrador'),
(3, 'Jefe de carrera + administrador'),
(4, 'Usuario departamento'),
(5, 'Jefe de Laboratorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trimestre`
--

CREATE TABLE IF NOT EXISTS `trimestre` (
  `Codigo_Trimestre` int(11) NOT NULL COMMENT 'Código del trimestre.',
  `Numero` int(11) NOT NULL COMMENT 'Número del trimestre, 1,2 o 3.',
  `Anho` year(4) NOT NULL COMMENT 'Año en que tuvo lugar el trimestre.',
  `Fecha_Inicio` datetime NOT NULL COMMENT 'Fecha de inicio de programación de trimestre.',
  `Fecha_Termino` datetime DEFAULT NULL COMMENT 'Fecha de termino de programación de trimestre.',
  PRIMARY KEY (`Codigo_Trimestre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `trimestre`
--

INSERT INTO `trimestre` (`Codigo_Trimestre`, `Numero`, `Anho`, `Fecha_Inicio`, `Fecha_Termino`) VALUES
(201225, 3, 2012, '2012-05-14 01:53:35', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `Nombre_Usuario` varchar(40) NOT NULL,
  `RUT` varchar(10) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  `Password` varchar(32) NOT NULL,
  `Id_Tipo` int(1) NOT NULL,
  PRIMARY KEY (`Nombre_Usuario`),
  KEY `Id_Tipo` (`Id_Tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Nombre_Usuario`, `RUT`, `Nombre`, `Password`, `Id_Tipo`) VALUES
('admin', '164827607', 'Administrador', '607c23cfed39259fc0e8ed8636d9bfe5', 2),
('admin2', '173184379', 'Cristian Flores', 'e10adc3949ba59abbe56e057f20f883e', 2),
('carolina.toro', '15317567-5', 'Carolina Toro Mendoza', '040b7cf4a55014e185813e0644502ea9', 1),
('cris.pardo', '1-9', 'Cristobal', 'e10adc3949ba59abbe56e057f20f883e', 5),
('depto', '164827607', 'Departamento', '040b7cf4a55014e185813e0644502ea9', 4),
('miguel.gutierrez', '16102960-2', 'Miguel Gutierrez Gaitan', 'e10adc3949ba59abbe56e057f20f883e', 1),
('opinto', '8542558-9', 'Oscar Pinto G.', '040b7cf4a55014e185813e0644502ea9', 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
