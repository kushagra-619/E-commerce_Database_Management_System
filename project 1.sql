---CREATIONS OF TABLES
CREATE TABLE order_detail(
order_detail_id DECIMAL(12) not null PRIMARY KEY,
order_detail VARCHAR(255) NOT NULL);

CREATE TABLE inventory(
inventory_id DECIMAL(12) PRIMARY KEY,
product_id DECIMAL(12) NOT NULL,
seller_id DECIMAL(12) NOT NULL,
order_detail_id DECIMAL(12) NOT NULL,
condition_id DECIMAL(12) NOT NULL,
inventory_number DECIMAL(12) NOT NULL);

CREATE TABLE product(
product_id DECIMAL(12) PRIMARY KEY,
product_name VARCHAR(255) NOT NULL,
price DECIMAL(12) NOT NULL,
category_id DECIMAL(12) NOT NULL,
description VARCHAR(255) NOT NULL);

CREATE TABLE category(
category_id DECIMAL(12) PRIMARY KEY,
category_type VARCHAR(255) NOT NULL);

CREATE TABLE condition(
condition_id DECIMAL(12) PRIMARY KEY,
condition_type VARCHAR(255) NOT NULL);

CREATE TABLE seller(
seller_id DECIMAL(12) PRIMARY KEY,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
user_id DECIMAL(12) NOT NULL);

CREATE TABLE orders(
order_id DECIMAL(12) PRIMARY KEY,
order_detail_id DECIMAL(12) NOT NULL,
shipping_id DECIMAL(12) NOT NULL,
package_id DECIMAL(12) NOT NULL,
product_id DECIMAL(12) NOT NULL,
item_number DECIMAL(12))

CREATE TABLE consumer(
consumer_id DECIMAL(12) PRIMARY KEY,
consumer_first_name VARCHAR(255) NOT NULL,
consumer_last_name VARCHAR(255) NOT NULL,
mailing_address VARCHAR(255) NOT NULL,
e_mail VARCHAR(255) NOT NULL,
order_detail_id DECIMAL(12) NOT NULL);

CREATE TABLE consumer_address_bridge(
consumer_id DECIMAL(12) not null ,
address_id DECIMAL(12) not null);
ALTER TABLE consumer_address_bridge
ADD CONSTRAINT bridge_pk PRIMARY KEY(consumer_id, address_id);

CREATE TABLE address(
address_id DECIMAL(12) PRIMARY KEY,
address VARCHAR(255) NOT NULL);

CREATE TABLE shipping_type(
shipping_id DECIMAL(12) PRIMARY KEY,
ship_type varchar(255) NOT NULL);

ALTER TABLE shipping_type 
ALTER COLUMN ship_type VARCHAR(255);


CREATE TABLE package(
package_id DECIMAL(12) PRIMARY KEY,
address_id DECIMAL(12) NOT NULL);

CREATE TABLE shipment(
tracking_id DECIMAL(12) PRIMARY KEY,
order_id DECIMAL(12) NOT NULL);


---ALTERING TABLE INVENTORY
ALTER TABLE inventory
ADD CONSTRAINT inventory_product_fk
FOREIGN KEY(product_id)
REFERENCES product(product_id);
ALTER TABLE inventory
ADD CONSTRAINT inventory_order_detail_fk
FOREIGN KEY(order_detail_id)
REFERENCES order_detail(order_detail_id);
ALTER TABLE inventory
ADD CONSTRAINT inventory_seller_fk
FOREIGN KEY(seller_id)
REFERENCES seller(seller_id);
ALTER TABLE inventory
ADD CONSTRAINT inventory_condition_fk
FOREIGN KEY(condition_id)
REFERENCES condition(condition_id);

---ALTERING TABLE PRODUCT
ALTER TABLE product
ADD CONSTRAINT product_category_fk
FOREIGN KEY(category_id)
REFERENCES category(category_id);

---ALTERING TABLE ORDERS
ALTER TABLE orders
ADD CONSTRAINT order_package_fk
FOREIGN KEY(package_id)
REFERENCES package(package_id);

ALTER TABLE orders
ADD CONSTRAINT orders_order_detail_fk
FOREIGN KEY(order_detail_id)
REFERENCES order_detail(order_detail_id);

ALTER TABLE orders
ADD CONSTRAINT orders_shipping_type_fk
FOREIGN KEY(shipping_id)
REFERENCES shipping_type(shipping_id);

