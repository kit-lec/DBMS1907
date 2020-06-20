SELECT name, profno FROM t_student;  -- 20명
SELECT profno, name FROM t_professor; -- 16명

-- 카티션 곱 (Cartesian Product)
-- 컬럼명 앞에 테이블명을 명시적으로 붙여서 SELECT 
SELECT t_student.name, t_professor.name
FROM t_student, t_professor;  -- 320 개 

-- 테이블에 별명 사용 가능.  별명을 사용하여 컬럼 SELECT하기
SELECT s.name, p.name
FROM t_student s, t_professor p;

-- 학생의 이름과 그 학생의 담당교수 이름.
SELECT s.name, s.profno, p.profno, p.name
FROM t_student s, t_professor p
WHERE s.profno = p.profno
;

SELECT s.name, p.name
FROM t_student s, t_professor p  -- JOIN에 참여하는 테이블들 FROM절에 기술
WHERE s.profno = p.profno        -- 카티션곱에서 추출해낼(걸러낼) 조건기술 (JOIN조건)
;

-- #6101
-- ORACLE JOIN 
SELECT s.name 학생이름, s.deptno1 학과번호, d.dname 학과이름
FROM t_student s, t_department d
WHERE s.deptno1 = d.deptno
;

-- ANSI JOIN
-- JOIN 키워드 사용, Join 조건이 곧바로 뒤에 붙음. ON ~
SELECT s.name 학생이름, s.deptno1 학과번호, d.dname 학과이름
FROM 
	t_student s JOIN t_department d ON s.deptno1 = d.deptno
;


-- #6102
-- ORACLE JOIN
SELECT s.name "학생이름", s.profno "지도교수", p.name "지도교수이름"
FROM t_student s, t_professor p
WHERE s.profno = p.profno;  -- join 조건

-- ANSI JOIN
SELECT s.name "학생이름", s.profno "지도교수", p.name "지도교수이름"
FROM 
	t_student s JOIN t_professor p ON s.profno = p.profno;  -- join 조건

-- #6103
-- ORACLE JOIN
SELECT  s.name "학생이름", d.dname "학과이름", p.name "교수이름"
FROM t_student s, t_department d, t_professor p
WHERE s.deptno1 = d.deptno AND s.profno = p.profno
	
-- ANSI JOIN
SELECT  s.name "학생이름", d.dname "학과이름", p.name "교수이름"
FROM 
	t_student s JOIN t_department d ON s.deptno1 = d.deptno
			    JOIN t_professor p ON s.profno = p.profno;

-- #6104
SELECT * FROM t_emp2;
SELECT * FROM t_post;

-- ORACLE JOIN
SELECT
	e.name "사원이름", e.post "현재직급", e.pay "현재연봉",
	p.s_pay "하한금액", p.e_pay "상한금액"
FROM t_emp2 e, t_post p
WHERE e.post = p.post;


-- ANSI JOIN
SELECT
	e.name "사원이름", e.post "현재직급", e.pay "현재연봉",
	p.s_pay "하한금액", p.e_pay "상한금액"
FROM t_emp2 e JOIN t_post p ON e.post = p.post;


-- #6105
-- ORACLE JOIN
SELECT 	s.name "학생이름", p.name "교수이름"
FROM t_student s, t_professor p
WHERE s.profno = p.profno   -- join 조건
	AND s.deptno1 = 101    -- 검색 조건
	-- 단! 위의 JOIN 조건보다 검색조건을 먼저 수행한다.
;

-- ANSI JOIN
SELECT 	s.name "학생이름", p.name "교수이름"
FROM t_student s JOIN t_professor p
	ON s.profno = p.profno   -- join 조건
WHERE s.deptno1 = 101    -- 검색 조건
;

SELECT 	s.name "학생이름", p.name "교수이름"
FROM t_student s JOIN t_professor p
	ON s.profno = p.profno AND s.deptno1 = 101
;


