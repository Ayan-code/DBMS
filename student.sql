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

INSERT INTO STUDENT VALUES(1, 'jhon', 'CS', 'Sr', 19),(2, 'Smith', 'CS', 'Jr', 20),(3 , 'Jacob', 'CV', 'Sr', 20),(4, 'Tom ', 'CS', 'Jr', 20),
(5, 'Rahul', 'CS', 'Jr', 20),(6, 'Rita', 'CS', 'Sr', 21);

INSERT INTO FACULTY VALUES(11, 'Harish', 1000),(12, 'MV', 1000),(13 , 'Mira', 1001),(14, 'Shiva', 1002)(15, 'Nupur', 1000);

insert into class values('class1', '12/11/15 10:15:16', 'R1', 14),('class10', '12/11/15 10:15:16', 'R128', 14),
('class2', '12/11/15 10:15:20', 'R2', 12),('class3', '12/11/15 10:15:25', 'R3', 12),('class4', '12/11/15 20:15:20', 'R4', 14),
('class5', '12/11/15 20:15:20', 'R3', 15),('class6', '12/11/15 13:20:20', 'R2', 14),('class7', '12/11/15 10:10:10', 'R3', 14);

insert into enrolled values(1, 'class1'),(2, 'class1'),(3, 'class3'),(4, 'class3'),(5, 'class4'),(2, 'class5'),(2, 'class5'),
(4, 'class5'),(5, 'class5');

SELECT DISTINCT S.Sname
FROM Student S, Class C, Enrolled E, Faculty F
WHERE S.snum = E.snum AND E.cname = C.cname AND C.fid = F.fid AND
F.fname = ‘Harish’ AND S.lvl = ‘Jr’;

SELECT C.cname
FROM Class C
WHERE C.room = ‘R128’
OR C.cname IN (SELECT E.cname
		FROM Enrolled E
		GROUP BY E.cname
		HAVING COUNT (*) >= 5);

SELECT DISTINCT S.sname
FROM Student S
WHERE S.snum IN (SELECT E1.snum
			FROM Enrolled E1, Enrolled E2, Class C1, Class C2
			WHERE E1.snum = E2.snum AND E1.cname <> E2.cname
			AND E1.cname = C1.cname
			AND E2.cname = C2.cname AND C1.meets_at = C2.meets_at);
      
      
SELECT DISTINCT F.fname
FROM Faculty F
WHERE NOT EXISTS ((SELECT C.roomFROM Class C )
				MINUS
				(SELECTC1.room
				FROM Class C1
				WHERE C1.fid = F.fid ));
         
         
SELECT DISTINCT F.fname
FROM Faculty F
WHERE 5 > (SELECT COUNT (E.snum)
FROM Class C, Enrolled E
WHERE C.cname = E.cname
AND C.fid = F.fid)

SELECT DISTINCT S.sname
FROM Student S
WHERE S.snum NOT IN (SELECT E.snum
FROM Enrolled E );
