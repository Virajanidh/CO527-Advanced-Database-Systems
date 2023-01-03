-- Question 3 --------------------------------------------------------------------------------------------

CREATE USER 'user1'@'localhost' 
IDENTIFIED BY 'password1';

-- Question 4 --------------------------------------------------------------------------------------------

use company_security;

-- Question 5 --------------------------------------------------------------------------------------------

GRANT SELECT 
ON company_security.employee
TO 'user1'@'localhost';

-- Question 6 --------------------------------------------------------------------------------------------

select * from employee;
INSERT INTO EMPLOYEE 
VALUES('Hasara','B','Smith',123456788,'1965-01-09','731 Fondren, Housten, TX','M', 30000,'333445555',5);
GRANT INSERT
ON company_security.employee
TO 'user1'@'localhost';

-- Question 7 --------------------------------------------------------------------------------------------

GRANT SELECT 
ON company_security.works_on
TO 'user1'@'localhost';

GRANT CREATE VIEW
ON company_security.*
TO 'user1'@'localhost';

CREATE VIEW WORKS_ON1 AS
SELECT employee.Fname,employee.Lname,works_on.Pno
FROM employee,works_on
WHERE employee.ssn=works_on.Essn;

CREATE USER 'user2'@'localhost' IDENTIFIED BY 'password2';

GRANT SELECT 
ON company_security.works_on1
TO 'user2'@'localhost';

-- Question 8 --------------------------------------------------------------------------------------------
 
 SELECT * FROM works_on1;

-- Question 9 -------------------------------------------------------------------------------------------- 

REVOKE
SELECT
ON company_security.works_on
FROM 'user1'@'localhost';

REVOKE
SELECT
ON company_security.employee
FROM 'user1'@'localhost';

SELECT * FROM works_on1;

--   Assignment  -----------------------------------------------------------------------------------------

use company_security;

CREATE USER 'A'@'localhost' IDENTIFIED BY 'passwordA';
CREATE USER 'B'@'localhost' IDENTIFIED BY 'passwordB';
CREATE USER 'C'@'localhost' IDENTIFIED BY 'passwordC';
CREATE USER 'D'@'localhost' IDENTIFIED BY 'passwordD';
CREATE USER 'E'@'localhost' IDENTIFIED BY 'passwordE';

-- i 

GRANT SELECT, UPDATE ON company_security.EMPLOYEE TO 'A'@'localhost' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON company_security.DEPARTMENT TO 'A'@'localhost' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON company_security.DEPT_LOCATIONS TO 'A'@'localhost' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON company_security.PROJECT TO 'A'@'localhost' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON company_security.WORKS_ON TO 'A'@'localhost' WITH GRANT OPTION;

-- ii 

CREATE VIEW empDetails AS
SELECT Fname, Minit, Lname, Ssn, Bdate, Address,sex
Supper_ssn,Dno
FROM EMPLOYEE;

GRANT SELECT ON empDetails
TO 'B'@'localhost';

CREATE VIEW deptDetails AS
SELECT Dname, Dnumber
FROM DEPARTMENT;

GRANT SELECT ON deptDetails
TO 'B'@'localhost';

-- iii 

GRANT SELECT, UPDATE
ON WORKS_ON
TO 'C'@'localhost';

CREATE VIEW empd2 AS
SELECT Fname, Minit, Lname, Ssn
FROM EMPLOYEE;

GRANT SELECT ON empd2
TO 'C'@'localhost';

CREATE VIEW projd2 AS
SELECT Pname, Pnumber
FROM PROJECT;

GRANT SELECT ON projd2
TO 'C'@'localhost';

-- iv 
 
GRANT SELECT ON EMPLOYEE TO 'D'@'localhost';
GRANT SELECT ON DEPENDENT TO 'D'@'localhost';
GRANT UPDATE ON DEPENDENT TO 'D'@'localhost';

-- v 

CREATE VIEW dno3_emp AS
SELECT * FROM EMPLOYEE
WHERE DNO = 3;
GRANT SELECT ON dno3_emp
TO 'E'@'localhost';