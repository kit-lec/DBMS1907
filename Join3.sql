-- 오라클의 'JOIN'  <-- INNER JOIN

SELECT t_emp.deptno, t_emp.empno, t_emp.ename, t_dept.dname
FROM t_emp, t_dept
WHERE t_emp.deptno = t_dept.deptno;

SELECT t_emp.deptno, t_emp.empno, t_emp.ename, t_dept.dname
FROM t_emp INNER JOIN t_dept
ON t_emp.deptno = t_dept.deptno;

-------------------------------------------------------------
-- NATURAL JOIN (자연조인)
-- 두 테이블 간의 동일한 이름을 갖는 모든 컬럼에 대해 EQUI JOIN 을 수행한다.
-- NATURAL JOIN 이 수행되면, 
-- ON 조건절, WHERE 조건절, USING 조건절에서 JOIN조건 정의 불가!

SELECT * FROM t_emp;
SELECT * FROM t_dept;

-- 사원번호, 사원이름, 소속부서 코드, 소속부서 이름
SELECT deptno, empno, ename, dname
FROM t_emp NATURAL JOIN t_dept
ORDER BY empno;
-- 위에 코드 비록 별도의 'join 조건 '을 주진 않았지만 (즉, WHERE, ON, USING 없슴)
-- 두 테이블의 deptno 가 동일이름 칼럼으로 '자동으로' 인식하여 JOIN 처리

SELECT e.deptno, empno, e.ename, d.dname
FROM t_emp e, t_dept d
WHERE e.deptno = d.deptno
ORDER BY empno;

-- #6302
SELECT t_emp.deptno, empno, ename, dname
FROM t_emp NATURAL JOIN t_dept;

-- #6303
SELECT *
FROM t_emp NATURAL JOIN t_dept;

SELECT *
FROM t_emp JOIN t_dept ON t_emp.deptno = t_dept.deptno;

----------------------------------------------------------
--#6305) 
CREATE TABLE dept_temp
AS
SELECT * FROM t_dept;

SELECT * FROM dept_temp;

-- #6306
UPDATE dept_temp SET DNAME = 'R&D' WHERE dname = 'RESEARCH';
UPDATE dept_temp SET DNAME = 'MARKETING' WHERE dname = 'SALES';

-- #6307
SELECT * FROM t_DEPT NATURAL JOIN DEPT_TEMP;

-- #6308
SELECT * FROM t_DEPT JOIN DEPT_TEMP USING (DEPTNO);

-- #6309) 잘못된 경우
SELECT t_dept.deptno. t_dept.dname, 
       t_dept.loc, dept_temp.dname, dept_temp.loc 
FROM t_dept JOIN dept_temp USING (deptno); 
--#6310) 바른 경우
SELECT deptno, t_dept.dname, 
       t_dept.loc, dept_temp.dname, dept_temp.loc 
FROM t_dept JOIN dept_temp USING (deptno);

-- #6311
SELECT *
FROM t_dept JOIN dept_temp USING (dname);

-- #6312
SELECT *
FROM t_dept JOIN dept_temp USING (loc, deptno);

SELECT *
FROM t_dept JOIN dept_temp USING (deptno, dname, loc);























