create database CodingChallange;

use CodingChallange;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
	FirstName VARCHAR(100),
    LastName VARCHAR(100),
    email VARCHAR(100),
    address TEXT
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL,
    stockQuantity INT
);

CREATE TABLE cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_amount INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO products (product_id, name, description, price, stockQuantity) VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient ', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave ', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

INSERT INTO customers (customer_id, firstName, lastName, Email, address) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
(7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
(8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
(9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory');

INSERT INTO orders (order_id, customer_id, order_date, total_price) VALUES
(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, item_amount) VALUES
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);

INSERT INTO cart (cart_id, customer_id, product_id, quantity) VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);


UPDATE products
SET price = 800
WHERE name ="Refrigerator";

select * from products;

DELETE FROM cart
WHERE customer_id = 2;

select * from cart;

select name, price from products where price < 100;

select * from products where stockQuantity > 5;


select * from orders where total_price between 500 and 1000;


select product_id, name from products where name like "%r";


select  c.customer_id as CustomerID, p.name as Product, c.quantity
from cart c
JOIN products p ON
c.product_id = p.product_id
where c.customer_id = 5;  

select 
c.customer_id as customerID, 
c.FirstName as FirstName, 
c.lastName as LastName,
year(o.order_date) as orderYear
from customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE year(o.order_date) = 2023;


select name, min(stockQuantity) as MinStockQuantity 
from products 
group by name;




select customer_id, sum(total_price) from orders
group by customer_id;

select customer_id, AVG(total_price) from orders
group by customer_id;

select customer_id, COUNT(order_id) AS number_of_orders
from orders
group by customer_id;

select 	o.customer_id ,
concat(c.firstName," ", c.lastName) as CustomerName,
max(o.total_price) as MaxOrderAmount 
from orders o
join customers c 
on c.customer_id = o.customer_id
group by o.customer_id;


select 	o.customer_id ,
concat(c.firstName," ", c.lastName) as CustomerName,
o.total_price as orderAbove1000 
from orders o
join customers c 
on c.customer_id = o.customer_id
where o.total_price > 1000;



-- sub query

select *
from products
where product_id not in (select product_id from cart);


select customer_id, concat(firstName," ", Lastname) as customerWithoutOrders from customers
WHERE customer_id NOT IN (select customer_id from orders);

select customer_id, concat(firstName," ", Lastname) as customerWithoutOrders from customers
WHERE customer_id NOT IN (select customer_id from cart);

select sum(item_amount) from order_items;

select o.product_id, p.name, sum(o.item_amount) as productRevenue, 
(SUM(o.item_amount) * 100.0) / (SELECT SUM(item_amount) FROM order_items) AS revenue_percentage
 from order_items o 
join products p
on p.product_id = o.product_id
group by product_id; 



select product_id, name, stockQuantity from products
WHERE stockQuantity < (select avg(stockQuantity) from products);



select c.customer_id, c.firstName, c.lastName, o.total_price as OrderAmount from customers c
join orders o
on c.customer_id  = o.customer_id
where o.total_price > (select avg(total_price) from orders);















