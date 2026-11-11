-- ========================================================
-- ONLINE FOOD DELIVERY APP - PRACTICE QUERIES FOR TABLEPLUS
-- Run these in TablePlus (Cmd + E -> Paste -> Cmd + Enter)
-- ========================================================

-- 1. List all active restaurants and their owner's information
SELECT 
    r.id AS restaurant_id,
    r.name AS restaurant_name,
    r.address,
    r.phone_number AS restaurant_phone,
    u.full_name AS owner_name,
    u.email AS owner_email
FROM restaurants r
JOIN users u ON r.owner_id = u.id
WHERE r.is_active = true;


-- 2. Fetch the complete menu for 'Pizza Paradise' grouped by category
SELECT 
    category,
    name AS item_name,
    price,
    availability,
    description
FROM menu_items
WHERE restaurant_id = 1
ORDER BY category, price ASC;


-- 3. The Full Order Breakdown (Multi-table JOIN)
-- View Order #1: Customer details, restaurant, delivery status, and items ordered
SELECT 
    o.id AS order_id,
    o.created_at,
    o.status AS order_status,
    c.full_name AS customer_name,
    c.phone_number AS customer_phone,
    r.name AS restaurant_name,
    oi.item_name,
    oi.quantity,
    oi.price AS unit_price,
    (oi.quantity * oi.price) AS subtotal,
    o.total_amount,
    o.delivery_fees,
    o.payment_method,
    o.payment_status
FROM orders o
JOIN users c ON o.user_id = c.id
JOIN restaurants r ON o.restaurant_id = r.id
JOIN order_items oi ON oi.order_id = o.id
WHERE o.id = 1;


-- 4. Active Deliveries Dashboard
-- Which orders are currently out for delivery, and who is delivering them?
SELECT 
    o.id AS order_id,
    o.delivery_address,
    da.status AS delivery_status,
    agent.full_name AS delivery_agent_name,
    agent.phone_number AS agent_phone,
    da.assigned_at,
    da.pickup_at
FROM orders o
JOIN delivery_assignments da ON o.id = da.order_id
JOIN users agent ON da.agent_id = agent.id
WHERE da.status IN ('assigned', 'picked_up');


-- 5. Restaurant Sales Report
-- Calculate total revenue and total orders for each restaurant
SELECT 
    r.name AS restaurant_name,
    COUNT(o.id) AS total_orders_count,
    COALESCE(SUM(o.total_amount), 0) AS total_revenue
FROM restaurants r
LEFT JOIN orders o ON r.id = o.restaurant_id AND o.payment_status = 'paid'
GROUP BY r.id, r.name;


-- 6. Restaurant Ratings & Customer Reviews
SELECT 
    r.name AS restaurant_name,
    ROUND(AVG(rev.rating), 2) AS average_rating,
    COUNT(rev.id) AS total_reviews,
    STRING_AGG(rev.comment, ' | ') AS customer_feedback
FROM restaurants r
LEFT JOIN reviews rev ON r.id = rev.restaurant_id
GROUP BY r.id, r.name;
