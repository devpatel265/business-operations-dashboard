/*
Business Operations Dashboard
File: insert_sample_data.sql

Purpose:
This script inserts realistic sample data for a small business that sells
office technology, furniture, and service subscriptions.

The data covers six months of activity in 2025 and includes:
- 15 customers
- 12 products
- 30 orders
- 48 transaction line items

Run this script after create_tables.sql.
*/

-- Customers represent a mix of small businesses, healthcare, education, and nonprofit buyers.
INSERT INTO customers (customer_id, customer_name, segment, city, state, signup_date) VALUES
(1, 'Northstar Medical Group', 'Healthcare', 'Boston', 'MA', '2025-01-08'),
(2, 'Summit Legal Partners', 'Professional Services', 'Hartford', 'CT', '2025-01-16'),
(3, 'Greenfield Academy', 'Education', 'Providence', 'RI', '2025-01-28'),
(4, 'Harbor Cafe Co.', 'Hospitality', 'Portland', 'ME', '2025-02-03'),
(5, 'BrightPath Nonprofit', 'Nonprofit', 'Manchester', 'NH', '2025-02-12'),
(6, 'Metro Design Studio', 'Creative Services', 'New York', 'NY', '2025-02-25'),
(7, 'Blue Ridge Logistics', 'Transportation', 'Albany', 'NY', '2025-03-04'),
(8, 'Evergreen Accounting', 'Professional Services', 'Burlington', 'VT', '2025-03-17'),
(9, 'Lakeside Dental Care', 'Healthcare', 'Springfield', 'MA', '2025-03-29'),
(10, 'Pioneer Retail Supply', 'Retail', 'Worcester', 'MA', '2025-04-06'),
(11, 'Urban Fitness Collective', 'Fitness', 'New Haven', 'CT', '2025-04-19'),
(12, 'Cedar Hill Library', 'Public Sector', 'Concord', 'NH', '2025-05-02'),
(13, 'Beacon Engineering', 'Manufacturing', 'Lowell', 'MA', '2025-04-14'),
(14, 'Riverfront Events', 'Hospitality', 'Newport', 'RI', '2025-02-20'),
(15, 'Oak Street Pharmacy', 'Healthcare', 'Salem', 'MA', '2025-06-09');

-- Products are grouped into categories that are useful for dashboard analysis.
INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(101, 'Business Laptop Pro 14', 'Hardware', 1199.00),
(102, 'Docking Station', 'Hardware', 229.00),
(103, 'Wireless Keyboard Bundle', 'Accessories', 89.00),
(104, 'Office Chair Ergonomic', 'Furniture', 349.00),
(105, 'Standing Desk Converter', 'Furniture', 289.00),
(106, 'Cloud Backup Annual Plan', 'Software', 499.00),
(107, 'Analytics Starter License', 'Software', 799.00),
(108, 'Network Setup Service', 'Services', 950.00),
(109, 'Data Migration Package', 'Services', 1450.00),
(110, 'HD Webcam', 'Accessories', 129.00),
(111, 'Conference Room Display', 'Hardware', 1899.00),
(112, 'Security Awareness Training', 'Services', 650.00);

-- Orders are the purchase headers. Completed orders are included in revenue reporting.
INSERT INTO orders (order_id, customer_id, order_date, order_status, sales_channel) VALUES
(1001, 1, '2025-01-10', 'Completed', 'Direct'),
(1002, 2, '2025-01-18', 'Completed', 'Online'),
(1003, 3, '2025-01-30', 'Completed', 'Direct'),
(1004, 4, '2025-02-05', 'Completed', 'Online'),
(1005, 5, '2025-02-14', 'Completed', 'Partner'),
(1006, 6, '2025-02-27', 'Completed', 'Direct'),
(1007, 7, '2025-03-07', 'Completed', 'Direct'),
(1008, 8, '2025-03-19', 'Completed', 'Online'),
(1009, 9, '2025-03-31', 'Completed', 'Partner'),
(1010, 1, '2025-04-04', 'Completed', 'Direct'),
(1011, 10, '2025-04-08', 'Completed', 'Online'),
(1012, 11, '2025-04-21', 'Completed', 'Direct'),
(1013, 12, '2025-05-04', 'Completed', 'Partner'),
(1014, 13, '2025-05-16', 'Completed', 'Direct'),
(1015, 14, '2025-05-29', 'Completed', 'Online'),
(1016, 15, '2025-06-11', 'Completed', 'Direct'),
(1017, 2, '2025-06-15', 'Completed', 'Online'),
(1018, 3, '2025-06-20', 'Completed', 'Partner'),
(1019, 6, '2025-06-25', 'Completed', 'Direct'),
(1020, 7, '2025-06-28', 'Completed', 'Online'),
(1021, 4, '2025-03-11', 'Completed', 'Online'),
(1022, 5, '2025-04-18', 'Completed', 'Partner'),
(1023, 8, '2025-05-22', 'Completed', 'Direct'),
(1024, 9, '2025-06-03', 'Completed', 'Online'),
(1025, 10, '2025-06-06', 'Completed', 'Direct'),
(1026, 11, '2025-05-10', 'Completed', 'Online'),
(1027, 12, '2025-06-12', 'Completed', 'Partner'),
(1028, 13, '2025-04-25', 'Completed', 'Direct'),
(1029, 14, '2025-02-22', 'Completed', 'Online'),
(1030, 15, '2025-06-29', 'Pending', 'Direct');

