create database Flight;
use Flight;
create table flights(
	flno int,
    frm varchar(20),
    dest varchar(20),
    dist int,
    departs time,
    arrives time,
    price int,
    primary key(flno)
);

create table aircraft(
	aid int,
    aname varchar(20),
    cruisningrange int,
    primary key(aid)
);

create table emp(
	eid int,
    ename varchar(20),
    salary int,
    primary key(eid)
);

create table certified(
	eid int,
    aid int,
    primary key(eid,aid)
);

insert into flights values(1001,'Delhi','Goa',1700,'12:00:00','1:00:00',10000),
(1002,'Delhi','kolkata',700,'7:00:00','7:30:00',8000),
(1003,'Bangalore','Goa',700,'9:00:00','9:30:00',8000),
(1004,'Bangalore','Delhi',2200,'6:00:00','8:00:00',15000);

insert into flights values(1005,'Bangalore','frankfurt',20000,'4:00:00','11:45:00',25000);

insert into aircraft values(11001,'boeing',10000),(11002,'aurora',7000),(11003,'autogyro',4000),
(11004,'stealth',2500);

insert into emp values(20101,'steve',95000),(20102,'Peter',55000),(20103,'Stan',80000),
(20104,'amar',100000),(20105,'paul',75000);
insert into emp values(20106,'drew',100000);

insert into certified values(20101,11001),(20102,11002),(20104,11003),(20105,11004); 


select aname 
from aircraft,emp,certified
where certified.aid=aircraft.aid and certified.eid = emp.eid and emp.salary>80000;

select emp.eid,aircraft.cruisningrange
from emp,aircraft,certified
where exists(select * from certified group by eid having count(aid)>3);

select emp.ename
from emp,flights
where emp.salary < (select min(price) from flights where frm='Bangalore' and dest='frankfurt');

select aircraft.aname,avg(emp.salary)
from aircraft,emp,certified
where aircraft.cruisningrange > 1000 and emp.eid = certified.eid and aircraft.aid = certified.aid
group by aircraft.aname;

select emp.ename 
from emp,certified,aircraft
where emp.eid = certified.eid and aircraft.aid = certified.aid and aircraft.aname = 'boeing';

select flights.dest
from flights 
where dest='delhi' and frm!='Bangalore';

select emp.ename,emp.salary
from emp,certified
where not exists(select certified.eid from certified) and emp.salary > (select avg(emp.salary) 
from emp,certified where exists(select certified.eid from certified));