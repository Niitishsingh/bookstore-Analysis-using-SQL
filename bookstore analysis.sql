-- create a database 
create database bookstore;
-- switch to the new databse
use bookstore;

create table books (
       book_id int primary key,
       title varchar(50),
       author varchar(50),
       genre varchar(50),
       published_year int,
       price numeric(10,2),
       stock int
);  


create table customers(
      customer_id int primary key,
	  name varchar(20),
      email varchar(50),
      phone varchar(15),
      city varchar(30),
      country varchar(30)
 );    


 create table orders(
      order_id int primary key,
      customer_id int References customers(customer_id),
      book_id int REFERENCEs books(book_id),
      order_date date,
      quantity int,
      total_Amount numeric(10,2)
      
);     

select * from books;
select * from customers;
select * from orders;

-- 1 retrive all the books in the "fiction" genre 

select * from books
where genre ='fiction';

-- 2 find books published after year 1950

select * from books
where published_year>1950
order by published_year asc;

-- 3) list all the customers from canada 

select * from customers 
where country ='canada';

-- 4) show order placed in nov 2023

select * from orders
where order_date between '2023-11-01' and '2023-11-30';


-- 5) retrive the total stocks of book available

select sum(STOCK) as total_stock
from books;

-- 6) select all the customer who order more than 5 quantity of books

select *
from orders
where quantity > 5;

-- 7) retrive the most expensive book

select * from books 
order by price desc
limit 1;

-- 8) retrive all the order where totalamount exceed the 20$

select * from orders
where total_Amount > 20;

--  9)  list all genre available in the books stock

select distinct genre from books ;


-- 10) find the book with thw lowest stock


select* from books 
order by stock asc;

-- 11) calculate the total revenue generate from all order
select * from orders;

select sum(total_amount) as total_revenue
from orders;


-- ADVANCED QUERY PROBLEM


-- 12) retrive the total number of book solds from each genre 


SELECT * FROM BOOKS;
SELECT * FROM orders;

select B.GENRE , SUM(O.QUANTITY) AS TOTAL_BOOK_SOLD
FROM ORDERS O
JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
group by B.GENRE;


-- 12) FIND THE AVERAGE PRICE OF BOOK IN 'FANTASY' GENRE


SELECT GENRE, AVG(PRICE ) AS AVG_PRICE
FROM BOOKS
WHERE GENRE= 'FANTASY';

-- 13) Name the CUSTOMERs WHO HAVE PLACED ATLEAST 2 ORDER

SELECT * FROM ordERS;

SELECT o.CUSTOMER_ID , C.name , COUNT( o.ORDER_ID) AS TOTAL_ORDER
FROM ORDERS o
join customers c on o.customer_id = c.customer_id
group by customer_ID , c.name
having COUNT(ORDER_ID)>=2;



-- 14)  find the name most frequntly ordered book

select o.book_id, b.title, count(o.order_id) as most_ordered
from orders o
join books b on o.book_id=b.book_id
group by o.book_id ,b.title
order by most_ordered desc;

-- 15)show the top 3 most expensive book of fantasy genre

select * from books
where genre = "fantasy"
order by price desc
limit 3;

-- 16) retrive the total quantity of books sold by each author:

select*from orders;
select* from books;
select*from customers;

select b.author, sum(o.quantity) as total_sold 
from books b
join orders o on b.book_id = o.book_id
group by b.author ;

-- 17)List the cities where custoomers spents more than 300$ located:

select distinct c.city , o.total_Amount
from customers c
join orders o on c.customer_id = o.customer_id
where o.total_Amount >= 300;

-- 18) find the customer who spent the most on orders

select distinct c.name, c.customer_id, sum(o.total_amount) as total_spent
from customers c 
join orders o on c.customer_id= o.customer_id
group by c.customer_id,c.name	
order by total_spent desc
limit 1;

-- 19) Calculate the stock remaining after fullfiling the all orders

select b.book_id,b.title, b.stock, coalesce(sum(o.quantity),0)as order_quantity,
b.stock - coalesce(sum(o.quantity),0)as total_remain
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id;


