-- Bước 1: Sử dụng cơ sở dữ liệu classicmodels
USE classicmodels;

-- ========================================================
-- PHẦN 1: TẠO VIEW VÀ TRUY VẤN DỮ LIỆU TỪ VIEW
-- ========================================================

-- Tạo view customer_views để lấy các cột customerNumber, customerName, phone
CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- Lấy dữ liệu từ bảng ảo customer_views vừa tạo
SELECT * 
FROM customer_views;


-- ========================================================
-- PHẦN 2: CẬP NHẬT VIEW (SỬ DỤNG CREATE OR REPLACE VIEW)
-- ========================================================

-- Cập nhật lại view customer_views để thêm các cột tên liên hệ và lọc theo thành phố 'Nantes'
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

-- Kiểm tra lại dữ liệu sau khi cập nhật view
SELECT * 
FROM customer_views;


-- ========================================================
-- PHẦN 3: XÓA VIEW (DROP VIEW)
-- ========================================================

-- Xóa view customer_views khi không còn sử dụng đến nữa
DROP VIEW IF EXISTS customer_views;
