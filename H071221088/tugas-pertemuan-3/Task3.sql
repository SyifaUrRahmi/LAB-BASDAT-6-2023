-- Nomor 1

CREATE DATABASE praktikum3;

USE praktikum3;

CREATE TABLE Mahasiswa (
NIM VARCHAR (10) PRIMARY KEY,
Nama VARCHAR (50) NOT NULL,
Kelas CHAR (1) NOT NULL,
`status` VARCHAR (50) NOT NULL,
Nilai INT (11)
);

INSERT INTO mahasiswa
VALUES 
		('H071241056', 'Kotlina', 'A', 'hadir', 100),
		('H071241060', 'Pitonia', 'A', 'alfa', 85),
		('H071241063', 'Javano', 'A', 'hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'hadir', 65),
		('H071241066', 'Pihap E', 'B', 'hadir', 85),
		('H071241079', 'Ruby', 'B', 'alfa', 90);
		
SELECT * FROM mahasiswa;

-- Nomor 2

UPDATE mahasiswa
SET nilai = 0, Kelas = 'C'
WHERE `status` = 'alfa';

-- Nomor 3

DELETE FROM mahasiswa
WHERE Kelas = 'A' AND nilai > 90;

-- Nomor 4

INSERT INTO mahasiswa
VALUES ('H071221088', 'Fauzan', 'B', 'pindahan', NULL);

UPDATE mahasiswa
SET nilai = 50
WHERE `status` = 'alfa';

UPDATE mahasiswa
SET Kelas = 'A';

DROP TABLE mahasiswa

SELECT * FROM employees
WHERE firstname = 'Yoshimi'

UPDATE offices
SET officeCode = 11
WHERE officeCode = 5

ALTER TABLE employees DROP FOREIGN KEY employees_ibfk_2;
ALTER TABLE employees ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode) ON UPDATE CASCADE;
