SELECT * FROM t_professor;

-- null 값과의 산술연산의 결과는 null 이다
SELECT name, pay, bonus, pay + bonus
FROM t_professor;

-- nvl 함수 적용
SELECT name, pay, bonus, pay + NVL(bonus, 0)
FROM t_professor;

-- #4201
SELECT name, pay, NVL(bonus, 0) BONUS, (pay * 12 + NVL(bonus, 0)) 연봉
FROM t_professor WHERE deptno = 101;

-- #4202
SELECT name, pay, NVL(bonus, 0) BONUS, 
	NVL2(bonus, pay * 12 + bonus, pay * 12) 연봉
FROM t_professor WHERE deptno = 101;

-------------------------------------------------------
-- 형변환 함수들

SELECT 1 + 1 FROM dual; 
SELECT 1 + '1' FROM dual;  -- 묵시적 형변환 (implicit casting)
	-- 내부적으로는 아래와 같은 형변환 함수 사용하여 계산
SELECT 1 + TO_NUMBER('1') FROM dual;  -- 명시적형변환 (explicit casting), 형변환 함수 사용

-- 묵시적형변환이 편한것 같지만
-- 성능에서 뜻하지 않는 문제를 가져올수 있다.

-- TO_CHAR 함수 (날짜 -> 문자)
SELECT SYSDATE,
	TO_CHAR(SYSDATE, 'YYYY') 연도4자리,
	TO_CHAR(SYSDATE, 'RRRR') Y2K이후연도4자리,
	TO_CHAR(SYSDATE, 'YY') 연도2자리,
	TO_CHAR(SYSDATE, 'YEAR') 연도영문
FROM dual;

SELECT
	TO_CHAR(SYSDATE, 'MM') 월2자리,
	TO_CHAR(SYSDATE, 'MON') 월3자리,
	TO_CHAR(SYSDATE, 'MONTH') 월전체,
	TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE=ENGLISH') 영문월3자리,
	TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE=ENGLISH') 영문월전체,
	TO_CHAR(SYSDATE, 'month', 'NLS_DATE_LANGUAGE=ENGLISH') "영문월전체(소)",
	TO_CHAR(SYSDATE, 'Month', 'NLS_DATE_LANGUAGE=ENGLISH') "영문월전체(첫글자대)"
FROM dual;

SELECT	
	TO_CHAR(SYSDATE, 'DD') 일숫자2자리,
	TO_CHAR(SYSDATE, 'DDTH') 몇번째날,
	TO_CHAR(SYSDATE, 'DAY') 요일,
	TO_CHAR(SYSDATE, 'Dy') 요일앞자리
FROM dual;

SELECT
	TO_CHAR(SYSDATE, 'HH24') 시24hr,
	TO_CHAR(SYSDATE, 'HH') 시12hr,
	TO_CHAR(SYSDATE, 'MI') 분,
	TO_CHAR(SYSDATE, 'SS') 초
FROM dual;

--- #4301
SELECT SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI:SS YYYY-MM-DD') 날짜
FROM dual;

-- 신용카드 포맷
SELECT TO_CHAR(SYSDATE, 'MM/YY')
FROM dual;

-- 2019년07월16일 21시22분34초  <--- 이렇게 출력?
-- 포맷문자열에 한글표현하려면 " ~ "
SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초"')
FROM dual;


-- #4302
SELECT name, TO_CHAR(birthday, 'YYYY-MM-DD') 생일
FROM t_student
WHERE TO_CHAR(birthday, 'MM') = '03'
;

-- TO_CHAR 함수 (숫자 -> 문자)
SELECT 
	TO_CHAR(1234, '99999') "9하나당 1자리",
	TO_CHAR(1234, '099999') "빈자리 0으로",
	TO_CHAR(1234, '$9999') "빈자리 $로",
	TO_CHAR(1234.1234, '9999.99') "소숫점이하2자리",
	TO_CHAR(1234, '99,999') "천단위 구분기호",
	TO_CHAR(123789, '9,999,999,999') "천단위 구분기호"
FROM dual;

-- #4303
SELECT name, TO_CHAR((pay * 12) + NVL(bonus, 0) , '99,999') 연봉
FROM t_professor WHERE deptno = 101;


-- TO_NUMBER() 함수 - 
-- 문자->숫자로 변환
SELECT '123.44', TO_NUMBER('123.44') FROM dual;

SELECT TO_NUMBER('abc') FROM dual;  -- 에러
SELECT 1 + 'a' FROM dual; -- 에러

-- TO_DATE 함수 
-- 문자 --> 날짜
SELECT TO_DATE('2012-01-01', 'YYYY-MM-DD') TO_DATE결과
FROM dual;

SELECT TO_DATE('04-23-98', 'MM-DD-YY') TO_DATE결과
FROM dual;

-- #4304
SELECT
	name, TO_CHAR(hiredate, 'RRRR-MM-DD') 입사일,
	TO_CHAR(pay * 12, '99,999') 연봉,
	TO_CHAR((pay * 12) * 1.1, '99,999') 인상분
FROM t_professor
WHERE TO_CHAR(hiredate, 'RRRR') < '2000';











