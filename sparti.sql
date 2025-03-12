-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2025 at 08:25 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sparti`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(20) UNSIGNED NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Finence', '2024-01-17 13:37:27', '2024-01-17 13:37:27', '0000-00-00 00:00:00'),
(2, 'Web Engineer', '2024-01-17 13:37:45', '2024-01-17 13:37:45', '0000-00-00 00:00:00'),
(3, 'Mobile Engineer', '2024-01-17 13:38:15', '2024-01-17 13:38:15', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `lamar`
--

CREATE TABLE `lamar` (
  `lamar_id` int(20) UNSIGNED NOT NULL,
  `user_id` int(20) NOT NULL,
  `lowongan_id` int(20) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `status` enum('diterima','diproses') NOT NULL DEFAULT 'diproses',
  `cv` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lamar`
--

INSERT INTO `lamar` (`lamar_id`, `user_id`, `lowongan_id`, `alamat`, `status`, `cv`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 1, 'Jakarta', 'diproses', 'laporan Cloud.pdf', '2024-01-17 13:46:07', '2024-01-17 13:46:07', '0000-00-00 00:00:00'),
(2, 4, 1, 'Jakarta', 'diproses', 'Cv juan.pdf', '2024-01-17 13:49:47', '2024-01-17 13:49:47', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `lowongan`
--

CREATE TABLE `lowongan` (
  `lowongan_id` int(20) UNSIGNED NOT NULL,
  `user_id` int(20) NOT NULL,
  `category_id` int(20) NOT NULL,
  `perusahaan` varchar(255) NOT NULL,
  `lowongan_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `gaji` varchar(255) NOT NULL,
  `image_lowongan` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `lowongan`
--

INSERT INTO `lowongan` (`lowongan_id`, `user_id`, `category_id`, `perusahaan`, `lowongan_name`, `description`, `alamat`, `gaji`, `image_lowongan`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 3, 'aigo teach', 'mobile krea', 'kerja enak, gaji besar, meanal aman, mati optional', 'jawa tengah, pemalang', 'Rp 3000000 - Rp 78000000', 'pic1.jpg', '2024-01-17 13:44:26', '2024-01-17 13:44:26', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(2, '2024-01-09-091436', 'App\\Database\\Migrations\\User', 'default', 'App', 1705494578, 1),
(3, '2024-01-12-061429', 'App\\Database\\Migrations\\Lowongan', 'default', 'App', 1705494578, 1),
(4, '2024-01-12-061742', 'App\\Database\\Migrations\\Category', 'default', 'App', 1705494578, 1),
(5, '2024-01-16-143511', 'App\\Database\\Migrations\\Lamar', 'default', 'App', 1705494578, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact` bigint(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `name`, `contact`, `image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'iqmal@gmail.com', '$2y$10$NRZq7EZBwf8Mx1U0wTTEMuh.9st0WU2OYTFD5tNWFzaalm8tHsbam', 'iqmal', 625665446, 'default.jpg', '2024-01-17 12:38:38', '2024-01-17 12:38:38', '0000-00-00 00:00:00'),
(2, 'juan@gmail.com', '$2y$10$um5aG1b6SX2dQzthCWxc4Odliz59UrpywxLX7M5tCQwNBp39Sg5Hy', 'juan', 6232325325, 'default.jpg', '2024-01-17 12:47:08', '2024-01-17 12:47:08', '0000-00-00 00:00:00'),
(3, 'upin@gmail.com', '$2y$10$SdVWURB9YFYcvj7JPXwp1OIRdemyTD0h6utOjy3AFZ.D/qzR767x.', 'upin', 62768678678, 'default.jpg', '2024-01-17 13:45:36', '2024-01-17 13:45:36', '0000-00-00 00:00:00'),
(4, 'juan1@gmail.com', '$2y$10$AAViNmYgQDRU2gcTxD/6getEm/axMqBxvcl658lk14Li5bmsxlBTi', 'juan', 62235325, 'default.jpg', '2024-01-17 13:48:51', '2024-01-17 13:48:51', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `lamar`
--
ALTER TABLE `lamar`
  ADD PRIMARY KEY (`lamar_id`);

--
-- Indexes for table `lowongan`
--
ALTER TABLE `lowongan`
  ADD PRIMARY KEY (`lowongan_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lamar`
--
ALTER TABLE `lamar`
  MODIFY `lamar_id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lowongan`
--
ALTER TABLE `lowongan`
  MODIFY `lowongan_id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
