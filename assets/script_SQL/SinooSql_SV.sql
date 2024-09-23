CREATE DATABASE FuniTeamDB;
GO

USE FuniTeamDB;
GO
-- Bảng MyRole quản lý vai trò của người dùng
CREATE TABLE MyRole (
    ID INT PRIMARY KEY IDENTITY(1,1),
    role_name VARCHAR(50) NOT NULL
);

-- Bảng MyUser lưu thông tin người dùng
CREATE TABLE MyUser (
    ID INT PRIMARY KEY IDENTITY(1,1),
    fullname NVARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    address NVARCHAR(255),
    gender NVARCHAR(10),
    dateOfBirth DATE,
    password_hash NVARCHAR(255) NOT NULL,
    salt NVARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES MyRole(ID)
);

-- Bảng Category quản lý danh mục sản phẩm
CREATE TABLE Category (
    ID INT PRIMARY KEY IDENTITY(1,1),
    parent_id INT NULL,
    name NVARCHAR(100) NOT NULL,
    room_type NVARCHAR(100),
    usage_type NVARCHAR(100),
    description NVARCHAR(255),
    active BIT NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES Category(ID)
);

-- Bảng MyProduct lưu thông tin sản phẩm
CREATE TABLE MyProduct (
    ID INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    price DECIMAL(18, 2) NOT NULL,
    unit NVARCHAR(50),
    material NVARCHAR(100),
    dimension NVARCHAR(100),
    standard NVARCHAR(100),
    color NVARCHAR(50),
    type NVARCHAR(50),
    brand NVARCHAR(50),
    warranty_period NVARCHAR(50),
    description NVARCHAR(255),
    image NVARCHAR(MAX),
    active BIT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Category(ID)
);

-- Bảng Supplier lưu thông tin nhà cung cấp
CREATE TABLE Supplier (
    ID INT PRIMARY KEY IDENTITY(1,1),
    display_name NVARCHAR(100) NOT NULL,
    address NVARCHAR(255),
    email NVARCHAR(100),
    phone_number VARCHAR(15),
    image NVARCHAR(MAX),
    active BIT NOT NULL
);

-- Bảng GoodsReceived lưu phiếu nhập hàng
CREATE TABLE GoodsReceived (
    ID INT PRIMARY KEY IDENTITY(1,1),
    receipt_date DATE NOT NULL,
    total_price DECIMAL(18,2) NOT NULL,
    total_quantity DECIMAL(18,2) NOT NULL,
    note NVARCHAR(255),
    supplier_id INT NOT NULL,
    manager_id INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(ID),
    FOREIGN KEY (manager_id) REFERENCES MyUser(ID)
);

-- Bảng GoodsReceivedItem lưu chi tiết phiếu nhập
CREATE TABLE GoodsReceivedItem (
    ID INT PRIMARY KEY IDENTITY(1,1),
    quantity INT NOT NULL,
    import_price DECIMAL(18, 2) NOT NULL,
    total_price DECIMAL(18, 2) NOT NULL,
    goods_received_id INT NOT NULL,
    product_id INT NOT NULL UNIQUE,
    FOREIGN KEY (goods_received_id) REFERENCES GoodsReceived(ID),
    FOREIGN KEY (product_id) REFERENCES MyProduct(ID)
);

-- Bảng Cart lưu thông tin giỏ hàng
CREATE TABLE MyCart (
    ID INT PRIMARY KEY IDENTITY(1,1),
    totalPrice DECIMAL(18,2),
    customer_id INT NOT NULL UNIQUE,
    FOREIGN KEY (customer_id) REFERENCES MyUser(ID)
);

-- Bảng CartItem lưu chi tiết giỏ hàng
CREATE TABLE CartItem (
    ID INT PRIMARY KEY IDENTITY(1,1),
    quantity INT NOT NULL,
    price DECIMAL(18, 2) NOT NULL,
    cart_id INT NOT NULL,
    product_id INT NOT NULL UNIQUE,
    FOREIGN KEY (cart_id) REFERENCES Cart(ID),
    FOREIGN KEY (product_id) REFERENCES MyProduct(ID)
);

-- Bảng MyOrder lưu thông tin đơn hàng
CREATE TABLE MyOrder (
    ID INT PRIMARY KEY IDENTITY(1,1),
    customer_phone_number VARCHAR(15) NOT NULL,
    total_price DECIMAL(18,2) NOT NULL,
    order_date DATE NOT NULL,
    order_status INT NOT NULL,
    customer_id INT NOT NULL,
    sale_staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES MyUser(ID),
    FOREIGN KEY (sale_staff_id) REFERENCES MyUser(ID)
);

-- Bảng OrderItem lưu chi tiết đơn hàng
CREATE TABLE OrderItem (
    ID INT PRIMARY KEY IDENTITY(1,1),
    product_name NVARCHAR(100) NOT NULL,
    price_at_order DECIMAL(18, 2) NOT NULL,
    subtotal DECIMAL(18, 2) NOT NULL,
    quantity INT NOT NULL,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES MyOrder(ID),
    FOREIGN KEY (product_id) REFERENCES MyProduct(ID)
);

-- Bảng Invoice lưu thông tin hóa đơn
CREATE TABLE MyInvoice (
    ID INT PRIMARY KEY IDENTITY(1,1),
    invoice_date DATE NOT NULL,
    total_price DECIMAL(18,2) NOT NULL,
    payment_status NVARCHAR(50) NOT NULL,
    payment_method NVARCHAR(50) NOT NULL,
    order_id INT NOT NULL UNIQUE,
    FOREIGN KEY (order_id) REFERENCES MyOrder(ID)
);
