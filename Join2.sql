-- 비등가 조언 (Non-Equi Join)
SELECT * FROM t_customer;
SELECT * FROM t_gift;

-- #6201
-- ORACLE JOIN
SELECT  c.c_name "고객명", c.c_point "POINT", g.g_name "상품명"
FROM t_customer c, t_gift g
WHERE c.c_point BETWEEN g.g_start AND g.g_end;

-- ANSI JOIN
SELECT  c.c_name "고객명", c.c_point "POINT", g.g_name "상품명"
FROM t_customer c JOIN t_gift g 
     ON c.c_point BETWEEN g.g_start AND g.g_end;
 

-- #6202
-- ORACLE JOIN
SELECT  g.g_name "상품명", COUNT(*) "필요수량"
FROM t_customer c, t_gift g
WHERE c.c_point BETWEEN g.g_start AND g.g_end
GROUP BY g.g_name;

-- ANSI JOIN
SELECT  g.g_name "상품명", COUNT(*) "필요수량"
FROM t_customer c JOIN t_gift g 
     ON c.c_point BETWEEN g.g_start AND g.g_end
GROUP BY g.g_name;    
    
-- #6203
SELECT * FROM t_exam01;
SELECT * FROM t_credit;

-- ORACLE JOIN
SELECT s.name "학생이름", e.total "점수", c.grade "학점"
FROM t_student s, t_exam01 e, t_credit c
WHERE s.studno = e.studno AND e.total BETWEEN c.min_point AND c.max_point;
;

-- ANSI JOIN
SELECT s.name "학생이름", e.total "점수", c.grade "학점"
FROM 
	t_student s 
	JOIN t_exam01 e ON s.studno = e.studno
	JOIN t_credit c ON e.total BETWEEN c.min_point AND c.max_point
;

-- #6204
-- ORACLE JOIN
SELECT c.c_name "고객명", c.c_point "POINT", g.g_name "상품명"
FROM t_customer c, t_gift g
WHERE 
	g.g_start <= c.c_point
	AND
	-- g.g_no = 5
	g.g_name = '산악용자전거'
;

-- ANSI JOIN
SELECT c.c_name "고객명", c.c_point "POINT", g.g_name "상품명"
FROM t_customer c JOIN t_gift g
	ON
	g.g_start <= c.c_point
	AND
	-- g.g_no = 5
	g.g_name = '산악용자전거'
;
 
-- #6205
SELECT e.name "이름",   
	(TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(e.birthday, 'YYYY') + 1) "현재나이",
	NVL(e.post, ' ') "현재직급",
	p.post "예상직급"
FROM t_emp2 e, t_post p
WHERE
	(TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(e.birthday, 'YYYY') + 1)
	BETWEEN p.s_age AND p.e_age
;

-- ANSI JOIN
SELECT e.name "이름",   
	(TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(e.birthday, 'YYYY') + 1) "현재나이",
	NVL(e.post, ' ') "현재직급",
	p.post "예상직급"
FROM t_emp2 e JOIN t_post p
	ON
	(TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(e.birthday, 'YYYY') + 1)
	BETWEEN p.s_age AND p.e_age
;

-------------------------------------------------------
-- OUTER JOIN
-- #6206
SELECT s.name "학생이름", p.name "교수이름"
FROM 
	t_student s LEFT OUTER JOIN t_professor p
	ON s.profno = p.profno;

-- #6207
SELECT s.name "학생이름", p.name "교수이름"
FROM 
	t_student s RIGHT OUTER JOIN t_professor p
	ON s.profno = p.profno;


-- #6208
SELECT s.name "학생이름", p.name "교수이름"
FROM 
	t_student s FULL OUTER JOIN t_professor p
	ON s.profno = p.profno;

--------------------------------------------------
-- SELF JOIN

-- #6209
-- ORACLE JOIN
SELECT  d1.dname 부서명,  d2.dname 상위부서명
FROM t_dept2 d1, t_dept2 d2
WHERE d1.pdept = d2.dcode;

-- ANSI JOIN
SELECT  d1.dname 부서명,  d2.dname 상위부서명
FROM t_dept2 d1 JOIN t_dept2 d2
	ON d1.pdept = d2.dcode;

-- #6210
-- ↓ 중간 확인용
SELECT a.profno "교수번호", a.name "교수명", 
		TO_CHAR(a.hiredate, 'YYYY-MM-DD') "입사일",
		b.name "빠른교수명", b.hiredate "빠른사람"
FROM 
	t_professor a LEFT OUTER JOIN t_professor b
	ON b.hiredate < a.hiredate
ORDER BY a.profno


SELECT a.profno "교수번호", a.name "교수명", 
		TO_CHAR(a.hiredate, 'YYYY-MM-DD') "입사일",
		COUNT(b.hiredate) "빠른사람"
FROM 
	t_professor a LEFT OUTER JOIN t_professor b
	ON b.hiredate < a.hiredate
GROUP BY
	a.profno, a.name, a.hiredate
--ORDER BY "빠른사람"
ORDER BY 4



























    
    