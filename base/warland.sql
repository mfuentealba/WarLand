-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-10-2015 a las 04:55:26
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `warland`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE IF NOT EXISTS `compra` (
`id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha_inicio_Trans` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `monto` int(11) NOT NULL,
  `fecha_confirmacion_trans` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `combo_seleccion` varchar(10) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `compra`
--

INSERT INTO `compra` (`id`, `usuario_id`, `fecha_inicio_Trans`, `estado`, `monto`, `fecha_confirmacion_trans`, `combo_seleccion`) VALUES
(1, 1, '000', 'V', 2000, '0000', '1111'),
(2, 1, '000', 'V', 2000, '0000', '1111'),
(3, 1, '000', 'V', 2000, '0000', '1111'),
(4, 1, '000', 'V', 2000, '0000', '1111'),
(5, 1, '000', 'V', 2000, '0000', '1111'),
(6, 1, '000', 'V', 2000, '0000', '1111');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `error`
--

CREATE TABLE IF NOT EXISTS `error` (
  `err` varchar(500) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fen`
--

CREATE TABLE IF NOT EXISTS `fen` (
  `fen` varchar(70) COLLATE utf8_spanish2_ci NOT NULL,
  `resultado` varchar(6) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'NO',
`id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fen_hist`
--

CREATE TABLE IF NOT EXISTS `fen_hist` (
  `fen_ant` varchar(70) COLLATE utf8_spanish2_ci NOT NULL,
  `fen_act` varchar(70) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mercado`
--

CREATE TABLE IF NOT EXISTS `mercado` (
`id` int(11) NOT NULL,
  `creadorId` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` int(11) NOT NULL,
  `tipo` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `fechaHora` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `moneda` varchar(20) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `mercado`
--

INSERT INTO `mercado` (`id`, `creadorId`, `cantidad`, `precio`, `tipo`, `estado`, `fechaHora`, `moneda`) VALUES
(1, 1, 10, 10, 'V', 'V', '10/8/2015', 'Normal'),
(2, 1, 10, 10, 'V', 'V', '10/8/2015', 'Normal'),
(3, 2, 10, 10, 'V', 'V', '10/8/2015', 'Normal'),
(4, 2, 10, 10, 'V', 'V', '10/8/2015', 'Normal'),
(5, 2, 10, 10, 'V', 'V', '10/8/2015', 'Normal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movida`
--

CREATE TABLE IF NOT EXISTS `movida` (
`id` int(11) NOT NULL,
  `id_partida` int(11) NOT NULL,
  `num_movida` int(11) NOT NULL,
  `color_movida` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `movida` varchar(15) COLLATE utf8_spanish2_ci NOT NULL,
  `fen` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `movida`
--

INSERT INTO `movida` (`id`, `id_partida`, `num_movida`, `color_movida`, `movida`, `fen`) VALUES
(1, 1, 1, 'B', 'd2--d4', 'rnbqkbnr/pppppppp/8/8/3P4/8/PPP1PPPP/RNBQKBNR/ w QKqk d3 0 1'),
(2, 1, 1, 'N', 'e7--e5', 'rnbqkbnr/pppp1ppp/8/4p3/3P4/8/PPP1PPPP/RNBQKBNR/ b QKqk e6 0 1'),
(3, 1, 2, 'B', 'd4--e5', 'rnbqkbnr/pppp1ppp/8/4P3/8/8/PPP1PPPP/RNBQKBNR/ w QKqk - 0 2'),
(4, 1, 2, 'N', 'b8--c6', 'r1bqkbnr/pppp1ppp/2n5/4P3/8/8/PPP1PPPP/RNBQKBNR/ b QKqk - 1 2'),
(5, 1, 3, 'B', 'b1--c3', 'r1bqkbnr/pppp1ppp/2n5/4P3/8/2N5/PPP1PPPP/R1BQKBNR/ w QKqk - 2 3'),
(6, 1, 3, 'N', 'c6--e5', 'r1bqkbnr/pppp1ppp/8/4n3/8/2N5/PPP1PPPP/R1BQKBNR/ b QKqk - 0 3'),
(7, 1, 4, 'B', 'c1--f4', 'r1bqkbnr/pppp1ppp/8/4n3/5B2/2N5/PPP1PPPP/R2QKBNR/ w QKqk - 1 4'),
(8, 1, 4, 'N', 'd7--d6', 'r1bqkbnr/ppp2ppp/3p4/4n3/5B2/2N5/PPP1PPPP/R2QKBNR/ b QKqk - 0 4'),
(9, 1, 5, 'B', 'g1--f3', 'r1bqkbnr/ppp2ppp/3p4/4n3/5B2/2N2N2/PPP1PPPP/R2QKB1R/ w QKqk - 1 5'),
(10, 1, 5, 'N', 'e5--f3+', 'r1bqkbnr/ppp2ppp/3p4/8/5B2/2N2n2/PPP1PPPP/R2QKB1R/ b QKqk - 0 5'),
(11, 1, 6, 'B', 'e2--f3', 'r1bqkbnr/ppp2ppp/3p4/8/5B2/2N2P2/PPP2PPP/R2QKB1R/ w QKqk - 0 6'),
(12, 1, 6, 'N', 'g8--f6', 'r1bqkb1r/ppp2ppp/3p1n2/8/5B2/2N2P2/PPP2PPP/R2QKB1R/ b QKqk - 1 6'),
(13, 1, 7, 'B', 'f1--b5+', 'r1bqkb1r/ppp2ppp/3p1n2/1B6/5B2/2N2P2/PPP2PPP/R2QK2R/ w QKqk - 2 7'),
(14, 1, 7, 'N', 'c7--c6', 'r1bqkb1r/pp3ppp/2pp1n2/1B6/5B2/2N2P2/PPP2PPP/R2QK2R/ b QKqk - 0 7'),
(15, 1, 8, 'B', 'e1--g1', 'r1bqkb1r/pp3ppp/2pp1n2/1B6/5B2/2N2P2/PPP2PPP/R2Q1RK1/ w qk - 1 8'),
(16, 1, 8, 'N', 'f8--e7', 'r1bqk2r/pp2bppp/2pp1n2/1B6/5B2/2N2P2/PPP2PPP/R2Q1RK1/ b qk - 2 8'),
(17, 1, 9, 'B', 'a1--c1', 'r1bqk2r/pp2bppp/2pp1n2/1B6/5B2/2N2P2/PPP2PPP/2RQ1RK1/ w qk - 3 9'),
(18, 1, 9, 'N', 'e8--g8', 'r1bq1rk1/pp2bppp/2pp1n2/1B6/5B2/2N2P2/PPP2PPP/2RQ1RK1/ b - - 4 9'),
(19, 1, 10, 'B', 'd1--d6', 'r1bq1rk1/pp2bppp/2pQ1n2/1B6/5B2/2N2P2/PPP2PPP/2R2RK1/ w - - 0 10'),
(20, 1, 10, 'N', 'f8--e8', 'r1bqr1k1/pp2bppp/2pQ1n2/1B6/5B2/2N2P2/PPP2PPP/2R2RK1/ b - - 1 10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida`
--

CREATE TABLE IF NOT EXISTS `partida` (
`id` int(11) NOT NULL,
  `idPlayer1` int(11) NOT NULL,
  `idPlayer2` int(11) DEFAULT NULL,
  `color_p1` varchar(1) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` varchar(2) COLLATE utf8_spanish2_ci NOT NULL DEFAULT 'VI',
  `resultado` varchar(1) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `detalle_fin` varchar(30) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `p1_conn` int(11) DEFAULT NULL,
  `p2_conn` int(11) DEFAULT NULL,
  `duracion` varchar(10) COLLATE utf8_spanish2_ci NOT NULL DEFAULT '5:00',
  `apuesta` int(11) NOT NULL DEFAULT '0',
  `minELO` int(11) NOT NULL,
  `maxELO` int(11) NOT NULL,
  `torneo_id` int(11) DEFAULT NULL,
  `tipo` varchar(15) COLLATE utf8_spanish2_ci NOT NULL DEFAULT '',
  `puntosJ1` varchar(5) COLLATE utf8_spanish2_ci NOT NULL,
  `puntosJ2` varchar(5) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ganancia` int(11) NOT NULL,
  `Player1` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `Player2` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `qdp` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `partida`
--

INSERT INTO `partida` (`id`, `idPlayer1`, `idPlayer2`, `color_p1`, `estado`, `resultado`, `detalle_fin`, `p1_conn`, `p2_conn`, `duracion`, `apuesta`, `minELO`, `maxELO`, `torneo_id`, `tipo`, `puntosJ1`, `puntosJ2`, `ganancia`, `Player1`, `Player2`, `qdp`) VALUES
(1, 2, 1, 'N', 'S', 'V', 'V', 1, 0, '20:00', 0, 0, 9999, NULL, 'normal', '1524', '1251', 0, 'p2', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `player`
--

CREATE TABLE IF NOT EXISTS `player` (
`id` int(11) NOT NULL,
  `user` varchar(25) COLLATE utf8_spanish2_ci NOT NULL,
  `pass` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `puntosBlitz` int(11) NOT NULL DEFAULT '1400',
  `triunfos` int(11) NOT NULL DEFAULT '0',
  `derrotas` int(11) NOT NULL DEFAULT '0',
  `tablas` int(11) NOT NULL DEFAULT '0',
  `saldo` int(11) NOT NULL DEFAULT '0',
  `puntosBala` int(11) NOT NULL DEFAULT '1400',
  `puntosNormal` int(11) NOT NULL DEFAULT '1400',
  `monedaRoja` int(11) DEFAULT '0',
  `monedaVerde` int(11) DEFAULT '0',
  `monedaAzul` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `player`
--

INSERT INTO `player` (`id`, `user`, `pass`, `puntosBlitz`, `triunfos`, `derrotas`, `tablas`, `saldo`, `puntosBala`, `puntosNormal`, `monedaRoja`, `monedaVerde`, `monedaAzul`) VALUES
(1, 'p1', '0', 1304, 2, 13, 0, 9650, 1375, 1251, 0, 0, 0),
(2, 'p2', '0', 1371, 13, 2, 0, 9650, 1395, 1524, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesion`
--

CREATE TABLE IF NOT EXISTS `sesion` (
`id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha_conexion` datetime NOT NULL,
  `fecha_desconexion` datetime DEFAULT NULL,
  `estado` varchar(1) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=394 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `sesion`
--

INSERT INTO `sesion` (`id`, `usuario_id`, `fecha_conexion`, `fecha_desconexion`, `estado`) VALUES
(1, 1, '2015-09-04 01:16:37', NULL, 'E'),
(2, 2, '2015-09-04 01:16:38', NULL, 'E'),
(3, 1, '2015-09-04 01:17:26', NULL, 'E'),
(4, 1, '2015-09-04 01:19:09', NULL, 'E'),
(5, 1, '2015-09-04 01:21:58', NULL, 'E'),
(6, 2, '2015-09-04 01:21:59', NULL, 'E'),
(7, 1, '2015-09-04 01:22:44', NULL, 'E'),
(8, 1, '2015-09-04 01:36:47', NULL, 'E'),
(9, 2, '2015-09-04 01:36:48', NULL, 'E'),
(10, 1, '2015-09-04 01:37:25', NULL, 'E'),
(11, 2, '2015-09-04 01:37:26', NULL, 'E'),
(12, 1, '2015-09-04 01:38:08', NULL, 'E'),
(13, 1, '2015-09-04 01:45:11', NULL, 'E'),
(14, 2, '2015-09-04 01:45:11', NULL, 'E'),
(15, 1, '2015-09-04 01:45:48', NULL, 'E'),
(16, 1, '2015-09-04 02:04:53', NULL, 'E'),
(17, 2, '2015-09-04 02:04:54', NULL, 'E'),
(18, 1, '2015-09-04 02:05:25', NULL, 'E'),
(19, 1, '2015-09-04 02:11:21', NULL, 'E'),
(20, 2, '2015-09-04 02:11:22', NULL, 'E'),
(21, 1, '2015-09-04 02:11:51', NULL, 'E'),
(22, 1, '2015-09-04 02:12:46', NULL, 'E'),
(23, 2, '2015-09-04 02:12:48', NULL, 'E'),
(24, 1, '2015-09-04 02:14:29', NULL, 'E'),
(25, 1, '2015-09-04 02:19:32', NULL, 'E'),
(26, 2, '2015-09-04 02:19:33', NULL, 'E'),
(27, 1, '2015-09-04 02:21:56', NULL, 'E'),
(28, 1, '2015-09-04 02:23:36', NULL, 'E'),
(29, 2, '2015-09-04 02:23:36', NULL, 'E'),
(30, 1, '2015-09-04 02:26:25', NULL, 'E'),
(31, 1, '2015-09-04 02:32:53', NULL, 'E'),
(32, 2, '2015-09-04 02:32:54', NULL, 'E'),
(33, 2, '2015-09-04 02:34:07', NULL, 'E'),
(34, 1, '2015-09-04 02:34:09', NULL, 'E'),
(35, 1, '2015-09-04 02:35:42', NULL, 'E'),
(36, 1, '2015-09-04 02:37:15', NULL, 'E'),
(37, 1, '2015-09-04 02:37:35', NULL, 'E'),
(38, 1, '2015-09-04 23:31:25', NULL, 'E'),
(39, 2, '2015-09-04 23:31:29', NULL, 'E'),
(40, 1, '2015-09-04 23:33:47', NULL, 'E'),
(41, 1, '2015-09-04 23:34:23', NULL, 'E'),
(42, 1, '2015-09-05 10:57:46', NULL, 'E'),
(43, 2, '2015-09-05 10:58:01', NULL, 'E'),
(44, 2, '2015-09-05 11:00:42', NULL, 'E'),
(45, 1, '2015-09-05 11:01:00', NULL, 'E'),
(46, 1, '2015-09-05 11:01:47', NULL, 'E'),
(47, 2, '2015-09-05 11:01:53', NULL, 'E'),
(48, 1, '2015-09-05 11:05:17', NULL, 'E'),
(49, 2, '2015-09-05 11:05:19', NULL, 'E'),
(50, 1, '2015-09-05 11:05:58', NULL, 'E'),
(51, 1, '2015-09-05 11:06:14', NULL, 'E'),
(52, 1, '2015-09-05 11:07:15', NULL, 'E'),
(53, 1, '2015-09-05 11:27:23', NULL, 'E'),
(54, 2, '2015-09-05 11:27:25', NULL, 'E'),
(55, 1, '2015-09-05 11:27:55', NULL, 'E'),
(56, 1, '2015-09-05 11:28:07', NULL, 'E'),
(57, 1, '2015-09-05 11:30:55', NULL, 'E'),
(58, 2, '2015-09-05 11:30:57', NULL, 'E'),
(59, 1, '2015-09-05 11:31:35', NULL, 'E'),
(60, 2, '2015-09-05 11:31:36', NULL, 'E'),
(61, 2, '2015-09-05 11:34:45', NULL, 'E'),
(62, 1, '2015-09-05 21:52:13', NULL, 'E'),
(63, 2, '2015-09-05 21:52:14', NULL, 'E'),
(64, 1, '2015-09-05 21:52:57', NULL, 'E'),
(65, 1, '2015-09-05 21:53:28', NULL, 'E'),
(66, 2, '2015-09-05 21:53:48', NULL, 'E'),
(67, 1, '2015-09-06 15:46:03', NULL, 'E'),
(68, 2, '2015-09-06 15:46:05', NULL, 'E'),
(69, 1, '2015-09-06 15:52:24', NULL, 'E'),
(70, 2, '2015-09-06 15:52:26', NULL, 'E'),
(71, 1, '2015-09-06 15:52:55', NULL, 'E'),
(72, 2, '2015-09-06 15:52:57', NULL, 'E'),
(73, 1, '2015-09-06 15:55:11', NULL, 'E'),
(74, 2, '2015-09-06 15:55:12', NULL, 'E'),
(75, 2, '2015-09-06 23:11:23', NULL, 'E'),
(76, 1, '2015-09-13 23:59:04', NULL, 'E'),
(77, 1, '2015-09-16 01:28:23', NULL, 'E'),
(78, 1, '2015-09-16 01:29:06', NULL, 'E'),
(79, 1, '2015-09-16 01:30:14', NULL, 'E'),
(80, 1, '2015-09-16 01:32:47', NULL, 'E'),
(81, 2, '2015-09-16 01:34:50', NULL, 'E'),
(82, 1, '2015-09-21 13:39:26', NULL, 'E'),
(83, 2, '2015-09-21 13:39:30', NULL, 'E'),
(84, 1, '2015-09-21 13:50:00', NULL, 'E'),
(85, 2, '2015-09-21 13:50:03', NULL, 'E'),
(86, 1, '2015-09-21 14:21:53', NULL, 'E'),
(87, 2, '2015-09-21 14:21:57', NULL, 'E'),
(88, 1, '2015-09-21 14:29:11', NULL, 'E'),
(89, 2, '2015-09-21 14:29:13', NULL, 'E'),
(90, 1, '2015-09-21 14:44:20', NULL, 'E'),
(91, 2, '2015-09-21 14:44:22', NULL, 'E'),
(92, 1, '2015-09-21 14:45:30', NULL, 'E'),
(93, 2, '2015-09-21 14:45:33', NULL, 'E'),
(94, 1, '2015-09-21 15:22:44', NULL, 'E'),
(95, 2, '2015-09-21 15:22:47', NULL, 'E'),
(96, 1, '2015-09-21 15:30:50', NULL, 'E'),
(97, 2, '2015-09-21 15:30:51', NULL, 'E'),
(98, 2, '2015-09-21 15:34:34', NULL, 'E'),
(99, 1, '2015-09-21 15:34:38', NULL, 'E'),
(100, 1, '2015-09-21 16:52:31', NULL, 'E'),
(101, 2, '2015-09-21 16:56:08', NULL, 'E'),
(102, 1, '2015-09-21 16:56:13', NULL, 'E'),
(103, 1, '2015-09-21 19:37:13', NULL, 'E'),
(104, 2, '2015-09-21 19:37:22', NULL, 'E'),
(105, 1, '2015-09-21 20:03:15', NULL, 'E'),
(106, 2, '2015-09-21 20:03:16', NULL, 'E'),
(107, 1, '2015-09-21 20:05:39', NULL, 'E'),
(108, 2, '2015-09-21 20:05:41', NULL, 'E'),
(109, 1, '2015-09-21 20:29:52', NULL, 'E'),
(110, 2, '2015-09-21 20:30:13', NULL, 'E'),
(111, 1, '2015-09-21 22:14:20', NULL, 'E'),
(112, 2, '2015-09-21 22:14:21', NULL, 'E'),
(113, 1, '2015-09-21 22:45:54', NULL, 'E'),
(114, 2, '2015-09-21 22:45:55', NULL, 'E'),
(115, 1, '2015-09-21 23:00:26', NULL, 'E'),
(116, 2, '2015-09-21 23:00:26', NULL, 'E'),
(117, 1, '2015-09-21 23:02:49', NULL, 'E'),
(118, 2, '2015-09-21 23:02:50', NULL, 'E'),
(119, 1, '2015-09-21 23:07:05', NULL, 'E'),
(120, 2, '2015-09-21 23:07:07', NULL, 'E'),
(121, 1, '2015-09-21 23:26:18', NULL, 'E'),
(122, 2, '2015-09-21 23:26:20', NULL, 'E'),
(123, 1, '2015-09-22 00:00:00', NULL, 'E'),
(124, 2, '2015-09-22 00:00:01', NULL, 'E'),
(125, 1, '2015-09-22 01:43:29', NULL, 'E'),
(126, 2, '2015-09-22 01:43:30', NULL, 'E'),
(127, 1, '2015-09-22 01:45:03', NULL, 'E'),
(128, 2, '2015-09-22 01:45:04', NULL, 'E'),
(129, 1, '2015-09-22 01:46:32', NULL, 'E'),
(130, 2, '2015-09-22 01:46:34', NULL, 'E'),
(131, 1, '2015-09-22 01:49:03', NULL, 'E'),
(132, 2, '2015-09-22 01:49:06', NULL, 'E'),
(133, 1, '2015-09-23 19:33:53', NULL, 'E'),
(134, 2, '2015-09-23 19:33:56', NULL, 'E'),
(135, 2, '2015-09-23 20:30:01', NULL, 'E'),
(136, 1, '2015-09-23 20:30:09', NULL, 'E'),
(137, 1, '2015-09-23 20:33:56', NULL, 'E'),
(138, 2, '2015-09-23 20:34:01', NULL, 'E'),
(139, 2, '2015-09-23 20:35:12', NULL, 'E'),
(140, 1, '2015-09-23 20:35:16', NULL, 'E'),
(141, 2, '2015-09-23 20:38:18', NULL, 'E'),
(142, 1, '2015-09-23 20:38:27', NULL, 'E'),
(143, 1, '2015-09-23 20:41:37', NULL, 'E'),
(144, 2, '2015-09-23 20:41:45', NULL, 'E'),
(145, 1, '2015-09-23 21:30:55', NULL, 'E'),
(146, 2, '2015-09-23 21:30:57', NULL, 'E'),
(147, 2, '2015-09-23 21:33:02', NULL, 'E'),
(148, 1, '2015-09-23 21:33:03', NULL, 'E'),
(149, 1, '2015-09-23 21:39:59', NULL, 'E'),
(150, 2, '2015-09-23 21:40:00', NULL, 'E'),
(151, 1, '2015-09-23 21:43:26', NULL, 'E'),
(152, 2, '2015-09-23 21:43:28', NULL, 'E'),
(153, 2, '2015-09-23 21:44:36', NULL, 'E'),
(154, 1, '2015-09-23 21:44:36', NULL, 'E'),
(155, 1, '2015-09-23 21:46:59', NULL, 'E'),
(156, 2, '2015-09-23 21:47:00', NULL, 'E'),
(157, 1, '2015-09-23 22:00:44', NULL, 'E'),
(158, 2, '2015-09-23 22:00:45', NULL, 'E'),
(159, 1, '2015-09-23 23:32:26', NULL, 'E'),
(160, 2, '2015-09-23 23:32:27', NULL, 'E'),
(161, 1, '2015-09-24 00:10:33', NULL, 'E'),
(162, 2, '2015-09-24 00:10:34', NULL, 'E'),
(163, 1, '2015-09-24 01:07:23', NULL, 'E'),
(164, 2, '2015-09-24 01:07:25', NULL, 'E'),
(165, 1, '2015-09-24 01:31:18', NULL, 'E'),
(166, 2, '2015-09-24 01:31:19', NULL, 'E'),
(167, 1, '2015-09-24 01:36:19', NULL, 'E'),
(168, 2, '2015-09-24 01:36:21', NULL, 'E'),
(169, 1, '2015-09-24 02:31:22', NULL, 'E'),
(170, 2, '2015-09-24 02:31:24', NULL, 'E'),
(171, 1, '2015-09-24 02:43:54', NULL, 'E'),
(172, 2, '2015-09-24 02:43:56', NULL, 'E'),
(173, 1, '2015-10-04 20:35:43', NULL, 'E'),
(174, 2, '2015-10-04 20:35:45', NULL, 'E'),
(175, 1, '2015-10-04 20:41:26', NULL, 'E'),
(176, 2, '2015-10-04 20:41:28', NULL, 'E'),
(177, 1, '2015-10-04 20:45:16', NULL, 'E'),
(178, 2, '2015-10-04 20:45:18', NULL, 'E'),
(179, 1, '2015-10-04 21:24:08', NULL, 'E'),
(180, 2, '2015-10-04 21:24:10', NULL, 'E'),
(181, 1, '2015-10-05 21:56:11', NULL, 'E'),
(182, 2, '2015-10-05 21:56:13', NULL, 'E'),
(183, 1, '2015-10-07 21:46:37', NULL, 'E'),
(184, 2, '2015-10-07 21:53:32', NULL, 'E'),
(185, 1, '2015-10-07 21:57:11', NULL, 'E'),
(186, 2, '2015-10-07 21:57:13', NULL, 'E'),
(187, 1, '2015-10-07 21:58:29', NULL, 'E'),
(188, 2, '2015-10-07 21:58:30', NULL, 'E'),
(189, 1, '2015-10-07 21:59:53', NULL, 'E'),
(190, 2, '2015-10-07 21:59:54', NULL, 'E'),
(191, 1, '2015-10-07 22:01:25', NULL, 'E'),
(192, 2, '2015-10-07 22:01:26', NULL, 'E'),
(193, 1, '2015-10-07 22:03:05', NULL, 'E'),
(194, 2, '2015-10-07 22:03:06', NULL, 'E'),
(195, 1, '2015-10-07 22:07:06', NULL, 'E'),
(196, 2, '2015-10-07 22:07:07', NULL, 'E'),
(197, 1, '2015-10-07 22:09:02', NULL, 'E'),
(198, 2, '2015-10-07 22:09:03', NULL, 'E'),
(199, 1, '2015-10-07 23:56:23', NULL, 'E'),
(200, 2, '2015-10-07 23:56:28', NULL, 'E'),
(201, 1, '2015-10-08 00:00:11', NULL, 'E'),
(202, 2, '2015-10-08 00:00:15', NULL, 'E'),
(203, 1, '2015-10-08 00:02:44', NULL, 'E'),
(204, 2, '2015-10-08 00:02:45', NULL, 'E'),
(205, 1, '2015-10-08 00:04:39', NULL, 'E'),
(206, 2, '2015-10-08 00:04:40', NULL, 'E'),
(207, 1, '2015-10-08 00:09:13', NULL, 'E'),
(208, 2, '2015-10-08 00:09:18', NULL, 'E'),
(209, 1, '2015-10-08 00:14:18', NULL, 'E'),
(210, 2, '2015-10-08 00:14:20', NULL, 'E'),
(211, 1, '2015-10-08 00:18:33', NULL, 'E'),
(212, 2, '2015-10-08 00:18:34', NULL, 'E'),
(213, 1, '2015-10-08 00:19:47', NULL, 'E'),
(214, 2, '2015-10-08 00:19:48', NULL, 'E'),
(215, 1, '2015-10-08 00:21:10', NULL, 'E'),
(216, 2, '2015-10-08 00:21:11', NULL, 'E'),
(217, 1, '2015-10-08 00:22:43', NULL, 'E'),
(218, 2, '2015-10-08 00:22:44', NULL, 'E'),
(219, 2, '2015-10-08 00:25:08', NULL, 'E'),
(220, 1, '2015-10-08 00:25:10', NULL, 'E'),
(221, 1, '2015-10-08 00:30:15', NULL, 'E'),
(222, 2, '2015-10-08 00:30:16', NULL, 'E'),
(223, 1, '2015-10-08 00:32:40', NULL, 'E'),
(224, 2, '2015-10-08 00:32:41', NULL, 'E'),
(225, 1, '2015-10-08 00:40:08', NULL, 'E'),
(226, 2, '2015-10-08 00:40:10', NULL, 'E'),
(227, 1, '2015-10-08 00:44:57', NULL, 'E'),
(228, 2, '2015-10-08 00:44:58', NULL, 'E'),
(229, 1, '2015-10-08 00:46:44', NULL, 'E'),
(230, 2, '2015-10-08 00:46:44', NULL, 'E'),
(231, 1, '2015-10-08 00:49:47', NULL, 'E'),
(232, 2, '2015-10-08 00:49:48', NULL, 'E'),
(233, 1, '2015-10-08 00:52:44', NULL, 'E'),
(234, 2, '2015-10-08 00:52:45', NULL, 'E'),
(235, 1, '2015-10-08 00:57:33', NULL, 'E'),
(236, 2, '2015-10-08 00:57:34', NULL, 'E'),
(237, 1, '2015-10-08 00:59:58', NULL, 'E'),
(238, 2, '2015-10-08 00:59:59', NULL, 'E'),
(239, 1, '2015-10-08 01:05:54', NULL, 'E'),
(240, 2, '2015-10-08 01:05:55', NULL, 'E'),
(241, 1, '2015-10-08 01:11:27', NULL, 'E'),
(242, 2, '2015-10-08 01:11:29', NULL, 'E'),
(243, 1, '2015-10-08 01:14:10', NULL, 'E'),
(244, 2, '2015-10-08 01:14:11', NULL, 'E'),
(245, 1, '2015-10-08 01:18:43', NULL, 'E'),
(246, 2, '2015-10-08 01:18:44', NULL, 'E'),
(247, 1, '2015-10-08 01:25:21', NULL, 'E'),
(248, 2, '2015-10-08 01:25:27', NULL, 'E'),
(249, 2, '2015-10-08 01:33:48', NULL, 'E'),
(250, 1, '2015-10-08 01:33:50', NULL, 'E'),
(251, 1, '2015-10-08 21:25:25', NULL, 'E'),
(252, 2, '2015-10-08 21:25:27', NULL, 'E'),
(253, 1, '2015-10-10 19:37:36', NULL, 'E'),
(254, 2, '2015-10-10 19:37:38', NULL, 'E'),
(255, 1, '2015-10-10 21:09:22', NULL, 'E'),
(256, 2, '2015-10-10 21:09:23', NULL, 'E'),
(257, 1, '2015-10-10 21:23:28', NULL, 'E'),
(258, 2, '2015-10-10 21:23:29', NULL, 'E'),
(259, 1, '2015-10-10 21:42:09', NULL, 'E'),
(260, 2, '2015-10-10 21:42:10', NULL, 'E'),
(261, 1, '2015-10-10 22:13:11', NULL, 'E'),
(262, 2, '2015-10-10 22:13:12', NULL, 'E'),
(263, 1, '2015-10-10 22:16:34', NULL, 'E'),
(264, 2, '2015-10-10 22:16:36', NULL, 'E'),
(265, 1, '2015-10-10 22:21:37', NULL, 'E'),
(266, 2, '2015-10-10 22:21:42', NULL, 'E'),
(267, 1, '2015-10-10 22:30:09', NULL, 'E'),
(268, 2, '2015-10-10 22:30:11', NULL, 'E'),
(269, 1, '2015-10-11 01:10:34', NULL, 'E'),
(270, 2, '2015-10-11 01:10:36', NULL, 'E'),
(271, 2, '2015-10-14 21:57:03', NULL, 'E'),
(272, 1, '2015-10-14 21:57:09', NULL, 'E'),
(273, 1, '2015-10-14 22:05:05', NULL, 'E'),
(274, 2, '2015-10-14 22:05:06', NULL, 'E'),
(275, 1, '2015-10-14 22:39:00', NULL, 'E'),
(276, 2, '2015-10-14 22:39:06', NULL, 'E'),
(277, 1, '2015-10-15 00:21:40', NULL, 'E'),
(278, 2, '2015-10-15 00:21:40', NULL, 'E'),
(279, 1, '2015-10-15 00:36:42', NULL, 'E'),
(280, 2, '2015-10-15 00:36:45', NULL, 'E'),
(281, 1, '2015-10-15 00:43:27', NULL, 'E'),
(282, 2, '2015-10-15 00:43:29', NULL, 'E'),
(283, 2, '2015-10-15 00:48:54', NULL, 'E'),
(284, 1, '2015-10-15 00:48:55', NULL, 'E'),
(285, 1, '2015-10-15 01:03:38', NULL, 'E'),
(286, 2, '2015-10-15 01:03:46', NULL, 'E'),
(287, 1, '2015-10-17 21:56:24', NULL, 'E'),
(288, 2, '2015-10-17 21:56:26', NULL, 'E'),
(289, 1, '2015-10-17 22:00:06', NULL, 'E'),
(290, 2, '2015-10-17 22:00:07', NULL, 'E'),
(291, 1, '2015-10-17 22:07:09', NULL, 'E'),
(292, 2, '2015-10-17 22:07:11', NULL, 'E'),
(293, 1, '2015-10-17 22:21:13', NULL, 'E'),
(294, 2, '2015-10-17 22:21:14', NULL, 'E'),
(295, 1, '2015-10-17 23:20:53', NULL, 'E'),
(296, 2, '2015-10-17 23:20:54', NULL, 'E'),
(297, 1, '2015-10-18 16:36:06', NULL, 'E'),
(298, 2, '2015-10-18 16:36:07', NULL, 'E'),
(299, 1, '2015-10-18 16:38:50', NULL, 'E'),
(300, 2, '2015-10-18 16:38:54', NULL, 'E'),
(301, 1, '2015-10-18 16:41:31', NULL, 'E'),
(302, 2, '2015-10-18 16:41:33', NULL, 'E'),
(303, 1, '2015-10-18 16:43:19', NULL, 'E'),
(304, 2, '2015-10-18 16:43:20', NULL, 'E'),
(305, 1, '2015-10-18 17:01:27', NULL, 'E'),
(306, 2, '2015-10-18 17:01:29', NULL, 'E'),
(307, 1, '2015-10-18 17:06:15', NULL, 'E'),
(308, 2, '2015-10-18 17:06:17', NULL, 'E'),
(309, 2, '2015-10-18 17:08:34', NULL, 'E'),
(310, 1, '2015-10-18 17:08:38', NULL, 'E'),
(311, 1, '2015-10-18 17:54:57', NULL, 'E'),
(312, 2, '2015-10-18 17:54:58', NULL, 'E'),
(313, 1, '2015-10-18 17:59:15', NULL, 'E'),
(314, 2, '2015-10-18 17:59:16', NULL, 'E'),
(315, 1, '2015-10-18 18:01:07', NULL, 'E'),
(316, 2, '2015-10-18 18:01:09', NULL, 'E'),
(317, 1, '2015-10-18 18:04:02', NULL, 'E'),
(318, 2, '2015-10-18 18:04:03', NULL, 'E'),
(319, 1, '2015-10-18 18:08:35', NULL, 'E'),
(320, 2, '2015-10-18 18:08:39', NULL, 'E'),
(321, 2, '2015-10-18 18:10:04', NULL, 'E'),
(322, 1, '2015-10-18 18:10:09', NULL, 'E'),
(323, 1, '2015-10-18 22:57:55', NULL, 'E'),
(324, 2, '2015-10-18 22:57:56', NULL, 'E'),
(325, 1, '2015-10-18 23:18:17', NULL, 'E'),
(326, 2, '2015-10-18 23:18:19', NULL, 'E'),
(327, 1, '2015-10-18 23:46:04', NULL, 'E'),
(328, 2, '2015-10-18 23:46:05', NULL, 'E'),
(329, 1, '2015-10-18 23:48:14', NULL, 'E'),
(330, 2, '2015-10-18 23:48:14', NULL, 'E'),
(331, 1, '2015-10-19 00:04:38', NULL, 'E'),
(332, 2, '2015-10-19 00:04:39', NULL, 'E'),
(333, 1, '2015-10-19 00:15:55', NULL, 'E'),
(334, 2, '2015-10-19 00:15:55', NULL, 'E'),
(335, 1, '2015-10-19 23:28:56', NULL, 'E'),
(336, 2, '2015-10-19 23:28:56', NULL, 'E'),
(337, 1, '2015-10-19 23:49:47', NULL, 'E'),
(338, 2, '2015-10-19 23:49:48', NULL, 'E'),
(339, 1, '2015-10-20 00:00:09', NULL, 'E'),
(340, 2, '2015-10-20 00:00:10', NULL, 'E'),
(341, 1, '2015-10-20 00:04:55', NULL, 'E'),
(342, 2, '2015-10-20 00:04:56', NULL, 'E'),
(343, 1, '2015-10-20 02:57:28', NULL, 'E'),
(344, 2, '2015-10-20 02:57:29', NULL, 'E'),
(345, 2, '2015-10-20 02:59:53', NULL, 'E'),
(346, 1, '2015-10-20 02:59:55', NULL, 'E'),
(347, 1, '2015-10-20 03:06:09', NULL, 'E'),
(348, 2, '2015-10-20 03:06:11', NULL, 'E'),
(349, 1, '2015-10-20 03:13:03', NULL, 'E'),
(350, 2, '2015-10-20 03:13:08', NULL, 'E'),
(351, 1, '2015-10-20 03:15:55', NULL, 'E'),
(352, 2, '2015-10-20 03:15:56', NULL, 'E'),
(353, 1, '2015-10-20 03:17:48', NULL, 'E'),
(354, 2, '2015-10-20 03:17:50', NULL, 'E'),
(355, 1, '2015-10-22 00:09:24', NULL, 'E'),
(356, 2, '2015-10-22 00:09:26', NULL, 'E'),
(357, 1, '2015-10-22 00:10:26', NULL, 'E'),
(358, 2, '2015-10-22 00:10:27', NULL, 'E'),
(359, 1, '2015-10-22 00:13:02', NULL, 'E'),
(360, 2, '2015-10-22 00:13:03', NULL, 'E'),
(361, 1, '2015-10-22 00:22:03', NULL, 'E'),
(362, 2, '2015-10-22 00:22:06', NULL, 'E'),
(363, 1, '2015-10-22 00:44:09', NULL, 'E'),
(364, 2, '2015-10-22 00:44:11', NULL, 'E'),
(365, 1, '2015-10-22 01:09:14', NULL, 'E'),
(366, 2, '2015-10-22 01:09:15', NULL, 'E'),
(367, 2, '2015-10-22 01:43:16', NULL, 'E'),
(368, 1, '2015-10-22 01:43:18', NULL, 'E'),
(369, 2, '2015-10-22 01:46:07', NULL, 'E'),
(370, 1, '2015-10-22 01:46:09', NULL, 'E'),
(371, 1, '2015-10-22 01:58:56', NULL, 'E'),
(372, 2, '2015-10-22 01:58:57', NULL, 'E'),
(373, 1, '2015-10-22 02:06:17', NULL, 'E'),
(374, 2, '2015-10-22 02:06:18', NULL, 'E'),
(375, 1, '2015-10-22 02:16:21', NULL, 'E'),
(376, 2, '2015-10-22 02:16:22', NULL, 'E'),
(377, 1, '2015-10-25 21:50:38', NULL, 'E'),
(378, 1, '2015-10-26 20:24:44', NULL, 'E'),
(379, 2, '2015-10-26 20:24:50', NULL, 'E'),
(380, 1, '2015-10-27 00:12:08', NULL, 'E'),
(381, 2, '2015-10-27 00:12:15', NULL, 'E'),
(382, 2, '2015-10-27 00:18:34', NULL, 'E'),
(383, 1, '2015-10-27 00:18:38', NULL, 'E'),
(384, 1, '2015-10-27 00:19:54', NULL, 'E'),
(385, 2, '2015-10-27 00:19:55', NULL, 'E'),
(386, 1, '2015-10-27 00:30:07', NULL, 'E'),
(387, 2, '2015-10-27 00:30:08', NULL, 'E'),
(388, 2, '2015-10-27 00:35:11', NULL, 'E'),
(389, 1, '2015-10-27 00:35:12', NULL, 'E'),
(390, 1, '2015-10-27 00:44:02', NULL, 'E'),
(391, 2, '2015-10-27 00:44:03', NULL, 'E'),
(392, 1, '2015-10-27 01:15:20', NULL, 'E'),
(393, 2, '2015-10-27 01:15:22', NULL, 'V');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `torneo`
--

CREATE TABLE IF NOT EXISTS `torneo` (
`id` int(11) NOT NULL,
  `creadorId` int(11) NOT NULL,
  `minELO` int(11) DEFAULT '0',
  `maxELO` int(11) DEFAULT '3000',
  `inscripcion` int(11) DEFAULT '300',
  `duracion` varchar(10) COLLATE utf8_spanish2_ci NOT NULL DEFAULT '5:00',
  `sistemaJuego` varchar(30) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `rondas` int(11) DEFAULT NULL,
  `maxJugadores` int(11) DEFAULT NULL,
  `ganadorId` int(10) DEFAULT NULL,
  `premio` int(11) NOT NULL DEFAULT '0',
  `estado` varchar(1) COLLATE utf8_spanish2_ci DEFAULT 'V'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `torneo`
--

INSERT INTO `torneo` (`id`, `creadorId`, `minELO`, `maxELO`, `inscripcion`, `duracion`, `sistemaJuego`, `rondas`, `maxJugadores`, `ganadorId`, `premio`, `estado`) VALUES
(1, 2, 0, 9999, 0, '5:00', 'Todos contra todos', 6, 6, NULL, 0, NULL),
(2, 1, 0, 9999, 0, '5:00', 'Sistema de Juego', 0, 0, NULL, 0, NULL),
(3, 1, 0, 9999, 0, '5:00', 'Eliminación directa', 10, 10, NULL, 0, NULL),
(4, 1, 0, 9999, 0, '5:00', 'Todos contra todos', 4, 6, NULL, 0, NULL),
(5, 1, 0, 9999, 0, '5:00', 'Eliminación directa', 10, 10, NULL, 0, NULL),
(6, 1, 0, 9999, 0, '5:00', 'Todos contra todos', 6, 6, NULL, 0, NULL),
(7, 2, 0, 9999, 0, '5:00', 'Todos contra todos', 8, 6, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `torneo_jugador`
--

CREATE TABLE IF NOT EXISTS `torneo_jugador` (
`id` int(11) NOT NULL,
  `torneo_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `fen`
--
ALTER TABLE `fen`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mercado`
--
ALTER TABLE `mercado`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `movida`
--
ALTER TABLE `movida`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `partida`
--
ALTER TABLE `partida`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `player`
--
ALTER TABLE `player`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sesion`
--
ALTER TABLE `sesion`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `torneo`
--
ALTER TABLE `torneo`
 ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `torneo_jugador`
--
ALTER TABLE `torneo_jugador`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `fen`
--
ALTER TABLE `fen`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `mercado`
--
ALTER TABLE `mercado`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `movida`
--
ALTER TABLE `movida`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT de la tabla `partida`
--
ALTER TABLE `partida`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `player`
--
ALTER TABLE `player`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `sesion`
--
ALTER TABLE `sesion`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=394;
--
-- AUTO_INCREMENT de la tabla `torneo`
--
ALTER TABLE `torneo`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `torneo_jugador`
--
ALTER TABLE `torneo_jugador`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