---ALTERING TABLE consumer
ALTER TABLE consumer
ADD CONSTRAINT consumer_order_detail_fk
FOREIGN KEY(order_detail_id)
REFERENCES order_detail(order_detail_id);

---ALTERING TABLE CONSUMER_ADDRESS_BRIDGE
ALTER TABLE consumer_address_bridge
ADD CONSTRAINT consumer_consumer_fk
FOREIGN KEY(consumer_id)
REFERENCES consumer(consumer_id);

ALTER TABLE consumer_address_bridge
ADD CONSTRAINT consumer_address_fk
FOREIGN KEY(address_id)
REFERENCES address(address_id);

---ALTERING TABLE PACKAGE
ALTER TABLE package
ADD CONSTRAINT package_address_fk
FOREIGN KEY(address_id)
REFERENCES address(address_id);

---ALTERING TABLE SHIPMENT 
ALTER TABLE shipment 
ADD CONSTRAINT shipment_orders_fk
FOREIGN KEY(order_id)
REFERENCES orders(order_id);

---Procedure Category
INSERT INTO category(category_id, category_type)
VALUES(10, 'Clothing')

GO
CREATE PROCEDURE  ADD_CATEGORY(
    @category_id DECIMAL(12,0),   
    @category_type VARCHAR(255) 
	)
AS   
BEGIN
     INSERT INTO category(category_id, category_type)
	 VALUES(@category_id, @category_type)

    END
EXEC ADD_CATEGORY 10, Clothing
EXEC ADD_CATEGORY 11, Shoes
EXEC ADD_CATEGORY 12, Jewelry
EXEC ADD_CATEGORY 13, Watches
EXEC ADD_CATEGORY 14, Books
EXEC ADD_CATEGORY 15, Electronics
EXEC ADD_CATEGORY 16, Computers
EXEC ADD_CATEGORY 17, Tools
EXEC ADD_CATEGORY 18, Pet_Supplies
EXEC ADD_CATEGORY 19, Food
EXEC ADD_CATEGORY 20, Beauty
EXEC ADD_CATEGORY 21, Health
EXEC ADD_CATEGORY 22, Toys
EXEC ADD_CATEGORY 23, Sports
EXEC ADD_CATEGORY 24, Automotive
EXEC ADD_CATEGORY 25, Outdoor

---Procedure Product
GO
CREATE PROCEDURE  ADD_PRODUCT(
    @product_id DECIMAL(12,0),   
    @product_name VARCHAR(255),
	@price DECIMAL(12,0),
	@category_id DECIMAL(12,0),
	@description VARCHAR(255)
	)
AS   
BEGIN
     INSERT INTO product(product_id, product_name, price, category_id, description)
	 VALUES( @product_id, @product_name, @price, @category_id,@description)

    END
EXEC ADD_PRODUCT 300, "Levi's Jeans" , 35, 10, 'Blue Jeans'
EXEC ADD_PRODUCT 301, 'Peter England Chinos', 32, 10, 'Red Chinos' 
EXEC ADD_PRODUCT 302, 'NBA Shorts', 15, 10, 'Black Lower' 
EXEC ADD_PRODUCT 303, 'ZARA Jeans', 79, 10, 'Blue Stretched Jeans' 
EXEC ADD_PRODUCT 304, 'Addidas Adizero', 120, 11, 'Sports Shoes' 
EXEC ADD_PRODUCT 305, 'Casio G-Shok', 250, 13, 'Digital Sports Watch' 
EXEC ADD_PRODUCT 306, 'Lenevo Laptop', 485, 16, 'Lenovo Fourth gen Laptop' 

---Procedure seller
GO
CREATE PROCEDURE  ADD_SELLER(
    @seller_id DECIMAL(12,0),   
    @first_name VARCHAR(255),
	@last_name VARCHAR(255),
	@user_id DECIMAL(12,0)
	)
AS   
BEGIN
     INSERT INTO seller(seller_id, first_name, last_name, user_id)
	 VALUES(@seller_id, @first_name, @last_name, @user_id)

    END
EXEC ADD_SELLER 500, 'Robin', 'Williams', 001
EXEC ADD_SELLER 501, 'Mark', 'Twane', 002
EXEC ADD_SELLER 502, 'John', 'Smith', 003
EXEC ADD_SELLER 503, 'Marty', 'Capolla', 004
EXEC ADD_SELLER 504, 'Ron', 'Wade', 005

---Procedure Condition
GO
CREATE PROCEDURE  ADD_CONDITION(
    @condition_id DECIMAL(12,0),   
    @condition_type VARCHAR(255)
	)
