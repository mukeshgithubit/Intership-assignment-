SELECT Orders.Order_ID, Customers.Name, Orders.Order_Date
FROM Orders
INNER JOIN Customers ON Orders.Customer_ID=Customers.Customer_ID;

SELECT Customers.Name, Orders.Order_ID
FROM Customers
LEFT JOIN Orders ON Customers.Customer_ID = Orders.Customer_ID
ORDER BY Customers.Name;

SELECT *
FROM Orders
RIGHT JOIN Customers
ON Orders.Customer_ID=Customers.Customer_ID;

SELECT Customers.Name, Orders.Order_ID
FROM Customers
FULL OUTER JOIN Orders ON Customers.Customer_ID=Orders.Customer_ID
ORDER BY Customers.Name;

SELECT A.Name AS CustomerName1, B.Name AS CustomerName2, A.Address
FROM Customers A, Customers B
WHERE A.Customer_ID <> B.Customer_ID
AND A.Address = B.Address
ORDER BY A.address;

--oracle views
CREATE OR REPLACE VIEW customer_sales AS 
SELECT
    name AS customer,
    SUM( quantity * unit_price ) sales_amount,
    EXTRACT(
        YEAR
    FROM
        order_date
    ) YEAR
FROM
    orders
INNER JOIN order_items
        USING(order_id)
INNER JOIN customers
        USING(customer_id)
WHERE
    status = 'Shipped'
GROUP BY
    name,
    EXTRACT(
        YEAR
    FROM
        order_date
    );
    
    CREATE
    VIEW ford_cars AS SELECT
        car_id,
        car_name,
        brand_id
    FROM
        cars
    WHERE
        brand_id = 3 WITH CHECK OPTION;


INSERT
    INTO
        ford_cars(
            car_name,
            brand_id
        )
    VALUES(
        'Audi RS6 Avant',
        1
    );
    
CREATE VIEW employee_yos AS
SELECT
    employee_id,
    first_name || ' ' || last_name full_name,
    FLOOR( months_between( CURRENT_DATE, hire_date )/ 12 ) yos
FROM
    employees;
SELECT
    *
FROM
    employee_yos
WHERE
    yos = 15
ORDER BY
    full_name;
    
CREATE OR REPLACE VIEW customer_credits(
        customer_id,
        name,
        credit
    ) AS 
SELECT
        customer_id,
        name,
        credit_limit
    FROM
        customers WITH READ ONLY;
        
CREATE OR REPLACE VIEW backlogs AS
SELECT
    product_name,
    EXTRACT(
        YEAR
    FROM
        order_date
    ) YEAR,
    SUM( quantity * unit_price ) amount
FROM
    orders
INNER JOIN order_items
        USING(order_id)
INNER JOIN products
        USING(product_id)
WHERE
    status = 'Pending'
GROUP BY
    EXTRACT(
        YEAR
    FROM
        order_date
    ),
    product_name;


CREATE VIEW salesman AS 
SELECT
    *
FROM
    employees
WHERE
    job_title = 'Sales Representative';
    
    
    CREATE VIEW salesman_contacts AS 
SELECT
    first_name,
    last_name,
    email,
    phone
FROM
    salesman;

DROP VIEW salesman;

SELECT
    object_name,
    status
FROM
    user_objects
WHERE
    object_type = 'VIEW'
    AND object_name = 'SALESMAN_CONTACTS';

DROP VIEW salesman_contacts;

CREATE TABLE brands(
	brand_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
	brand_name VARCHAR2(50) NOT NULL,
	PRIMARY KEY(brand_id)
);

CREATE TABLE cars (
	car_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
	car_name VARCHAR2(255) NOT NULL,
	brand_id NUMBER NOT NULL,
	PRIMARY KEY(car_id),
	FOREIGN KEY(brand_id) 
	REFERENCES brands(brand_id) ON DELETE CASCADE
);

INSERT INTO brands(brand_name)
VALUES('Audi');


INSERT INTO brands(brand_name)
VALUES('BMW');


INSERT INTO brands(brand_name)
VALUES('Ford');


INSERT INTO brands(brand_name)
VALUES('Honda');


