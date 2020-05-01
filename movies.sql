create database movies;
use movies;

create table actor(
	actid int,
    actname varchar(30),
    actgender varchar(6),
    primary key(actid)
);

create table director(
	dirid int,
    dirname varchar(30),
    dirphone varchar(10),
    primary key(dirid)
);

create table movie(
	movieid int,
    movietitle varchar(30),
    movieyear int,
    movielang varchar(30),
    dirid int,
    primary key(movieid),
    foreign key(dirid) references director(dirid)
);

create table moviecast(
	actid int,
    movieid int,
    roles varchar(30),
    primary key(actid,movieid),
    foreign key(actid) references actor(actid),
    foreign key(movieid) references movie(movieid)
);

create table rating(
	movieid int,
    stars int,
    primary key(movieid),
    foreign key(movieid) references movie(movieid) 
);

insert into actor values(1,'Tom Cruise','Male'),(2,'Dwyane Jhonson','Male'),(3,'Rowan Atkinson','Male'),(4,'Alba Flores','Female'),
(5,'Ursula corbero','Female');

insert into director values(1,'Christopher Nolan','1234567890'),(2,'Spielberg','0987654321'),(3,'Hitchcock','6543217890'),
(4,'James Cameron','1357908642'),(5,'Ritchie','2468097531');

insert into movie values(1,'Interstellar',2015,'English',1),(2,'Avatar',2011,'English',4),(3,'Psycho',1972,'English',3),
(4,'snatch',2013,'English',5),(5,'Lincoln',2001,'English',2);

insert into moviecast values(1,4,'lead'),(2,5,'lead'),(3,3,'lead'),(4,1,'lead'),(5,2,'lead');

insert into rating values(1,5),(2,4),(3,4),(4,4),(5,5);

select movie.movietitle
from movie,director
where director.dirname = 'Hitchcock' and director.dirid = movie.dirid;

select distinct movie.movietitle
from movie,actor,moviecast
where moviecast.actid = actor.actid
group by moviecast.movieid
having count(moviecast.actid) > 1;

select actor.actname
from actor,movie,moviecast
where (movie.movieyear >= 2015 or movie.movieyear <= 2000) and actor.actid = moviecast.actid and moviecast.actid = movie.movieid;

select movie.movietitle,rating.stars,max(stars)
from movie,rating
where exists(select * from rating,movie where rating.movieid = movie.movieid) and rating.movieid = movie.movieid
group by movie.movietitle
order by movie.movietitle asc;

update rating,movie,director
set rating.stars = 5
where rating.movieid = movie.movieid and movie.dirid = director.dirid and director.dirname = 'Spielberg';