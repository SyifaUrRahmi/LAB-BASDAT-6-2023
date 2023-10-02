-- NO1
## membuat database
CREATE DATABASE praktikum3;
USE praktikum3;

## membuat tabel
CREATE TABLE mahasiswa (
NIM VARCHAR(10) NOT NULL PRIMARY KEY,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
`status` VARCHAR(50) NOT NULL,
Nilai INT 
);
DESC mahasiswa;

## menambahkan data
INSERT INTO mahasiswa 
		VALUE ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
				('H071241060', 'Pitona', 'A', 'Alfa', 85),
				('H071241063', 'Javano', 'A', 'Hadir', 50),
				('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
				('H071241066', 'Pihap E', 'B', 'Hadir', 85),
				('H071241079', 'Ruby', 'B', 'Alfa', 90);
SELECT*FROM mahasiswa;

-- NO.2
## update
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'c'
WHERE STATUS = 'Alfa';
SELECT*FROM mahasiswa;

-- NO. 3
## menghapus data
DELETE FROM mahasiswa
WHERE Kelas = 'A'AND Nilai > 90;
SELECT*FROM mahasiswa;

-- NO. 4
## menambahkan data diri
INSERT INTO mahasiswa
		VALUE ('H071221091', 'Adrian Hidayat', 'B', 'Pindahan', NULL);
SELECT*FROM mahasiswa;

## update nilai
UPDATE mahasiswa 
SET Nilai = 50
WHERE STATUS = 'Alfa';
SELECT*FROM mahasiswa;

## update kelas
UPDATE mahasiswa
SET Kelas = 'A';
SELECT*FROM mahasiswa;

-- NO. 5
-- Cari di kantor manakah Yoshimi Kato bekerja kemudian 
-- ubah officeCode dari kantor tersebut menjadi 11!

## memasuki database classicmodels
USE classicmodels;
-- SELECT*FROM customers;

## mencari kode kantornya
DESC employees;
SELECT*FROM employees
WHERE firstName = 'Yoshimi';

##
DESC offices;
SELECT*FROM offices
WHERE officeCode = 5;

## ubah ke 11
ALTER TABLE employees DROP FOREIGN KEY employees_ibfk_2;
ALTER TABLE employees ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode) ON UPDATE CASCADE;

UPDATE offices
SET officeCode = 11
WHERE officeCode = 5;

SELECT*FROM offices;


## Ubah kembali
ALTER TABLE employees DROP FOREIGN KEY employees_ibfk_2;
ALTER TABLE employees ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode) ON UPDATE RESTRICT;

UPDATE offices
SET officeCode = 5
WHERE officeCode = 11;
SELECT*FROM offices;




