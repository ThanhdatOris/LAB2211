-- Tạo database
CREATE DATABASE ThienAnDB;

go

USE ThienAnDB;
go
-- Bảng Role
CREATE TABLE MyRole (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL
);
go
-- Bảng User
CREATE TABLE MyUser (
    id INT PRIMARY KEY IDENTITY(1,1),
    role_id INT,
    fullname VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    deleted BIT DEFAULT 0,
    FOREIGN KEY (role_id) REFERENCES MyRole(id)
);
go
-- Bảng Supplier
CREATE TABLE Supplier (
    id INT PRIMARY KEY IDENTITY(1,1),
    display_name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20)
);
go
-- Bảng Category
CREATE TABLE Category (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL
);
go
-- Bảng Product
CREATE TABLE MyProduct (
    id INT PRIMARY KEY IDENTITY(1,1),
    category_id INT,
    gallery_id INT,
    supplier_id INT,
    title VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    image VARCHAR(255),
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    status VARCHAR(50) NOT NULL DEFAULT 'available',
    FOREIGN KEY (category_id) REFERENCES Category(id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(id)
);
go
-- Bảng Gallery
CREATE TABLE Gallery (
    id INT PRIMARY KEY IDENTITY(1,1),
    image VARCHAR(255),
	product_id INT,
    FOREIGN KEY (product_id) REFERENCES MyProduct(id),
);
go
-- Bảng Import
CREATE TABLE Import (
    id INT PRIMARY KEY IDENTITY(1,1),
    supplier_id INT,
    import_date DATETIME DEFAULT GETDATE(),
    quantity INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(id)
);
go
-- Bảng Import_Detail
CREATE TABLE Import_Detail (
    id INT PRIMARY KEY IDENTITY(1,1),
    import_id INT,
    product_id INT,
    quantity INT NOT NULL,
    input_price DECIMAL(10, 2) NOT NULL,
    output_price DECIMAL(10, 2),
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (import_id) REFERENCES Import(id),
    FOREIGN KEY (product_id) REFERENCES MyProduct(id)
);
go
-- Bảng Order
CREATE TABLE MyOrder (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    fullname VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    note TEXT,
    order_date DATETIME DEFAULT GETDATE(),
    order_status VARCHAR(50) NOT NULL DEFAULT 'pending',
    total_price DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    payment_status VARCHAR(50) NOT NULL DEFAULT 'unpaid',
    FOREIGN KEY (user_id) REFERENCES MyUser(id)
);
go
-- Bảng Order_Detail
CREATE TABLE Order_Detail (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    import_id INT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    date_output DATETIME,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES MyOrder(id),
    FOREIGN KEY (product_id) REFERENCES MyProduct(id),
    FOREIGN KEY (import_id) REFERENCES Import(id)
);