-- Transactions are order line items. Revenue equals line_total for completed orders.
INSERT INTO transactions (transaction_id, order_id, product_id, quantity, unit_price, discount_amount, line_total) VALUES
(1, 1001, 101, 3, 1199.00, 150.00, 3447.00),
(2, 1001, 102, 3, 229.00, 0.00, 687.00),
(3, 1002, 106, 2, 499.00, 0.00, 998.00),
(4, 1002, 112, 1, 650.00, 50.00, 600.00),
(5, 1003, 107, 4, 799.00, 200.00, 2996.00),
(6, 1003, 103, 6, 89.00, 0.00, 534.00),
(7, 1004, 104, 5, 349.00, 100.00, 1645.00),
(8, 1004, 105, 2, 289.00, 0.00, 578.00),
(9, 1005, 109, 1, 1450.00, 150.00, 1300.00),
(10, 1005, 106, 1, 499.00, 0.00, 499.00),
(11, 1006, 101, 2, 1199.00, 0.00, 2398.00),
(12, 1006, 110, 4, 129.00, 0.00, 516.00),
(13, 1007, 108, 1, 950.00, 0.00, 950.00),
(14, 1007, 102, 5, 229.00, 50.00, 1095.00),
(15, 1008, 107, 2, 799.00, 0.00, 1598.00),
(16, 1008, 106, 2, 499.00, 0.00, 998.00),
(17, 1009, 101, 1, 1199.00, 0.00, 1199.00),
(18, 1009, 103, 3, 89.00, 0.00, 267.00),
(19, 1010, 109, 1, 1450.00, 0.00, 1450.00),
(20, 1010, 112, 2, 650.00, 100.00, 1200.00),
(21, 1011, 111, 1, 1899.00, 100.00, 1799.00),
(22, 1011, 110, 2, 129.00, 0.00, 258.00),
(23, 1012, 104, 4, 349.00, 0.00, 1396.00),
(24, 1012, 106, 1, 499.00, 0.00, 499.00),
(25, 1013, 107, 1, 799.00, 0.00, 799.00),
(26, 1013, 112, 1, 650.00, 0.00, 650.00),
(27, 1014, 101, 4, 1199.00, 300.00, 4496.00),
(28, 1014, 102, 4, 229.00, 0.00, 916.00),
(29, 1015, 108, 1, 950.00, 0.00, 950.00),
(30, 1015, 105, 3, 289.00, 0.00, 867.00),
(31, 1016, 109, 1, 1450.00, 100.00, 1350.00),
(32, 1016, 106, 3, 499.00, 100.00, 1397.00),
(33, 1017, 111, 1, 1899.00, 0.00, 1899.00),
(34, 1017, 103, 8, 89.00, 0.00, 712.00),
(35, 1018, 107, 3, 799.00, 150.00, 2247.00),
(36, 1018, 110, 5, 129.00, 0.00, 645.00),
(37, 1019, 101, 2, 1199.00, 100.00, 2298.00),
(38, 1019, 108, 1, 950.00, 50.00, 900.00),
(39, 1020, 104, 6, 349.00, 200.00, 1894.00),
(40, 1021, 106, 2, 499.00, 0.00, 998.00),
(41, 1022, 112, 2, 650.00, 0.00, 1300.00),
(42, 1023, 105, 4, 289.00, 0.00, 1156.00),
(43, 1024, 102, 6, 229.00, 75.00, 1299.00),
(44, 1025, 108, 1, 950.00, 0.00, 950.00),
(45, 1026, 110, 6, 129.00, 0.00, 774.00),
(46, 1028, 109, 1, 1450.00, 100.00, 1350.00),
(47, 1027, 103, 4, 89.00, 0.00, 356.00),
(48, 1029, 111, 1, 1899.00, 150.00, 1749.00);
