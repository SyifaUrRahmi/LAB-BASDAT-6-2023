-- NO 1
CREATE DATABASE library;

USE library;


-- No 1
CREATE TABLE books (
	id INT PRIMARY KEY,
	isbn VARCHAR(50) UNIQUE,
	title VARCHAR(50) NOT NULL,
	pages INT,
	summary TEXT,
	genre VARCHAR (50) NOT NULL
);

-- No 2
ALTER TABLE books
MODIFY isbn CHAR(13);

-- No 3
ALTER TABLE books
DROP summary;

-- No 4
DESCRIBE books;

-- No 5
CREATE DATABASE db_praltikum;

USE db_praktikum;

CREATE TABLE students (
	name VARCHAR(50) NOT NULL,
	email VARCHAR(255) UNIQUE,
	gender CHAR(1),
	student_id INT(11) PRIMARY KEY NOT NULL UNIQUE
);

DESCRIBE students;

CREATE TABLE classess (
	classess_name VARCHAR(50),
	class_id INT(11) PRIMARY KEY NOT NULL UNIQUE
);

DESCRIBE classess
;
CREATE TABLE class_student (
	grade CHAR(1),
	student_id INT(11),
	class_id INT(11),
	enrollment_id INT(11) PRIMARY KEY NOT NULL UNIQUE,
	FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (class_id) REFERENCES classess(class_id)
);

DESCRIBE class_student;