DROP TABLE SalesRecords;    


-- 1NF
CREATE TABLE SalesRecords (
    OrdersID VARCHAR(10),
    CustomerName VARCHAR(20),
    ProductID VARCHAR2(10),
    ProductName VARCHAR2(255),
    SalesPersonID VARCHAR(10),
    SalesPersonName VARCHAR(20),
    SalesBranch VARCHAR(20),
    OrdersDate DATE,
    PRIMARY KEY (OrdersID,CustomerName,ProductID,OrdersDate)
);

-- 2NF

CREATE TABLE SalesRecords (
    OrdersID VARCHAR(10),
    CustomerName VARCHAR(20),
    ProductID VARCHAR2(10),
    ProductName VARCHAR2(255),
    SalesPersonID VARCHAR(10),
    SalesPersonName VARCHAR(20),
    SalesBranch VARCHAR(20),
    OrdersDate DATE
    PRIMARY KEY (OrdersID,CustomerName,ProductID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPersons(SalesPersonID)
);

CREATE TABLE Products (
    ProductID VARCHAR(10),
    ProductName VARCHAR(255),
    PRIMARY KEY (ProductID)
);

CREATE TABLE SalesPersons (
    SalesPersonID VARCHAR(10),
    SalesPersonName VARCHAR(20),
    SalesBranch VARCHAR(20),
    PRIMARY KEY (SalesPersonID)
);

-- 3NF

DROP TABLE SalesRecords CASCADE CONSTRAINTS;
CREATE TABLE SalesRecords (
    OrdersID VARCHAR(10),
    CustomerName VARCHAR(20),
    ProductID VARCHAR2(10),
    SalesPersonID VARCHAR(10),
    PRIMARY KEY (OrdersID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SalesPersonID) REFERENCES SalesPersons(SalesPersonID),
    FOREIGN KEY (OrdersID) REFERENCES Orders(OrdersID)
);


DROP TABLE Orders CASCADE CONSTRAINTS;
CREATE TABLE Orders (
    OrdersID VARCHAR(10),
    OrdersDate DATE,
    PRIMARY KEY (OrdersID)
);

DROP TABLE Products CASCADE CONSTRAINTS;
CREATE TABLE Products (
    ProductID VARCHAR(10),
    ProductName VARCHAR(255),
    PRIMARY KEY (ProductID)
);


DROP TABLE SalesPersons CASCADE CONSTRAINTS;
CREATE TABLE SalesPersons (
    SalesPersonID VARCHAR(10),
    SalesPersonName VARCHAR(20),
    SalesBranch VARCHAR(20),
    PRIMARY KEY (SalesPersonID)
);



SELECT 
    s.OrdersID,
    s.CustomerName,
    p.ProductName,
    sp.SalesPersonName,
    o.OrdersDate
FROM SalesRecords s
JOIN Orders o ON s.OrdersID = o.OrdersID
JOIN Products p ON s.ProductID = p.ProductID
JOIN SalesPersons sp ON s.SalesPersonID = sp.SalesPersonID;


INSERT INTO SalesPersons (SalesPersonID, SalesPersonName, SalesBranch)
VALUES
('SP001', 'Alice Johnson', 'North Branch');
INSERT INTO Products (ProductID, ProductName)
VALUES
('P001', 'Laptop');


INSERT INTO Orders (OrdersID, OrdersDate)
VALUES
('O001', TO_DATE('2025-03-01', 'YYYY-MM-DD'));

INSERT INTO SalesRecords (OrdersID, CustomerName, ProductID, SalesPersonID)
VALUES
('O001', 'John Doe', 'P001', 'SP001');



