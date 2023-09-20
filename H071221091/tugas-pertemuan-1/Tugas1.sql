-- 1 Create database
CREATE DATABASE library;
USE library;

-- 1 create table
CREATE TABLE books(
id INT PRIMARY KEY,
isbn VARCHAR(50) UNIQUE, 
title VARCHAR(50) NOT NULL,
pages INT,
summary TEXT,
genre VARCHAR(50) NOT NULL
);

-- 2 modifikasi
ALTER TABLE books
MODIFY isbn CHAR (13);

-- 3
ALTER TABLE books DROP summary;

-- 4
DESCRIBE books

-- 5
CREATE DATABASE db_praktikum;
USE db_praktikum;

CREATE TABLE students(
`name` VARCHAR(50) NOT NULL,
email VARCHAR(255) UNIQUE,
gender CHAR(1) ,
student_id INT PRIMARY KEY
);

CREATE TABLE classes(
class_name VARCHAR(50),
class_id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE class_student(
grade CHAR(1) DEFAULT "E",
student_id INT,
class_id INT,
enrollment_id INT PRIMARY KEY AUTO_INCREMENT,

FOREIGN KEY(class_id) REFERENCES classes(class_id),
FOREIGN KEY(student_id) REFERENCES students(student_id)
);

SHOW TABLES



