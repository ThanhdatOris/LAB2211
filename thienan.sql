-- Tạo database
CREATE DATABASE ThienAn;
USE ThienAn;

-- Bảng Role
CREATE TABLE Role (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Bảng User
CREATE TABLE User (
    id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT,
    fullname VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (role_id) REFERENCES Role(id)
);

-- Bảng Supplier
CREATE TABLE Supplier (
    id INT PRIMARY KEY AUTO_INCREMENT,
    display_name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20)
);

-- Bảng Category
CREATE TABLE Category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Bảng Gallery
CREATE TABLE Gallery (
    id INT PRIMARY KEY AUTO_INCREMENT,
    image VARCHAR(255)
);

-- Bảng Product
CREATE TABLE Product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    gallery_id INT,
    supplier_id INT,
    title VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    image VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'available',
    FOREIGN KEY (category_id) REFERENCES Category(id),
    FOREIGN KEY (gallery_id) REFERENCES Gallery(id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(id)
);

-- Bảng Import
CREATE TABLE Import (
    id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT,
    import_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(id)
);

-- Bảng Import_Detail
CREATE TABLE Import_Detail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    import_id INT,
    product_id INT,
    quantity INT NOT NULL,
    input_price DECIMAL(10, 2) NOT NULL,
    output_price DECIMAL(10, 2),
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (import_id) REFERENCES Import(id),
    FOREIGN KEY (product_id) REFERENCES Product(id)
);

-- Bảng Order
CREATE TABLE `Order` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    fullname VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    note TEXT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(50) NOT NULL DEFAULT 'pending',
    total_price DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    payment_status VARCHAR(50) NOT NULL DEFAULT 'unpaid',
    FOREIGN KEY (user_id) REFERENCES User(id)
);

-- Bảng Order_Detail
CREATE TABLE Order_Detail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    import_id INT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    date_output TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES `Order`(id),
    FOREIGN KEY (product_id) REFERENCES Product(id),
    FOREIGN KEY (import_id) REFERENCES Import(id)
);
