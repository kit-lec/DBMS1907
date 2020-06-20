-- VIEW

CREATE OR REPLACE VIEW v_prof
AS
SELECT profno, name, email, hpage FROM t_professor;

SELECT * FROM v_prof;

SELECT tname FROM tab;

-- VIEW 삭제
DROP VIEW v_prof;

-- VIEW 생성시 컬럼 이름 지정 가능
CREATE OR REPLACE VIEW v_prof (pfno, nm, em, hp)
AS
SELECT profno, name, email, hpage FROM t_professor;

SELECT * FROM v_prof;


-- 특정 사용자가 소유한 VIEW 목록 확인용
SELECT owner AS schema_name, view_name
FROM sys.ALL_VIEWS
WHERE owner = 'SCOTT7'
ORDER BY owner, view_name;

-- #8101
CREATE OR REPLACE VIEW v_prof_dept
AS
SELECT p.profno "교수번호", p.name "교수명", d.dname "소속학과명"
FROM t_professor p, t_department d
WHERE p.deptno = d.deptno;

SELECT * FROM v_prof_dept;

-- #8103
SELECT 
	d.dname "학과명", s.max_height "최대키", s.max_weight "최대몸무게"
FROM 
	( SELECT deptno1, MAX(height) max_height, MAX(weight) max_weight
	FROM t_student GROUP BY deptno1 ) s , t_department d
WHERE 
	s.deptno1 = d.deptno;


-- #8104

SELECT
	d.dname "학과명", a.max_height "최대키", s.name "학생이름", s.height "키"
FROM
(SELECT deptno1, MAX(height) max_height FROM t_student GROUP BY deptno1) a,
t_student s, t_department d
WHERE	
	s.deptno1 = a.deptno1 AND s.height = a.max_height
	AND s.deptno1 = d.deptno;

-- #8105
SELECT 
	s.grade "학년", s.name "이름", s.height "키", a.avg_height "평균키",
	s.height - a.avg_height "차이"
FROM
	(SELECT grade, AVG(height) avg_height FROM t_student GROUP BY grade) a, 
	t_student s
WHERE 
	a.grade = s.grade AND s.height > a.avg_height
ORDER BY "차이" DESC;