AS   
BEGIN
     INSERT INTO condition(condition_id, condition_type)
	 VALUES(@condition_id, @condition_type)

    END
EXEC ADD_CONDITION 400, 'New'
EXEC ADD_CONDITION 401, 'Used'
EXEC ADD_CONDITION 402, 'Refurbished'
EXEC ADD_CONDITION 403, 'Damaged'

---Procedure Order_detail
GO
CREATE PROCEDURE  ADD_ORDER_DETAIL(
    @order_detail_id DECIMAL(12,0),   
    @order_detail VARCHAR(255)
	)
AS   
BEGIN
     INSERT INTO order_detail(order_detail_id, order_detail)
	 VALUES(@order_detail_id, @order_detail)

    END
EXEC ADD_ORDER_DETAIL 100, 'In-Cart'
EXEC ADD_ORDER_DETAIL 101, 'Ordered'
EXEC ADD_ORDER_DETAIL 102, 'Shipped'
EXEC ADD_ORDER_DETAIL 103, 'Delivered'
EXEC ADD_ORDER_DETAIL 104, 'In-Transit'
EXEC ADD_ORDER_DETAIL 105, 'cancelled'

---Procedure Shipping type
GO
CREATE PROCEDURE  ADD_SHIPPING_TYPE(
    @shipping_id DECIMAL(12,0),   
    @ship_type VARCHAR(255)
	)
AS   
BEGIN
     INSERT INTO shipping_type(shipping_id, ship_type)
	 VALUES(@shipping_id, @ship_type)

    END
EXEC ADD_SHIPPING_TYPE 1, 'Premium'
EXEC ADD_SHIPPING_TYPE 2, 'Two-Days'
EXEC ADD_SHIPPING_TYPE 3, 'Normal'
EXEC ADD_SHIPPING_TYPE 4, 'Pickup'

---Procedure Address
GO
CREATE PROCEDURE  ADD_ADDRESS(
    @address_id DECIMAL(12,0),   
    @address VARCHAR(255)
	)
AS   
BEGIN
     INSERT INTO address(address_id, address)
	 VALUES(@address_id, @address)

    END
EXEC ADD_ADDRESS 50, '27 grand street'
EXEC ADD_ADDRESS 51, '1 Gardner Street'
EXEC ADD_ADDRESS 52, '54 Chandler Street'
EXEC ADD_ADDRESS 53, '90 florence street'
EXEC ADD_ADDRESS 54, '12 dewey street'
EXEC ADD_ADDRESS 55, '6 shirley street'


---PROCEDURE PACKAGE
GO
CREATE PROCEDURE  ADD_PACKAGE(
    @package_id DECIMAL(12,0),   
    @address_id DECIMAL(12,0)
	)
AS   
BEGIN
     INSERT INTO package(package_id, address_id)
	 VALUES(@package_id, @address_id)

    END
EXEC ADD_PACKAGE 1001, 51
EXEC ADD_PACKAGE 1002, 50
EXEC ADD_PACKAGE 1003, 53
EXEC ADD_PACKAGE 1004, 52
EXEC ADD_PACKAGE 1005, 54
EXEC ADD_PACKAGE 1006, 55


---Procedure Consumer
GO
CREATE PROCEDURE  ADD_CONSUMER(
    @consumer_id DECIMAL(12,0),   
    @consumer_first_name VARCHAR(255),
	@consumer_last_name VARCHAR(255),
	@mailing_address VARCHAR(255),
	@e_mail VARCHAR(255),
	@order_detail_id DECIMAL(12,0)
	)
AS   
BEGIN
     INSERT INTO consumer(consumer_id, consumer_first_name, consumer_last_name, mailing_address, e_mail, order_detail_id)
	 VALUES(@consumer_id, @consumer_first_name, @consumer_last_name, @mailing_address, @e_mail, @order_detail_id)

    END

EXEC ADD_CONSUMER 701, 'Harshit','Yadav','27 Grand Street','Harshit@yahoo.com',102
EXEC ADD_CONSUMER 702, 'Saurabh','Sharma','90 Florence Street','Saurabh@yahoo.com',105
EXEC ADD_CONSUMER 703, 'Nexon','Samuel','54 Chandler Street','NX123@hotmail.com',101
EXEC ADD_CONSUMER 704, 'Nikhil','Jaiswal','12 Dewey Street','Nik@icloud.com',104
EXEC ADD_CONSUMER 705, 'Rajeev','Rai','6 Shirley Street','Rrai@yahoo.com',103

