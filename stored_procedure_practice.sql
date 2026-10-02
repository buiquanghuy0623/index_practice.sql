-- Bước 1: Sử dụng cơ sở dữ liệu classicmodels
USE classicmodels;

-- ========================================================
-- PHẦN 1: TẠO VÀ GỌI STORED PROCEDURE ĐẦU TIÊN
-- ========================================================

-- Thay đổi ký tự kết thúc lệnh tạm thời thành //
DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END //

-- Trả lại ký tự kết thúc lệnh về mặc định là dấu chấm phẩy ;
DELIMITER ;

-- Cách gọi Stored Procedure vừa tạo
CALL findAllCustomers();


-- ========================================================
-- PHẦN 2: XÓA VÀ CẬP NHẬT/SỬA STORED PROCEDURE
-- ========================================================
-- Lưu ý: MySQL không hỗ trợ lệnh ALTER PROCEDURE trực tiếp, 
-- do đó ta sẽ dùng DROP PROCEDURE IF EXISTS để xóa và tạo lại.

DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()
BEGIN
  -- Cập nhật logic: Lọc khách hàng có customerNumber bằng 175
  SELECT * FROM customers WHERE customerNumber = 175;
END //

DELIMITER ;

-- Gọi lại Stored Procedure sau khi đã cập nhật
CALL findAllCustomers();
