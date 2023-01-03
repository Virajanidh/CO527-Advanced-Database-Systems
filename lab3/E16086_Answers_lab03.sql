show databases;
use company;
show tables;
show index from employees;

-- drop indexes
drop index emp_ix on employees;
drop index fname_index on employees;

-- check indexes
show index from employees;

-- Question 01 part I
EXPLAIN SELECT * FROM departments WHERE dept_name = "Finance";

-- Question 01 part II
EXPLAIN SELECT * FROM departments WHERE dept_no ="d002";

-- Question 02

create table emplist select emp_no, first_name from employees;
create table titleperiod select emp_no, title, datediff(to_date, from_date) as period FROM titles;

EXPLAIN SELECT first_name, period from emplist inner join titleperiod
on titleperiod.emp_no = emplist.emp_no
where period>4000;