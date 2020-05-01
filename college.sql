create database college;
use college;

create table stud(
	usn varchar(20),
    sname varchar(20),
    address varchar(20),
    phone varchar(10),
    gender varchar(6),
    primary key(usn)
);

create table semsec(
	ssid int,
    sem int,
    sec varchar(1),
    primary key(ssid)
);

create table class(
	usn varchar(20),
    ssid int,
    primary key(usn,ssid),
    foreign key(usn) references stud(usn),
    foreign key(ssid) references semsec(ssid)
);

create table sub(
	subcode int,
    title varchar(20),
    sem int,
    credits int,
    primary key(subcode)
);

create table iamarks(
	usn varchar(20),
    ssid int,
    subcode int,
    test1 int,
    test2 int,
    test3 int,
    final int,
    primary key(usn),
    foreign key(usn) references stud(usn),
    foreign key(ssid) references class(ssid),
    foreign key(subcode) references sub(subcode)
);

insert into stud values('1BI15CS101','abhishek','basavnagar','1234567890','Male'),
('1BI15CS102','akshay','jalhalli','0987654321','Male'),
('1BI15CS103','akul','balajinagar,','1357908642','male'),
('1BI15CS104','apoorva','sai nagar','1234509876','female'),
('1BI15CS105','anvit','basavanagudi','1029384756','male');

insert into semsec values(1,2,'A'),(2,2,'B'),(3,2,'C'),(4,2,'D'),(5,2,'E');

insert into class values('1BI15CS101',1),('1BI15CS102',2),('1BI15CS103',3),('1BI15CS104',4),('1BI15CS105',5);

insert into sub values(1,'maths',2,4),(2,'dbms',2,4),(3,'os',2,4),(4,'tfcs',2,3),(5,'ada',2,4);

insert into iamarks values('1BI15CS101',1,1,80,81,82,83),('1BI15CS102',2,2,90,91,92,93),('1BI15CS103',3,3,69,59,76,87),
('1BI15CS104',4,4,67,85,75,99),('1BI15CS105',5,5,50,85,66,90);


select stud.* 
from stud, semsec,class
where stud.usn = class.usn and class.ssid = semsec.ssid and semsec.sem = 2 and semsec.sec = 'C';

select semsec.sem,semsec.sec,count(stud.gender)
from semsec,stud,class
where stud.usn = class.usn and class.ssid = semsec.ssid
group by stud.gender, semsec.sec, semsec.sem;


create view test1marks as
select test1,test2,test3,final
from iamarks,sub
where iamarks.subcode = sub.subcode and iamarks.usn = '1BI15CS101';

alter table iamarks
add column cat varchar(10);

update iamarks,class,semsec
set iamarks.cat = 'Very good'
where iamarks.final > 80 and iamarks.final <= 100 and iamarks.usn = class.usn and class.ssid = semsec.ssid and sem = 2 and sec in ('A','B','C'); 