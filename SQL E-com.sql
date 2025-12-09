Create Database orders;
Use orders;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

INSERT INTO Customers VALUES
(1, 'Rahul', 'Mumbai', '2023-01-10'),
(2, 'Sneha', 'Delhi', '2023-02-14'),
(3, 'Amit', 'Pune', '2023-03-18'),
(4, 'Priya', 'Mumbai', '2023-04-05'),
(5, 'Karan', 'Chennai', '2023-04-20');


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders VALUES
(101, 1, '2023-05-01', 1200.50, 'Delivered'),
(102, 2, '2023-05-03', 2500.00, 'Pending'),
(103, 1, '2023-05-05', 750.75, 'Delivered'),
(104, 4, '2023-05-10', 1800.00, 'Cancelled'),
(105, 3, '2023-05-12', 2200.10, 'Delivered');


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2),
    category VARCHAR(30)
);

INSERT INTO Products VALUES
(201, 'Shoes', 1500.00, 'Fashion'),
(202, 'Mobile', 15000.00, 'Electronics'),
(203, 'Watch', 3500.00, 'Accessories'),
(204, 'T-shirt', 600.00, 'Fashion'),
(205, 'Laptop', 55000.00, 'Electronics');

 -- 1.Display all customers
Select * from customers;

-- 2.List all orders made in 2023
select * from orders
where order_date like "2023%";

-- 3.Show name and city of customers from Mumbai.
Select name,city 
from customers
where city="mumbai";

-- 4.List all products in “Electronics” category
Select name from products
where category="electronics";

-- 5.Retrieve total number of customers 
select count(*) as total_customers 
from customers;

-- 6.Show orders where status = "Delivered" 
select * from orders
where status="delivered";

-- 7.List product names and prices sorted by price descending 
select name,price 
from products
order by price desc;

-- 8.Find customers who signed up before March 2023
select * from customers
where signup_date<"2023-03-01";

-- 9.Display all orders along with amounts
select order_id,amount
from orders;

-- 10.Show products priced more than 2000
select name,price
from products
where price>2000;

-- 11.Show all orders with customer names
select c.name,o.*
from customers as c
right join orders as o
using(customer_id);

-- 12.Count number of orders per customer
select customer_id,count(*) as orders_per_customer
from orders
group by customer_id;

-- 13.Total revenue generated from all orders 
select sum(amount) as total_revenue
from orders;

-- 14.Show customers who placed at least 2 orders
select customer_id,count(*) as order_per_customer
from orders 
group by customer_id
having order_per_customer>1;

-- 15.Get number of delivered orders 
select count(*) as delivered_orders
from orders
where status="delivered";

-- 16.Show product categories with number of products in each 
select category,count(*) as number_of_products
from products
group by category;

-- 17.Find average order amount for each customer
select customer_id,avg(amount) as avg_amount 
from orders
group by customer_id;

-- 18.Retrieve highest and lowest product price 
select max(price) as highest_price,min(price) as lowest_price
from products;

-- 19.Show customers with no orders at all 
select c.customer_id,c.name,count(order_id) as total_order
from customers as c
left join orders as o
using(customer_id)
group by customer_id
having total_order<1;

-- 20.For each city, find number of customers and total orders
select c.city,count(c.customer_id) as total_customers,count(o.order_id) as total_order
from customers as c
left join orders as o
using(customer_id)
group by city;


-- 21.Show categories generating highest revenue
select category 
from products
where price>=(select max(price) from products);

-- 22.Display customer with maximum total purchase amount
select customer_id 
from orders
where amount>=(select max(amount) from orders);

-- 23.Find repeat customers (more than one order)
select customer_id,count(order_id) as total_order
from orders
group by customer_id
having total_order>1;

-- 24.Find date with the highest sales amount
select order_date
from orders
where amount>=(select max(amount) from orders);

-- 25.Show customers who placed orders on dates when total revenue > 2000 
select customer_id,order_date,sum(amount) as total_amount
from orders
group by customer_id,order_date
having total_amount>2000;

