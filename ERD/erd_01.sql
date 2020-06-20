
/* Drop Tables */

DROP TABLE student CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE student
(
	id number NOT NULL,
	name varchar2(10) NOT NULL,
	grade number(1) DEFAULT 1,
	gender char(1 char) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT student_gender_ck CHECK(gender IN ('남', '여'))
);