INSERT INTO brands(brand_name)
VALUES('Toyota');


INSERT INTO cars (car_name,brand_id)
VALUES('Audi R8 Coupe',
       1);


INSERT INTO cars (car_name,brand_id)
VALUES('Audi Q2',
       1);


INSERT INTO cars (car_name,brand_id)
VALUES('Audi S1',
       1);


INSERT INTO cars (car_name,brand_id)
VALUES('BMW 2-serie Cabrio',
       2);


INSERT INTO cars (car_name,brand_id)
VALUES('BMW i8',
       2);


INSERT INTO cars (car_name,brand_id)
VALUES('Ford Edge',
       3);


INSERT INTO cars (car_name,brand_id)
VALUES('Ford Mustang Fastback',
       3);


INSERT INTO cars (car_name,brand_id)
VALUES('Honda S2000',
       4);


INSERT INTO cars (car_name,brand_id)
VALUES('Honda Legend',
       4);


INSERT INTO cars (car_name,brand_id)
VALUES('Toyota GT86',
       5);


INSERT INTO cars (car_name,brand_id)
VALUES('Toyota C-HR',
       5);
       
       
CREATE VIEW cars_master AS 
SELECT
    car_id,
    car_name
FROM
    cars;

DELETE
FROM
    cars_master
WHERE
    car_id = 1;

UPDATE
    cars_master
SET
    car_name = 'Audi RS7 Sportback'
WHERE
    car_id = 2;

INSERT INTO cars_master
VALUES('Audi S1 Sportback');

CREATE VIEW all_cars AS 
SELECT
    car_id,
    car_name,
    c.brand_id,
    brand_name
FROM
    cars c
INNER JOIN brands b ON
    b.brand_id = c.brand_id; 

INSERT INTO all_cars(car_name, brand_id )
VALUES('Audi A5 Cabriolet', 1);

DELETE
FROM
    all_cars
WHERE
    brand_name = 'Honda';

SELECT
    *
FROM
    USER_UPDATABLE_COLUMNS
WHERE
    TABLE_NAME = 'ALL_CARS';


--fetch clause

SELECT
	product_name,
	quantity
FROM
	inventories
INNER JOIN products
		USING(product_id)
ORDER BY
	quantity DESC 
LIMIT 5;

SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH NEXT 5 ROWS ONLY;


SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH NEXT 10 ROWS ONLY;

SELECT
	product_name,
	quantity
FROM
	inventories
INNER JOIN products
		USING(product_id)
ORDER BY
	quantity DESC 
FETCH NEXT 10 ROWS WITH TIES;

SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH FIRST 5 PERCENT ROWS ONLY;

SELECT
	product_name,
	quantity
FROM
	inventories
INNER JOIN products
		USING(product_id)
ORDER BY
	quantity DESC 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;

--Inline View

SELECT
    *
FROM
    (
        SELECT
            product_id,
            product_name,
            list_price
        FROM
            products
        ORDER BY
            list_price DESC
    )
WHERE
    ROWNUM <= 10;
SELECT
    category_name,
    max_list_price
FROM
    product_categories a,
    (
        SELECT
            category_id,
            MAX( list_price ) max_list_price
        FROM
            products
        GROUP BY
            category_id
    ) b
WHERE
    a.category_id = b.category_id
ORDER BY
    category_name;
SELECT
    category_name,
    product_name
FROM
    products p,
    (
        SELECT
            *
        FROM
            product_categories c
        WHERE
            c.category_id = p.category_id
    )
ORDER BY
    product_name;
SELECT
    product_name,
    category_name
FROM
    products p,
    LATERAL(
        SELECT
            *
        FROM
            product_categories c
        WHERE
            c.category_id = p.category_id
    )
ORDER BY
    product_name;
UPDATE
    (
        SELECT
            list_price
        FROM
            products
        INNER JOIN product_categories using (category_id)
        WHERE
            category_name = 'CPU'
    )
SET
    list_price = list_price * 1.15; 
DELETE
    (
        SELECT
            list_price
        FROM
            products
        INNER JOIN product_categories
                USING(category_id)
        WHERE
            category_name = 'Video Card'
    )
WHERE
    list_price < 1000; 