---Procedure Consumer_address_bridge
GO
CREATE PROCEDURE  ADD_CONSUMER_ADDRESS_BRIDGE(
    @consumer_id DECIMAL(12,0),   
    @address_id DECIMAL(12,0)
	)
AS   
BEGIN
     INSERT INTO consumer_address_bridge(consumer_id, address_id)
	 VALUES(@consumer_id, @address_id)

    END
EXEC ADD_CONSUMER_ADDRESS_BRIDGE 700, 51
EXEC ADD_CONSUMER_ADDRESS_BRIDGE 701, 50
EXEC ADD_CONSUMER_ADDRESS_BRIDGE 702, 53
EXEC ADD_CONSUMER_ADDRESS_BRIDGE 703, 52
EXEC ADD_CONSUMER_ADDRESS_BRIDGE 704, 54
EXEC ADD_CONSUMER_ADDRESS_BRIDGE 705, 55
S
---Procedure INVENTORY
GO
CREATE PROCEDURE  ADD_INVENTORY(
    @inventory_id DECIMAL(12,0),   
    @product_id DECIMAL(12,0),
	@seller_id DECIMAL(12,0),
	@order_detail_id DECIMAL(12,0),
	@condition_id DECIMAL(12,0),
	@inventory_number DECIMAL(12,0)
	)
AS   
BEGIN
     INSERT INTO inventory(inventory_id, product_id, seller_id, order_detail_id, condition_id, inventory_number)
	 VALUES(@inventory_id, @product_id, @seller_id, @order_detail_id, @condition_id, @inventory_number)

    END
EXEC ADD_INVENTORY 101, 300, 501, 101, 402, 10

EXEC ADD_INVENTORY 102, 301, 500, 103, 400, 11
EXEC ADD_INVENTORY 103, 302, 502, 100, 403, 12
EXEC ADD_INVENTORY 104, 303, 504, 102, 401, 13
EXEC ADD_INVENTORY 105, 304, 503, 103, 401, 14
EXEC ADD_INVENTORY 106, 305, 500, 105, 400, 15

---PROCEDURE ORDERS
GO
CREATE PROCEDURE  ADD_ORDERS(
    @order_id DECIMAL(12,0),   
    @order_detail_id DECIMAL(12,0),
	@shipping_id DECIMAL(12,0),
	@package_id DECIMAL(12,0),
	@product_id DECIMAL(12,0),
	@item_number DECIMAL(12,0)
	)
AS   
BEGIN
     INSERT INTO orders(order_id, order_detail_id, shipping_id,package_id, product_id, item_number)
	 VALUES(@order_id, @order_detail_id, @shipping_id, @package_id, @product_id, @item_number)

    END

EXEC ADD_ORDERS 600, 100, 1, 1000, 300, 150
EXEC ADD_ORDERS 601, 105, 2, 1001, 306, 151
EXEC ADD_ORDERS 602, 103, 1, 1002, 302, 152
EXEC ADD_ORDERS 603, 101, 4, 1003, 303, 153
EXEC ADD_ORDERS 604, 102, 3, 1004, 301, 154
EXEC ADD_ORDERS 605, 100, 2, 1005, 305, 155
EXEC ADD_ORDERS 606, 104, 3, 1006, 304, 156

---RUNNING SQL QUERIES
---(i)
SELECT p.product_name, p.product_id, i.inventory_id, i.inventory_number
FROM product p, inventory i
WHERE p.product_id = i.product_id
AND i.inventory_number < 15

---(ii)
SELECT consumer_last_name, count(1)
FROM consumer
GROUP BY consumer_last_name
HAVING count(1)<2

---(iii)
SELECT consumer_first_name, consumer_last_name, mailing_address
FROM consumer
JOIN order_detail ON order_detail.order_detail_id = consumer.order_detail_id
JOIN inventory ON inventory.order_detail_id = consumer.order_detail_id
JOIN product ON product.product_id = inventory.product_id
WHERE order_detail.order_detail_id = (SELECT inventory_id FROM order_detail HAVING COUNT(*)>0)

---(iv)
SELECT shipping_id, order_id
FROM orders
JOIN shipping_type ON orders.shipping_id=shipping_type.shipping_id
JOIN shipment ON order_id=shipment.order_id

---(v)
SELECT p.price,p.product_name,c.category_type 
FROM product p, category c
WHERE p.category_id=c.category_id
AND p.price<50
AND c.category_type='Clothing';



