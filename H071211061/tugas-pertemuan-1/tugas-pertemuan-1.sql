CREATE DATABASE library 
USE library
CREATE TABLE books (
id int PRIMARY KEY, 
isbn VARCHAR(50) UNIQUE,
title varchar(50) NOT NULL,
pages INT,
summary TEXT,
genre VARCHAR(50) NOT NULL
);

DESCRIBE books;

ALTER TABLE books 
MODIFY isbn CHAR(13) UNIQUE;

ALTER TABLE books 
DROP summary;

CREATE DATABASE db_praktikum;
USE db_praktikum
CREATE TABLE students (
student_id INT(11) PRIMARY KEY NOT NULL, 
NAME VARCHAR(50) NOT NULL,
email VARCHAR(255) UNIQUE,
gender CHAR (1)
);

CREATE TABLE classes (
class_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
class_name VARCHAR(50)
);

CREATE TABLE class_student (
enrollment_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
grade CHAR(1) DEFAULT "E",
student_id INT(11),
class_id INT (11),

FOREIGN KEY (student_id) REFERENCES students (student_id),
FOREIGN KEY (class_id) REFERENCES classes (class_id)
)




 


