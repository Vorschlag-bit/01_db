-- 1)
SELECT
		 *
  FROM employee;
  
-- 2)
SELECT
		 EMP_ID
	  , EMP_NAME 
  FROM employee;
  
-- 3)
SELECT
		 EMP_ID
	  , EMP_NAME
  FROM employee
 WHERE EMP_ID = 201;
 
-- 4)
SELECT
		 EMP_NAME
  FROM employee
 WHERE DEPT_CODE = 'D9';
 
-- 5)
SELECT
		 EMP_NAME
  FROM employee
 WHERE JOB_CODE = 'J1';
 
-- 6)
SELECT
		 EMP_ID
	  , EMP_NAME
	  , DEPT_CODE
	  , SALARY
  FROM employee
 WHERE SALARY >= 3000000;
 
-- 7)
SELECT
		 EMP_NAME
	  , DEPT_CODE
	  , SALARY
  FROM employee
 WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;
 
-- 8)
SELECT
		 EMP_ID
	  , EMP_NAME
	  , SALARY
	  , BONUS
  FROM employee
 WHERE BONUS IS NULL;
 
-- 9)
SELECT
		 EMP_ID
	  , EMP_NAME
	  , DEPT_CODE
  FROM employee
 WHERE DEPT_CODE != 'D9';
 
-- 10)
SELECT
		 EMP_NAME AS '존함'
  FROM employee
 WHERE ENT_YN = 'N';