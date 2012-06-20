-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 15-05-2012 a las 09:44:25
-- Versión del servidor: 5.5.8
-- Versión de PHP: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `hsc`
--

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
-- Volcar la base de datos para la tabla `carrera`
--

INSERT INTO `carrera` (`Codigo`, `NombreUsuario_JC`, `Nombre_Carrera`, `Periodo`, `Regimen`, `Numero`) VALUES
('UNAB11500', 'carolina.toro', 'Ingenieria en Computacion e Informatica', 1, 'D', 2),
('UNAB11502', 'carolina.toro', 'Ingenieria en Telecomunicaciones', 1, 'D', 2),
('UNAB12200', 'carolina.toro', 'Ingenieria Civil en Computacion e Informatica', 1, 'D', 2),
('UNAB19200', 'carolina.toro', 'Ingenieria en Gestion Informatica', 1, 'D', 2),
('UNAB21500', 'miguel.gutierrez', 'Ingenieria en Computacion e Informatica', 1, 'V', 2),
('UNAB21502', 'miguel.gutierrez', 'Ingenieria en Telecomunicaciones', 1, 'V', 2),
('UNAB29200', 'miguel.gutierrez', 'Ingenieria en Gestion Informatica', 1, 'V', 2);

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
-- Volcar la base de datos para la tabla `carrera_tiene_ramos`
--

INSERT INTO `carrera_tiene_ramos` (`Codigo_Carrera`, `Codigo_Ramo`, `Semestre`) VALUES
('UNAB21502', 'FMM012', 1),
('UNAB21502', 'ITC1401', 1),
('UNAB21502', 'FMF024', 1),
('UNAB21502', 'FIC1603', 1),
('UNAB21502', 'FIC1601', 1),
('UNAB21502', 'FMM112', 2),
('UNAB21502', 'INF1201', 2),
('UNAB21502', 'FMF025', 2),
('UNAB21502', 'QUI070', 2),
('UNAB21502', 'FMM214', 3),
('UNAB21502', 'INF1203', 3),
('UNAB21502', 'FMF144', 3),
('UNAB21502', 'FIC1604', 3),
('UNAB21502', 'ING119', 3),
('UNAB21502', 'FMM312', 4),
('UNAB21502', 'ITC1601', 4),
('UNAB21502', 'ITC1701', 4),
('UNAB21502', 'FMF086', 4),
('UNAB21502', 'ING129', 4),
('UNAB21502', 'IND2102', 5),
('UNAB21502', 'ITC2601', 5),
('UNAB21502', 'ITC2702', 5),
('UNAB21502', 'ITC2401', 5),
('UNAB21502', 'ING239', 5),
('UNAB21502', 'IND2103', 6),
('UNAB21502', 'ITC2704', 6),
('UNAB21502', 'ITC2402', 6),
('UNAB21502', 'ITC2403', 6),
('UNAB21502', 'ING249', 6),
('UNAB21502', 'IND2104', 7),
('UNAB21502', 'ITC2802', 7),
('UNAB21502', 'ITC2705', 7),
('UNAB21502', 'ITC2404', 7),
('UNAB21502', 'ITC2901', 7),
('UNAB21502', 'ITC2803', 8),
('UNAB21502', 'FIC1602', 8),
('UNAB21502', 'ITC2706', 8),
('UNAB21502', 'ITC2405', 8),
('UNAB21502', 'ITC2902', 8);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=126 ;

--
-- Volcar la base de datos para la tabla `clase`
--


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase_tipo`
--

CREATE TABLE IF NOT EXISTS `clase_tipo` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id del tipo de clase.',
  `Tipo` varchar(50) NOT NULL COMMENT 'Tipo del profesor.',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Volcar la base de datos para la tabla `clase_tipo`
--


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
-- Volcar la base de datos para la tabla `modulo`
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
(1, 'V', '19:00:00', '19:45:00'),
(2, 'V', '19:46:00', '20:30:00'),
(3, 'V', '20:40:00', '21:25:00'),
(4, 'V', '21:26:00', '22:10:00'),
(5, 'V', '22:20:00', '23:05:00'),
(6, 'V', '23:06:00', '23:50:00');

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

--
-- Volcar la base de datos para la tabla `presupuesto`
--


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
-- Volcar la base de datos para la tabla `profesor`
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
-- Volcar la base de datos para la tabla `profesor_grado`
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
  `Codigo_Ramo` varchar(6) NOT NULL COMMENT 'Ramo dictado por el profesor.',
  PRIMARY KEY (`RUT_Profesor`),
  KEY `Codigo_Ramo` (`Codigo_Ramo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `profesor_tiene_ramos`
