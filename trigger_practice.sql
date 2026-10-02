-- Bước 1: Tạo CSDL và Bảng
CREATE DATABASE IF NOT EXISTS company;
USE company;

-- Xóa bảng nếu đã tồn tại để tránh lỗi trùng lặp khi chạy lại
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- ========================================================
-- Bước 2: Tạo Trigger tự động cập nhật trường "department"
-- ========================================================
DELIMITER //

-- Xóa trigger cũ nếu đã tồn tại
DROP TRIGGER IF EXISTS update_department //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;

-- ========================================================
-- Bước 3: Demo sử dụng trigger
-- ========================================================
-- Thêm dữ liệu mẫu (dù ban đầu gán department là 'A', trigger sẽ tự động ghi đè dựa trên lương)
INSERT INTO employees (name, department, salary)
VALUES 
    ('John Doe', 'A', 3500),       -- Lương 3500 -> Sẽ đổi thành 'Sales'
    ('Jane Smith', 'A', 2000),     -- Lương 2000 -> Sẽ đổi thành 'Support'
    ('David Johnson', 'A', 6000);  -- Lương 6000 -> Sẽ đổi thành 'Management'

-- Kiểm tra kết quả dữ liệu trong bảng sau khi trigger hoạt động
SELECT * FROM employees;
