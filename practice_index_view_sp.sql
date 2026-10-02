-- ========================================================
-- BƯỚC 1: TẠO CƠ SỞ DỮ LIỆU DEMO
-- ========================================================
CREATE DATABASE IF NOT EXISTS demo_product_db;
USE demo_product_db;

-- ========================================================
-- BƯỚC 2: TẠO BẢNG PRODUCTS VÀ CHÈN DỮ LIỆU MẪU
-- ========================================================
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10,2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription TEXT,
    productStatus VARCHAR(50)
);

-- Chèn dữ liệu mẫu vào bảng Products
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus) VALUES
('P001', 'Laptop Dell Inspiron', 15000000.00, 10, 'Laptop văn phòng cấu hình tốt', 'Available'),
('P002', 'Smartphone iPhone 15', 22000000.00, 15, 'Điện thoại thông minh cao cấp', 'Available'),
('P003', 'Chuột không dây Logitech', 350000.00, 50, 'Chuột quang không dây tiện lợi', 'Available'),
('P004', 'Bàn phím cơ Gaming', 1200000.00, 20, 'Bàn phím LED RGB chơi game', 'Out of Stock');


-- ========================================================
-- BƯỚC 3: TẠO INDEX VÀ KHẢO SÁT BẰNG EXPLAIN
-- ========================================================

-- Kiểm tra EXPLAIN trước khi tạo Index cho productCode
EXPLAIN SELECT * FROM Products WHERE productCode = 'P002';

-- 1. Tạo Unique Index trên cột productCode
CREATE UNIQUE INDEX idx_productCode ON Products(productCode);

-- 2. Tạo Composite Index trên 2 cột productName và productPrice
CREATE INDEX idx_name_price ON Products(productName, productPrice);

-- Kiểm tra EXPLAIN sau khi đã tạo Index
EXPLAIN SELECT * FROM Products WHERE productCode = 'P002';
EXPLAIN SELECT * FROM Products WHERE productName = 'Smartphone iPhone 15' AND productPrice = 22000000.00;


-- ========================================================
-- BƯỚC 4: TẠO, SỬA VÀ XÓA VIEW
-- ========================================================

-- 1. Tạo view lấy về các thông tin cơ bản của sản phẩm
CREATE VIEW view_products_basic AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

-- Xem dữ liệu từ View vừa tạo
SELECT * FROM view_products_basic;

-- 2. Sửa đổi View (Cập nhật thêm cột productAmount)
CREATE OR REPLACE VIEW view_products_basic AS
SELECT productCode, productName, productPrice, productAmount, productStatus
FROM Products;

-- 3. Xóa View khi không còn dùng đến
DROP VIEW IF EXISTS view_products_basic;


-- ========================================================
-- BƯỚC 5: TẠO CÁC STORED PROCEDURE
-- ========================================================

DELIMITER //

-- 1. Stored Procedure lấy tất cả thông tin của tất cả sản phẩm
DROP PROCEDURE IF EXISTS GetAllProducts //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //

-- 2. Stored Procedure thêm một sản phẩm mới
DROP PROCEDURE IF EXISTS InsertProduct //
CREATE PROCEDURE InsertProduct(
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_desc TEXT,
    IN p_status VARCHAR(50)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_code, p_name, p_price, p_amount, p_desc, p_status);
END //

-- 3. Stored Procedure sửa thông tin sản phẩm theo Id
DROP PROCEDURE IF EXISTS UpdateProductById //
CREATE PROCEDURE UpdateProductById(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_desc TEXT,
    IN p_status VARCHAR(50)
)
BEGIN
    UPDATE Products
    SET productName = p_name,
        productPrice = p_price,
        productAmount = p_amount,
        productDescription = p_desc,
        productStatus = p_status
    WHERE Id = p_id;
END //

-- 4. Stored Procedure xóa sản phẩm theo Id
DROP PROCEDURE IF EXISTS DeleteProductById //
CREATE PROCEDURE DeleteProductById(
    IN p_id INT
)
BEGIN
    DELETE FROM Products WHERE Id = p_id;
END //

DELIMITER ;


-- ========================================================
-- DEMO GỌI CÁC STORED PROCEDURE VỪA TẠO
-- ========================================================
-- Gọi lấy danh sách sản phẩm
CALL GetAllProducts();

-- Gọi thêm sản phẩm mới
CALL InsertProduct('P005', 'Tai nghe Bluetooth', 850000.00, 30, 'Tai nghe chống ồn', 'Available');

-- Gọi sửa sản phẩm có Id = 3
CALL UpdateProductById(3, 'Chuột không dây Logitech Pro', 400000.00, 45, 'Phiên bản nâng cấp', 'Available');

-- Gọi xóa sản phẩm có Id = 4
CALL DeleteProductById(4);

-- Kiểm tra lại toàn bộ danh sách sản phẩm sau khi thực thi
CALL GetAllProducts();