--


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
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcar la base de datos para la tabla `ramo`
--

INSERT INTO `ramo` (`Codigo`, `Nombre`, `Teoria`, `Tipo`, `Periodo`, `Ayudantia`, `Laboratorio`, `Taller`, `Creditos`) VALUES
('CEG001', 'ELECTIVO DE FORMACIÃ“N GENERAL I', 2, 4, 1, 0, 0, 0, 2),
('CEG002', 'ELECTIVO DE FORMACIÃ“N GENERAL II', 2, 4, 1, 0, 0, 0, 2),
('CEG003', 'ELECTIVO DE FORMACIÃ“N GENERAL III', 2, 4, 1, 0, 0, 0, 2),
('CEG004', 'ELECTIVO DE FORMACIÃ“N GENERAL IV', 2, 4, 1, 0, 0, 0, 2),
('FIC1601', 'METODOLOGÃAS DE APRENDIZAJE Y ESTUDIO', 0, 4, 1, 0, 0, 3, 3),
('FIC1602', 'ETICA, SOCIEDAD Y TRABAJO', 0, 4, 1, 0, 0, 3, 3),
('FIC1603', 'TECNOLOGÃAS DE LA INFORMACIÃ“N', 0, 1, 1, 0, 0, 3, 3),
('FIC1604', 'COMUNICACIÃ“N EFECTIVA', 0, 4, 1, 0, 0, 3, 3),
('FMF021', 'FISICA I', 4, 2, 1, 2, 0, 0, 6),
('FMF023', 'INTRODUCCION A LA FISICA', 4, 2, 1, 2, 0, 0, 6),
('FMF024', 'FÃSICA GENERAL', 4, 2, 1, 0, 0, 2, 6),
('FMF025', 'INTRODUCCIÃ“N A LA MECANICA', 4, 2, 1, 0, 0, 2, 6),
('FMF081', 'DESARROLLO EXPERIMENTAL I', 0, 2, 1, 0, 2, 0, 2),
('FMF082', 'MOD.EXPERIMENTAL I', 0, 2, 1, 0, 4, 0, 4),
('FMF086', 'FISICA EXPERIMENTAL', 0, 2, 1, 0, 4, 0, 4),
('FMF121', 'FÃSICA II', 4, 2, 1, 2, 0, 0, 6),
('FMF122', 'MECANICA', 4, 2, 1, 2, 0, 0, 6),
('FMF141', 'ELECTRICIDAD, MAGNETISMO Y ONDAS', 4, 2, 1, 2, 0, 0, 6),
('FMF144', 'ELECTRICIDAD Y MAGNETISMO', 4, 2, 1, 0, 0, 2, 6),
('FMF181', 'DESARROLLO EXPERIMENTAL II', 0, 2, 1, 0, 2, 0, 2),
('FMF182', 'MOD.EXPERIMENTAL II', 0, 2, 1, 0, 4, 0, 4),
('FMF226', 'FISICA MODERNA', 4, 2, 1, 2, 0, 0, 6),
('FMF241', 'ELECTROMAGNETISMO', 4, 2, 1, 2, 0, 0, 6),
('FMF282', 'MOD. EXPERIMENTAL III', 0, 2, 1, 0, 4, 0, 4),
('FMM010', 'ALGEBRA I', 4, 6, 1, 2, 0, 0, 6),
('FMM012', 'INTRODUCCIÃ“N A LAS MATEMATICAS', 6, 6, 1, 2, 0, 0, 8),
('FMM013', 'ALGEBRA I', 6, 6, 1, 2, 0, 0, 8),
('FMM030', 'CÃLCULO I', 4, 6, 1, 2, 0, 0, 6),
('FMM033', 'CALCULO I', 6, 6, 1, 2, 0, 0, 8),
('FMM110', 'ALGEBRA LINEAL', 4, 6, 1, 2, 0, 0, 6),
('FMM112', 'CÃLCULO DIFERENCIAL', 6, 6, 1, 2, 0, 0, 8),
('FMM113', 'ALGEBRA LINEAL', 6, 6, 1, 2, 0, 0, 8),
('FMM130', 'CÃLCULO II', 4, 6, 1, 2, 0, 0, 6),
('FMM133', 'CALCULO II', 6, 6, 1, 2, 0, 0, 8),
('FMM214', 'CALCULO INTEGRAL Y PROBABILIDADES', 6, 6, 1, 2, 0, 0, 8),
('FMM230', 'CÃLCULO III', 4, 6, 1, 2, 0, 0, 6),
('FMM232', 'CALCULO NUMERICO', 6, 6, 1, 2, 0, 0, 8),
('FMM235', 'CALCULO EN VARIAS VARIABLES', 6, 6, 1, 2, 0, 0, 8),
('FMM254', 'ECUACIONES DIFERENCIALES', 6, 6, 1, 2, 0, 0, 8),
('FMM312', 'SISTEMAS Y ECUACIONES DIFERENCIALES LINEALES', 6, 6, 1, 2, 0, 0, 8),
('FMS175', 'PROBABILIDAD Y ESTADISTICA', 4, 6, 1, 2, 0, 0, 6),
('FMS176', 'PROBABILIDADES Y ESTADISTICA', 6, 6, 1, 2, 0, 0, 8),
('ICC111', 'ELEMENTOS DE COMPUTACIÃ“N', 4, 1, 1, 0, 2, 0, 6),
('ICC120', 'MODELAMIENTO Y PROGRAMACIÃ“N', 4, 1, 1, 0, 2, 0, 6),
('ICC121', 'ESTRUCTURA DE DATOS', 4, 1, 1, 0, 2, 0, 6),
('ICC130', 'CIRCUITOS ELÃ‰CTRICOS Y ELECTRÃ“NICOS', 4, 1, 1, 2, 0, 0, 6),
('ICC133', 'PROCESAMIENTO DE SEÃ‘ALES', 4, 1, 1, 2, 0, 0, 6),
('ICC233', 'AUTOMATAS Y COMPILADORES', 4, 1, 1, 2, 0, 0, 6),
('ICC234', 'LÃ“GICA Y ANÃLISIS DE ALGORITMOS', 4, 1, 1, 2, 0, 0, 6),
('ICC235', 'ARQUITECTURA DE COMPUTADORES', 4, 1, 1, 0, 2, 0, 6),
('ICC236', 'MODELAMIENTO DE DATOS', 4, 1, 1, 0, 2, 0, 6),
('ICC243', 'SISTEMAS OPERATIVOS', 4, 1, 1, 2, 0, 0, 6),
('ICC244', 'INTELIGENCIA ARTIFICIAL', 4, 1, 1, 0, 2, 0, 6),
('ICC245', 'REDES DE DATOS II', 4, 1, 1, 0, 2, 0, 6),
('ICC246', 'INGENIERÃA DE SOFTWARE I', 4, 1, 1, 0, 2, 0, 6),
('ICC247', 'REDES DE DATOS I', 4, 1, 1, 0, 2, 0, 6),
('ICC248', 'BASE DE DATOS', 4, 1, 1, 0, 2, 0, 6),
('ICC249', 'MODELAMIENTO Y SIMULACIÃ“N', 4, 1, 1, 0, 2, 0, 6),
('ICC252', 'EVALUACIÃ“N Y ADMINISTRACIÃ“N DE PROYECTOS', 4, 1, 1, 2, 0, 0, 6),
('ICC253', 'TECNOLOGÃAS DE SISTEMAS DE INFORMACIÃ“N', 4, 1, 1, 0, 2, 0, 6),
('ICC254', 'SISTEMAS DE INFORMACIÃ“N DE GESTIÃ“N', 4, 1, 1, 2, 0, 0, 6),
('ICC255', 'ARQUITECTURA DE SISTEMAS', 4, 1, 1, 2, 2, 0, 8),
('ICC256', 'INGENIERIA DE SOFTWARE II', 4, 1, 1, 2, 2, 0, 8),
('ICC260', 'TALLER DE TITULO I', 5, 1, 1, 0, 0, 0, 5),
('ICC261', 'TALLER DE TITULO II', 6, 1, 1, 0, 0, 0, 6),
('ICC352', 'ELECTIVO DE FORMACION PROFESIONAL III', 4, 5, 1, 0, 2, 0, 6),
('ICC353', 'ELECTIVO DE FORMACION PROFESIONAL I', 4, 5, 1, 0, 2, 0, 6),
('ICC354', 'ELECTIVO DE FORMACION PROFESIONAL II', 4, 5, 1, 0, 2, 0, 6),
('ICC360', 'ELECTIVO DE FORMACION PROFESIONAL IV', 4, 1, 1, 0, 2, 0, 6),
('ICC361', 'ELECTIVO DE FORMACION PROFESIONAL V', 4, 5, 1, 0, 2, 0, 6),
('ICC362', 'ELECTIVO DE FORMACION PROFESIONAL VI', 4, 5, 1, 0, 2, 0, 6),
('ICC363', 'ELECTIVO DE FORMACION PROFESIONAL VII', 4, 5, 1, 0, 2, 0, 6),
('ICI041', 'ADMINISTRACIÃ“N DE RECURSOS HUMANOS', 3, 1, 1, 0, 0, 0, 3),
('ICI050', 'TALLER DE HABILIDADES GERENCIALES', 3, 1, 1, 0, 0, 0, 3),
('ICI111', 'INTRODUCCION A LA INGENIERIA', 2, 1, 1, 0, 0, 0, 2),
('ICI135', 'TEORIA DE SISTEMAS', 4, 1, 1, 2, 0, 0, 6),
('ICI245', 'INGENIERIA ECONOMICA', 4, 1, 1, 2, 0, 0, 6),
('ICI248', 'ECONOMIA', 4, 1, 1, 2, 0, 0, 6),
('ICI249', 'CONTABILIDAD Y FINANZAS', 4, 1, 1, 2, 0, 0, 6),
('IEC119', 'LENGUAJE DE PROGRAMACION', 4, 1, 1, 2, 0, 0, 6),
('IEC122', 'MODELAMIENTO DE DATOS', 4, 1, 1, 2, 0, 0, 6),
('IEC130', 'TRANSMISIÃ“N DE DATOS', 4, 1, 1, 2, 0, 0, 6),
('IEC210', 'SISTEMA DE INFORMACIÃ“N I', 4, 1, 1, 0, 0, 0, 4),
('IEC211', 'SISTEMA DE INFORMACIÃ“N II', 4, 1, 1, 2, 0, 0, 6),
('IEC220', 'BASE DE DATOS', 4, 1, 1, 2, 0, 0, 6),
('IEC230', 'INGENIERÃA DE REDES I', 4, 1, 1, 2, 0, 0, 6),
('IEC301', 'SISTEMA DE GESTIÃ“N TECNOLÃ“GICA', 4, 1, 1, 0, 0, 0, 4),
('IEC302', 'PROYECTO DE TÃTULO', 4, 1, 1, 0, 0, 0, 4),
('IEC320', 'TALLER DE DESARROLLO DE SOFTWARE I', 4, 1, 1, 0, 0, 0, 4),
('IEC325', 'TALLER DE DESARROLLO DE SOFTWARE II', 4, 1, 1, 0, 0, 0, 4),
('IEC330', 'INGENIERÃA DE REDES II', 4, 1, 1, 2, 0, 0, 6),
('IEG122', 'BASE DE DATOS', 4, 1, 1, 2, 0, 0, 6),
('IEG191', 'PLANIFICACIÃ“N ESTRATÃ‰GICA', 4, 1, 1, 0, 0, 0, 4),
('IEG192', 'ADMINISTRACIÃ“N DE LA PRODUCCIÃ“N', 4, 1, 1, 0, 0, 0, 4),
('IEG210', 'SISTEMAS DE INFORMACIÃ“N', 4, 1, 1, 0, 0, 0, 4),
('IEG230', 'INTRODUCCIÃ“N A LAS REDES', 4, 1, 1, 2, 0, 0, 6),
('IEG270', 'MICROECONOMÃA', 4, 1, 1, 2, 0, 0, 6),
('IEG271', 'MACROECONOMÃA', 4, 1, 1, 2, 0, 0, 6),
('IEG281', 'COSTOS Y PRESUPUESTOS', 4, 1, 1, 2, 0, 0, 6),
('IEG300', 'PROYECTO DE TÃTULO', 4, 1, 1, 0, 0, 0, 4),
('IET001', 'ELEMENTOS DE COMPUTACIÃ“N', 4, 1, 1, 2, 2, 0, 8),
('IET020', 'METODOLOGÃA DE PROGRAMACIÃ“N', 4, 1, 1, 2, 2, 0, 8),
('IET030', 'ORGANIZAC. DE COMPUTADORES', 4, 1, 1, 2, 0, 0, 6),
('IET090', 'INTRODUCCIÃ“N A LA ADMINISTRACIÃ“N', 4, 1, 1, 2, 0, 0, 6),
('IET091', 'ADMINISTRACIÃ“N DE RRHH', 4, 1, 1, 0, 0, 0, 4),
('IET100', 'ELECTIVO F. PROFESIONAL I', 4, 5, 1, 0, 0, 0, 4),
('IET101', 'ELECTIVO F. PROFESIONAL II', 4, 5, 1, 0, 0, 0, 4),
('IET102', 'ELECTIVO DE F. PROFESIONAL III', 4, 5, 1, 0, 0, 0, 4),
('IET103', 'ELECTIVO F. PROFESIONAL IV', 4, 1, 1, 0, 0, 0, 4),
('IET104', 'ELECTIVO DE F. PROFESIONAL V', 4, 5, 1, 0, 0, 0, 4),
('IET105', 'ELECTIVO F. PROFESIONAL VI', 4, 5, 1, 0, 0, 0, 4),
('IET106', 'ELECTIVO FORM. PROFESIONAL VII', 4, 5, 1, 0, 0, 0, 4),
('IET110', 'SISTEMAS OPERATIVOS', 4, 1, 1, 2, 0, 0, 6),
('IET121', 'ESTRUCTURAS DE DATOS', 4, 1, 1, 2, 2, 0, 8),
('IET140', 'INVESTIGACIÃ“N OPERATIVA', 4, 1, 1, 2, 0, 0, 6),
('IET170', 'ECONOMÃA', 4, 1, 1, 2, 0, 0, 6),
('IET180', 'CONTABILIDAD', 4, 1, 1, 2, 0, 0, 6),
('IET181', 'FINANZAS', 4, 1, 1, 2, 0, 0, 6),
('IET190', 'DESARROLLO ORGANIZACIONAL', 4, 1, 1, 0, 0, 0, 4),
('IET193', 'MERCADOS', 4, 1, 1, 0, 0, 0, 4),
('IET221', 'INGENIERÃA DE SOFTWARE', 4, 1, 1, 0, 0, 0, 4),
('IET300', 'PREP. Y EVALUACIÃ“N DE PROYECTOS', 4, 1, 1, 2, 0, 0, 6),
('IET310', 'AUDITORIA COMPUTACIONAL', 4, 1, 1, 0, 0, 0, 4),
('IND2102', 'COSTOS Y PRESUPUESTOS', 4, 1, 1, 0, 0, 0, 4),
('IND2103', 'INGENIERÃA ECONOMICA', 4, 1, 1, 2, 0, 0, 6),
('IND2104', 'FORMULACIÃ“N Y EVALUACIÃ“N DE PROYECTOS', 4, 1, 1, 0, 2, 0, 6),
('INF1201', 'PROGRAMACIÃ“N', 4, 1, 1, 0, 2, 0, 6),
('INF1203', 'SISTEMAS OPERATIVOS', 0, 1, 1, 0, 0, 4, 4),
('ING119', 'INGLÃ‰S I', 0, 3, 1, 0, 0, 6, 6),
('ING129', 'INGLÃ‰S II', 0, 3, 1, 0, 0, 6, 6),
('ING239', 'INGLÃ‰S III', 0, 3, 1, 0, 0, 6, 6),
('ING249', 'INGLÃ‰S IV', 0, 3, 1, 0, 0, 6, 6),
('ITC1401', 'INTRODUCCIÃ“N A LOS SISTEMAS DE TELECOMUNICACIONES', 4, 1, 1, 0, 0, 2, 6),
('ITC1601', 'ELECTRONICA', 0, 1, 1, 0, 0, 4, 4),
('ITC1701', 'REDES DE COMPUTADORES', 0, 1, 1, 0, 0, 4, 4),
('ITC2401', 'SEÃ‘ALES Y SISTEMAS', 4, 1, 1, 0, 2, 0, 6),
('ITC2402', 'COMUNICACIONES DIGITALES', 0, 1, 1, 0, 0, 4, 4),
('ITC2403', 'SISTEMAS DE COMUNICACIONES', 4, 1, 1, 0, 2, 0, 6),
('ITC2404', 'REDES DE TELECOMUNICACIONES', 4, 1, 1, 0, 2, 0, 6),
('ITC2405', 'TOPICOS DE ESPECIALIDAD EN TELECOMUNICACIONES', 0, 5, 1, 0, 0, 4, 4),
('ITC2601', 'SISTEMAS DE CONTROL', 0, 1, 1, 0, 0, 4, 4),
('ITC2702', 'REDES DE DATOS', 0, 1, 1, 0, 0, 4, 4),
('ITC2704', 'COMUNICACIONES OPTICAS', 0, 1, 1, 0, 0, 4, 4),
('ITC2705', 'COMUNICACIONES INALAMBRICAS', 0, 1, 1, 0, 0, 4, 4),
('ITC2706', 'TOPICOS DE ESPECIALIDAD EN REDES', 0, 5, 1, 0, 0, 4, 4),
('ITC2802', 'INGENIERIA DE PROYECTOS', 6, 1, 1, 0, 0, 0, 6),
('ITC2803', 'PROYECTO DE TITULO', 6, 1, 1, 0, 0, 0, 6),
('ITC2901', 'FORMACIÃ“N PROFESIONAL COMPLEMENTARIA I', 0, 5, 1, 0, 0, 3, 3),
('ITC2902', 'FORMACIÃ“N PROFESIONAL COMPLEMENTARIA II', 0, 5, 1, 0, 0, 3, 3),
('QUI070', 'QUIMICA Y AMBIENTE', 4, 7, 1, 2, 0, 0, 6),
('QUI104', 'QUIMICA', 4, 7, 1, 2, 0, 0, 6),
('QUI105', 'LABORATORIO DE QUIMICA', 0, 7, 1, 0, 2, 0, 2);

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
-- Volcar la base de datos para la tabla `ramos_impartidos`
--


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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Volcar la base de datos para la tabla `ramo_tipo`
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
-- Estructura de tabla para la tabla `seccion`
--

