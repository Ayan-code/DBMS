create database StudentFac;
use StudentFac;

create table student(
snum int,
sname varchar(20),
major varchar(20),
lvl varchar(20),
age int,
primary key(snum)
);

create table class(
cname varchar(20),
meet_at time,
room varchar(20),
fid int,
primary key(cname),
foreign key(fid) references faculty(fid)
);

create table enrolled(
snum int,
cname varchar(20),
primary key(snum,cname),
foreign key(snum) references student(snum),
foreign key(cname) references class(cname)
);

create table faculty(
fid int,
fname varchar(20),
deptid int,
primary key(fid)
);