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
-- Database: `roti`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id_absensi` int(11) NOT NULL,
  `id_karyawan` int(11) NOT NULL,
  `id_jabatan` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `status1` enum('Hadir','Tidak hadir','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `absensi`
--

INSERT INTO `absensi` (`id_absensi`, `id_karyawan`, `id_jabatan`, `tanggal`, `status1`) VALUES
(20, 7, 2, '2023-06-26 23:32:00', 'Hadir'),
(21, 4, 1, '2023-06-26 23:32:00', 'Hadir'),
(22, 4, 1, '2023-06-27 09:35:00', 'Hadir'),
(23, 7, 2, '2023-06-27 09:36:00', 'Hadir'),
(24, 3, 5, '2023-06-27 09:37:00', 'Hadir'),
(25, 5, 4, '2023-06-27 09:38:00', 'Hadir'),
(26, 4, 1, '2023-06-27 10:08:00', 'Hadir'),
(27, 3, 5, '2023-06-27 10:19:00', 'Hadir'),
(28, 7, 2, '2023-06-27 10:21:00', 'Hadir'),
(29, 5, 4, '2023-06-27 10:22:00', 'Hadir'),
(30, 6, 3, '2023-06-27 10:34:00', 'Hadir');

-- --------------------------------------------------------

--
-- Table structure for table `bahan_baku`
--

CREATE TABLE `bahan_baku` (
  `id_bahan` int(11) NOT NULL,
  `id_suplier` int(11) NOT NULL,
  `nama_bahan` varchar(60) NOT NULL,
  `satuan` varchar(50) NOT NULL,
  `stok` int(11) NOT NULL,
  `harga_u` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bahan_baku`
--

INSERT INTO `bahan_baku` (`id_bahan`, `id_suplier`, `nama_bahan`, `satuan`, `stok`, `harga_u`) VALUES
(6, 1, 'Terigu', 'kg', 105, 10000),
(7, 1, 'minyak', 'liter', 15, 20000),
(8, 5, 'Gandum', 'Kg', 100, 10000);

--
-- Triggers `bahan_baku`
--
DELIMITER $$
CREATE TRIGGER `input_gudang_bahan` AFTER UPDATE ON `bahan_baku` FOR EACH ROW BEGIN
   
    IF NEW.stok <> OLD.stok THEN
       
        INSERT INTO gudang_bahan ( tanggal, stok, bahan)
        VALUES (NOW(), NEW.stok - OLD.stok, OLD.nama_bahan);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id_cart` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `nama_produk` varchar(100) NOT NULL,
  `harga_produk` int(50) NOT NULL,
  `picture` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id_cart`, `id_produk`, `quantity`, `nama_produk`, `harga_produk`, `picture`) VALUES
