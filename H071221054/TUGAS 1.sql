-- TUGAS 1


-- CREATE DATABASE library
-- 
USE library;

CREATE TABLE books (
id int PRIMARY KEY,
isbn VARCHAR (50) UNIQUE,
title VARCHAR (50) NOT NULL,
pages INT,
summary TEXT,
genre VARCHAR (50) NOT NULL
)

ALTER TABLE books
MODIFY isbn CHAR (13);
-- (modifikasi atribut isbn menjadi CHAR dengan panjang karakter 13)

ALTER TABLE books DROP summary;
-- (hapus atribut summary)


SHOW TABLES;
 -- (tampilkan struktur tabel yg dibuat)
 
 
-- DROP TABLE books;
 
DESCRIBE books;




-- CREATE DATABASE db_praktikum

USE db_praktikum;

CREATE TABLE students (
student_id INT PRIMARY KEY,
`name` VARCHAR (50) NOT NULL,
email VARCHAR (255) UNIQUE,
gender CHAR(1)
);

CREATE TABLE classes (
class_id INT AUTO_INCREMENT PRIMARY KEY,
class_name VARCHAR(50)
);

CREATE TABLE class_student (
enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
grade CHAR(1) DEFAULT 'E',
student_id INT,
class_id INT,

FOREIGN KEY (student_id) REFERENCES students (student_id),
FOREIGN KEY (class_id) REFERENCES classes (class_id)
);

DESCRIBE students
DESCRIBE classes
DESCRIBE class_student

SHOW TABLES;



