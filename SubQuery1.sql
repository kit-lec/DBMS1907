-- Sub Query

-- #7101
SELECT sal FROM t_emp WHERE ename = 'SCOTT';

SELECT ename, sal
FROM t_emp
WHERE sal > ( SELECT sal FROM t_emp WHERE ename = 'SCOTT' );

-- #7102
-- 가장 키큰 학생의 키
SELECT MAX(height) FROM t_student;

SELECT name, height
FROM t_student
WHERE height = (SELECT MAX(height) FROM t_student)
;

-- #7103
SELECT s.name "학생이름", d.dname "제1전공"
FROM t_student s, t_department d
WHERE s.deptno1 = d.deptno
		AND
	s.deptno1 = (SELECT deptno1 FROM t_student WHERE name = '이윤나');

-- #7104
SELECT p.name "교수명", TO_CHAR(p.hiredate, 'YYYY-MM-DD') "입사일",
		d.dname
FROM t_professor p, t_department d
WHERE p.deptno = d.deptno
	AND p.hiredate > (SELECT hiredate FROM t_professor WHERE name = '송도권');
	
SELECT hiredate FROM t_professor WHERE name = '송도권';


-- #7105
SELECT AVG(weight) FROM t_student WHERE deptno1 = 101;

SELECT name "이름", weight "몸무게"
FROM t_student
WHERE weight > (SELECT AVG(weight) FROM t_student WHERE deptno1 = 101);

-- #7106
SELECT hiredate FROM t_professor WHERE name = '심슨';
SELECT pay FROM t_professor WHERE name = '조인형';

SELECT name "이름", pay "급여", hiredate "입사일"
FROM t_professor
WHERE hiredate = (SELECT hiredate FROM t_professor WHERE name = '심슨') 
	AND pay < (SELECT pay FROM t_professor WHERE name = '조인형');


-- #7107
SELECT * FROM t_dept2;

SELECT dcode FROM t_dept2 WHERE area = '서울지사';

SELECT empno, name, deptno
FROM t_emp2 
WHERE deptno IN (SELECT dcode FROM t_dept2 WHERE area = '서울지사');
--FROM t_emp2 WHERE deptno IN (1000, 1001, 1002, 1010);


-- #7108

SELECT * FROM t_emp2;
SELECT pay FROM t_emp2 WHERE post = '과장';

SELECT name "이름", post "직급", TO_CHAR(pay, '999,999,999') || '원' "연봉"
FROM t_emp2
WHERE pay >ANY (SELECT pay FROM t_emp2 WHERE post = '과장'); 
;

-- #7109
SELECT weight FROM t_student WHERE grade = 4;

SELECT	name "이름", grade "학년", weight "몸무게"
FROM t_student 
WHERE weight <ALL (SELECT weight FROM t_student WHERE grade = 4);

-- 다중 컬럼 SubQuery

-- #7201
SELECT grade, MAX(height)
FROM t_student GROUP BY grade;

SELECT grade "학년", name "이름", height "키"
FROM t_student
WHERE (grade, height) IN 
		(SELECT grade, MAX(height)
		FROM t_student GROUP BY grade)
ORDER BY "학년" ASC;


-- #7202

SELECT deptno, MIN(hiredate)
FROM t_professor GROUP BY deptno;

SELECT p.profno "교수번호", p.name "교수명", 
	TO_CHAR(p.hiredate, 'YYYY-MM-DD') "입사일", d.dname "학과명"
FROM t_professor p, t_department d
WHERE p.deptno = d.deptno
AND (p.deptno, p.hiredate) 
	IN 
	(SELECT deptno, MIN(hiredate) FROM t_professor GROUP BY deptno)
ORDER BY "학과명" ASC;
;

-- #7203
SELECT post, MAX(pay) FROM t_emp2 GROUP BY post;

SELECT name "사원명", post "직급", pay "연봉"
FROM t_emp2
WHERE (post, pay) IN (SELECT post, MAX(pay) FROM t_emp2 GROUP BY post)
ORDER BY pay
;

-- #7204
SELECT AVG(pay) FROM t_emp2 GROUP BY deptno;

SELECT d.dname "부서명", e.name "직원명", e.pay "연봉"
FROM t_emp2 e, t_dept2 d
WHERE e.deptno = d.dcode
AND e.pay <ALL (SELECT AVG(pay) FROM t_emp2 GROUP BY deptno)
ORDER BY 3
;

-- #7205
SELECT  a.name "사원이름", NVL(a.post, ' ') "직급", a.pay "급여"
FROM t_emp2 a
WHERE a.pay >= ( 
	SELECT AVG(b.pay) 
	FROM t_emp2 b WHERE NVL(a.post, ' ') = NVL(b.post, ' '));

SELECT AVG(pay) FROM t_emp2 WHERE post = '과장';
SELECT AVG(pay) FROM t_emp2 WHERE post = '부장';


-- Scalar SubQuery
-- SELECT 절에 오는 sub query
-- 스칼라 서브쿼리 방식
SELECT 
name "사원이름", 
(SELECT dname FROM t_dept2 d
	WHERE e.deptno = d.dcode ) "부서이름"
FROM t_emp2 e;