(6, 29, 6, 'donat', 10000, '1686570190_46ec0d53e564a81831ad.jpg'),
(7, 30, 5, 'roti unyil', 2000, '1686570249_089a89af6e7a0d499e7a.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `detail_offline`
--

CREATE TABLE `detail_offline` (
  `id_detail2` int(11) NOT NULL,
  `id_trans2` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_offline`
--

INSERT INTO `detail_offline` (`id_detail2`, `id_trans2`, `id_produk`, `jumlah`) VALUES
(88, 73, 29, 50),
(89, 73, 30, 50),
(90, 74, 31, 45),
(91, 75, 33, 25),
(92, 75, 34, 30),
(93, 75, 32, 20),
(94, 76, 32, 4),
(95, 76, 33, 2);

--
-- Triggers `detail_offline`
--
DELIMITER $$
CREATE TRIGGER `pengurangan_trans_offline` AFTER INSERT ON `detail_offline` FOR EACH ROW BEGIN
UPDATE produk SET stok=stok-
NEW.jumlah
WHERE id_produk = NEW.id_produk;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `gaji`
--

CREATE TABLE `gaji` (
  `id_jabatan` int(11) NOT NULL,
  `jabatan` varchar(66) NOT NULL,
  `gaji_pokok` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gaji`
--

INSERT INTO `gaji` (`id_jabatan`, `jabatan`, `gaji_pokok`) VALUES
(1, 'admin', 200000),
(2, 'gudang', 150000),
(3, 'hrd', 160000),
(4, 'supplier', 170000),
(5, 'produksi', 100000),
(6, 'keuangan', 250000);

-- --------------------------------------------------------

--
-- Table structure for table `gaji_karyawan`
--

CREATE TABLE `gaji_karyawan` (
  `id_gaji_k` int(11) NOT NULL,
  `rekening` int(15) NOT NULL,
  `tanggal` date NOT NULL,
  `id_karyawan` int(11) NOT NULL,
  `total` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gaji_karyawan`
--

INSERT INTO `gaji_karyawan` (`id_gaji_k`, `rekening`, `tanggal`, `id_karyawan`, `total`) VALUES
(23, 123456789, '2023-06-27', 3, 105000),
(24, 2147483647, '2023-06-27', 3, 210000);

-- --------------------------------------------------------

--
-- Table structure for table `gudang_bahan`
--

CREATE TABLE `gudang_bahan` (
  `tanggal` datetime NOT NULL,
  `id_bh` int(11) NOT NULL,
  `bahan` varchar(100) NOT NULL,
  `stok` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gudang_bahan`
--

INSERT INTO `gudang_bahan` (`tanggal`, `id_bh`, `bahan`, `stok`) VALUES
('2023-06-27 09:26:04', 58, 'minyak', -5),
('2023-06-27 09:26:34', 59, 'Terigu', -25),
('2023-06-27 09:29:10', 60, 'minyak', -90),
('2023-06-27 09:34:14', 61, 'minyak', 10),
('2023-06-27 09:34:16', 62, 'Terigu', 5),
('2023-06-27 10:17:56', 63, 'Terigu', -125),
('2023-06-27 10:29:00', 64, 'Terigu', 100);

-- --------------------------------------------------------

--
-- Table structure for table `gudang_produk`
--

CREATE TABLE `gudang_produk` (
  `id_p` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `nama_p` varchar(100) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gudang_produk`
--

INSERT INTO `gudang_produk` (`id_p`, `tanggal`, `nama_p`, `stok`) VALUES
(57, '2023-06-26 23:31:16', 'donat', -50),
(58, '2023-06-26 23:31:16', 'roti unyil', -50),
(59, '2023-06-26 23:40:45', 'mochi', -45),
(60, '2023-06-27 09:21:59', 'Nastar', -25),
(61, '2023-06-27 09:21:59', 'roti isi daging', -30),
(62, '2023-06-27 09:21:59', 'croissant', -20),
(63, '2023-06-27 09:27:05', 'donat', 50),
(64, '2023-06-27 09:27:24', 'roti unyil', 85),
(65, '2023-06-27 09:27:43', 'croissant', 34),
(66, '2023-06-27 10:07:06', 'croissant', -4),
(67, '2023-06-27 10:07:06', 'Nastar', -2),
(68, '2023-06-27 10:19:29', 'mochi', 98);

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `id_karyawan` int(11) NOT NULL,
  `nama_kar` varchar(60) NOT NULL,
  `id_jabatan` int(11) NOT NULL,
  `alamat_kar` varchar(60) NOT NULL,
  `Picture` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`id_karyawan`, `nama_kar`, `id_jabatan`, `alamat_kar`, `Picture`) VALUES
(3, 'juan', 5, 'wiradesa', '1687794927_1b29f93b2eeb8f054bcb.jpg'),
(4, 'Firman', 6, 'Comal', '1687795276_067c914c1aa887ba2615.jpg'),
(5, 'Aldian', 4, 'Paninggaran', '1687795532_20efd0609d2d5d753e45.jpg'),
(6, 'iqmal', 3, 'mbodeh', '1687794667_21ecae938ad53e765294.jpg'),
(7, 'Difa', 2, 'Limbangan', '1687795017_64555ae1889482521811.jpg');

-- --------------------------------------------------------

--
-- Stand-in structure for view `pemasukan`
-- (See below for the actual view)
--
CREATE TABLE `pemasukan` (
`id_trans2` int(11)
,`id_karyawan` int(11)
,`tanggal_trans` timestamp
,`nama_produk` varchar(55)
,`harga_produk` int(11)
,`jumlah` int(11)
,`subtotal` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `persetujuan_bahan_baku`
--

CREATE TABLE `persetujuan_bahan_baku` (
  `id_pbb` int(11) NOT NULL,
  `id_bahan` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `stok_p` int(20) NOT NULL,
  `status` enum('setuju','tidak setuju','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `persetujuan_bahan_baku`
--

INSERT INTO `persetujuan_bahan_baku` (`id_pbb`, `id_bahan`, `tanggal`, `stok_p`, `status`) VALUES
(37, 7, '2023-06-27 09:32:00', 10, 'setuju'),
(38, 6, '2023-06-27 09:33:00', 5, 'setuju'),
(40, 6, '2023-06-27 10:25:00', 100, 'setuju');

--
-- Triggers `persetujuan_bahan_baku`
--
DELIMITER $$
CREATE TRIGGER `persetujuan_bahan_baku` AFTER UPDATE ON `persetujuan_bahan_baku` FOR EACH ROW IF NEW.status = 'setuju' THEN
        UPDATE bahan_baku
        SET stok = stok + NEW.stok_p
        WHERE id_bahan = NEW.id_bahan;
    END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pesan`
--

CREATE TABLE `pesan` (
  `id_pesan` int(11) NOT NULL,
  `dari` varchar(50) NOT NULL,
  `tujuan` varchar(50) NOT NULL,
  `isi` text NOT NULL,
  `tgl` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pesan`
--

INSERT INTO `pesan` (`id_pesan`, `dari`, `tujuan`, `isi`, `tgl`) VALUES
(61, 'gudang', 'produksi', 'Restock donat, roti unyil, mochi, nastar 50 pcs semua', '2023-06-27 09:23:00'),
(62, 'gudang', 'supplier', 'restock minyak 10 liter', '2023-06-27 09:30:00'),
(63, 'gudang', 'produksi', 'tolong restok mochi sebesar 100 unit', '2023-06-27 10:12:00'),
(64, 'gudang', 'supplier', 'Restok Terigu 100 kg', '2023-06-27 10:21:00');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(55) NOT NULL,
  `harga_produk` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `picture` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `nama_produk`, `harga_produk`, `stok`, `deskripsi`, `picture`) VALUES
(29, 'donat', 10000, 50, 'enak dan lembut', '1686570190_46ec0d53e564a81831ad.jpg'),
(30, 'roti unyil', 2000, 50, 'kecil enak', '1686570249_089a89af6e7a0d499e7a.jpg'),
(31, 'mochi', 5000, 100, 'manis seperti saya', '1687322511_57532dfc08a83d55fb02.jpg'),
(32, 'croissant', 30000, 46, 'dari paris asli', '1687322692_212586bf5ff00762c403.jpg'),
(33, 'Nastar', 50000, 7, 'enak di hari raya', '1687322866_ddf10126f8aa31150393.jpg'),
(34, 'roti isi daging', 50000, 65, 'dging halal', '1687323038_0daf0e90145662ebef18.jpg'),
(36, 'roti sobek', 40000, 93, '6 pack', '1687345528_c11d3172bdeb461c5b79.jpg'),
(37, 'kue sus', 5000, 50, 'suuuuussss', '1687697339_bcc93bcd1b2dbd8b99ad.jpg');

--
-- Triggers `produk`
--
DELIMITER $$
CREATE TRIGGER `input_gudang_produk` AFTER UPDATE ON `produk` FOR EACH ROW BEGIN
   
    IF NEW.stok <> OLD.stok THEN
       
        INSERT INTO gudang_produk ( tanggal, stok, nama_p)
        VALUES (NOW(), NEW.stok - OLD.stok, OLD.nama_produk);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `produksi_bahanbaku_masuk`
--

CREATE TABLE `produksi_bahanbaku_masuk` (
  `id_bh_masuk` int(11) NOT NULL,
  `id_bahan` int(11) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `jumlah` int(5) NOT NULL,
  `keterangan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produksi_bahanbaku_masuk`
--

INSERT INTO `produksi_bahanbaku_masuk` (`id_bh_masuk`, `id_bahan`, `tanggal_masuk`, `jumlah`, `keterangan`) VALUES
(33, 7, '2023-06-26', 40, 'buat goreng roti unyil'),
(34, 6, '2023-06-26', 95, 'gae donat'),
(35, 7, '2023-06-27', 5, 'goreng donat'),
(36, 6, '2023-06-27', 25, 'adonan roti'),
(37, 7, '2023-06-27', 90, 'goreng goreng '),
(38, 6, '2023-06-27', 125, 'buat base adonan');

--
-- Triggers `produksi_bahanbaku_masuk`
--
DELIMITER $$
CREATE TRIGGER `pengurangan_bahan_baku` AFTER INSERT ON `produksi_bahanbaku_masuk` FOR EACH ROW BEGIN
UPDATE bahan_baku SET stok=stok-
NEW.jumlah
WHERE id_bahan = NEW.id_bahan;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_suplier` int(11) NOT NULL,
  `nama_suplier` varchar(6666) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `kontak` varchar(66) NOT NULL,
  `informasi_sup` varchar(66) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_suplier`, `nama_suplier`, `alamat`, `kontak`, `informasi_sup`) VALUES
(1, 'juan', 'pekalongan', '0909090909', 'orang ini tampan dan berani'),
(5, 'Iqmal', 'Bodeh', '123456789', 'Supplier telur dan gandum');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_pemesanan`
--

CREATE TABLE `transaksi_pemesanan` (
  `id_trans1` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `no_hp` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `total_produk` int(11) NOT NULL,
  `total_harga` int(11) NOT NULL,
  `tanggal_trans` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaksi_pemesanan`
--

INSERT INTO `transaksi_pemesanan` (`id_trans1`, `nama`, `no_hp`, `email`, `alamat`, `total_produk`, `total_harga`, `tanggal_trans`) VALUES
(18, 'juan', '01837134741', 'takunayoshi@gmail.com', 'wiradesa', 3, 17000, '2023-06-26 14:13:00'),
(19, 'Aldian', '09876545678', 'asdfahdg@gmail.com', 'Paninggaran', 2, 12000, '2023-06-27 02:16:14'),
(20, 'cocolatos', '09876545678', 'aji333332@gmail.com', 'Mbodeh', 2, 12000, '2023-06-27 02:17:13'),
(21, 'Firman', '098765456789', 'firman@gmail.com', 'Comal', 2, 70000, '2023-06-27 03:03:52');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_penjualan`
--

CREATE TABLE `transaksi_penjualan` (
  `id_trans2` int(11) NOT NULL,
  `id_karyawan` int(11) NOT NULL,
  `tanggal_trans` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaksi_penjualan`
--

INSERT INTO `transaksi_penjualan` (`id_trans2`, `id_karyawan`, `tanggal_trans`) VALUES
(73, 4, '2023-06-26 16:30:00'),
(74, 4, '2023-06-26 16:40:00'),
(75, 5, '2023-06-27 02:20:00'),
(76, 4, '2023-06-27 03:05:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `jabatan` int(11) NOT NULL,
  `picture` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `jabatan`, `picture`) VALUES
(26, 'iqmal', '$2y$10$V/uRDdnv95BU2x4EoOytsOS6a1axXDVS2UDjM6LSR1eFXMaG8MT6C', 3, '1686479999_e3bbf06c514a2652f028.jpg'),
(28, 'difa', '$2y$10$RNtoGiZvVm4EbA7WE62pY.7PEmXv6nTYYU7LLdM6BoVZANAI6neSa', 2, '1686480274_cc5074141ba398b784fd.jpg'),
(29, 'aldian', '$2y$10$3qCFkWLx438x03UptUxp3uf1olDHbg8OTa9ohoaqfc5FNJifsceCm', 4, '1686480301_5ef356d8bb24587e2cab.jpg'),
(30, 'firman', '$2y$10$hSuudP0rz0zZS5I9zopgNe5R9hKQV.4CycBJJveexogy4gGPS9Ht.', 1, '1686480331_a7312e98184fd019dbaa.jpg'),
(31, 'juan', '$2y$10$tBj4s2qR6iphT7TIkLQdJeQqPX0sQxrmxJo7UcczwGjOIMUTp3Xna', 5, '1686480361_7d2a9dcac274c2ef4ae5.jpg'),
(33, 'keuangan', '$2y$10$Pvbup699PvuKRjvHPvpXT.HRDtD0l/vFt7Nc1xUFme4VHyzowV7Ey', 6, '1687326336_d35cccfaa072b5f0dbe4.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user_pelanggan`
--

CREATE TABLE `user_pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `alamat` varchar(233) NOT NULL,
  `no_hp` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure for view `pemasukan`
--
DROP TABLE IF EXISTS `pemasukan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pemasukan`  AS SELECT `detail_offline`.`id_trans2` AS `id_trans2`, `transaksi_penjualan`.`id_karyawan` AS `id_karyawan`, `transaksi_penjualan`.`tanggal_trans` AS `tanggal_trans`, `produk`.`nama_produk` AS `nama_produk`, `produk`.`harga_produk` AS `harga_produk`, `detail_offline`.`jumlah` AS `jumlah`, `produk`.`harga_produk`* `detail_offline`.`jumlah` AS `subtotal` FROM ((`detail_offline` join `produk` on(`produk`.`id_produk` = `detail_offline`.`id_produk`)) join `transaksi_penjualan` on(`transaksi_penjualan`.`id_trans2` = `detail_offline`.`id_trans2`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id_absensi`),
  ADD KEY `id_karyawan` (`id_karyawan`),
  ADD KEY `id_jabatan` (`id_jabatan`);

--
-- Indexes for table `bahan_baku`
--
ALTER TABLE `bahan_baku`
  ADD PRIMARY KEY (`id_bahan`),
  ADD KEY `id_suplier` (`id_suplier`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id_cart`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `detail_offline`
--
ALTER TABLE `detail_offline`
  ADD PRIMARY KEY (`id_detail2`),
  ADD KEY `id_trans2` (`id_trans2`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `gaji`
--
ALTER TABLE `gaji`
  ADD PRIMARY KEY (`id_jabatan`);

--
-- Indexes for table `gaji_karyawan`
--
ALTER TABLE `gaji_karyawan`
  ADD PRIMARY KEY (`id_gaji_k`),
  ADD KEY `id_karyawan` (`id_karyawan`);

--
-- Indexes for table `gudang_bahan`
--
ALTER TABLE `gudang_bahan`
  ADD PRIMARY KEY (`id_bh`);

--
-- Indexes for table `gudang_produk`
--
ALTER TABLE `gudang_produk`
  ADD PRIMARY KEY (`id_p`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`id_karyawan`),
  ADD KEY `relasi_karyawan` (`id_jabatan`);

--
-- Indexes for table `persetujuan_bahan_baku`
--
ALTER TABLE `persetujuan_bahan_baku`
  ADD PRIMARY KEY (`id_pbb`),
  ADD KEY `id_bahan` (`id_bahan`);

--
-- Indexes for table `pesan`
--
ALTER TABLE `pesan`
  ADD PRIMARY KEY (`id_pesan`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `produksi_bahanbaku_masuk`
--
ALTER TABLE `produksi_bahanbaku_masuk`
  ADD PRIMARY KEY (`id_bh_masuk`),
  ADD KEY `id_bahan` (`id_bahan`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_suplier`),
  ADD KEY `id_bahan` (`alamat`);

--
-- Indexes for table `transaksi_pemesanan`
--
ALTER TABLE `transaksi_pemesanan`
  ADD PRIMARY KEY (`id_trans1`);

--
-- Indexes for table `transaksi_penjualan`
--
ALTER TABLE `transaksi_penjualan`
  ADD PRIMARY KEY (`id_trans2`),
  ADD KEY `id_karyawan` (`id_karyawan`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jabatan` (`jabatan`);

--
-- Indexes for table `user_pelanggan`
--
ALTER TABLE `user_pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id_absensi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `bahan_baku`
--
ALTER TABLE `bahan_baku`
  MODIFY `id_bahan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id_cart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `detail_offline`
--
ALTER TABLE `detail_offline`
  MODIFY `id_detail2` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `gaji`
--
ALTER TABLE `gaji`
  MODIFY `id_jabatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `gaji_karyawan`
--
ALTER TABLE `gaji_karyawan`
  MODIFY `id_gaji_k` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `gudang_bahan`
--
ALTER TABLE `gudang_bahan`
  MODIFY `id_bh` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `gudang_produk`
--
ALTER TABLE `gudang_produk`
  MODIFY `id_p` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `id_karyawan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `persetujuan_bahan_baku`
--
ALTER TABLE `persetujuan_bahan_baku`
  MODIFY `id_pbb` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `pesan`
--
ALTER TABLE `pesan`
  MODIFY `id_pesan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `produksi_bahanbaku_masuk`
--
ALTER TABLE `produksi_bahanbaku_masuk`
  MODIFY `id_bh_masuk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_suplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transaksi_pemesanan`
--
ALTER TABLE `transaksi_pemesanan`
  MODIFY `id_trans1` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `transaksi_penjualan`
--
ALTER TABLE `transaksi_penjualan`
  MODIFY `id_trans2` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `user_pelanggan`
--
ALTER TABLE `user_pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `r_jabatan` FOREIGN KEY (`id_jabatan`) REFERENCES `gaji` (`id_jabatan`),
  ADD CONSTRAINT `r_karyawan` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawan` (`id_karyawan`);

--
-- Constraints for table `bahan_baku`
--
ALTER TABLE `bahan_baku`
  ADD CONSTRAINT `relasi_suplier` FOREIGN KEY (`id_suplier`) REFERENCES `supplier` (`id_suplier`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `r_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `detail_offline`
--
ALTER TABLE `detail_offline`
  ADD CONSTRAINT `relasi_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`),
  ADD CONSTRAINT `relasi_trans_penj` FOREIGN KEY (`id_trans2`) REFERENCES `transaksi_penjualan` (`id_trans2`);

--
-- Constraints for table `gaji_karyawan`
--
ALTER TABLE `gaji_karyawan`
  ADD CONSTRAINT `gaji_karyawan_ibfk_1` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawan` (`id_karyawan`);

--
-- Constraints for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD CONSTRAINT `relasi_karyawan` FOREIGN KEY (`id_jabatan`) REFERENCES `gaji` (`id_jabatan`);

--
-- Constraints for table `persetujuan_bahan_baku`
--
ALTER TABLE `persetujuan_bahan_baku`
  ADD CONSTRAINT `r_bahan` FOREIGN KEY (`id_bahan`) REFERENCES `bahan_baku` (`id_bahan`);

--
-- Constraints for table `produksi_bahanbaku_masuk`
--
ALTER TABLE `produksi_bahanbaku_masuk`
  ADD CONSTRAINT `relasi_bahanbaku` FOREIGN KEY (`id_bahan`) REFERENCES `bahan_baku` (`id_bahan`);

--
-- Constraints for table `transaksi_penjualan`
--
ALTER TABLE `transaksi_penjualan`
  ADD CONSTRAINT `realsi_kar` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawan` (`id_karyawan`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `relasi_jabatan` FOREIGN KEY (`jabatan`) REFERENCES `gaji` (`id_jabatan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