CREATE TABLE IF NOT EXISTS `seccion` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id de la sección.',
  `Numero_Seccion` int(11) NOT NULL COMMENT 'Número de la sección.',
  `NRC` int(11) NOT NULL COMMENT 'Código identificador de cada sección.',
  `Codigo_Ramo` varchar(6) NOT NULL COMMENT 'Código del ramo al cual pertenece la sección.',
  `Codigo_Carrera` varchar(9) NOT NULL COMMENT 'Código de la carrera a la cual le pertenece esta sección.',
  `Codigo_Semestre` int(11) NOT NULL COMMENT 'Semestre al que pertenece la sección.',
  `Regimen` varchar(1) NOT NULL COMMENT 'D = Diurno, V = Vespertino.',
  `Vacantes` int(11) NOT NULL COMMENT 'Vacantes de la sección.',
  `Vacantes_utilizadas` int(11) NOT NULL COMMENT 'Cantidad de vacantes utilizadas por el jefe de carrera.',
  PRIMARY KEY (`Id`),
  KEY `Codigo_Ramo` (`Codigo_Ramo`),
  KEY `Numero_Seccion` (`Numero_Seccion`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

--
-- Volcar la base de datos para la tabla `seccion`
--


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
-- Volcar la base de datos para la tabla `semestre`
--

INSERT INTO `semestre` (`Codigo_Semestre`, `Numero`, `Anho`, `Fecha_Inicio`, `Fecha_Termino`) VALUES
(201220, 2, 2012, '2012-05-14 00:00:00', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud`
--

CREATE TABLE IF NOT EXISTS `solicitud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Codigo_Ramo` varchar(6) NOT NULL COMMENT 'Código del ramo pedido.',
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcar la base de datos para la tabla `solicitud`
--


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
-- Volcar la base de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`Id`, `Tipo`) VALUES
(1, 'Jefe de carrera'),
(2, 'Administrador'),
(3, 'Jefe de carrera + administrador'),
(4, 'Usuario departamento');

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
-- Volcar la base de datos para la tabla `trimestre`
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
-- Volcar la base de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Nombre_Usuario`, `RUT`, `Nombre`, `Password`, `Id_Tipo`) VALUES
('admin', '164827607', 'Administrador', '607c23cfed39259fc0e8ed8636d9bfe5', 2),
('admin2', '173184379', 'Cristian Flores', 'e10adc3949ba59abbe56e057f20f883e', 2),
('carolina.toro', '15317567-5', 'Carolina Toro Mendoza', '6f24088082242e34c534c7fcc307ce2a', 1),
('depto', '164827607', 'Departamento', '36f17c3939ac3e7b2fc9396fa8e953ea', 4),
('miguel.gutierrez', '16102960-2', 'Miguel Gutierrez Gaitan', 'e10adc3949ba59abbe56e057f20f883e', 1),
('opinto', '8542558-9', 'Oscar Pinto G.', '040b7cf4a55014e185813e0644502ea9', 3);
