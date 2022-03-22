create database if not exists assignment_work;

use assignment_work;

create table if not exists SalesPeople(
Snum int,
primary key(snum),
Sname varchar(15),
unique(Sname),
City varchar(20),
Comm int
);

create table if not exists Customers(
Cnum int,
primary key(Cnum),
Cname varchar(20),
City varchar(15) not null,
Snum int,
foreign key(Snum) references SalesPeople(Snum)
);

create table if not exists Orders(
Onum int,
primary key(Onum),
Amt decimal(10,2),
Odate date,
Cnum int,
Snum int,
foreign key(Cnum) references Customers(Cnum),
foreign key(Snum) references SalesPeople(Snum)
);

insert into SalesPeople values
(1001,'Peel','London',12),
(1002,'Serres','Sanjose',13),
(1004,'Motika','London',11),
(1007,'Rifkin','Barcelona',15),
(1003,'Axelrod','Newyork',10);

insert into Customers Values
(2001,'Hoffman','London',1001),
(2002,'Giovanni','Rome',1003),
(2003,'Liu','Sanjose',1002),
(2004,'Grass','Berlin',1002),
(2006,'Clemens','London',1001),
(2008,'Cisneros','Sanjose',1007),
(2007,'Pereira','Rome',1004);

insert into Orders Values
(3001,18.69,'1990-10-3',2008,1007),
(3003,767.19,'1990-10-3',2001,1001),
(3002,1900.10,'1990-10-3',2007,1004),
(3005,5160.45,'1990-10-3',2003,1002),
(3006,1098.16,'1990-10-3',2008,1007),
(3009,1713.23,'1990-10-4',2002,1003),
(3007,75.75,'1990-10-4',2004,1002),
(3008,4273.00,'1990-10-5',2006,1001),
(3010,1309.95,'1990-10-6',2004,1002),
(3011,9891.88,'1990-10-6',2006,1001);

select * from SalesPeople;
select * from Customers;
select * from Orders;

-- 1) Count the number of Salesperson whose name begin with ‘a’/’A’:
select count(Sname) as total_count from salespeople where Sname like 'a%' or 'A%';

-- 2) Display all the Salesperson whose all orders worth is more than Rs. 2000:
select 
sp.Sname, 
sum(o.Amt) 
from SalesPeople as sp 
inner join Orders as o 
on sp.Snum=o.Snum 
group by sp.Sname having sum(o.Amt)>2000;

-- 3) Count the number of Salesperson belonging to Newyork:
select count(City) as total_count from salespeople where city like '%Newyork';

-- 4) Display the number of Salespeople belonging to London and belonging to Paris:
select Snum,Sname,City from salespeople where city like '%London' or '%Paris';
select Snum,Sname,City from salespeople where city='London' or city='Paris';

-- 5) Display the number of orders taken by each Salesperson and their date of orders:
select 
sp.Sname,
sp.Snum,
o.Odate,
o.Onum
from orders as o
inner join salesPeople as sp
on sp.Snum=o.Snum;

create or replace view details as
select
sp.Snum,
sp.Sname
from orders as o
inner join salespeople as sp
where sp.Snum=o.Snum; 
select Sname,count(sname) as total_orders from details group by sname;