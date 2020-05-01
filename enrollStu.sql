create database studEnroll;
use studEnroll;


create table enroll(
	regno int,
    cname varchar(30),
    sem int,
    marks int,
    primary key(regno)
);


create table stud(
	regno int,
    sname varchar(30),
    major varchar(30),
    bdate date,
    primary key(regno),
    foreign key(regno) references enroll(regno)
);

create table course(
	courseno int,
    cname varchar(30),
    dept varchar(30),
    primary key(courseno)
);

create table Txt(
	bookisbn int,
    title varchar(30),
    publisher varchar(30),
    author varchar(30),
    primary key(bookisbn)
);

create table bookAdop(
	courseno int,
    sem int,
    bookisbn int,
    primary key(bookisbn),
    foreign key(courseno) references course(courseno),
    foreign key(bookisbn) references Txt(bookisbn)
);

insert into enroll values(1,'CS',2,88),(2,'IS',2,68),(3,'EC',2,88),(4,'ME',2,100),(5,'AE',2,58);

insert into stud values(1,'abhishek','CS','2020-01-01'),(2,'amit','EC','2020-02-02'),(3,'arjun','IS','2020-03-03'),
(4,'ankush','ME','2020-04-04'),(5,'akshi','AE','2020-05-05');

insert into course values(1,'CS','CS'),(2,'IS','IS'),(3,'AE','AE'),(4,'ME','ME'),(5,'EC','EC');

insert into Txt values(1,'Computers','aravind','bheemsen'),(2,'Information Science','ajit','manju'),
(3,'Aerospace Engineering','kiran','pratham'),(4,'Mechanical Engineering','abhiram','anant'),(5,'Electrical','Ram','lakshman');

insert into bookAdop values(1,2,1),(2,2,2),(3,2,3),(4,2,4),(5,2,5);

insert into Txt values(6,'Medical','Arati','pratham');
insert into bookAdop values(1,2,6);


select  bookAdop.courseno,Txt.bookisbn,Txt.title
from bookAdop,Txt,course
where Txt.bookisbn = bookAdop.bookisbn and course.courseno = bookAdop.courseno and course.cname = 'CS'
order by title asc;


select course.dept
from course,Txt,bookAdop
where publisher = 'bheemsen' and Txt.bookisbn = bookAdop.bookisbn and bookAdop.courseno = course.courseno
group by Txt.publisher;
