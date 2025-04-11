--Task1
CREATE TABLE test(
	test_identity INT IDENTITY(1,1),
	name NVARCHAR(50)
);

INSERT INTO test(name) VALUES
	('john'),
	('rock'),
	('doe'),
	('adam'),
	('jane');

DELETE FROM test;
INSERT INTO test(name) VALUES('rose') -- OUTPUT: test identity:3, name: 'rose'
--All rows are removed.
--The table structure stays.
--The IDENTITY seed is NOT reset.
TRUNCATE TABLE test;
INSERT INTO test(name) VALUES('rose') -- OUTPUT: test identity:1, name: 'rose'
--All rows are removed.
--The table structure stays.
--The IDENTITY seed IS reset.
DROP TABLE test;
--The entire table is deleted from the database.
--Structure and data are gone

--Task2
CREATE TABLE data_types_demo (
    tiny_col TINYINT,
    small_col SMALLINT,
    int_col INT,
    big_col BIGINT,
    
    dec_col DECIMAL(10,2),
    float_col FLOAT,
    
    char_col CHAR(10),
    varchar_col VARCHAR(50),
    text_col TEXT,
    
    date_col DATE,
    time_col TIME,
    datetime_col DATETIME,
    
    guid_col UNIQUEIDENTIFIER,
    
    image_col VARBINARY(MAX)
);
INSERT INTO data_types_demo (
    tiny_col, small_col, int_col, big_col,
    dec_col, float_col,
    char_col, varchar_col, text_col,
    date_col, time_col, datetime_col,
    guid_col, image_col
)
VALUES (
    100,               -- TINYINT
    32000,             -- SMALLINT
    2000000000,        -- INT
    9000000000000000,  -- BIGINT

    12345.67,          -- DECIMAL
    3.14159,           -- FLOAT

    'char-text',       -- CHAR(10)
    'varchar text',    -- VARCHAR(50)
    'This is a long text string.', -- TEXT

    '2025-04-10',      -- DATE
    '14:30:00',        -- TIME
    GETDATE(),         -- DATETIME

    NEWID(),           -- UNIQUEIDENTIFIER

    CAST('FakeImageBinary' AS VARBINARY(MAX)) -- VARBINARY
);

--Task3
CREATE TABLE photos(
	id INT PRIMARY KEY,
	image VARBINARY(MAX)
)

INSERT INTO photos
select 1,BulkColumn from openrowset(
	BULK 'C:\Users\user\Pictures\download.jpg', SINGLE_BLOB
) AS img;

SELECT * FROM photos;
--SELECT @@SERVERNAME

--Task4
CREATE TABLE student(
	id INT PRIMARY KEY,
	classes INT,
	name VARCHAR(100),
	tuition_per_class DECIMAL(10,2),
	total_tuition AS (classes * tuition_per_class) PERSISTED
);

INSERT INTO student (id, name, classes, tuition_per_class)
VALUES
(1, 'Alice', 5, 200.00),
(2, 'Bob', 3, 150.50),
(3, 'Charlie', 7, 180.25);
SELECT * FROM student;

--Task5
CREATE TABLE employee(
	id INT PRIMARY KEY,
	name NVARCHAR(100)
);
BULK INSERT employee
FROM 'D:\sql homework\sql-homework\lesson-2\homework\employees.csv'
WITH (
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
);
SELECT * FROM employee