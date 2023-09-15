 
USE library 
 
 
CREATE TABLE books(
id_books INT PRIMARY KEY,
isbn VARCHAR (50) UNIQUE,
title VARCHAR (50) NOT NULL,
pages INT,
summary TEXT,
genre VARCHAR (50) NOT NULL
)
 
ALTER TABLE books
MODIFY isbn CHAR (12) UNIQUE 
 
ALTER TABLE books
DROP COLUMN summary;
 
 
DESCRIBE books
 
DROP DATABASE library
 
CREATE DATABASE db_pratikum
 
USE db_pratikum
 
CREATE TABLE students (
   student_id INT PRIMARY KEY,
   name VARCHAR(50),
   email VARCHAR(255) UNIQUE ,
   gender CHAR(1)
);

 
CREATE TABLE classes (
	class_id INT PRIMARY KEY AUTO_INCREMENT ,
	class_name VARCHAR (50)
);

DESCRIBE students


CREATE TABLE class_student (
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT ,
	grade CHAR(1) DEFAULT "E",
	student_id INT,
	class_id INT,
	FOREIGN KEY (student_id) REFERENCES students(student_id),
   FOREIGN KEY (class_id) REFERENCES classes(class_id)
);