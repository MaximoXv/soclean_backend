-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 01, 2024 at 07:03 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soclean`
--

-- --------------------------------------------------------

--
-- Table structure for table `antiguedad`
--

CREATE TABLE `antiguedad` (
  `id` int UNSIGNED NOT NULL,
  `antiguedad` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `antiguedad`
--

INSERT INTO `antiguedad` (`id`, `antiguedad`) VALUES
(1, 'menos de 1 año'),
(2, 'mas de 1 año y menos de 3 años'),
(3, 'mas de 3 años y menos de 6 años'),
(4, 'mas de 6 años');

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `id` int UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `fk_tipocliente` int UNSIGNED NOT NULL,
  `inicio_contrato` date NOT NULL,
  `plazo_contrato` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `fk_servicio` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `fk_tipocliente`, `inicio_contrato`, `plazo_contrato`, `fk_servicio`) VALUES
(1, 'Adolfo Lopez', 1, '2024-02-20', '2 años', 3),
(2, 'Salsedo SRL', 2, '2024-05-15', '2 años', 1),
(3, 'Felipe Orca', 1, '2024-06-01', '6 meses', 2),
(4, 'Juan Maisterra', 1, '2023-09-26', '3 años', 3);

-- --------------------------------------------------------

--
-- Table structure for table `empleados`
--

CREATE TABLE `empleados` (
  `id` int UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `dni` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `fk_servicio` int UNSIGNED NOT NULL,
  `fk_antiguedad` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `empleados`
--

INSERT INTO `empleados` (`id`, `nombre`, `dni`, `fk_servicio`, `fk_antiguedad`) VALUES
(1, 'Jose Alvarez', '44199438', 2, 3),
(2, 'Enzo Rodriguez', '13488206', 3, 4),
(3, 'Maria Benitez', '27285199', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `servicios`
--

CREATE TABLE `servicios` (
  `id` int UNSIGNED NOT NULL,
  `tipo_de_servicio` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `servicios`
--

INSERT INTO `servicios` (`id`, `tipo_de_servicio`) VALUES
(1, 'Limpieza a oficinas'),
(2, 'Limpieza a exteriores'),
(3, 'Limpieza de casa');

-- --------------------------------------------------------

--
-- Table structure for table `tipos_de_clientes`
--

CREATE TABLE `tipos_de_clientes` (
  `id` int UNSIGNED NOT NULL,
  `tipo_de_cliente` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipos_de_clientes`
--

INSERT INTO `tipos_de_clientes` (`id`, `tipo_de_cliente`) VALUES
(1, 'Personas'),
(2, 'Empresas');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `antiguedad`
--
ALTER TABLE `antiguedad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipocliente` (`fk_tipocliente`),
  ADD KEY `fk_servicio` (`fk_servicio`);

--
-- Indexes for table `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_servicio` (`fk_servicio`),
  ADD KEY `fk_antiguedad` (`fk_antiguedad`);

--
-- Indexes for table `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tipos_de_clientes`
--
ALTER TABLE `tipos_de_clientes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `antiguedad`
--
ALTER TABLE `antiguedad`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tipos_de_clientes`
--
ALTER TABLE `tipos_de_clientes`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`fk_tipocliente`) REFERENCES `tipos_de_clientes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `clientes_ibfk_2` FOREIGN KEY (`fk_servicio`) REFERENCES `servicios` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`fk_servicio`) REFERENCES `servicios` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `empleados_ibfk_2` FOREIGN KEY (`fk_antiguedad`) REFERENCES `antiguedad` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
