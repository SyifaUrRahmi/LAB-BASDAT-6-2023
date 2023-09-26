CREATE DATABASE praktikum3;

USE praktikum3;

CREATE TABLE mahasiswa (
NIM VARCHAR(10) primary KEY NOT NULL,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
STATUS VARCHAR(50) NOT NULL,
Nilai INT(11));

DESC mahasiswa;

INSERT INTO mahasiswa
VALUES ("H071241056", "Kotlina", "A", "Hadir", 100), 
("H071241060", "Pitonia", "A", "Alfa", 85),
("H071241063", "Javano", "A", "Hadir", 50),
("H071241065", "Ciplus Kuadra", "B", "Hadir", 65),
("H071241066", "Pihap E", "B", "Hadir", 85),
("H071241079", "Ruby", "B", "Alfa", 90);

DROP TABLE mahasiswa
SELECT * FROM mahasiswa;

UPDATE mahasiswa
SET nilai = 0, kelas = "C"
WHERE STATUS = "alfa";

DELETE FROM mahasiswa WHERE kelas = "A" AND nilai > 90;

INSERT INTO mahasiswa
VALUES ("H071211061", "St. Alya Ardani Aries", "C", "Pindahan", NULL);

UPDATE mahasiswa SET nilai = 50 WHERE STATUS = "alfa";

UPDATE mahasiswa SET kelas = "A";

USE classicmodels;
SELECT officecode FROM employees WHERE FIRSTname = "Yoshimi" and lastname = "Kato"

SELECT * FROM offices;
SELECT * FROM employees;
UPDATE offices SET officecode = 11 WHERE officecode = 5;

ALTER TABLE employees DROP FOREIGN KEY employees_ibfk_2;     
ALTER TABLE employees ADD FOREIGN KEY (officeCode) REFERENCES offices (officeCode) ON UPDATE CASCADE;