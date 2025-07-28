-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2025 at 02:05 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


-- FAJAR
CREATE TABLE `kategori` (
  `kategori_id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(100) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  PRIMARY KEY (`kategori_id`),
  UNIQUE KEY `nama_kategori` (`nama_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- DWI
CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tanggal_dibuat` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `admin` (`username`, `password`, `nama_lengkap`, `email`)
VALUES
('admin_dwi', SHA2('password123', 256), 'Dwi Budi Fitri Adi', 'dwi.admin@example.com'),
('admin_sari', SHA2('sariSecure!', 256), 'Sari Lestari', 'sari.lestari@example.com'),
('admin_fahmi', SHA2('fahmiPass456', 256), 'Fahmi Nurhuda', 'fahmi.nur@example.com');

-- MAHESA
CREATE TABLE `mahasiswa` (
  `mahasiswa_id` varchar(20) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `program_studi` varchar(100) DEFAULT NULL,
  `tanggal_daftar` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`mahasiswa_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `mahasiswa` (`mahasiswa_id`, `nama_lengkap`, `email`, `program_studi`)
VALUES
('MHS001', 'Andi Pratama', 'andi.pratama@example.com', 'Teknik Informatika'),
('MHS002', 'Siti Aminah', 'siti.aminah@example.com', 'Pendidikan Matematika'),
('MHS003', 'Budi Santoso', 'budi.santoso@example.com', 'Manajemen');


-- SARI
CREATE TABLE `buku` (
  `buku_id` int(11) NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) NOT NULL,
  `pengarang` varchar(255) DEFAULT NULL,
  `penerbit` varchar(150) DEFAULT NULL,
  `tahun_terbit` year(4) DEFAULT NULL,
  `kategori_id` int(11) DEFAULT NULL,
  `deskripsi_singkat` text DEFAULT NULL,
  `lokasi_lemari` varchar(255) DEFAULT NULL,
  `jumlah_tersedia` int(11) DEFAULT 1,
  `status_ketersediaan` enum('Tersedia','Dipinjam','Dalam Perawatan','Hilang') DEFAULT 'Tersedia',
  `tanggal_ditambahkan` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`buku_id`),
  KEY `kategori_id` (`kategori_id`),
  CONSTRAINT `buku_ibfk_1` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`kategori_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- SIWAH
CREATE TABLE `peminjaman` (
  `peminjaman_id` int(11) NOT NULL AUTO_INCREMENT,
  `buku_id` int(11) NOT NULL,
  `mahasiswa_id` varchar(20) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `tanggal_pinjam` timestamp NOT NULL DEFAULT current_timestamp(),
  `tanggal_jatuh` timestamp NULL DEFAULT NULL,
  `tanggal_kembali` timestamp NULL DEFAULT NULL,
  `status_peminjaman` enum('Dipinjam','Dikembalikan','Terlambat','Hilang') DEFAULT 'Dipinjam',
  `denda` decimal(10,2) DEFAULT 0.00,
  `catatan` text DEFAULT NULL,
  PRIMARY KEY (`peminjaman_id`),
  KEY `buku_id` (`buku_id`),
  KEY `mahasiswa_id` (`mahasiswa_id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`buku_id`) REFERENCES `buku` (`buku_id`),
  CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswa` (`mahasiswa_id`),
  CONSTRAINT `peminjaman_ibfk_3` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;