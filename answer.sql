-- ============================================================
-- Week 7 Assignment: Database Design and Normalization
-- Question 1: 1NF | Question 2: 2NF
-- ============================================================

-- ============================================================
-- QUESTION 1: Achieving First Normal Form (1NF)
-- ============================================================
-- Problem: Products column contains multiple values in one cell
-- (e.g. 'Laptop, Mouse') -> Violates 1NF
-- Solution: Each row = one product per order only

CREATE TABLE ProductDetail_1NF (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

SELECT * FROM ProductDetail_1NF;

-- ============================================================
-- QUESTION 2: Achieving Second Normal Form (2NF)
-- ============================================================
-- Partial Dependency: CustomerName depends ONLY on OrderID,
-- NOT on full composite key (OrderID, Product). Violates 2NF.
-- Solution: Split into Orders + OrderItems

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

SELECT * FROM Orders;
SELECT * FROM OrderItems;

SELECT o.OrderID, o.CustomerName, i.Product, i.Quantity
FROM Orders o
JOIN OrderItems i ON o.OrderID = i.OrderID
ORDER BY o.OrderID, i.Product;
