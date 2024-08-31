-- Tạo database
CREATE DATABASE VLXDThienAnDB;

go

USE VLXDThienAnDB;
go
-- Bảng Role
CREATE TABLE MyRole (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL
);
go
-- Bảng User
CREATE TABLE MyUser (
    id INT PRIMARY KEY IDENTITY(1,1),
    role_id INT,
    fullname NVARCHAR(255) NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,
    address NVARCHAR(255),
    username NVARCHAR(100) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    deleted BIT DEFAULT 0,
    FOREIGN KEY (role_id) REFERENCES MyRole(id)
);
go
-- Bảng Supplier
CREATE TABLE Supplier (
    id INT PRIMARY KEY IDENTITY(1,1),
    display_name NVARCHAR(255) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    phone NVARCHAR(20) NOT NULL
);
go
-- Bảng Category
CREATE TABLE Category (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL
);
go
-- Bảng Product
CREATE TABLE MyProduct (
    id INT PRIMARY KEY IDENTITY(1,1),
    category_id INT,
    supplier_id INT,
    --unit_id INT,
    title NVARCHAR(255) NOT NULL,
    unit NVARCHAR(100) NOT NULL,
    --price MONEY NOT NULL,
    image VARCHAR(255),
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) NOT NULL DEFAULT 'Available',
    FOREIGN KEY (category_id) REFERENCES Category(id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(id),
    --FOREIGN KEY (unit_id) REFERENCES MyUnit(id)

);
go
-- Bảng Unit
--CREATE TABLE MyUnit (
--    id INT PRIMARY KEY IDENTITY(1,1),
--	display_name NVARCHAR(255) NOT NULL,
--    FOREIGN KEY (supplier_id) REFERENCES Supplier(id)
--);
--go
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
    import_date DATETIME DEFAULT GETDATE(),
    quantity INT NOT NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'Success',
);
go
-- Bảng Import_Detail
CREATE TABLE Import_Detail (
    id INT PRIMARY KEY IDENTITY(1,1),
    import_id INT,
    product_id INT,
    quantity INT NOT NULL,
    input_price MONEY NOT NULL,
    output_price MONEY,
    total_price MONEY NOT NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (import_id) REFERENCES Import(id),
    FOREIGN KEY (product_id) REFERENCES MyProduct(id)
);
go
-- Bảng Order
CREATE TABLE MyOrder (
    id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    fullname NVARCHAR(255) NOT NULL,
    phone_number NVARCHAR(20),
    address NVARCHAR(255),
    note NVARCHAR(255),
    order_date DATETIME DEFAULT GETDATE(),
    order_status NVARCHAR(50) NOT NULL DEFAULT 'Pending',
    total_price MONEY NOT NULL,
    payment_method NVARCHAR(100) NOT NULL,
    payment_status NVARCHAR(50) NOT NULL DEFAULT 'Unpaid',
    FOREIGN KEY (user_id) REFERENCES MyUser(id)
);
go
-- Bảng Order_Detail
CREATE TABLE Order_Detail (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    import_id INT,
    price MONEY NOT NULL,
    quantity INT NOT NULL,
    date_output DATETIME,
    total_price MONEY NOT NULL,
    status NVARCHAR(50) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES MyOrder(id),
    FOREIGN KEY (product_id) REFERENCES MyProduct(id),
    FOREIGN KEY (import_id) REFERENCES Import(id)
);
