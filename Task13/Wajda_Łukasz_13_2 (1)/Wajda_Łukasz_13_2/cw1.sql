SELECT product_name, customer_name, COUNT(*), SUM(sales) FROM lab04.sample GROUP BY GROUPING SETS ( (product_name, customer_name), (customer_name), (product_name) )
HAVING COUNT(*) > 1 ORDER BY product_name, customer_name LIMIT 50;