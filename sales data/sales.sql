CREATE DATABASE superstore;
use superstore;
SELECT * FROM order_file LIMIT 10
ALTER TABLE order_file
MODIFY order_DATE DATE;
ALTER TABLE order_file
MODIFY profit DECIMAL (10,2);
ALTER TABLE order_file
MODIFY shipping_cost DECIMAL (10,2);
ALTER TABLE order_file
MODIFY discount DECIMAL (10,2);

-- Q1: Total Sales kitni hui?

SELECT sum(sales) AS total_sales
FROM order_file;

-- Q2: Top 5 highest selling products ?
select product_id, SUM(sales) AS total_sales
from order_file
group by product_id limit 20

-- Q3: Kis region me sabse zyada profit hai?

select region, sum(profit) AS total_profit
from order_file
group by region
order by total_profit

-- Q4: Monthly sales trend dikhao ?

select DATE_FORMAT(order_date, '%Y-%m') AS month_name,	
		SUM(sales) AS total_sales
        from order_file
        group by month_name
        order by total_sales
        
-- Q5: Loss wale orders (negative profit) ?

SELECT *
FROM order_file
WHERE profit < 0
LIMIT 10;

-- Q6: Top customers by revenue

select customer_name, SUM(sales) AS total_sales
from order_file
group by customer_name
order by total_sales desc
limit 20

-- Q7: Category-wise performance?

SELECT category,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit
FROM order_file
GROUP BY category;

-- Q8: Discount ka profit par impact?

SELECT discount,
       ROUND(AVG(profit), 2) AS avg_profit
FROM order_file
GROUP BY discount;

-- Q9: Sabse zyada quantity kis product ki bikti hai?

select product_id, SUM(quantity) as total_qty
from order_file
group by product_id
order by total_qty desc
limit 20;

-- Q10: Country-wise sales ranking ?
select country, sum(sales) AS total_sales,
	            rank() over(order by sum(sales) desc) AS rank_no
                from order_file
                group by country;
                
-- Q11: Top 3 products in each category?

SELECT category, product_id, total_sales
FROM ( SELECT category,
           product_id,
           SUM(sales) AS total_sales,
           RANK() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) AS rn
           FROM order_file
           GROUP BY category, product_id) t WHERE rn <= 3;
 
 -- Q12: Running total of sales (Cumulative Sales)?
 
 select order_date, sum(sales) AS daily_sales,
 sum(sum(sales)) OVER ( order by order_date) AS running_total
 FROM order_file
 group by order_date;
 
-- Q13: Repeat vs New Customers ?

SELECT customer_name,
       COUNT(order_id) AS total_orders
FROM order_file
GROUP BY customer_name
HAVING COUNT(order_id) > 1;

-- Q14: Profit ratio (Profit / Sales) ?

select category, sum(profit) / sum(sales) AS profit_ratio
from order_file
group by category

-- Q15: Most profitable sub-category in each region ?

SELECT *
FROM (
    SELECT region, sub_category, SUM(profit) AS total_profit,
           RANK() OVER(PARTITION BY region ORDER BY SUM(profit) DESC) AS rnk
    FROM order_file
    GROUP BY region, sub_category
) t
WHERE rnk = 1;





