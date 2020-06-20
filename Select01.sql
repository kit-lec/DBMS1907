-- dual 은 row 1개 짜리 dummy table;
SELECT '안녕하세요' FROM dual;

SELECT 'ABCD' FROM phonebook;

SELECT 100 FROM dual;

SELECT * FROM t_emp;  -- emp 테이블에서 모든 컬럼(*) SELECT 한다

-- 원하는 컬럼만 조회(SELECT)
-- t_emp 테이블에서 직원번호(empno) 와 직원이름(ename) 만 SELECT
SELECT empno, ename FROM t_emp;
SELECT ename, empno FROM t_emp;

SELECT name FROM t_professor;
SELECT name, '교수님 싸랑해요~' FROM t_professor;

-- 컬럼 별칭(alias) 사용하여 SELECT
SELECT studno, name FROM t_student;
SELECT studno 학번, name 이름 FROM t_student;

-- alias 에 띄어쓰기가 있으면 쌍따옴표로 묶어주기
SELECT studno "학생 번호", name AS 이름 FROM t_student;

-- t_emp 테이블에서  empno 를 사원번호,  ename을 사원명,  
-- job을 직업으로 별명을 설정하여 출력
SELECT empno 사원번호, ename 사원명, job 직업
FROM t_emp;


-- t_dept 테이블을 사용하여 
-- deptno를 ‘부서#’, dname을 ‘부서명’, 
-- loc를 ‘위치’ 로 별명을 설정하여 출력
SELECT deptno "부서#", dname "부서명", loc "위치"
FROM t_dept;

-- DISTINCT : 중복값 제거하고 출력
-- SELECT DISTINCT [컬럼명 또는 표현식] FROM [테이블, 뷰]

SELECT deptno FROM t_emp;
SELECT DISTINCT deptno FROM t_emp;

-- 학생테이블(t_student) 에서 제1전공 (deptno1) 을 중복값을 제거하여 출력해보기
SELECT DISTINCT deptno1 FROM t_student;

-- DISTINCT 앞에 컬럼 올수 없다.
-- 다른 컬럼과 같이 출력시에는 최초 값 하나만 추출됨.
SELECT DISTINCT deptno1, name FROM t_student;

-- 직원(t_emp) 들의 직책(job) 을 중복값 제거하여 출력해보기
SELECT DISTINCT job FROM t_emp;

-- || : 필드, 문자열 연결
SELECT name, position FROM t_professor;
SELECT name || '-' ||  POSITION AS "교수님 목록" FROM t_professor;

-- 학생테이블(student)를 사용하여 
-- 모든 학생들이 
-- ‘서진수의 키는 180cm, 몸무게는 55kg 입니다’ 
-- 와 같은 형식으로 출력되도록 문자를 추가하고, 
-- 칼럼 이름은 ‘학생의 키와 몸무게’ 라는 별명으로 출력하세요	

SELECT  
	name || '의 키는' || 
	height || 'cm, ' || 
	'몸무게는 ' || weight || 
	'kg 입니다' "학생의 키와 몸무게"
FROM t_student

-- 산술연산자
-- +, -, *, / 

-- 직원테이블(t_emp) 직원이름(ename), 급여(sal), 2.5% 상승분 SELECT
SELECT ename, sal, sal * 1.025 "급여 2.5% 인상분" FROM t_emp;

SELECT * FROM t_emp;

-- 일반 산술연산에 null 값과의 연산 결과는 --> null !!!
SELECT sal, comm, sal + comm FROM t_emp;

-- WHERE 조건절 : 원하는 조건에 맞는 레코드만 검색

-- SELECT [컬럼명, 표현식]
-- FROM [테이블, 뷰]
-- WHERE [조건식]

-- 직원테이블에 직책(job)이 SALESMAN 인 사람만 조회
SELECT * FROM t_emp WHERE job = 'SALESMAN';

-- 직원 테이블(t_emp) 에서 10번 부서(deptno)에 근무하는 직원의  
-- 원의 이름(ename)과 급여(sal)와 부서번호(deptno) 출력
SELECT ename, sal, deptno FROM t_emp WHERE deptno = 10;

--직원 테이블(t_emp) 에서 급여(sal) 가 2000보다 큰 사람의 
--이름(ename)과 급여(sal)를 출력하세요
SELECT ename, sal FROM t_emp WHERE sal > 2000;

--직원 테이블(t_emp) 에서 이름이 SCOTT인 사람의 
--이름(ename)과 사원번호(empno), 급여(sal) 출력
SELECT ename, empno, sal FROM t_emp WHERE ename = 'SCOTT';

-- 연습
-- 학생 테이블(t_student) 에서
-- 2,3 학년(grade) 학생의  이름(name), 학년(grade) 출력

-- OR, AND, NOT

SELECT name, grade FROM t_student
WHERE grade = 2 OR grade = 3;

SELECT name, grade FROM t_student
WHERE grade IN (2, 3);  -- IN (값1, 값2, ...   )

SELECT name, grade FROM t_student
WHERE grade NOT IN (1, 4);  -- IN (값1, 값2, ...   )

SELECT name, grade FROM t_student
WHERE grade BETWEEN 2 AND 3;

SELECT name, grade FROM t_student
WHERE grade > 1 AND grade < 4;


-- LIKE 연산자
SELECT ename FROM t_emp WHERE ename LIKE 'A%';

-- 교수님(t_professor) 중에서 
-- '김'씨 성을 가진 교수님만 이름 (name)출력 (LIKE 사용)
SELECT name FROM t_professor WHERE name LIKE '김%';

-- 직원테이블 (t_emp) 에서 직원이름(ename) 중에
-- NE 가 포함된 직원만 출력
SELECT ename FROM t_emp WHERE ename LIKE '%NE%';

-- 직원테이블(t_emp) 에서 직원이름(ename) 의
-- 두번째 글자가 'A' 인 사람의 이름(ename) 출력
SELECT ename FROM t_emp WHERE ename LIKE '_A%'

-- 보너스(bonus) 를 못받는 교수님의 이름(name) 과 직급(position) 을 SELECT
SELECT * FROM t_professor;
SELECT name, position FROM t_professor
WHERE bonus IS NULL; -- null 여부

SELECT name, position FROM t_professor
WHERE bonus IS NOT NULL; 

-- ORDER BY [컬럼, 컬럼번호] : SELECT 결과 정렬
-- 직원(t_emp) 중 이름(ename) 에 L 이 들어간 사람의 이름을 
-- 사전오름차순으로 정렬하여 SELECT 하기
SELECT ename FROM t_emp WHERE ename LIKE '%L%'
ORDER BY ename ASC  -- 오름차순 (ASC 생략가능)
;

-- 내림차순 정렬 
SELECT ename FROM t_emp WHERE ename LIKE '%L%'
ORDER BY ename DESC -- 내림차순
;


-- 직원(t_emp) 의 이름, 직책, 급여를 SELECT 하되
-- 우선은 직책(job) 내림차순으로 
-- 그리고 급여(sal) 오름차순으로 SELECT 하기
SELECT ename, job, sal FROM t_emp
ORDER BY job DESC, sal ASC
;




























