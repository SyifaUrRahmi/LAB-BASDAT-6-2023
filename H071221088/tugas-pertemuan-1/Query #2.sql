NO 1

CREATE DATABASE library

USE library

CREATE TABLE books (
	id INT AUTO_INCREMENT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	tittle VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR(50) NOT NULL
);


NO 2
ALTER TABLE books 
MODIFY isbn CHAR(13)

NO 3
ALTER TABLE books
DROP summary

NO 4
DESCRIBE books


NO 5
CREATE DATABASE db_praktikum

USE db_praktikum

CREATE TABLE classes (
	class_name VARCHAR(50),
	class_id INT(11) PRIMARY KEY UNIQUE NOT NULL
);

CREATE TABLE students (
	nama VARCHAR(50) NOT NULL,
	email VARCHAR(255) UNIQUE,
	gender CHAR(1),
	student_id INT(11) PRIMARY KEY NOT NULL UNIQUE
);

CREATE TABLE class_student (
	grade CHAR(1),
	student_id INT(11),
	class_id INT(11),
	enrollment_id INT(11) PRIMARY KEY NOT NULL UNIQUE,
	
	FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

