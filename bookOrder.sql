create database bookDealer;
use bookDealer;

create table author(
	authorid int,
    aname varchar(30),
    city varchar(30),
    country varchar(30),
    primary key(authorid)
);

create table publisher(
	publisherid int,
    pname varchar(30),
    city varchar(30),
    country varchar(30),
    primary key(publisherid)
);

create table category(
	catid int,
    descr varchar(30),
    primary key(catid)
);

create table catalog(
	bookid int,
    title varchar(30),
    authorid int,
    publisherid int,
    catid int,
    yearP int,
    price int,
    primary key(bookid),
    foreign key(authorid) references author(authorid),
    foreign key(publisherid) references publisher(publisherid),
    foreign key(catid) references category(catid)
);

create table orderD(
	orderno int,
    bookid int,
    qty int,
    primary key(orderno),
    foreign key(bookid) references catalog(bookid)
);

insert into author values(1,'shankar','agra','India'),(2,'peter','stockholm','sweden'),(3,'alonso','berlin','germany'),
(4,'amit','kolkata','India'),(5,'debanjana','ajmer','India');

insert into publisher values(1,'bharat','agra','India'),(2,'govind','patna','India'),(3,'brian','tokyo','china'),
(4,'joe','jakarta','malaysia'),(5,'aravind','kanyakumari','India');

insert into category values(1,'romance'),(2,'comedy'),(3,'action'),(4,'horror'),(5,'thriller');

insert into catalog values(1,'Uri',5,5,3,2018,1000),(2,'Housefull',4,4,2,2010,500),(3,'Badla',3,3,5,2019,700),
(4,'ashiqui',2,2,1,2013,300),(5,'stri',1,1,4,2019,600);
insert into catalog values(6,'Don',1,1,3,2000,750);

insert into orderD values(1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6);
insert orderD values(6,1,10);


select author.aname,author.city,author.country
from author,catalog
where author.authorid = catalog.authorid and catalog.yearP > 2000
group by catalog.authorid having count(catalog.authorid) > 1;

select distinct author.aname
from author,orderD,catalog
where  catalog.bookid = (select orderD.bookid from orderD where qty = (select max(orderD.qty) from orderD)) and catalog.bookid = orderD.bookid;

use bookdealer;

update catalog 
set catalog.price = price + (price * 0.1)
where publisherid = 1;
