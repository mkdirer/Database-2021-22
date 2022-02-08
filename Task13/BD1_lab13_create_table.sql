CREATE TABLE sample (
  Row_id int,
  Order_id int,
  Order_data date,
  Order_priority varchar,
  Order_quantity int,
  Sales numeric(10,2),
  Discount numeric(10,2),
  Ship_mode varchar,
  Profit numeric(10,2),
  Unit_price numeric(10,2),
  Shipping_cost numeric(10,2),
  Customer_name varchar,
  Province varchar,
  Region varchar,
  Customer_segment varchar,
  Product_category varchar,
  Product_sub_category varchar,
  Product_name varchar,
  Product_container varchar,
  Product_basa_margin numeric(10,2),
  Ship_date date ) ;
--
COPY sample FROM 'c:\lem\postgres\lab12\sample.csv' DELIMITER ';' CSV ;

