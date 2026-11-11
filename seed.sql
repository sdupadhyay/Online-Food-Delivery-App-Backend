-- ========================================================
-- ONLINE FOOD DELIVERY APP - SAMPLE SEED DATA
-- ========================================================

-- Clear existing data (in reverse dependency order)
TRUNCATE TABLE reviews, delivery_assignments, order_items, orders, menu_items, restaurants, users RESTART IDENTITY CASCADE;

-- 1. SEED USERS
-- Password hash for 'password123' (bcrypt format placeholder)
INSERT INTO users (full_name, email, phone_number, role, address, password_hash)
VALUES
('Alice Customer', 'alice@example.com', '+1-555-0101', 'customer', '123 Maple Street, Apt 4B, Springfield', '$2b$12$e8kP01GkO6U4U8g1e3Z4MeEXAMPLEHASH1'),
('Bob Customer', 'bob@example.com', '+1-555-0102', 'customer', '456 Oak Avenue, Springfield', '$2b$12$e8kP01GkO6U4U8g1e3Z4MeEXAMPLEHASH2'),
('Chef Mario', 'mario@pizzaparadise.com', '+1-555-0201', 'restaurant_owner', '10 Market Street, Downtown', '$2b$12$e8kP01GkO6U4U8g1e3Z4MeEXAMPLEHASH3'),
('Priya Sharma', 'priya@curryhouse.com', '+1-555-0202', 'restaurant_owner', '25 Spice Lane, Uptown', '$2b$12$e8kP01GkO6U4U8g1e3Z4MeEXAMPLEHASH4'),
('Dave Delivery', 'dave@delivery.com', '+1-555-0301', 'delivery_agent', '77 Transit Road, Springfield', '$2b$12$e8kP01GkO6U4U8g1e3Z4MeEXAMPLEHASH5'),
('Elena Fast', 'elena@delivery.com', '+1-555-0302', 'delivery_agent', '88 Speed Way, Springfield', '$2b$12$e8kP01GkO6U4U8g1e3Z4MeEXAMPLEHASH6');

-- 2. SEED RESTAURANTS
INSERT INTO restaurants (owner_id, name, address, pincode, phone_number, is_active)
VALUES
(3, 'Pizza Paradise', '10 Market Street, Downtown', '97477', '+1-555-0201', true),
(4, 'Spice & Curry House', '25 Spice Lane, Uptown', '97478', '+1-555-0202', true);

-- 3. SEED MENU ITEMS
INSERT INTO menu_items (restaurant_id, name, description, price, category, availability)
VALUES
-- Pizza Paradise items (restaurant_id = 1)
(1, 'Margherita Pizza', 'Classic fresh mozzarella, basil, and San Marzano tomato sauce', 12.50, 'Main Course', true),
(1, 'Pepperoni Feast', 'Loaded with Italian pepperoni and aged mozzarella', 15.00, 'Main Course', true),
(1, 'Garlic Breadsticks', 'Warm garlic butter-brushed breadsticks with marinara dip', 5.50, 'Starters', true),
(1, 'Tiramisu', 'Classic Italian espresso-soaked ladyfingers with mascarpone', 7.00, 'Desserts', true),

-- Spice & Curry House items (restaurant_id = 2)
(2, 'Butter Chicken', 'Tender chicken cooked in a rich, buttery tomato-cream sauce', 14.50, 'Main Course', true),
(2, 'Garlic Butter Naan', 'Freshly baked tandoori flatbread topped with garlic and butter', 3.50, 'Starters', true),
(2, 'Gulab Jamun', 'Warm fried milk dumplings soaked in cardamom sugar syrup', 4.50, 'Desserts', true),
(2, 'Mango Lassi', 'Chilled sweet yogurt smoothie blended with ripe Alphonso mangoes', 4.00, 'Beverages', true);

-- 4. SEED ORDERS
INSERT INTO orders (user_id, restaurant_id, delivery_address, status, payment_method, payment_status, total_amount, delivery_fees)
VALUES
-- Order 1: Alice ordered from Pizza Paradise (Delivered)
(1, 1, '123 Maple Street, Apt 4B, Springfield', 'delivered', 'card', 'paid', 25.00, 3.00),

-- Order 2: Bob ordered from Spice & Curry House (Preparing)
(2, 2, '456 Oak Avenue, Springfield', 'preparing', 'upi', 'paid', 26.50, 2.50),

-- Order 3: Alice ordered from Spice & Curry House (Out for delivery)
(1, 2, '123 Maple Street, Apt 4B, Springfield', 'out_for_delivery', 'cod', 'pending', 19.00, 2.00);

-- 5. SEED ORDER ITEMS (Snapshots of what was purchased)
INSERT INTO order_items (order_id, menu_item_id, item_name, price, quantity)
VALUES
-- For Order 1: (Margherita $12.50 x 1) + (Garlic Breadsticks $5.50 x 1) + (Tiramisu $7.00 x 1) = $25.00
(1, 1, 'Margherita Pizza', 12.50, 1),
(1, 3, 'Garlic Breadsticks', 5.50, 1),
(1, 4, 'Tiramisu', 7.00, 1),

-- For Order 2: (Butter Chicken $14.50 x 1) + (Garlic Butter Naan $3.50 x 2 = $7.00) + (Mango Lassi $4.00 x 1) = $25.50
(2, 5, 'Butter Chicken', 14.50, 1),
(2, 6, 'Garlic Butter Naan', 3.50, 2),
(2, 8, 'Mango Lassi', 4.00, 1),

-- For Order 3: (Butter Chicken $14.50 x 1) + (Gulab Jamun $4.50 x 1) = $19.00
(3, 5, 'Butter Chicken', 14.50, 1),
(3, 7, 'Gulab Jamun', 4.50, 1);

-- 6. SEED DELIVERY ASSIGNMENTS
INSERT INTO delivery_assignments (order_id, agent_id, status, assigned_at, pickup_at, delivered_at)
VALUES
-- Order 1: Delivered by Dave Delivery (agent_id = 5)
(1, 5, 'delivered', NOW() - INTERVAL '2 hours', NOW() - INTERVAL '90 minutes', NOW() - INTERVAL '60 minutes'),

-- Order 3: Currently out for delivery by Elena Fast (agent_id = 6)
(3, 6, 'picked_up', NOW() - INTERVAL '30 minutes', NOW() - INTERVAL '10 minutes', NULL);

-- 7. SEED REVIEWS
INSERT INTO reviews (user_id, order_id, restaurant_id, rating, comment)
VALUES
-- Alice reviewed Order 1 from Pizza Paradise
(1, 1, 1, 5, 'The Margherita Pizza was hot, fresh, and delicious! Fast delivery by Dave.');
