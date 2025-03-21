-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 21, 2025 at 09:40 AM
-- Server version: 5.7.24
-- PHP Version: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ingatlan`
--
CREATE DATABASE IF NOT EXISTS `ingatlan` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `ingatlan`;

-- --------------------------------------------------------

--
-- Table structure for table `ingatlanok`
--

DROP TABLE IF EXISTS `ingatlanok`;
CREATE TABLE `ingatlanok` (
  `id` int(11) NOT NULL,
  `kategoria` int(11) NOT NULL,
  `leiras` text COLLATE utf8_hungarian_ci NOT NULL,
  `hirdetesDatuma` date NOT NULL,
  `tehermentes` tinyint(1) NOT NULL,
  `ar` int(11) NOT NULL,
  `kepUrl` text COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategoriak`
--

DROP TABLE IF EXISTS `kategoriak`;
CREATE TABLE `kategoriak` (
  `id` int(11) NOT NULL,
  `nev` text COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- Dumping data for table `kategoriak`
--

INSERT INTO `kategoriak` (`id`, `nev`) VALUES
(1, 'Ház'),
(2, 'Lakás'),
(3, 'Építési telek'),
(4, 'Garázs'),
(5, 'Mezőgazdasági terület'),
(6, 'Ipari ingatlan');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ingatlanok`
--
ALTER TABLE `ingatlanok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kategoria` (`kategoria`) USING BTREE;

--
-- Indexes for table `kategoriak`
--
ALTER TABLE `kategoriak`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ingatlanok`
--
ALTER TABLE `ingatlanok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategoriak`
--
ALTER TABLE `kategoriak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
