create database FitnessManagement;

use FitnessManagement;


create table members(
	member_id int primary key IDENTITY(1,1),
	first_name varchar (50),
	last_name varchar (50),
	gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
	date_of_birth DATE,
	phone_number VARCHAR(15),
	email VARCHAR(100)
);

CREATE TABLE rooms (
    room_id INT IDENTITY(1,1) PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(10) CHECK (room_type IN ('Cardio', 'Weights', 'Studio')),
    capacity INT NOT NULL
);


CREATE TABLE memberships (
    membership_id INT IDENTITY(1,1) PRIMARY KEY,
    member_id INT NOT NULL FOREIGN KEY REFERENCES members(member_id),
    room_id INT NOT NULL FOREIGN KEY REFERENCES rooms(room_id),
    start_datee DATE NOT NULL
);


CREATE TABLE departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(100)
);


CREATE TABLE trainers (
    trainer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50),
    department_id INT NOT NULL FOREIGN KEY REFERENCES departments(department_id)
);


CREATE TABLE appointments (
    appointment_id INT IDENTITY(1,1) PRIMARY KEY,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    trainer_id INT NOT NULL FOREIGN KEY REFERENCES trainers(trainer_id),
    member_id INT NOT NULL FOREIGN KEY REFERENCES members(member_id)
);



CREATE TABLE workout_plans (
    plan_id INT IDENTITY(1,1) PRIMARY KEY,
    member_id INT NOT NULL FOREIGN KEY REFERENCES members(member_id),
    trainer_id INT NOT NULL FOREIGN KEY REFERENCES trainers(trainer_id),
    instructions VARCHAR(255)
);


--insertion des donner pour des tests--

INSERT INTO members (first_name, last_name, gender, date_of_birth, phone_number, email) 
VALUES 
('Alex', 'Johnson', 'Male', '1990-07-15', '1234567890', 'alex.johnson@example.com'),
('Maria', 'Lopez', 'Female', '1985-03-22', '0987654321', 'maria.lopez@example.com'),
('Sam', 'Taylor', 'Other', '2000-12-05', '1122334455', 'sam.taylor@example.com');

INSERT INTO rooms (room_number, room_type, capacity) 
VALUES 
('R001', 'Cardio', 20),
('R002', 'Weights', 15),
('R003', 'Studio', 10);

INSERT INTO memberships (member_id, room_id, start_date) 
VALUES 
(1, 1, '2023-01-01'),
(8, 2, '2023-02-15'),
(9, 3, '2023-03-10');

INSERT INTO departments (department_name, location) 
VALUES 
('Cardio', 'Building A'),
('Musculation', 'Building B'),
('Administration', 'Building C');

INSERT INTO trainers (first_name, last_name, specialization, department_id) 
VALUES 
('John', 'Doe', 'Cardio', 1),
('Jane', 'Smith', 'Musculation', 2),
('Mike', 'Brown', 'Weights', 2);

INSERT INTO appointments (appointment_date, appointment_time, trainer_id, member_id) 
VALUES 
('2024-01-15', '09:00:00', 1, 1),
('2024-01-16', '11:00:00', 2, 8),
('2024-01-17', '14:00:00', 3, 9);

INSERT INTO workout_plans (member_id, trainer_id, instructions) 
VALUES 
(1, 1, 'Run on treadmill for 30 minutes daily.'),
(8, 2, 'Weight lifting: 3 sets of 10 reps each.'),
(9, 3, 'Yoga and stretching for 20 minutes.');

------------------------------------------------------

-- select * from members


--ex1--
insert into members (first_name,last_name,gender,date_of_birth,phone_number) values ('Alex','Johnson','Male','1990/07/15','1234567890');
--ex2--
SELECT * FROM departments;
--ex3--
select * from members ORDER BY date_of_birth;
--ex4--
 select DISTINCT gender from members ;
--ex5--
 select * from trainers LIMIT 3;
--ex6--
 select * from members where date_of_birth > '2000-01-01';
--ex7--
 select * from trainers join departments on trainers.department_id = departments.department_id where department_name = 'Musculation' or department_name = 'Cardio';
--ex8--
 select * from memberships where start_date between '2024-12-01' and '2024-12-07';
--ex9--
 ALTER TABLE members
 ADD category_age VARCHAR(10);

 UPDATE members SET category_age = CASE WHEN YEAR(CURDATE()) - YEAR(date_of_birth) < 18 THEN 'Junior' WHEN YEAR(CURDATE()) - YEAR(date_of_birth)<=35 THEN 'Adult' ELSE 'Senior' END;

--ex10--
 select count(appointment_id) from appointments;
--ex11--
 select count(trainer_id),department_id from trainers group by department_id;
--ex12--
 select AVG(DATEDIFF(year,date_of_birth,GETDATE() )) as age_moyen from members; --sql-
 SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS age_moyen FROM members; --mysql--
--ex13--
 select max(appointment_date),max(appointment_time) from appointments;
--ex14--
  select sum(membership_id) , room_id from memberships group by room_id;

--ex15--
  select * from members where email is null;
--ex16--
  select appointment_date,appointment_time , m.first_name, m.last_name,t.first_name, t.last_name from appointments join members m on appointments.member_id = m.member_id join trainers t on appointments.trainer_id = t.trainer_id;
--ex17--
  delete from appointments where appointment_date < '2024-01-01' ;

--ex18--
  update departments SET department_name = 'Force et Conditionnement' where department_name = 'Musculation';
--ex19--
  select gender , count(*) from members group by gender having count(*)>=2;
--ex20--
  create view Abonnements_actifs as select * from memberships where statut = 'en cours';


  alter table memberships add statut varchar (50);--add column for question 20 --

--bonus--
--ex1--
select m.first_name, m.last_name,t.first_name, t.last_name from appointments a join members m on a.member_id = m.member_id join trainers t on a.trainer_id = t.trainer_id;




