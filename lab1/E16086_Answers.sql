use company;
-- Question1
SELECT count(*) FROM departments;
SELECT count(*) FROM dept_emp;
SELECT count(*) FROM dept_manager;
SELECT count(*) FROM employees;
SELECT count(*) FROM salaries;
SELECT count(*) FROM titles;

-- Question 2
select last_name from employees group by last_name order by count(*) DESC limit 10;

-- Question 3
select dept_name, count(*) 
from titles,departments,dept_emp, employees
where employees.emp_no = titles.emp_no and departments.dept_no = dept_emp.dept_no and 
dept_emp.emp_no = employees.emp_no and titles.title = "Engineer" and titles.to_date >= curdate()
group by departments.dept_no;

-- Question 4
select employees.emp_no, concat(first_name," ",last_name) as emp_name, dept_no
from employees, dept_manager, titles
where employees.sex='F' and employees.emp_no =dept_manager.emp_no 
and employees.emp_no = titles.emp_no and  titles.title = "Senior Engineer";

-- Question 5  -- part1
select departments.dept_no , dept_name , title
from departments, salaries, employees, titles, dept_emp
where dept_emp.emp_no = salaries.emp_no and salaries.salary > 115000
and dept_emp.emp_no = titles.emp_no and departments.dept_no = dept_emp.dept_no
and employees.emp_no = dept_emp.emp_no
and salaries.to_date>=CURDATE() and titles.to_date>=CURDATE()
and dept_emp.to_date>=CURDATE()
order by departments.dept_no;

-- Question 5 --part2 -- display how many of employees work for each depart- ment.
select departments.dept_no , dept_name , title, count(*) as total_employees
from departments, salaries, employees, titles, dept_emp
where dept_emp.emp_no = salaries.emp_no and salaries.salary > 115000
and dept_emp.emp_no = titles.emp_no and departments.dept_no = dept_emp.dept_no
and employees.emp_no = dept_emp.emp_no
and salaries.to_date>=CURDATE() and titles.to_date>=CURDATE()
and dept_emp.to_date>=CURDATE()
group by departments.dept_no
order by departments.dept_no;

-- Question 6
select  concat(first_name,' ',last_name) as emp_name, timestampdiff(year,birth_date,CURDATE()) as age, 
hire_date, timestampdiff(year,hire_date,CURDATE()) as years_of_service
from employees,titles
where timestampdiff(year,birth_date,CURDATE())>50 and timestampdiff(year,hire_date,CURDATE())>10
and titles.to_date >= CURDATE() and titles.emp_no=employees.emp_no;

-- Question 7
select concat(first_name,' ',last_name) as emp_name
from employees, departments, dept_emp
where employees.emp_no = dept_emp.emp_no and departments.dept_no =dept_emp.dept_no
 and dept_name != 'Human Resources';
 
 -- Question 8
 select distinct first_name,last_name
 from employees,departments, dept_emp,salaries
 where employees.emp_no = dept_emp.emp_no and departments.dept_no =dept_emp.dept_no and
 employees.emp_no =salaries.emp_no and salaries.to_date >= CURDATE() and salary > (select max(salary) 
 from salaries, employees,departments, dept_emp where employees.emp_no = dept_emp.emp_no and 
 departments.dept_no =dept_emp.dept_no and
 employees.emp_no =salaries.emp_no and dept_name='Finance');
 
 -- Question 9
select distinct first_name, last_name
from employees,salaries
where employees.emp_no =salaries.emp_no and salaries.to_date >=curdate() and salary >(select avg(salary) 
from salaries where salaries.to_date>=CURDATE());
 
-- Question 10
select  
(select avg(salary) from employees, salaries, titles 
where employees.emp_no=salaries.emp_no and employees.emp_no=titles.emp_no 
and titles.title='Senior Engineer'and titles.to_date>=curdate() and salaries.to_date>=curdate())- 
(select avg(salary) 
from salaries where  salaries.to_date>=curdate()) as difference;

-- Question 11
create view current_dept_emp as
select employees.emp_no , dept_emp.from_date , dept_emp.to_date
from employees 
inner join dept_emp 
on employees.emp_no = dept_emp.emp_no
where dept_emp.to_date >= curdate() ;

-- Question 12
select e.emp_no, de.from_date, de.to_date
from employees e
inner join dept_emp de
on de.emp_no = e.emp_no
where de.to_date >= curdate() ;

-- Question 13
create table emp_salary_change
	(
		old_salary int,
		new_salary int,
		difference int,
		action VARCHAR(50) DEFAULT NULL
	);
	
	delimiter $
	create trigger after_salaries_update
	after update on salaries
	for each row
	begin 
	insert into emp_salary_change
	SET action = 'update',
    old_Salary = old.salary,
    new_Salary = new.salary,
    difference = new.salary-old.salary; 
	end $
	delimiter ;
    
-- Question 14
delimiter $
	
	create trigger error_salary_update
	before update on salaries
	for each row
	begin
	declare msg varchar(50);
	if(new.salary-old.salary)>(old.salary*0.1)then
		set msg ="Error : Salary increment > 10%";
		signal sqlstate '45000' set message_text = msg;
	end if;
	end $
	delimiter ;
