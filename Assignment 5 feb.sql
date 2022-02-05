-- Display all the information of the EMP table?
SELECT * FROM emp; 

-- Display unique Jobs from EMP table?
SELECT DISTINCT job 
 FROM emp ;
 
--  List the emps in the asc order of their Salaries?
SELECT empno, ename, sal
FROM emp
ORDER BY sal;

-- List the details of the emps in asc order of the Dptnos and desc of Jobs?
SELECT empno,ename,sal,deptno,job FROM emp ORDER BY deptno, job desc;

--Display all the unique job groups in the descending order?
SELECT DISTINCT job FROM emp ORDER BY job desc ;

-- Display all the details of all ‘Mgrs’
Select * from emp where empno in ( select mgr from emp) ;

-- List the emps who joined before 1981
SELECT empno, ename, sal, hiredate FROM emp WHERE hiredate<('01-01-81');

-- List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal
select empno ,ename ,sal,sal/30,12*sal annsal from emp order by annsal asc;

-- Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
SELECT Empno, Ename, job, Hiredate,mgr, months_between(sysdate,hiredate) EXP FROM emp where empno in ( select mgr from emp);

--List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369
select empno,ename,sal from emp where mgr = 7369;

--Display all the details of the emps whose Comm  Is more than their Sal
select * from emp where comm > sal;

-- List the emps along with their Exp and Daily Sal is more than Rs 100
select empno, ename, sal, sal/30 daily, months_between(sysdate,hiredate) exp from emp where (sal/30) > 100;

-- List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order
SELECT * FROM emp WHERE job='CLERK' OR job='ANALYST' ORDER BY job DESC;

-- List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order of seniority
SELECT empno,ename,sal FROM emp WHERE hiredate IN ('01-05-81','03-12-81','19-01-80') ORDER BY hiredate ASC;

-- List the emp who are working for the Deptno 10 or20
SELECT  empno,ename,deptno FROM emp WHERE  deptno=10 or deptno=20;

-- List the emps who are joined in the year 81
select empno,ename,deptno from emp where hiredate between '01-01-81' and '31-12-81';

--List the emps Who Annual sal ranging from 22000 and 45000
select * from emp where 12*sal between 22000 and 45000;

-- List the Enames those are having five characters in their Names
 select ename from emp where length (ename) = 5;
 
--  List the Enames those are starting with ‘S’ and with five characters
select ename from emp where ename like 'S%' and length (ename) = 5; 

-- List the emps those are having four chars and third character must be ‘r’
select empno,ename,deptno from emp where length(ename) = 4 and ename like '__R%';

-- List the Five character names starting with ‘S’ and ending with ‘H’
 select empno,ename,deptno from emp where length(ename) = 5 and ename like 'S%H'; 
 
--  List the emps who joined in January
select empno,ename,deptno,hiredate from emp where to_char (hiredate,'mon') = 'jan'; 

-- List the emps whose names having a character set ‘ll’ together
select empno,ename,deptno,hiredate from emp where ename like '%LL%'; 

--List the emps who does not belong to Deptno 20
select empno,ename,deptno,hiredate from emp where deptno!= 20;

-- List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries
select empno,ename,deptno,hiredate,job,sal from emp where job not like 'PRESIDENT' and job not like 'MANAGER' order by sal asc; 

-- List the emps whose Empno not starting with digit78
select empno,ename,deptno,hiredate,job,sal from emp where empno not like '78%';

-- List the emps who are working under ‘MGR’
select e.ename || ' works for ' || m.ename from emp e ,emp m where e.mgr = m.empno ;

-- List the emps who joined in any year but not belongs to the month of March
select empno,ename,deptno,hiredate,job,sal from emp where to_char (hiredate,'MON') != 'MAR'; 

-- List all the Clerks of Deptno 20
select * from emp where job ='CLERK' and deptno = 20; 

-- List the emps of Deptno 30 or 10 joined in the year 1981
select empno,ename,deptno,hiredate,job,sal from emp where to_char(hiredate,'YYYY') = '1981' and (deptno =30 or deptno =10) ; 

-- Display the details of SMITH
select empno,ename,deptno,hiredate,job,sal from emp where ename = 'SMITH' ; 

-- Display the job of SMITH
select job from emp e , dept d where e.ename = 'SMITH' and e.deptno = d.deptno ;