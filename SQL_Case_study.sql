create database Case_study_3

use Case_study_3

CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

select * from employee

select * from department

select * from job

select * from location

select first_name,last_name,salary,comm from employee


select employee_id as id_of_the_employee, last_name as name_of_the_employee ,
department_id as dep_id from employee

select first_name, last_name , salary * 12 as annual_income from employee



select * from employee where last_name ='smith'

select * from employee where department_id=20

select * from employee where salary between 2000 and 3000

select * from employee where department_id in (10,20)

select * from employee where department_id not in (10,20)

select * from employee where first_name like 'l%'

select * from employee where first_name like 'l%e'

select * from employee where len(first_name)=4 and first_name like 'j%'

select * from employee where department_id=30 and salary>2500

select * from employee where comm is null

select employee_id ,last_name from employee order by employee_id asc

select employee_id , first_name from employee order by salary desc

select * from employee order by last_name

select * from employee order by last_name asc, department_id desc

select department_id , max(salary) as max_sal,
min(salary) as min_sal, avg(salary) as avf_sal from employee group by department_id

select job_id , max(salary) as max_sal,min(salary) as min_sal,
avg(salary) as avg_sal from employee group by job_id

select month(hire_date) as mon,
count(*) as coun from employee group by month(hire_date) order by month(hire_date)

select year(hire_date) as yea_r, month(hire_date) as mon_t,count(*) as cou from employee group by(hire_date),
month(hire_date) order by year(hire_date),month(hire_date) 

select department_id from employee group by department_id having count(*) >=4

select count(*) from employee where month(hire_date) in (5,6)

select count(*) from employee where year(hire_date)=1985

select month(hire_date), count(*) from employee where year (hire_date)=1985 group by month(hire_date)

select count(*) from employee where month(hire_date)=4 and year(hire_date) =1985

select department_id from employee where month(hire_date)=4 and
year (hire_date) = 1985 group by department_id having count(*)>=3

select * from employee

select e.*,d.name from employee e join department d on e.department_id=d.department_id

select e.*,j.designation from employee e join job j on e.job_id=j.job_id

select e.first_name, d.name,l.city from employee e join department d on e.department_id=d.department_id join
location l on d.location_id=l.location_id

select d.name,count(*) from employee e join department d on e.department_id =d.department_id group by d.name 

select count(*) from employee e join
department d on e.department_id = d.department_id where d.name ='sales'

select d.name from employee e join
department d on e.department_id=d.department_id group by d.name having count(*)>=3

select count(*) from employee e join
department d on e.department_id=d.department_id join
location l on d.location_id = l.location_id where l.city='dallas'

select * from employee where department_id in 
(select department_id from department where name in ('sales','operations'))

select *,
case
when salary<1500 then 'c'
when salary between 1500 and 3000 then 'B'
else 'A'
end as grade from employee

select grade,count(*)
from 
(
select case 
when salary<1500 then'C'
when salary between 1500 and 3000 then 
'B' 
else 'A' 
end as grade from employee ) x group by grade

select grade, count(*) from ( 
select case when salary between 2000 and 5000 then 'A' end as grade from employee 
) x where grade is not null group by grade


select * from employee where salary =(select max(salary) from employee)

select * from employee where department_id=( select department_id from department where name ='sales')

select * from employee where job_id=(select job_id from job where  designation ='clerk')

select * from employee where department_id =( select department_id from department where location_id=(
select location_id from location where city='boston'))

select count(*) from employee where department_id =(
select department_id from department where name='sales')

update employee set salary =salary * 1.10 where job_id=(select job_id from job where designation ='clerk')

select * from employee where salary =( 
select max(salary) from employee where salary <(select max(salary) from employee ))

select * from employee where salary > all(select salary from employee where department_id=30)

select * from department where department_id not in ( select distinct department_id from employee)

select e.* from employee e 
join 
( select department_id , avg(salary) as avg_salary from employee group by department_id ) d
on e.department_id = d.department_id where e.salary > d.avg_salary

