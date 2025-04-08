--Task1
CREATE TABLE student(
	id int,
	name nvarchar(100),
	age int
);

ALTER TABLE student
ALTER COLUMN id INT NOT NULL;

--select * from student

--Task2
CREATE TABLE product(
	product_id INT UNIQUE,
	product_name NVARCHAR(255),
	price DECIMAL(10,2)
);

ALTER TABLE product
DROP CONSTRAINT UQ__product__47027DF490703809;

ALTER TABLE product
ADD CONSTRAINT UQ_product_id_name UNIQUE (product_id, product_name);

--Task3
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_name NVARCHAR(100),
	order_date DATE
);


ALTER TABLE orders
DROP CONSTRAINT PK__orders__4659622925429081;

ALTER TABLE orders
ADD CONSTRAINT PK_orders_order_id PRIMARY KEY(order_id);

--Task4
CREATE TABLE category(
	category_id INT PRIMARY KEY,
	category_name NVARCHAR(100)
);

CREATE TABLE item(
	item_id INT PRIMARY KEY,
	item_name NVARCHAR(100),
	category_id INT FOREIGN KEY REFERENCES category(category_id)
)
ALTER TABLE item
DROP CONSTRAINT FK__item__category_i__3AA1AEB8;

ALTER TABLE item
ADD CONSTRAINT fk_item_category
FOREIGN KEY (category_id)
REFERENCES category(category_id);

--Task5
CREATE TABLE account (
    account_id INT PRIMARY KEY,
    balance DECIMAL(10, 2) CONSTRAINT chk_balance CHECK (balance >= 0),
    account_type VARCHAR(20) CONSTRAINT chk_account_type CHECK (account_type IN ('Saving', 'Checking'))
);


ALTER TABLE account DROP CONSTRAINT chk_balance;
ALTER TABLE account DROP CONSTRAINT chk_account_type;

ALTER TABLE account
ADD CONSTRAINT chk_balance CHECK (balance >= 0);

ALTER TABLE account
ADD CONSTRAINT chk_account_type CHECK (account_type IN ('Saving', 'Checking'));

--Task6
CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
	name NVARCHAR(100),
	city NVARCHAR(100) CONSTRAINT df_city DEFAULT 'Unknown'
)
ALTER TABLE customer
DROP CONSTRAINT df_city;

ALTER TABLE customer
ADD CONSTRAINT df_city DEFAULT 'Unknown' FOR city;

--Task7
CREATE TABLE invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    amount DECIMAL(10, 2)
);
INSERT INTO invoice (amount) VALUES (150.00);
INSERT INTO invoice (amount) VALUES (200.50);
INSERT INTO invoice (amount) VALUES (75.25);
INSERT INTO invoice (amount) VALUES (99.99);
INSERT INTO invoice (amount) VALUES (300.00);

SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 500.00);

SET IDENTITY_INSERT invoice OFF;

--Task8
CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL CHECK (LEN(title) > 0),
    price DECIMAL(10, 2) CHECK (price > 0),
    genre VARCHAR(100) CONSTRAINT df_genre DEFAULT 'Unknown'
);

--Task9
CREATE TABLE Book (
    book_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255),
    author VARCHAR(255),
    published_year INT
);

CREATE TABLE Member (
    member_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE Loan (
    loan_id INT PRIMARY KEY IDENTITY(1,1),
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE NULL,
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES Book(book_id),
    CONSTRAINT fk_member FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

INSERT INTO Book (title, author, published_year) VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
('1984', 'George Orwell', 1949),
('To Kill a Mockingbird', 'Harper Lee', 1960);

INSERT INTO Member (name, email, phone_number) VALUES 
('Alice Johnson', 'alice@example.com', '123-456-7890'),
('Bob Smith', 'bob@example.com', '234-567-8901'),
('Charlie Brown', 'charlie@example.com', '345-678-9012');

INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES 
(1, 1, '2025-04-01', '2025-04-08'),
(2, 2, '2025-04-03', NULL),
(3, 1, '2025-04-05', NULL);

SELECT * FROM Book;
SELECT * FROM Member;
SELECT * FROM Loan;

