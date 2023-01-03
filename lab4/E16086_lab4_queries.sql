use company;
-- Issue a select query to view the current status of the departments 
-- table in both sessions.
select * from departments;

-- start transaction running start transaction in both sessions.------------------------------------------
start transaction;

-- Insert a new row into the departments table from the 1st session --------------------------------------
-- and check if the changes are visible in the second session.

-- session I
insert into departments values
 ('d010','Computer Engineering');
 
-- session II
select * from departments;


-- Commit changes in the 1st command window and check if you can------------------------------------------ 
-- see the updates done at 1st window in 2nd command window.

-- session I
commit;

-- session II
select * from departments;

-- Concurrent Transactions--------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------

-- start both transactions
start transaction;

-- session I
update departments
set dept_name = "Chemical and Process Engineering"
where dept_no = "d010";

-- session II
update departments
set dept_name = "Mechanical Engineering"
where dept_no = "d010";



