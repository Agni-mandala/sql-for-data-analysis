-- 1. Orders delayed more than 30 minutes
SELECT order_id, customer_id, delivery_time_minutes
FROM orders_details
WHERE delivery_time_minutes > 30
ORDER BY delivery_time_minutes DESC;

-- 2. Total profit earned by each area
SELECT area, SUM(total_profit) AS total_profit
FROM orders_details
GROUP BY area
ORDER BY total_profit DESC;

-- 3. Average rating of customers who gave feedback
SELECT AVG(rating) AS avg_rating
FROM orders_details
WHERE rating IS NOT NULL;

-- 4. Top 5 customers who spent the most
SELECT customer_id, SUM(order_total) AS total_spent
FROM orders_details
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 5. Customers whose avg order value is above overall avg
SELECT customer_id, avg_order_value
FROM orders_details
WHERE avg_order_value > (
    SELECT AVG(avg_order_value) FROM orders_details
);

-- 6. INNER JOIN example (simulate if customer table doesn't exist)
SELECT o.order_id, o.customer_id, o.order_total, c.customer_segment
FROM orders_details o
INNER JOIN orders_details c ON o.customer_id = c.customer_id;

-- 7. Create a view of high-value customers (spent > 1000)
CREATE VIEW high_value_customers AS
SELECT customer_id, SUM(order_total) AS total_spent
FROM orders_details
GROUP BY customer_id
HAVING total_spent > 1000;

-- 8. Create index on delivery_time_minutes
CREATE INDEX idx_delivery_time ON orders_details(delivery_time_minutes);

-- 9. Feedback sentiment count
SELECT sentiment, COUNT(*) AS count
FROM orders_details
GROUP BY sentiment;

-- 10. Total orders by payment method
SELECT payment_method, COUNT(*) AS total_orders
FROM orders_details
GROUP BY payment_method
ORDER BY total_orders DESC;