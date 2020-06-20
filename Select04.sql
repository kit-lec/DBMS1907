SELECT studno, name, deptno1
FROM t_student
WHERE deptno1 = 101;

SELECT profno, name, deptno
FROM t_professor
WHERE deptno = 101;

-- #3201
-- UNION 으로 합치기
SELECT studno, name, deptno1
FROM t_student
WHERE deptno1 = 101
UNION
SELECT profno, name, deptno
FROM t_professor
WHERE deptno = 101;

-- UNION ALL 로 합치기
SELECT studno, name, deptno1
FROM t_student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, deptno
FROM t_professor
WHERE deptno = 101;
-- 위 결과는 정렬없이 각각의 쿼리 결과를 그대로 합하여 출력


-- #3202
SELECT name
FROM t_student WHERE deptno1 = 101
UNION
SELECT name
FROM t_student WHERE deptno2 = 201;
-- UNION 중복 제거

SELECT name
FROM t_student WHERE deptno1 = 101
UNION ALL  -- 중복 나옴 : 서진수 2번 등장
SELECT name
FROM t_student WHERE deptno2 = 201;

-- #3202
SELECT name
FROM t_student WHERE deptno1 = 101
INTERSECT
SELECT name
FROM t_student WHERE deptno2 = 201;

-- #3203 
SELECT name, POSITION FROM t_professor
ORDER BY 2;

-- 전체명단 - 전임강사 
SELECT name, POSITION FROM t_professor
MINUS
SELECT name, POSITION FROM t_professor WHERE POSITION = '전임강사'











