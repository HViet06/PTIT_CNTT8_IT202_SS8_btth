create database btthss8;
use btthss8;

create table department(
	dept_id int primary key not null auto_increment,
    dept_name varchar(100) not null,
    location varchar(100)
);

create table employee(
	emp_id int primary key not null auto_increment,
    emp_name varchar(100) not null,
    gender int default(1),
    birth_date date,
    salary decimal,
    dept_id int,
    foreign key (dept_id) references department(dept_id) on update cascade
);

create table project(
	project_id int primary key not null auto_increment,
    project_name varchar(100),
    emp_id int,
    foreign key(emp_id) references employee(emp_id),
    start_date date default(current_date),
    end_date date
);

alter table employee add email varchar(100) unique;
alter table project modify project_name varchar(100);
alter table project add constraint check_date check(end_date>=start_date);


insert into department(dept_id, dept_name, location)
value(1, 'IT', 'Ha Noi'), (2, 'HR', 'HCM'), (3, 'Marketing', 'Da Nang');

insert into employee(emp_id, emp_name, gender, birth_date, salary, dept_id, email)
value(1, 'Nguyen Van A', 1, '1990-01-15', 1500, 1, 'a@gmail.com'),
(2, 'Tran Thi B', 0, '1995-05-20', 1200, 1, 'b@gmail.com'),
(3, 'Le Minh C', 1, '1998-10-10', 2000, 2, 'c@gmail.com'),
(4, 'Phan Thi D', 0, '1992-12-5', 1800, 3, 'd@gmail.com');

insert into project(project_id, project_name, emp_id, start_date, end_date)
value(101, 'Website Redesign', 1, '2024-01-01', '2024-06-01'),
(102, 'Recruitment System ', 3, '2024-02-01', '2024-08-01'),
(103, 'Marketing Campaign ', 3, '2024-03-01', null);

update employee
set salary = salary+200 
where dept_id =1;

update project
set end_date = '2024-12-31'
where end_date is null;

delete from project where start_date<'2024-02-01';



select emp_name, email,
case when gender = 1 then 'Nam' when gender=0 then 'Nu'
end as sex
from employee;

select e.emp_name, e.salary, d.dept_name
from employee e
inner join department d on e.dept_id = d.dept_id;

select emp_name, salary
from employee
order by salary desc
limit 2;

select emp_name, salary
from employee
where salary>(select avg(salary) from employee);
