-- TUGAS 3

-- NO 1
CREATE DATABASE praktikum3;

USE praktikum3;

CREATE TABLE mahasiswa (
NIM VARCHAR (10) PRIMARY KEY,
Nama VARCHAR (50) NOT NULL,
Kelas CHAR (1) NOT NULL,
`status` VARCHAR (50) NOT NULL,
Nilai INT
);

DESC mahasiswa;

INSERT INTO mahasiswa
				VALUE ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
						('H071241060', 'Pitonia', 'A', 'Alfa', 85),
						('H071241063', 'Javano', 'A', 'Hadir', 50),
						('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
						('H071241066', 'Pihap E', 'B', 'Hadir', 85),
						('H071241079', 'Ruby', 'B', 'Alfa', 90);			
SELECT * FROM mahasiswa 


-- NO 2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE `status` = 'Alfa';
SELECT * FROM mahasiswa

-- NO 3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;
SELECT * FROM mahasiswa


-- NO 4
INSERT INTO mahasiswa (NIM, Nama, Kelas, `status`) 
				VALUE ('H071221054', 'Natasya Indriani', 'D', 'Pindahan');
SELECT * FROM mahasiswa

UPDATE mahasiswa
SET Nilai = 50
WHERE `status` = 'Alfa';
SELECT * FROM mahasiswa


UPDATE mahasiswa
SET Kelas = 'A';
SELECT * FROM mahasiswa

DROP TABLE mahasiswa

-- NO 5 (soal tambahan)
-- Cari di kantor manakah Yoshimi Kato bekerja 
-- kemudian ubah officeCode dari kantor tersebut menjadi 11!
USE classicmodels;

SELECT firstname, lastname, officeCode
FROM employees
WHERE firstname = 'Yoshimi' AND lastname = 'Kato';
SELECT * FROM offices

UPDATE offices
SET officeCode = 11
WHERE officeCode = 5;
SELECT * FROM offices;
SELECT * FROM employees;
-- 1 dijalankan
ALTER TABLE employees DROP FOREIGN KEY employees_ibfk_2;
-- 2 dijalankan
ALTER TABLE employees ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode) 
ON UPDATE CASCADE;
