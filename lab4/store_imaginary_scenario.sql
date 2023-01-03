create database store;
use store;
drop table products;
create table products (
    ProductID int(4) primary Key,
    PName varchar(30),
    Price int(10)
);
INSERT INTO products (ProductID, PName,  Price)
VALUES (001, "Pen", 25),(002, "Book", 250),(003, "Pencil", 30),(004, "A4sheet", 5);

select * from products;

 --  Company-------------------------------
 
 Start transaction;
 update products set Price=25 where ProductID=001;

