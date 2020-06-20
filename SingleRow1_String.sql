-- (1) INITCAP 함수
-- 첫글자만 대문자로 변환하여 출력
-- 나머지는 전부 소문자로 출력

-- #4101
SELECT INITCAP('we are the champion') FROM DUAL;

-- #4102
SELECT id, INITCAP(id) FROM t_student WHERE deptno1 = 201;

-- #4103
SELECT name 이름, id, LOWER(id) 소문자, UPPER(id) 대문자
FROM t_student WHERE deptno1 = 201;

-- #4104
-- WHERE 조건절에 단일행 함수 사용 가능
SELECT name 이름, id, LENGTH(id) 글자수
FROM t_student WHERE LENGTH(id) >= 9;

-- #4105
SELECT name 이름, LENGTH(name) 길이, LENGTHB(name) 바이트
FROM t_student WHERE deptno1 = 201;

-- #4106
SELECT CONCAT(name, POSITION) 교수님명단
FROM t_professor WHERE deptno = 101;

SELECT name || POSITION 교수님명단
FROM t_professor WHERE deptno = 101;

-- SUBSTR 사용예
SELECT SUBSTR('ABCDE', 2, 3) FROM dual;
SELECT SUBSTR('ABCDE', 3, 10) FROM dual;
SELECT SUBSTR('ABCDE', 20, 3) FROM dual;
SELECT SUBSTR('ABCDE', -2, 2) FROM dual;  -- 음수 인덱싱 가능

-- #4107
SELECT name, substr(jumin, 1, 6) 생년월일
FROM t_student WHERE deptno1 = 101;

-- #4018
SELECT name, SUBSTR(jumin, 1, 6) 생년월일
FROM t_student 
WHERE SUBSTR(jumin, 3, 2) = '08';
-- WHERE jumin LIKE '__08%';

--#4109
SELECT name, jumin
FROM t_student WHERE SUBSTR(jumin, 7, 1) = '2' AND grade = 4;

-- INSTR() 함수
SELECT INSTR('A*B*C*', '*', 1, 1) FROM dual;
SELECT INSTR('A*B*C*', '*', 1, 2) FROM dual;
SELECT INSTR('A*B*C*', '*', 3, 2) FROM dual;
SELECT INSTR('A*B*C*', '*', -4, 1) FROM dual; -- 음수인덱스는 음의 방향으로 검색 진행
SELECT INSTR('A*B*C*', '*', -4, 2) FROM dual; -- 없으면 0 리턴
SELECT INSTR('A*B*C*', '*', -2, 2) FROM dual;

-- #4110
SELECT name, tel, INSTR(tel, ')', 1, 1) AS "위치"
FROM t_student WHERE deptno1 = 101;

-- #4111
--SELECT name, tel, SUBSTR(tel, 1, INSTR(tel, ')', 1, 1) - 1 ) 지역번호
SELECT name, tel, SUBSTR(tel, 1, INSTR(tel, ')') - 1 ) 지역번호
FROM t_student WHERE deptno1 = 101;

-- LPAD / RPAD 함수
SELECT 
	LPAD('abcd', 10, '#-') LPAD함수,
	RPAD('abcd', 10, '#-') RPAD함수 
FROM dual;

-- #4112
SELECT id, LPAD(id, 10, '$') LPAD예제
FROM t_student

-- #4115
SELECT dname, RPAD(dname, 10, '1234567890') RPAD연습
FROM t_dept2;   -- '사장실

-- LTRIM, RTRIM 함수

SELECT  
	LTRIM('슈퍼슈퍼슈가맨', '슈퍼') LTRIM,
	LTRIM('    좌측공백들 제거', ' ') LTRIM,
	RTRIM('우측 공백들 제거       ') RTRIM
FROM dual;

-- REPLACE 함수
SELECT REPLACE('슈퍼맨 슈퍼걸', '슈퍼', '파워') REPLACE예제
FROM dual;

-- #4118
SELECT REPLACE(name, substr(name, 1, 1), '#') 학생
FROM t_student WHERE deptno1 = 102;

-- #4119
SELECT REPLACE(name, substr(name, 2, 1), '#') 학생
FROM t_student WHERE deptno1 = 101;

-- #4120
SELECT name, REPLACE(jumin, SUBSTR(jumin, 7, 7), '*******') 주민번호
FROM t_student WHERE deptno1 = 101;



-- #4121









