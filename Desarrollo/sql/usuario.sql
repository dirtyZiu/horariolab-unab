-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 14-05-2012 a las 16:18:08
-- Versión del servidor: 5.5.8
-- Versión de PHP: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: 'hsc'
--

--
-- Volcar la base de datos para la tabla 'usuario'
--

INSERT INTO usuario (Nombre_Usuario, RUT, Nombre, `Password`, Id_Tipo) VALUES
('carolina.toro', '15317567-5', 'Carolina Toro Mendoza', '6f24088082242e34c534c7fcc307ce2a', 1),
('depto', '164827607', 'Departamento', '040b7cf4a55014e185813e0644502ea9', 4),
('miguel.gutierrez', '16102960-2', 'Miguel Gutierrez Gaitan', 'e10adc3949ba59abbe56e057f20f883e', 1),
('opinto', '8542558-9', 'Oscar Pinto G.', '040b7cf4a55014e185813e0644502ea9', 3);
