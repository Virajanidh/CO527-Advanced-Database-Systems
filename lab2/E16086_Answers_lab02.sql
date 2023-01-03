use company;

-- The Session Profiler captures the state of the
set session profiling=1;

-- Question 1 -------------------------------------------------------------------------------------
select * from employees order by first_name ASC;
show profiles;

-- Question 2 -------------------------------------------------------------------------------------
create index fname_index  on employees(first_name);
select * from employees order by first_name ASC;
show profiles;

-- Question 3 -------------------------------------------------------------------------------------
show index from employees;
show profiles;

-- Question 4 -------------------------------------------------------------------------------------
create unique index emp_ix on employees(emp_no, first_name, last_name);
select * from employees order by first_name ASC;
show profiles;

-- Question 5 Part I ------------------------------------------------------------------------------
create index frmDt on dept_manager(from_date);

-- Question 5 Part II ------------------------------------------------------------------------------
-- Query A
EXPLAIN select distinct emp_no from dept_manager where from_date>='1985-01-01' and dept_no >= 'd005';

-- Query B
EXPLAIN select distinct emp_no from dept_manager where from_date>= '1996-01-03' and dept_no >= 'd005';

-- Query C
EXPLAIN select distinct emp_no from dept_manager where from_date>='1985-01-01' and dept_no <= 'd009';

-- Question 7 -------------------------------------------------------------------------------------

-- check for unique index
select * from employees where emp_no="44444523";

-- remove index  for first name
drop index fname_index on employees;

-- insert values for employee table
INSERT INTO employees(emp_no, birth_date, first_name, last_name, sex, hire_date) 
VALUES (44444523,'1980-05-23','Nelum','Perera','F','1998-03-01');

-- update values in employees table
UPDATE employees SET first_name='Nelumi' where emp_no = 44444523;

-- delete values in employees table
DELETE FROM employees WHERE emp_no='44444523' and first_name="Nelum";

show profiles;



