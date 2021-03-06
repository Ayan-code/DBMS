create database Bank;
use Bank;

drop table Branch;
create table Branch(
branch_name varchar(30),
branch_city varchar(30),
assets REAL,
primary key(branch_name));

create table ACCOUNTS(
accno int,
branch_name varchar(30),
balance REAL,
primary key(accno),
foreign key(branch_name)references Branch(branch_name));

drop table DEPOSITOR;
create table Depositor(
cust_name varchar(30),
accno int,
primary key(cust_name,accno));
alter table Depositor add foreign key(accno) references ACCOUNTS(accno);

drop table BORROWER;
create table BankCust(
cust_name varchar(30),
cust_street varchar(30),
city varchar(30),
primary key(cust_name));


create table lon(
loan_num int,
branch_name varchar(30),
amount real,
primary key(loan_num),
foreign key(branch_name)references Branch(branch_name));

insert into Branch values ('SBI_Chamrajpet','Bangalore',50000),('SBI_ResidencyRoad','Bangalore',10000),
('SBI_ShivajiRoad','Bombay',20000),('SBI_ParlimentRoad','Delhi',10000),('SBI_Jantarmantar','Delhi',20000);

insert into ACCOUNTS values(1,'SBI_Chamrajpet',2000),(2,'SBI_ResidencyRoad',5000),(3,'SBI_ShivajiRoad',6000),
(4,'SBI_PArlimentRoad',9000),(5,'SBI_Jantarmantar',8000),(6,'SBI_ShivajiRoad',4000),(7,'SBI_ResidencyRoad',4000),
(8,'SBI_ResidencyRoad',4000),(9,'SBI_ResidencyRoad',3000),(10,'SBI_ResidencyRoad',5000),
(11,'SBI_Jantarmantar',2000);

insert into BankCust values('Avinash','Bull_temple_road','Bangalore'),('Dinesh','Bannergatta_road','Bangalore'),
('Mohan','NationalCollege_road','Bangalore'),('Nikil','Akbar_road','Delhi'),('Ravi','Prithviraj_road','Delhi');

insert into Depositor values('Avinash',1),('Dinesh',2),('Nikil',4),('Ravi',5),('Avinash',8),('Nikil',9),('Dinesh',10),
('Nikil',11);

insert into lon values(1,'SBI_Chamrajpet',1000),(2,'SBI_ResidencyRoad',2000),(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParlimentRoad',4000),(5,'SBI_Jantarmantar',5000);

select distinct(cust_name)
from Depositor
where accno in (select accno from ACCOUNTS a1 where a1.branch_name in (select branch_name 
                from ACCOUNTS a2
                group by a2.branch_name 
                having count(a2.branch_name)>=2));