-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versi server:                 8.4.3 - MySQL Community Server - GPL
-- OS Server:                    Win64
-- HeidiSQL Versi:               12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Membuang struktur basisdata untuk vote_osismpk
CREATE DATABASE IF NOT EXISTS `vote_osismpk` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vote_osismpk`;

-- membuang struktur untuk table vote_osismpk.m_guru
CREATE TABLE IF NOT EXISTS `m_guru` (
  `id_guru` int NOT NULL AUTO_INCREMENT,
  `nip` varchar(50) DEFAULT NULL,
  `nama_guru` varchar(200) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  PRIMARY KEY (`id_guru`),
  UNIQUE KEY `nip` (`nip`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel vote_osismpk.m_guru: ~14 rows (lebih kurang)
INSERT INTO `m_guru` (`id_guru`, `nip`, `nama_guru`, `jenis_kelamin`) VALUES
	(1, 'G001', 'Denisa ramadanti', 'P'),
	(2, 'G002', 'Lidiawati', 'P'),
	(3, 'G003', 'Sri rahayu', 'P'),
	(4, 'G004', 'Muhammad haerudin', 'L'),
	(5, 'G005', 'Sediana hadisujatma', 'L'),
	(6, 'G006', 'Naufal irgi ramadhan', 'L'),
	(7, 'G007', 'Ade supriadi', 'L'),
	(8, 'G008', 'Eka ayu kurniasih', 'P'),
	(9, 'G009', 'Andika mahendra', 'L'),
	(10, 'G010', 'Susiana', 'P'),
	(11, 'G011', 'Eka riana', 'L'),
	(12, 'G012', 'Sukron ansori', 'L'),
	(18, 'G013', 'Rudianto', 'L');

-- membuang struktur untuk table vote_osismpk.m_kandidat
CREATE TABLE IF NOT EXISTS `m_kandidat` (
  `id_kandidat` int NOT NULL AUTO_INCREMENT,
  `id_ketua` int DEFAULT NULL,
  `id_wakil` int DEFAULT NULL,
  `id_periode` int DEFAULT NULL,
  `jenis` enum('osis','mpk') DEFAULT NULL,
  `visi` varchar(200) DEFAULT NULL,
  `misi` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_kandidat`),
  KEY `id_ketua` (`id_ketua`),
  KEY `id_wakil` (`id_wakil`),
  KEY `id_periode` (`id_periode`),
  CONSTRAINT `m_kandidat_ibfk_1` FOREIGN KEY (`id_ketua`) REFERENCES `m_siswa` (`id_siswa`),
  CONSTRAINT `m_kandidat_ibfk_2` FOREIGN KEY (`id_wakil`) REFERENCES `m_siswa` (`id_siswa`),
  CONSTRAINT `m_kandidat_ibfk_3` FOREIGN KEY (`id_periode`) REFERENCES `m_periode` (`id_periode`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel vote_osismpk.m_kandidat: ~9 rows (lebih kurang)
INSERT INTO `m_kandidat` (`id_kandidat`, `id_ketua`, `id_wakil`, `id_periode`, `jenis`, `visi`, `misi`) VALUES
	(1, 4, 1, 2, 'osis', 'OSIS aktif dan kreatif', 'Mengadakan kegiatan seru & bermanfaat'),
	(2, 19, 10, 2, 'osis', 'OSIS disiplin dan kompak', 'Meningkatkan kerjasama dan kedisiplinan siswa'),
	(3, 6, 13, 2, 'mpk', 'MPK tegas dan adil', 'Menyampaikan aspirasi siswa'),
	(4, 9, 5, 2, 'mpk', 'MPK responsif', 'Menjadi penghubung siswa dan sekolah'),
	(5, 14, 22, 2, 'osis', 'mabar sambil main bareng', 'job is bad goon is good'),
	(6, 11, 12, 2, 'mpk', 'hidup sementara epep selama nya', 'menjadikan siswa BPM pemain epep handal'),
	(7, 25, 26, 1, 'osis', NULL, NULL),
	(8, 15, 19, 1, 'osis', NULL, NULL),
	(9, 3, 9, 1, 'mpk', NULL, NULL),
	(10, 25, 14, 1, 'mpk', NULL, NULL);

-- membuang struktur untuk table vote_osismpk.m_periode
CREATE TABLE IF NOT EXISTS `m_periode` (
  `id_periode` int NOT NULL AUTO_INCREMENT,
  `nama_periode` varchar(50) DEFAULT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `is_active` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id_periode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel vote_osismpk.m_periode: ~2 rows (lebih kurang)
INSERT INTO `m_periode` (`id_periode`, `nama_periode`, `tanggal_mulai`, `tanggal_selesai`, `is_active`) VALUES
	(1, '2027', '2026-01-01', '2026-12-31', 'Y'),
	(2, '2026', '2026-05-05', '2026-12-31', 'N');

-- membuang struktur untuk table vote_osismpk.m_siswa
CREATE TABLE IF NOT EXISTS `m_siswa` (
  `id_siswa` int NOT NULL AUTO_INCREMENT,
  `nipd` varchar(10) DEFAULT NULL,
  `nama_siswa` varchar(50) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `is_active` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`id_siswa`),
  UNIQUE KEY `nipd` (`nipd`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel vote_osismpk.m_siswa: ~32 rows (lebih kurang)
INSERT INTO `m_siswa` (`id_siswa`, `nipd`, `nama_siswa`, `jenis_kelamin`, `is_active`) VALUES
	(1, '242510072', 'Putra kasela', 'L', 'Y'),
	(2, '242510078', 'Sakanovagio', 'L', 'Y'),
	(3, '242510065', 'Muhamad irfan ardiansyah', 'L', 'Y'),
	(4, '242510074', 'Ratu haerunnisa', 'P', 'Y'),
	(5, '242510073', 'Ramadhan agil siraj', 'L', 'Y'),
	(6, '242510068', 'Muhammad ihwan utomo', 'L', 'Y'),
	(7, '242510079', 'Siti nur kholisha', 'P', 'Y'),
	(8, '242510055', 'Abdul syahril pratama', 'L', 'Y'),
	(9, '242510076', 'Rina rusliana', 'P', 'Y'),
	(10, '242510077', 'Robiyatun Nisa', 'P', 'Y'),
	(11, '242510061', 'Iskandar Ibrahim', 'L', 'Y'),
	(12, '242510075', 'Reyvan darmawan', 'L', 'Y'),
	(13, '242510071', 'Oktapia nurpadilah', 'P', 'Y'),
	(14, '242510062', 'Marchel hugo putra ramadhan', 'L', 'Y'),
	(15, '242510057', 'Emre razaq', 'L', 'Y'),
	(16, '242510070', 'Nurlita', 'P', 'Y'),
	(17, '242510064', 'Melvin olivia', 'P', 'Y'),
	(18, '242510080', 'Sugiarto raharjo', 'L', 'Y'),
	(19, '242510059', 'Felicya agatha susanto lie', 'P', 'Y'),
	(20, '242510069', 'Novita damayanti', 'P', 'Y'),
	(21, '242510067', 'Muhammad farel andriani', 'L', 'Y'),
	(22, '242510063', 'Maulidan Alif Wicaksono', 'L', 'Y'),
	(23, '242510060', 'Fiqih al farizi', 'L', 'Y'),
	(24, '242510066', 'M.fahry tri g', 'L', 'Y'),
	(25, '242510056', 'Dimas surya putra', 'L', 'Y'),
	(26, '242510058', 'Farel apandi', 'L', 'Y'),
	(27, '242510081', 'Umar hafidz muhyidin', 'L', 'Y'),
	(29, '242510099', 'Zaidan', 'L', 'Y'),
	(30, '242510098', 'Julian', 'L', 'Y'),
	(31, '242510100', 'Bagus Eko Supriyani', 'L', 'Y'),
	(37, '242510999', 'Subagio Ndoro ngidul', 'P', 'N'),
	(38, '252610062', 'Bradar Sucipto', 'L', 'N');

-- membuang struktur untuk table vote_osismpk.m_users
CREATE TABLE IF NOT EXISTS `m_users` (
  `id_users` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `role` enum('admin','siswa','guru') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nip` varchar(50) DEFAULT NULL,
  `nipd` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_users`),
  KEY `nip` (`nip`),
  KEY `nipd` (`nipd`),
  CONSTRAINT `m_users_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `m_guru` (`nip`),
  CONSTRAINT `m_users_ibfk_2` FOREIGN KEY (`nipd`) REFERENCES `m_siswa` (`nipd`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel vote_osismpk.m_users: ~39 rows (lebih kurang)
INSERT INTO `m_users` (`id_users`, `username`, `password`, `role`, `is_active`, `nip`, `nipd`) VALUES
	(1, '242510055', '123456', 'siswa', 'Y', NULL, '242510055'),
	(2, '242510056', '123456', 'siswa', 'Y', NULL, '242510056'),
	(3, '242510057', '123456', 'siswa', 'Y', NULL, '242510057'),
	(4, '242510058', '123456', 'siswa', 'Y', NULL, '242510058'),
	(5, '242510059', '123456', 'siswa', 'Y', NULL, '242510059'),
	(6, '242510060', '123456', 'siswa', 'Y', NULL, '242510060'),
	(7, '242510061', '123456', 'siswa', 'Y', NULL, '242510061'),
	(8, '242510062', '123456', 'siswa', 'Y', NULL, '242510062'),
	(9, '242510063', '123456', 'siswa', 'Y', NULL, '242510063'),
	(10, '242510064', '123456', 'siswa', 'Y', NULL, '242510064'),
	(11, '242510065', '123456', 'siswa', 'Y', NULL, '242510065'),
	(12, '242510066', '123456', 'siswa', 'Y', NULL, '242510066'),
	(13, '242510067', '123456', 'siswa', 'Y', NULL, '242510067'),
	(14, '242510068', '123456', 'siswa', 'Y', NULL, '242510068'),
	(15, '242510069', '123456', 'siswa', 'Y', NULL, '242510069'),
	(16, '242510070', '123456', 'siswa', 'Y', NULL, '242510070'),
	(17, '242510071', '123456', 'siswa', 'Y', NULL, '242510071'),
	(18, '242510072', '123456', 'siswa', 'Y', NULL, '242510072'),
	(19, '242510073', '123456', 'siswa', 'Y', NULL, '242510073'),
	(20, '242510074', '123456', 'siswa', 'Y', NULL, '242510074'),
	(21, '242510075', '123456', 'siswa', 'Y', NULL, '242510075'),
	(22, '242510076', '123456', 'siswa', 'Y', NULL, '242510076'),
	(23, '242510077', '123456', 'siswa', 'Y', NULL, '242510077'),
	(24, '242510078', '123456', 'siswa', 'Y', NULL, '242510078'),
	(25, '242510079', '123456', 'siswa', 'Y', NULL, '242510079'),
	(26, '242510080', '123456', 'siswa', 'Y', NULL, '242510080'),
	(27, '242510081', '123456', 'siswa', 'Y', NULL, '242510081'),
	(32, 'G001', '123456', 'guru', 'Y', 'G001', NULL),
	(33, 'G002', '123456', 'guru', 'Y', 'G002', NULL),
	(34, 'G003', '123456', 'guru', 'Y', 'G003', NULL),
	(35, 'G004', '123456', 'guru', 'Y', 'G004', NULL),
	(36, 'G005', '123456', 'guru', 'Y', 'G005', NULL),
	(37, 'G006', '123456', 'guru', 'Y', 'G006', NULL),
	(38, 'G007', '123456', 'guru', 'Y', 'G007', NULL),
	(39, 'G008', '123456', 'guru', 'Y', 'G008', NULL),
	(40, 'G009', '123456', 'guru', 'Y', 'G009', NULL),
	(41, 'G010', '123456', 'guru', 'Y', 'G010', NULL),
	(42, 'G011', '123456', 'guru', 'Y', 'G011', NULL),
	(43, 'G012', '123456', 'guru', 'Y', 'G012', NULL),
	(44, 'admin', '123', 'admin', 'Y', NULL, NULL),
	(45, '242510100', '123456', 'siswa', 'Y', NULL, '242510100');

-- membuang struktur untuk procedure vote_osismpk.sp_hapus_guru
DELIMITER //
CREATE PROCEDURE `sp_hapus_guru`(
	IN `p_id_guru` INT
)
BEGIN

DELETE FROM m_guru WHERE id_guru = p_id_guru;

END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_hapus_siswa
DELIMITER //
CREATE PROCEDURE `sp_hapus_siswa`(
    IN p_id_siswa INT
)
BEGIN

    UPDATE m_siswa
    SET is_active = 'N'
    WHERE id_siswa = p_id_siswa;

END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_hapus_user
DELIMITER //
CREATE PROCEDURE `sp_hapus_user`(
	IN `p_id_users` INT
)
BEGIN

    DELETE FROM m_users
    WHERE id_users = p_id_users;

END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_login
DELIMITER //
CREATE PROCEDURE `sp_login`(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(50)
)
BEGIN

    SELECT *
    FROM m_users
    WHERE username = p_username
    AND password = p_password
    AND is_active = 'Y'
    LIMIT 1;

END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_tambah_guru
DELIMITER //
CREATE PROCEDURE `sp_tambah_guru`(
    IN p_nip VARCHAR(50),
    IN p_nama VARCHAR(200),
    IN p_jk ENUM('L','P')
)
BEGIN
    INSERT INTO m_guru(nip, nama_guru, jenis_kelamin)
    VALUES (p_nip, p_nama, p_jk);
END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_tambah_kandidat
DELIMITER //
CREATE PROCEDURE `sp_tambah_kandidat`(
    IN p_ketua INT,
    IN p_wakil INT,
    IN p_periode INT,
    IN p_jenis ENUM('osis','mpk'),
    IN p_visi VARCHAR(200),
    IN p_misi VARCHAR(200)
)
BEGIN
    INSERT INTO m_kandidat(id_ketua, id_wakil, id_periode, jenis, visi, misi)
    VALUES (p_ketua, p_wakil, p_periode, p_jenis, p_visi, p_misi);
END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_tambah_siswa
DELIMITER //
CREATE PROCEDURE `sp_tambah_siswa`(
    IN p_nipd VARCHAR(10),
    IN p_nama VARCHAR(50),
    IN p_jk ENUM('L','P')
)
BEGIN

    INSERT INTO m_siswa(
        nipd,
        nama_siswa,
        jenis_kelamin,
        is_active
    )
    VALUES (
        p_nipd,
        p_nama,
        p_jk,
        'Y'
    );

END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_tambah_user
DELIMITER //
CREATE PROCEDURE `sp_tambah_user`(
	IN `p_username` VARCHAR(50),
	IN `p_password` VARCHAR(50),
	IN `p_role` ENUM('admin','siswa','guru'),
	IN `p_nip` VARCHAR(50),
	IN `p_nipd` VARCHAR(50)
)
BEGIN
    DECLARE v_count INT;

    -- cek username sudah ada atau belum
    SELECT COUNT(*) INTO v_count
    FROM m_users
    WHERE username = p_username;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username sudah digunakan';
    ELSE
        INSERT INTO m_users(
            username,
            password,
            role,
            is_active,
            nip,
            nipd
        )
        VALUES(
            p_username,
            p_password,
            p_role,
            'Y',
            p_nip,
            p_nipd
        );
    END IF;

END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_update_kandidat
DELIMITER //
CREATE PROCEDURE `sp_update_kandidat`(
    IN p_id INT,
    IN p_ketua INT,
    IN p_wakil INT,
    IN p_jenis ENUM('osis','mpk'),
    IN p_visi VARCHAR(200),
    IN p_misi VARCHAR(200)
)
BEGIN

    UPDATE m_kandidat
    SET
        id_ketua = p_ketua,
        id_wakil = p_wakil,
        jenis = p_jenis,
        visi = p_visi,
        misi = p_misi
    WHERE id_kandidat = p_id;

END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.sp_voting
DELIMITER //
CREATE PROCEDURE `sp_voting`(
    IN p_id_user INT,
    IN p_id_kandidat INT
)
BEGIN
    DECLARE v_count INT;
    DECLARE v_jenis VARCHAR(10);
    DECLARE v_periode INT;

    -- ambil periode aktif
    SELECT id_periode INTO v_periode
    FROM m_periode
    WHERE is_active = 'Y'
    LIMIT 1;

    -- ambil jenis kandidat
    SELECT jenis INTO v_jenis
    FROM m_kandidat
    WHERE id_kandidat = p_id_kandidat;

    -- cek sudah voting atau belum
    SELECT COUNT(*) INTO v_count
    FROM trs_voting
    WHERE id_user = p_id_user
    AND id_periode = v_periode
    AND jenis = v_jenis;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sudah voting di kategori ini';
    ELSE
        INSERT INTO trs_voting(id_user, id_kandidat, id_periode, jenis, tanggal)
        VALUES (p_id_user, p_id_kandidat, v_periode, v_jenis, NOW());
    END IF;

END//
DELIMITER ;

-- membuang struktur untuk view vote_osismpk.total_vote
-- Membuat tabel sementara untuk menangani kesalahan ketergantungan VIEW
CREATE TABLE `total_vote` (
	`jenis` ENUM('osis','mpk') NULL COLLATE 'utf8mb4_0900_ai_ci',
	`total_vote` BIGINT NOT NULL
) ENGINE=MyISAM;

-- membuang struktur untuk table vote_osismpk.trs_voting
CREATE TABLE IF NOT EXISTS `trs_voting` (
  `id_voting` int NOT NULL AUTO_INCREMENT,
  `id_kandidat` int DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `id_periode` int DEFAULT NULL,
  `jenis` enum('osis','mpk') DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL,
  PRIMARY KEY (`id_voting`),
  UNIQUE KEY `uniq_user_periode_jenis` (`id_user`,`id_periode`,`jenis`),
  KEY `id_kandidat` (`id_kandidat`),
  KEY `id_periode` (`id_periode`),
  CONSTRAINT `trs_voting_ibfk_1` FOREIGN KEY (`id_kandidat`) REFERENCES `m_kandidat` (`id_kandidat`),
  CONSTRAINT `trs_voting_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `m_users` (`id_users`),
  CONSTRAINT `trs_voting_ibfk_3` FOREIGN KEY (`id_periode`) REFERENCES `m_periode` (`id_periode`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Membuang data untuk tabel vote_osismpk.trs_voting: ~21 rows (lebih kurang)
INSERT INTO `trs_voting` (`id_voting`, `id_kandidat`, `id_user`, `id_periode`, `jenis`, `tanggal`) VALUES
	(1, 8, 13, 1, 'osis', '2026-05-06 21:20:52'),
	(2, 10, 13, 1, 'mpk', '2026-05-06 21:20:58'),
	(3, 2, 13, 2, 'osis', '2026-05-06 21:21:12'),
	(4, 6, 13, 2, 'mpk', '2026-05-06 21:21:18'),
	(5, 2, 6, 2, 'osis', '2026-05-06 21:28:41'),
	(6, 3, 6, 2, 'mpk', '2026-05-06 21:28:47'),
	(7, 4, 8, 2, 'mpk', '2026-05-06 21:33:15'),
	(8, 2, 8, 2, 'osis', '2026-05-06 21:33:19'),
	(9, 1, 15, 2, 'osis', '2026-05-06 22:25:44'),
	(10, 3, 15, 2, 'mpk', '2026-05-06 22:26:02'),
	(11, 8, 15, 1, 'osis', '2026-05-06 22:26:39'),
	(12, 10, 15, 1, 'mpk', '2026-05-06 22:26:49'),
	(13, 5, 24, 2, 'osis', '2026-05-06 22:30:02'),
	(14, 6, 24, 2, 'mpk', '2026-05-06 22:30:08'),
	(15, 8, 24, 1, 'osis', '2026-05-06 22:30:49'),
	(16, 10, 24, 1, 'mpk', '2026-05-06 22:30:54'),
	(17, 8, 11, 1, 'osis', '2026-05-07 09:50:12'),
	(18, 10, 11, 1, 'mpk', '2026-05-07 09:50:24'),
	(19, 8, 8, 1, 'osis', '2026-05-07 16:27:04'),
	(20, 10, 8, 1, 'mpk', '2026-05-07 16:27:12'),
	(21, 2, 19, 2, 'osis', '2026-05-07 16:29:13'),
	(22, 4, 19, 2, 'mpk', '2026-05-07 16:29:26'),
	(23, 10, 19, 1, 'mpk', '2026-05-07 16:29:44'),
	(24, 8, 19, 1, 'osis', '2026-05-07 16:29:51'),
	(25, 3, 45, 2, 'mpk', '2026-05-09 07:18:48'),
	(26, 5, 45, 2, 'osis', '2026-05-09 07:18:56');

-- membuang struktur untuk procedure vote_osismpk.update_guru
DELIMITER //
CREATE PROCEDURE `update_guru`(
    IN p_nama_guru VARCHAR(50),
    IN p_nip VARCHAR(50),
    IN p_jenis_kelamin CHAR(1),
    IN p_id_guru INT
)
BEGIN

    UPDATE m_guru
    SET nama_guru = p_nama_guru,
        nip = p_nip,
        jenis_kelamin = p_jenis_kelamin
    WHERE id_guru = p_id_guru;

    SELECT * 
    FROM m_guru 
    WHERE id_guru = p_id_guru;

END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.update_siswa
DELIMITER //
CREATE PROCEDURE `update_siswa`(
    IN p_id_siswa INT,
    IN p_is_active ENUM('Y','N')
)
BEGIN
    UPDATE m_siswa
    SET is_active = p_is_active
    WHERE id_siswa = p_id_siswa;

    SELECT * FROM m_siswa WHERE id_siswa = p_id_siswa;
END//
DELIMITER ;

-- membuang struktur untuk procedure vote_osismpk.update_user
DELIMITER //
CREATE PROCEDURE `update_user`(
	IN `p_id_users` INT,
	IN `p_username` VARCHAR(50),
	IN `p_password` VARCHAR(50),
	IN `p_role` ENUM('admin','siswa','guru'),
	IN `p_is_active` ENUM('Y','N'),
	IN `p_nip` VARCHAR(50),
	IN `p_nipd` VARCHAR(50)
)
BEGIN

    UPDATE m_users
    SET
        username = p_username,
        password = p_password,
        role = p_role,
        is_active = p_is_active,
        nip = p_nip,
        nipd = p_nipd
    WHERE id_users = p_id_users;

    SELECT * 
    FROM m_users
    WHERE id_users = p_id_users;

END//
DELIMITER ;

-- membuang struktur untuk view vote_osismpk.v_guru
-- Membuat tabel sementara untuk menangani kesalahan ketergantungan VIEW
CREATE TABLE `v_guru` (
	`id_guru` INT NOT NULL,
	`nip` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nama_guru` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`jenis_kelamin` ENUM('L','P') NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- membuang struktur untuk view vote_osismpk.v_kandidat
-- Membuat tabel sementara untuk menangani kesalahan ketergantungan VIEW
CREATE TABLE `v_kandidat` (
	`id_kandidat` INT NOT NULL,
	`jenis` ENUM('osis','mpk') NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nama_periode` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ketua` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`wakil` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`visi` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`misi` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- membuang struktur untuk view vote_osismpk.v_progres_voting
-- Membuat tabel sementara untuk menangani kesalahan ketergantungan VIEW
CREATE TABLE `v_progres_voting` (
	`id_kandidat` INT NOT NULL,
	`jenis` ENUM('osis','mpk') NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nama_periode` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`ketua` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`wakil` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`total_vote` BIGINT NOT NULL,
	`total_pemilih` BIGINT NULL,
	`persen` DECIMAL(26,2) NULL
) ENGINE=MyISAM;

-- membuang struktur untuk view vote_osismpk.v_siswa
-- Membuat tabel sementara untuk menangani kesalahan ketergantungan VIEW
CREATE TABLE `v_siswa` (
	`id_siswa` INT NOT NULL,
	`nipd` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nama_siswa` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`jenis_kelamin` ENUM('L','P') NULL COLLATE 'utf8mb4_0900_ai_ci',
	`is_active` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- membuang struktur untuk view vote_osismpk.v_user
-- Membuat tabel sementara untuk menangani kesalahan ketergantungan VIEW
CREATE TABLE `v_user` (
	`id_users` INT NOT NULL,
	`username` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`role` ENUM('admin','siswa','guru') NULL COLLATE 'utf8mb4_0900_ai_ci',
	`is_active` ENUM('Y','N') NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nama_guru` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nama_siswa` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci'
) ENGINE=MyISAM;

-- membuang struktur untuk view vote_osismpk.v_voting
-- Membuat tabel sementara untuk menangani kesalahan ketergantungan VIEW
CREATE TABLE `v_voting` (
	`id_voting` INT NOT NULL,
	`username` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`id_kandidat` INT NULL,
	`nama_periode` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`tanggal` DATETIME NULL
) ENGINE=MyISAM;

-- Menghapus tabel sementara dan menciptakan struktur VIEW terakhir
DROP TABLE IF EXISTS `total_vote`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `total_vote` AS select `v`.`jenis` AS `jenis`,count(0) AS `total_vote` from (`trs_voting` `v` join `m_periode` `p` on((`v`.`id_periode` = `p`.`id_periode`))) where (`p`.`is_active` = 'Y') group by `v`.`jenis`;

-- Menghapus tabel sementara dan menciptakan struktur VIEW terakhir
DROP TABLE IF EXISTS `v_guru`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_guru` AS select `m_guru`.`id_guru` AS `id_guru`,`m_guru`.`nip` AS `nip`,`m_guru`.`nama_guru` AS `nama_guru`,`m_guru`.`jenis_kelamin` AS `jenis_kelamin` from `m_guru`;

-- Menghapus tabel sementara dan menciptakan struktur VIEW terakhir
DROP TABLE IF EXISTS `v_kandidat`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_kandidat` AS select `k`.`id_kandidat` AS `id_kandidat`,`k`.`jenis` AS `jenis`,`p`.`nama_periode` AS `nama_periode`,`s1`.`nama_siswa` AS `ketua`,`s2`.`nama_siswa` AS `wakil`,`k`.`visi` AS `visi`,`k`.`misi` AS `misi` from (((`m_kandidat` `k` left join `m_siswa` `s1` on((`k`.`id_ketua` = `s1`.`id_siswa`))) left join `m_siswa` `s2` on((`k`.`id_wakil` = `s2`.`id_siswa`))) left join `m_periode` `p` on((`k`.`id_periode` = `p`.`id_periode`))) where (`p`.`is_active` = 'Y');

-- Menghapus tabel sementara dan menciptakan struktur VIEW terakhir
DROP TABLE IF EXISTS `v_progres_voting`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_progres_voting` AS select `k`.`id_kandidat` AS `id_kandidat`,`k`.`jenis` AS `jenis`,`p`.`nama_periode` AS `nama_periode`,`s1`.`nama_siswa` AS `ketua`,`s2`.`nama_siswa` AS `wakil`,count(`v`.`id_voting`) AS `total_vote`,(select count(distinct `tv`.`id_user`) from `trs_voting` `tv` where ((`tv`.`id_periode` = `k`.`id_periode`) and (`tv`.`jenis` = `k`.`jenis`))) AS `total_pemilih`,round(((count(`v`.`id_voting`) / (select count(distinct `tv`.`id_user`) from `trs_voting` `tv` where ((`tv`.`id_periode` = `k`.`id_periode`) and (`tv`.`jenis` = `k`.`jenis`)))) * 100),2) AS `persen` from ((((`m_kandidat` `k` left join `m_siswa` `s1` on((`k`.`id_ketua` = `s1`.`id_siswa`))) left join `m_siswa` `s2` on((`k`.`id_wakil` = `s2`.`id_siswa`))) left join `m_periode` `p` on((`k`.`id_periode` = `p`.`id_periode`))) left join `trs_voting` `v` on((`k`.`id_kandidat` = `v`.`id_kandidat`))) where (`p`.`is_active` = 'Y') group by `k`.`id_kandidat`,`k`.`jenis`,`p`.`nama_periode`,`s1`.`nama_siswa`,`s2`.`nama_siswa`;

-- Menghapus tabel sementara dan menciptakan struktur VIEW terakhir
DROP TABLE IF EXISTS `v_siswa`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_siswa` AS select `m_siswa`.`id_siswa` AS `id_siswa`,`m_siswa`.`nipd` AS `nipd`,`m_siswa`.`nama_siswa` AS `nama_siswa`,`m_siswa`.`jenis_kelamin` AS `jenis_kelamin`,coalesce(`m_siswa`.`is_active`,'Y') AS `is_active` from `m_siswa`;

-- Menghapus tabel sementara dan menciptakan struktur VIEW terakhir
DROP TABLE IF EXISTS `v_user`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_user` AS select `u`.`id_users` AS `id_users`,`u`.`username` AS `username`,`u`.`role` AS `role`,`u`.`is_active` AS `is_active`,`g`.`nama_guru` AS `nama_guru`,`s`.`nama_siswa` AS `nama_siswa` from ((`m_users` `u` left join `m_guru` `g` on((`u`.`nip` = `g`.`nip`))) left join `m_siswa` `s` on((`u`.`nipd` = `s`.`nipd`)));

-- Menghapus tabel sementara dan menciptakan struktur VIEW terakhir
DROP TABLE IF EXISTS `v_voting`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_voting` AS select `v`.`id_voting` AS `id_voting`,`u`.`username` AS `username`,`k`.`id_kandidat` AS `id_kandidat`,`p`.`nama_periode` AS `nama_periode`,`v`.`tanggal` AS `tanggal` from (((`trs_voting` `v` left join `m_users` `u` on((`v`.`id_user` = `u`.`id_users`))) left join `m_kandidat` `k` on((`v`.`id_kandidat` = `k`.`id_kandidat`))) left join `m_periode` `p` on((`v`.`id_periode` = `p`.`id_periode`)));

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
