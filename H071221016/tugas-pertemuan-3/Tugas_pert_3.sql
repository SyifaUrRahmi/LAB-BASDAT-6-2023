--- 1 ----
CREATE DATABASE praktikum3;
USE praktikum3;
CREATE TABLE Mahasiswa (
NIM VARCHAR(10) PRIMARY KEY NOT NULL,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
status VARCHAR(50) NOT NULL,
nilai INT(11)
);
DESCRIBE Mahasiswa;
INSERT INTO Mahasiswa VALUES 
('H071241056','Kotlina','A','Hadir',100),
('H071241060','Pitonia','A','Alfa',85),
('H071241063','Javano','A','Hadir',50),
('H071241065','Ciplus Kuadra','B','Hadir',65),
('H071241066','Pihap E','B','Hadir',85),
('H071241079','Ruby','B','Alfa',90);
SELECT * FROM mahasiswa;
--- nomor 2----
UPDATE mahasiswa SET nilai = 0, kelas = 'C' WHERE STATUS ='Alfa';
--- nomor 3 ---
DELETE FROM mahasiswa WHERE kelas = 'A' AND nilai > 90;
--- nomor 4---
INSERT INTO mahasiswa VALUES ('H071221016','Nur Amalia','C','Pindahan',NULL);
UPDATE mahasiswa SET nilai = 50 WHERE STATUS = 'Alfa';
UPDATE mahasiswa SET kelas = 'A';
--- soal tambahan--
USE classicmodels;
SELECT * FROM employees;
SELECT * FROM employees WHERE firstname ='yoshimi' AND lastname ='kato';
SELECT * FROM offices WHERE officecode = 5;
SELECT * FROM offices;
UPDATE offices
SET officeCode = 11
WHERE officeCode = 5;

ALTER TABLE employees DROP FOREIGN KEY employees_ibfk_2;     
ALTER TABLE employees ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode) ON UPDATE CASCADE;



