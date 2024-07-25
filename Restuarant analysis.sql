USE restaurant_db;

-- OBJECTIVE 1 (MENU TABLE)

-- 1. View the menu_items table.
SELECT *
FROM menu_items;

-- 2. Find the number of items on the menu.
SELECT COUNT(*) AS Number_of_items
FROM menu_items;

-- 3. What are the least and most expensive on the menu?
SELECT *
FROM menu_items
ORDER BY PRICE;

SELECT *
FROM menu_items
ORDER BY PRICE DESC;

-- 4. How many Italian dishes are on the menu?
SELECT COUNT(*) AS Total_Italian_dishes
FROM menu_items
WHERE category = 'Italian'; 

-- 5. What are the least and most expensive Italian dishes on the menu?
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY Price;

-- 6. How many dishes are in each category?
SELECT category, COUNT(item_name)
FROM menu_items
GROUP BY category;

-- 7.What is the average dish price within each category?
SELECT category, AVG(Price) AS Average_price
FROM menu_items
GROUP BY category;

-- OBJECTIVE 2 (ORDER TABLE)
-- 1. View the order_details table
SELECT *
FROM order_details;

-- 2. What is the date range of the table?
SELECT MIN(order_date), MAX(order_date)
FROM order_details
ORDER BY order_date;

-- 3. How many orders were made within this date range?
SELECT COUNT(DISTINCT order_id) AS Orders_made
FROM order_details;

-- 4. How many items were ordered within this data range?
SELECT COUNT(*) AS Number_of_items_ordered
FROM order_details;

-- 5. Which orders had the most number of items?
SELECT order_id, COUNT(item_id) AS Number_of_items
FROM order_details
GROUP BY order_id
ORDER BY Number_of_items DESC;

-- 6. How many orders had more than 12 items?
SELECT COUNT(*) FROM 

(SELECT order_id, COUNT(item_id) AS Number_of_items
FROM order_details
GROUP BY order_id
HAVING Number_of_items > 12) AS num_of_orders;

-- OBJECTIVE 3 (ANALYZE CUSTOMER'S BEHAVIOUR)
-- 1. Combine the menu_items and order_details into a single table
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT * FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What categories were they in ?
SELECT item_name, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY num_purchases DESC;

SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC;

-- 3. What were the top 5 orders that spent the most money?
SELECT order_id , SUM(price) as Total_spent
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY Total_spent DESC
LIMIT 5;

-- 4. Viewing the details of the highest spend order in order to gather insights
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;


-- INSIGHTS
-- 1. The least expensive items is Edumame.
-- 2. Most expensive item is Shrimp  Scampi.
-- 3. We have four different category of dishes.
-- 4. The range for orders fall between 1st Jan. 2023 to 31st March, 2023.
-- 5. A total of 5,370 orders were made.
-- 6. A total of 12,234 items were ordered.
-- 7. 20 orders had more than 12 items ordered.
-- 8. Italian dishes were ordered the most


-- RECOMMENDATION(s)
-- 1. The Restaurant should ensure it keeps Italian food in its menu as it has the highest spent order.
-- 2. The Restaurant can consider giving discounts to customers that order multiple items.