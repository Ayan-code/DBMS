create database orderProcess;
use orderProcess;

create table cust(
	custno int,
    cname varchar(30),
    city varchar(30),
    primary key(custno)
);

create table orderD(
	orderno int,
    odate date,
    custno int,
    ordAmt int,
    primary key(orderno),
    foreign key(custno) references cust(custno)
);

create table item(
	itemno int,
    unitprice int,
    primary key(itemno)
);

create table ordItem(
	orderno int,
    itemno int,
    qty int,
    primary key(orderno,itemno),
    foreign key(orderno) references orderD(orderno),
    foreign key(itemno) references item(itemno)
);

create table warehouse(
	warehouseno int,
    city varchar(30),
    primary key(warehouseno)
);

create table shipment(
	orderno int,
    warehouseno int,
    shipDate date,
    foreign key(orderno) references orderD(orderno),
    foreign key(warehouseno) references warehouse(warehouseno)
);

insert into cust values(1,'ajay','delhi'),(2,'birendra','amritsar'),(3,'akash','patna'),(4,'santosh','bangalore'),(5,'mahesh','agra');

insert into item values(1,10),(2,20),(3,30),(4,40),(5,50);

insert into orderD values(1,'2020-1-01',1,30),(2,'2020-02-02',2,50),(3,'2020-03-03',3,70),(4,'2020-04-04',4,90),(5,'2020-05-05',5,110);

insert into orditem values(5,1,11),(4,3,3),(3,1,7),(2,5,1),(1,3,1);

insert into warehouse values(1,'ajmer'),(2,'bangalore'),(3,'chennai'),(4,'mumbai'),(5,'delhi');

insert into shipment values(1,1,'2020-01-02'),(2,2,'2020-02-03'),(3,3,'2020-03-04'),(4,4,'2020-04-05'),(5,5,'2020-05-06');


select cust.cname,count(orderD.custno),avg(orderD.ordAmt)
from  cust,orderD
where cust.custno = orderD.custno
group by orderD.custno;


select count(shipment.orderno)
from shipment,warehouse
where warehouse.warehouseno = shipment.warehouseno and warehouse.city='delhi';

alter table orditem add constraint foreign key(itemno) references item(itemno) on delete null;