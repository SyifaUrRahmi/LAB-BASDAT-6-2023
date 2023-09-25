CREATE DATABASE pratikum3
USE pratikum3


## Nomor 1
CREATE TABLE mahasiswa(
nim VARCHAR(10) NOT NULL PRIMARY KEY ,
nama VARCHAR(50) NOT NULL,
kelas CHAR(1) NOT NULL,
STATUS VARCHAR(50) NOT NULL,
nilai INT
);

DESC mahasiswa 

INSERT INTO mahasiswa
	VALUE ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
			('H071241060', 'Pitonia', 'A', 'Alfa', 85),
			('H071241063', 'Pavano', 'A', 'Hadir', 50),
			('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
			('H071241066', 'Pihap E', 'B', 'Hadir', 85),
			('H071241079', 'Ruby', 'B', 'Alfa', 90);

## Nomor 2
UPDATE mahasiswa
SET nilai = 0, Kelas = 'c'
WHERE STATUS = 'alfa';

## Nomor 3
DELETE FROM mahasiswa
WHERE kelas = 'A' AND nilai > 90;

## Nomor 4
INSERT INTO mahasiswa (nim, nama, kelas, STATUS)
 	VALUE ('H071221089', 'Andi muh haikal l', 'D', 'Pindahan');
 	
UPDATE mahasiswa
SET nilai = 50
WHERE STATUS = 'alfa';

UPDATE mahasiswa
SET kelas = 'A';
 
SELECT * FROM mahasiswa

DROP TABLE mahasiswa

## Nomor 5

USE classicmodels

SELECT * FROM offices;

SELECT * FROM employees WHERE lastname = 'kato'


ALTER TABLE employees DROP FOREIGN KEY employees_ibfk_2;     
ALTER TABLE employees ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode) ON UPDATE CASCADE;


UPDATE offices
SET officeCode = 12
WHERE officeCode = 1

