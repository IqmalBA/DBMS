-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2025 at 08:26 PM
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
-- Database: `tauge`
--

-- --------------------------------------------------------

--
-- Table structure for table `bahan_jadi`
--

CREATE TABLE `bahan_jadi` (
  `id_bahanj` int(11) NOT NULL,
  `id_gudang` int(11) NOT NULL,
  `bahan_jadi` varchar(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `jumlah_t` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bahan_jadi`
--

INSERT INTO `bahan_jadi` (`id_bahanj`, `id_gudang`, `bahan_jadi`, `harga`, `jumlah_t`) VALUES
(8, 1, 'Tauge', 8000, 490);

-- --------------------------------------------------------

--
-- Table structure for table `detail_produksi`
--

CREATE TABLE `detail_produksi` (
  `id_detail_produksi` int(11) NOT NULL,
  `id_produksi` int(11) NOT NULL,
  `id_gudang` int(11) NOT NULL,
  `pakai` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_produksi`
--

INSERT INTO `detail_produksi` (`id_detail_produksi`, `id_produksi`, `id_gudang`, `pakai`) VALUES
(21, 82, 1, 80),
(22, 82, 24, 10),
(23, 83, 1, -2),
(24, 84, 1, 80),
(25, 84, 24, 10),
(26, 85, 1, 80),
(27, 85, 24, 10),
(28, 87, 1, 80),
(29, 87, 24, 10),
(30, 88, 1, 80),
(31, 88, 24, 10);

-- --------------------------------------------------------

--
-- Table structure for table `gudang`
--

CREATE TABLE `gudang` (
  `id_gudang` int(11) NOT NULL,
  `tanggal_g` date NOT NULL DEFAULT current_timestamp(),
  `jenis_kacang` varchar(110) NOT NULL,
  `hargakg` int(11) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gudang`
--

INSERT INTO `gudang` (`id_gudang`, `tanggal_g`, `jenis_kacang`, `hargakg`, `stok`) VALUES
(1, '2025-01-05', ' Kacang hijau bias', 23000, 840),
(24, '2025-01-28', 'Vit Sumo', 40, 50);

-- --------------------------------------------------------

--
-- Table structure for table `keuangan`
--

CREATE TABLE `keuangan` (
  `id_keuangan` int(11) NOT NULL,
  `id_produksi` int(11) NOT NULL,
  `id_gudang` int(11) NOT NULL,
  `id_pendapatan` int(11) NOT NULL,
  `tanggal_k` date NOT NULL,
  `pengeluaran` int(11) NOT NULL,
  `rincian_p` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `keuangan`
--

INSERT INTO `keuangan` (`id_keuangan`, `id_produksi`, `id_gudang`, `id_pendapatan`, `tanggal_k`, `pengeluaran`, `rincian_p`) VALUES
(23, 84, 1, 42, '2025-01-30', 500000, 'gaji karyawan'),
(24, 87, 1, 43, '2025-01-06', 500000, 'gaji karyawan dan konsumsi');

-- --------------------------------------------------------

--
-- Table structure for table `pendapatan`
--

CREATE TABLE `pendapatan` (
  `id_pendapatan` int(11) NOT NULL,
  `id_bahanj` int(11) NOT NULL,
  `tanggal_pen` date NOT NULL,
  `pendapatan` int(11) NOT NULL,
  `terjual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pendapatan`
--

INSERT INTO `pendapatan` (`id_pendapatan`, `id_bahanj`, `tanggal_pen`, `pendapatan`, `terjual`) VALUES
(42, 8, '2025-01-31', 2400000, 300),
(43, 8, '2025-01-06', 3760000, 470);

-- --------------------------------------------------------

--
-- Table structure for table `produksi`
--

CREATE TABLE `produksi` (
  `id_produksi` int(11) NOT NULL,
  `tanggal_produksi` date NOT NULL,
  `id_gudang` int(11) NOT NULL,
  `id_bahanj` int(11) NOT NULL,
  `bahan_dipakai` int(11) NOT NULL,
  `progres` text DEFAULT NULL,
  `progres_jam` datetime DEFAULT current_timestamp(),
  `status` enum('Proses','Sukses') NOT NULL,
  `tanggal_h` date DEFAULT NULL,
  `jadi` int(11) NOT NULL,
  `catatan_p` varchar(120) NOT NULL,
  `gagal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produksi`
--

INSERT INTO `produksi` (`id_produksi`, `tanggal_produksi`, `id_gudang`, `id_bahanj`, `bahan_dipakai`, `progres`, `progres_jam`, `status`, `tanggal_h`, `jadi`, `catatan_p`, `gagal`) VALUES
(84, '2025-01-30', 1, 8, 80, 'penyiraman ke 1 dan pemberian vitamin', '2025-01-31 03:42:04', 'Sukses', '2025-01-31', 480, 'hasil bagus', 0),
(87, '2025-01-03', 1, 8, 80, 'pembersihan kacang', '2025-01-06 09:54:47', 'Sukses', '2025-01-06', 480, 'hasil bagus', 0),
(88, '2025-01-31', 1, 8, 80, 'penyiraman ke 2', '2025-02-17 23:09:33', 'Proses', NULL, 0, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_users` int(11) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `pass` varchar(200) NOT NULL,
  `role` enum('pemilik','pengelola') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_users`, `nama`, `pass`, `role`) VALUES
(1, 'Iqmal', '$2y$10$YAaT6GDPyIIRXx9Ns92qzeeKTr2/MFHD/y6HGrrLIIkEo6nAAOY9C', 'pengelola'),
(2, 'ANA', '$2y$10$E03.DwseWjf1VK4uWwVX2.XYcpBYGyyqbtGPhQeUihEtFe8tiAAuq', 'pemilik'),
(3, 'ana', '$2y$10$YAaT6GDPyIIRXx9Ns92qzeeKTr2/MFHD/y6HGrrLIIkEo6nAAOY9C', 'pemilik'),
(4, 'iqmal', '$2y$10$vkfqlCIdA73l3E8fsIlAE.hYT76SCrPn7eeFl.EBZddiWfZoBONNu', 'pengelola'),
(5, 'beth', '$2y$10$WotE50v.pvmqJTd.B3mzMe4Si69hFeVS/KsQkJE/8iFR0FldnvSRu', 'pengelola'),
(6, 'upin', '$2y$10$6NUclUeKotMqbuJPTQpNX.eK2rygYwrajq0Zv47ucUIQas2Dbc7nm', 'pemilik'),
(7, 'rue', '$2y$10$tCsnTD92KTVjy8UttBHbgeK2RW/YSXvMEdHYtFRkI6YRK0jnlXBXG', 'pengelola');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bahan_jadi`
--
ALTER TABLE `bahan_jadi`
  ADD PRIMARY KEY (`id_bahanj`);

--
-- Indexes for table `detail_produksi`
--
ALTER TABLE `detail_produksi`
  ADD PRIMARY KEY (`id_detail_produksi`);

--
-- Indexes for table `gudang`
--
ALTER TABLE `gudang`
  ADD PRIMARY KEY (`id_gudang`);

--
-- Indexes for table `keuangan`
--
ALTER TABLE `keuangan`
  ADD PRIMARY KEY (`id_keuangan`),
  ADD KEY `id_produksi` (`id_produksi`),
  ADD KEY `id_gudang` (`id_gudang`),
  ADD KEY `id_pendapatan` (`id_pendapatan`);

--
-- Indexes for table `pendapatan`
--
ALTER TABLE `pendapatan`
  ADD PRIMARY KEY (`id_pendapatan`),
  ADD KEY `id_bahanj` (`id_bahanj`);

--
-- Indexes for table `produksi`
--
ALTER TABLE `produksi`
  ADD PRIMARY KEY (`id_produksi`),
  ADD KEY `id_gudang` (`id_gudang`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bahan_jadi`
--
ALTER TABLE `bahan_jadi`
  MODIFY `id_bahanj` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `detail_produksi`
--
ALTER TABLE `detail_produksi`
  MODIFY `id_detail_produksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `gudang`
--
ALTER TABLE `gudang`
  MODIFY `id_gudang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `keuangan`
--
ALTER TABLE `keuangan`
  MODIFY `id_keuangan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `pendapatan`
--
ALTER TABLE `pendapatan`
  MODIFY `id_pendapatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `produksi`
--
ALTER TABLE `produksi`
  MODIFY `id_produksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_users` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `keuangan`
--
ALTER TABLE `keuangan`
  ADD CONSTRAINT `relasi_gudang` FOREIGN KEY (`id_gudang`) REFERENCES `gudang` (`id_gudang`),
  ADD CONSTRAINT `relasi_produksi` FOREIGN KEY (`id_produksi`) REFERENCES `produksi` (`id_produksi`);

--
-- Constraints for table `produksi`
--
ALTER TABLE `produksi`
  ADD CONSTRAINT `produksi_ibfk_1` FOREIGN KEY (`id_gudang`) REFERENCES `gudang` (`id_gudang`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
