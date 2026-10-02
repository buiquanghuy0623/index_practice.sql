-- Bước 1: Sử dụng cơ sở dữ liệu classicmodels
USE classicmodels;

-- ========================================================
-- 1. THAM SỐ LOẠI IN (Tham số đầu vào)
-- ========================================================

DELIMITER //

DROP PROCEDURE IF EXISTS getCusById //

CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
  SELECT * FROM customers WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi Stored Procedure với tham số IN
CALL getCusById(175);


-- ========================================================
-- 2. THAM SỐ LOẠI OUT (Tham số đầu ra)
-- ========================================================

DELIMITER //

DROP PROCEDURE IF EXISTS GetCustomersCountByCity //

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi Stored Procedure với tham số OUT và xem kết quả
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS TotalCustomersInLyon;


-- ========================================================
-- 3. THAM SỐ LOẠI INOUT (Vừa truyền vào vừa lấy ra)
-- ========================================================

DELIMITER //

DROP PROCEDURE IF EXISTS SetCounter //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Khởi tạo biến, gọi liên tục Stored Procedure và kiểm tra kết quả
SET @counter = 1;

CALL SetCounter(@counter, 1); -- Giá trị sau khi cộng 1 là 2
CALL SetCounter(@counter, 1); -- Giá trị sau khi cộng tiếp 1 là 3
CALL SetCounter(@counter, 5); -- Giá trị sau khi cộng tiếp 5 là 8

-- Hiển thị kết quả cuối cùng của biến @counter
SELECT @counter AS FinalCounterValue;
