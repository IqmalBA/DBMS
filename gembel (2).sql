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
-- Database: `gembel`
--

-- --------------------------------------------------------

--
-- Table structure for table `jenis`
--

CREATE TABLE `jenis` (
  `id_jenis` int(11) UNSIGNED NOT NULL,
  `jenis_bimbel` varchar(100) NOT NULL,
  `type_bimbel` varchar(100) NOT NULL,
  `pertemuan` int(11) NOT NULL,
  `harga` int(20) NOT NULL,
  `deskripsi_j` text NOT NULL,
  `picture` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jenis`
--

INSERT INTO `jenis` (`id_jenis`, `jenis_bimbel`, `type_bimbel`, `pertemuan`, `harga`, `deskripsi_j`, `picture`) VALUES
(2, 'SNBT', 'Grub', 4, 60000, 'Layanan bimbel untuk persiapan ujian SNBT agar dapat meraih kampus impian', 'default.png'),
(4, 'Bimbel Istimewa', 'Privat', 6, 80000, 'pelayanan bimbel yang secara khusus memberikan pembelajaran bagi anak-anak                                  berkebutuhan khusus yang membutuhkan pembelajaran tambahan, dimana guru-guru                                    yang                                memberikan pengajaran sudah berpengalaman.', ''),
(5, 'Home Scholing', 'Privat', 12, 200000, ' Pelayanan bimbel home scholing, bagi anak-anak yang ingin atau memiliki program                                   pendidikan pribadi dirumah dengan menggunakan jenis home scholing', ''),
(6, 'Bimbel Umum', 'Grub', 9, 150000, 'pelayanan bimbel secara umum untuk tingkatan SD, SMP, SMA', '');

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
(1, '2023-10-12-013719', 'App\\Database\\Migrations\\Pengajar', 'default', 'App', 1699280031, 1),
(2, '2023-10-13-131642', 'App\\Database\\Migrations\\Konsumen', 'default', 'App', 1699280031, 1),
(3, '2023-10-13-133613', 'App\\Database\\Migrations\\Users', 'default', 'App', 1699280031, 1),
(4, '2023-10-13-134547', 'App\\Database\\Migrations\\Jenis', 'default', 'App', 1699280031, 1),
(5, '2023-10-13-135130', 'App\\Database\\Migrations\\Pemesanan', 'default', 'App', 1699280031, 1),
(6, '2023-10-13-141549', 'App\\Database\\Migrations\\Transaksi', 'default', 'App', 1699280031, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id_pemesanan` int(11) UNSIGNED NOT NULL,
  `id_users` int(11) NOT NULL,
  `id_pengajar` int(11) UNSIGNED NOT NULL,
  `id_jenis` int(11) UNSIGNED NOT NULL,
  `nama` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `no_hp` varchar(100) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `tanggal` datetime DEFAULT NULL,
  `pembayaran` enum('BCA (4563345432545)','DANA (07764522072)','Gopay (08776453354)','BRI (454545245425435)') NOT NULL,
  `bukti` varchar(100) NOT NULL,
  `buktii` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pemesanan`
--

INSERT INTO `pemesanan` (`id_pemesanan`, `id_users`, `id_pengajar`, `id_jenis`, `nama`, `email`, `no_hp`, `alamat`, `tanggal`, `pembayaran`, `bukti`, `buktii`) VALUES
(12, 1, 2, 2, 'iqmaall', 'IqmalBahrudin@stmik-wp.ac.id', '+6285328947232', 'Jakarta', '2024-01-14 00:00:00', 'BCA (4563345432545)', '', 'terima'),
(13, 1, 3, 2, 'upin', 'IqmalBahrudin@stmik-wp.ac.id', '+6285328947232', 'Jakarta', '2024-01-14 00:00:00', 'BCA (4563345432545)', '', 'tolak'),
(14, 2, 1, 2, 'askmdlk', 'klsakl@gmail.com', '9008900', 'aknsdkn', '2024-01-18 00:00:00', 'BCA (4563345432545)', '', 'terima'),
(15, 0, 4, 4, 'andi', 'iqmal@gmail.com', '4534534534', 'pemalang', '2024-01-16 00:00:00', 'BCA (4563345432545)', '', 'terima'),
(16, 1, 2, 2, 'iqmal', 'iqmal@gmail.com', '4546456556767657', 'comal', '2024-01-26 05:31:51', '', 'vdfgf', '1'),
(17, 0, 1, 4, 'Iqmal Bahrudin', 'iqmalchan@gmail.com', '897867768768', 'Jakarta', '2024-01-26 00:00:00', 'BCA (4563345432545)', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `pengajar`
--

CREATE TABLE `pengajar` (
  `id_pengajar` int(11) UNSIGNED NOT NULL,
  `id_jenis` int(110) NOT NULL,
  `nama_pengajar` varchar(100) NOT NULL,
  `email_p` varchar(100) NOT NULL,
  `hp_pengajar` varchar(100) NOT NULL,
  `deskripsi` text NOT NULL,
  `picture_p` varchar(111) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pengajar`
--

INSERT INTO `pengajar` (`id_pengajar`, `id_jenis`, `nama_pengajar`, `email_p`, `hp_pengajar`, `deskripsi`, `picture_p`) VALUES
(1, 2, 'Andii', 'andi@gmail.co', '089856904', 'because im nomber one in your company', 'einstain2.png');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) UNSIGNED NOT NULL,
  `id_pemesanan` int(11) UNSIGNED NOT NULL,
  `id_pengajar` int(11) UNSIGNED NOT NULL,
  `status` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_users` int(11) UNSIGNED NOT NULL,
  `users` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('user','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_users`, `users`, `email`, `password`, `role`) VALUES
(1, 'iqmal', 'iqmal@gmail.com', '$2y$10$UPQVzyUVkr5GsgRMl7fbwO/0.H.wfP20s6oFSiI3YMIaluW6rZ7ra', 'user'),
(2, 'admin', 'admin@gmail.com', '$2y$10$VF8IjzjdPHAMNGIFV5a55uZiuBYBcnkZwyCxcYCM7Z6BV37lmqQti', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jenis`
--
ALTER TABLE `jenis`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id_pemesanan`);

--
-- Indexes for table `pengajar`
--
ALTER TABLE `pengajar`
  ADD PRIMARY KEY (`id_pengajar`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jenis`
--
ALTER TABLE `jenis`
  MODIFY `id_jenis` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id_pemesanan` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `pengajar`
--
ALTER TABLE `pengajar`
  MODIFY `id_pengajar` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_users` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
