
/* Drop Tables */

DROP TABLE register CASCADE CONSTRAINTS;
DROP TABLE subject CASCADE CONSTRAINTS;
DROP TABLE professot CASCADE CONSTRAINTS;
DROP TABLE student CASCADE CONSTRAINTS;
DROP TABLE department CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE department
(
	deptno number NOT NULL,
	dname varchar2(10) NOT NULL,
	tel varchar2(10),
	office varchar2(10),
	PRIMARY KEY (deptno)
);


CREATE TABLE professot
(
	profno number NOT NULL,
	jumin number(13) NOT NULL,
	address varchar2(10),
	name varchar2(10),
	post varchar2(10),
	tel varchar2(10),
	hiredate date DEFAULT SYSDATE,
	deptno number NOT NULL,
	PRIMARY KEY (profno)
);


CREATE TABLE register
(
	studno number NOT NULL,
	subjno number NOT NULL
);


CREATE TABLE student
(
	studno number NOT NULL,
	name varchar2(10) NOT NULL,
	jumin varchar2(13) UNIQUE,
	grade number(1) DEFAULT 1,
	tel varchar2(10),
	address varchar2(10),
	deptno number NOT NULL,
	PRIMARY KEY (studno)
);


CREATE TABLE subject
(
	subjno number NOT NULL,
	name varchar2(10) NOT NULL,
	credit number DEFAULT 2,
	participant number DEFAULT 0,
	room varchar2(10),
	openyear number,
	profno number NOT NULL,
	PRIMARY KEY (subjno)
);



/* Create Foreign Keys */

ALTER TABLE professot
	ADD FOREIGN KEY (deptno)
	REFERENCES department (deptno)
;


ALTER TABLE student
	ADD FOREIGN KEY (deptno)
	REFERENCES department (deptno)
;


ALTER TABLE subject
	ADD FOREIGN KEY (profno)
	REFERENCES professot (profno)
;


ALTER TABLE register
	ADD FOREIGN KEY (studno)
	REFERENCES student (studno)
;


ALTER TABLE register
	ADD FOREIGN KEY (subjno)
	REFERENCES subject (subjno)
;



