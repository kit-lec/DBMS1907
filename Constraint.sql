-- 제약조건 (Constraint)

SELECT * FROM t_dept2;

-- #9001
-- 제약조건명을 명시하지 않는 방법
DROP TABLE t_emp4 CASCADE CONSTRAINT;  -- t_emp4 테이블 제거, 관련 제약조건 같이 삭제
CREATE TABLE t_emp4 (
	no NUMBER(4) PRIMARY KEY,
	name VARCHAR2(10) NOT NULL,
	jumin VARCHAR2(13) NOT NULL UNIQUE,  -- 제약조건 여러개 설정 가능
	area NUMBER(1) CHECK(area < 5),
	deptno VARCHAR2(6) REFERENCES t_dept2(dcode) -- t_dept2 테이블의 dcode 컬럼을 참조하는 deptno 
);

-- 위 생성 쿼리를 다름과 같이 별도 항목으로도 정의 가능.
CREATE TABLE t_emp4 (
	no NUMBER(4),
	name VARCHAR2(10) NOT NULL,
	jumin VARCHAR2(13) NOT NULL,  -- 제약조건 여러개 설정 가능
	area NUMBER(1),
	deptno VARCHAR2(6), -- t_dept2 테이블의 dcode 컬럼을 참조하는 deptno 
	PRIMARY KEY(no),  -- 제약조건 따로 지정 가능
	UNIQUE(jumin),
	CHECK(area < 5),
	FOREIGN KEY (deptno) REFERENCES t_dept2(dcode)
);

-- #9002
-- 제약조건명을 명시하여 작성
DROP TABLE t_emp3 CASCADE CONSTRAINT;
CREATE TABLE t_emp3 (
	no NUMBER(4) CONSTRAINT emp3_no_pk PRIMARY KEY,
	name VARCHAR2(10) CONSTRAINT emp3_name_nn NOT NULL,
	jumin VARCHAR2(13) 
		CONSTRAINT emp3_jumin_nn NOT NULL
		CONSTRAINT emp3_jumin_uk UNIQUE,  -- 제약조건 여러개 설정 가능
	area NUMBER(1) CONSTRAINT emp3_area_ck CHECK(area < 5),
	deptno VARCHAR2(6) CONSTRAINT emp3_deptno_fk REFERENCES t_dept2(dcode) -- t_dept2 테이블의 dcode 컬럼을 참조하는 deptno 	
);

CREATE TABLE t_emp3 (
	no NUMBER(4),
	name VARCHAR2(10) CONSTRAINT emp3_name_nn NOT NULL,
	jumin VARCHAR2(13) CONSTRAINT emp3_jumin_nn NOT NULL,  -- 제약조건 여러개 설정 가능
	area NUMBER(1),
	deptno VARCHAR2(6), -- t_dept2 테이블의 dcode 컬럼을 참조하는 deptno 
	CONSTRAINT emp3_no_pk PRIMARY KEY(no),  -- 제약조건 따로 지정 가능
	CONSTRAINT emp3_jumin_uk UNIQUE(jumin),
	CONSTRAINT emp3_area_ck CHECK(area < 5),
	CONSTRAINT emp3_deptno_fk FOREIGN KEY (deptno) REFERENCES t_dept2(dcode)
);

-- #9003) t_emp4
SELECT owner, constraint_name, constraint_type, status
FROM USER_CONSTRAINTS
WHERE table_name = 'T_EMP4';  -- 테이블명 대문자로

SELECT owner, constraint_name, constraint_type, status
FROM USER_CONSTRAINTS
WHERE table_name = 'T_EMP3';  -- 테이블명 대문자로

-- #9005) t_emp3 의 제약조건에 맞는/위배되는 DML 작성
INSERT INTO t_emp3 VALUES(
	1, '오라클', '1234561234567', 4, 1000
); -- 두번 실행하면 오류 --> pk

INSERT INTO t_emp3 VALUES(
	2, '오라클', '1234561234567', 4, 1000
); -- jumin UNIQUE 오류

INSERT INTO t_emp3 VALUES(
	2, '오라클', '2222222222222222222', 4, 1000
); -- NUMBER(13) 자릿수 초과 오류

INSERT INTO t_emp3 VALUES(
	2, 'tigers', '222222222222', 10, 1000
); -- CHECK ( < 5) 오류.

SELECT * FROM t_dept2;

INSERT INTO t_emp3 VALUES(
	2, 'tigers', '222222222222', 3, 2000
); -- FK 오류

INSERT INTO t_emp3 (NO, jumin, area, deptno) VALUES(
	2, '3333333333333', 4, 1001
); -- NN 오류

-- DML : INSERT, UPDATE, DELETE
-- INSERT 뿐 아니라, 모든 DML 에 대해서 제약조건 동작
UPDATE t_emp3 SET area = 10 WHERE NO = 1;  -- CHECK 값 오류

-- #9005) ALTER 명령 사용해서 테이블의 제약조건 추가/수정 가능
ALTER TABLE t_emp4 
ADD CONSTRAINT emp4_name_uk UNIQUE(name);

-- #9006)
-- t_emp4 테이블의 area 컬럼에 NOT NULL 제약조건 추가
ALTER TABLE t_emp4
ADD CONSTRAINT emp4_area_nn NOT NULL(area);
-- 이미 컬럼의 기본값이 NULL 로 설정되어 있어요. 그래서! ADD 가 아닌 MODIFY 로 해야 함!

ALTER TABLE t_emp4
MODIFY (area CONSTRAINT emp4_area_nn NOT NULL);

-- #9007)  외래키 추가
-- 아래 문장 처음에는 에러!
ALTER TABLE t_emp4
ADD CONSTRAINT emp4_name_fk FOREIGN KEY(name)
REFERENCES t_emp2(name);
-- 이유: ★참조되는 부모테이블의 컬럼은 PK 이거나 UK 이어야 한다.

-- 일단 부모테이블의 name 컬럼을 UNIQUE로 바꾼뒤 위의 쿼리를 실행해보자!
ALTER TABLE t_emp2 
ADD CONSTRAINT emp2_name_uk UNIQUE(name);

-- QUIZ2 - p1
CREATE TABLE patient
(
	id VARCHAR2(20) PRIMARY KEY,
	name CHAR(10),
	sex CHAR(1),
	phone CHAR(20),
	CONSTRAINT sex_ck CHECK(sex = 'f' OR sex = 'm'),
	CONSTRAINT id_fk FOREIGN KEY(id) REFERENCES t_emp2(name)
);

-- 복합키
-- 기본키(primary key)  <--- 복수개의 컬럼으로 지정가능
-- ORACLE 로 복합키 제약조건 만들기
DROP TABLE test_member CASCADE CONSTRAINTS;

CREATE TABLE test_member (
	mb_uid NUMBER NOT NULL,
	mb_nick VARCHAR2(10) NOT NULL,
	mb_name VARCHAR2(10) NOT NULL,
	CONSTRAINT test_member_pk PRIMARY KEY(mb_uid, mb_nick) -- 복합키 구성
);
INSERT INTO test_member VALUES(1, 'aaa', 'John');
INSERT INTO test_member VALUES(1, 'bbb', 'John');
INSERT INTO test_member VALUES(2, 'aaa', 'John');
INSERT INTO test_member VALUES(2, 'bbb', 'John');
SELECT * FROM test_member;



























