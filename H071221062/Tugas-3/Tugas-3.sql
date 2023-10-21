CREATE DATABASE praktikum3
USE praktikum3

CREATE TABLE mahasiswa(
	NIM VARCHAR(10) PRIMARY KEY,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	`Status` VARCHAR(50) NOT NULL,
	Nilai INT(11)
	);
	
	DROP TABLE mahasiswa;
	
DESCRIBE mahasiswa

INSERT INTO mahasiswa (NIM, Nama, Kelas, `STATUS`, Nilai)
VALUES	('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		 ('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		 ('H071241053', 'Javano', 'A', 'Hadir', 50),
		 ('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		 ('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		 ('H071241079', 'Ruby E', 'B', 'Alfa', 90);

SELECT * FROM mahasiswa

UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE STATUS = 'Alfa';
SELECT * FROM mahasiswa

SELECT * FROM mahasiswa

DELETE FROM mahasiswa
WHERE Nilai > 90 AND Kelas = 'A';
SELECT * FROM mahasiswa

INSERT INTO mahasiswa (NIM, Nama, Kelas, STATUS, Nilai)
VALUES	('H071221062', 'Fauzan', 'A', 'Pindahan', NULL);
SELECT * FROM mahasiswa

UPDATE mahasiswa 
SET Nilai = 50
WHERE STATUS = 'Alfa';
SELECT * FROM mahasiswa

UPDATE mahasiswa
SET Kelas = 'A';
SELECT * FROM mahasiswa

USE classicmodels;
SELECT*FROM customers;

## mencari kode kantornya
DESC employees;
SELECT officecode FROM employees
WHERE lastName = 'Kato' AND firstname ='Yoshimi';

UPDATE offices
SET officecode = 11
WHERE officecode = 20;

DESC offices;
SELECT*FROM offices
WHERE officecode = 20;

SELECT*FROM employees;
SELECT*FROM offices;

ALTER TABLE employees DROP FOREIGN KEY employees_ibfk_2;
ALTER TABLE employees ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode) ON UPDATE CASCADE;










