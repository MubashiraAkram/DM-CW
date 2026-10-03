CREATE DATABASE AMCUPCAKES;
GO

USE AMCUPCAKES;
GO

--Create Tables associated with each entity

CREATE TABLE Customer (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE --customers cannot share same email
);
GO

CREATE TABLE Employee (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    JobRole VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    CONSTRAINT CHK_EmployeeSalary CHECK (Salary > 0) --salary has to be more than 0
);
GO

--additional table created as employee phone number is a multivalued attribute.
CREATE TABLE EmployeePhone (
    EmployeePhone VARCHAR (15),
    EmployeeID VARCHAR (10) NOT NULL,
    PRIMARY KEY (EmployeeID,EmployeePhone),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)ON DELETE CASCADE --deletes any records from all connected tables
);

CREATE TABLE Category (
    CategoryID VARCHAR(10) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Cake (
    CakeID VARCHAR(10) PRIMARY KEY,
    CakeName VARCHAR(100) NOT NULL,
    CakeSize VARCHAR(20) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CategoryID VARCHAR(10) NOT NULL,
    CONSTRAINT CHK_CakePrice CHECK (Price > 0),
    CONSTRAINT FK_Cake_Category FOREIGN KEY (CategoryID)
    REFERENCES Category(CategoryID)
);
GO

CREATE TABLE Branch (
    BranchID VARCHAR(10) PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    BranchLocation VARCHAR(100) NOT NULL
);
GO

CREATE TABLE [Order] ( --square brackets as Order is a reserved word
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    TotalAmt DECIMAL(10,2) NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    CustomerID VARCHAR(10) NOT NULL,
    EmployeeID VARCHAR(10) NOT NULL,
    BranchID VARCHAR(10) NOT NULL,
    CONSTRAINT CHK_OrderTotal CHECK (TotalAmt > 0),
    CONSTRAINT CHK_OrderStatus CHECK (OrderStatus IN ('Pending','Completed','Cancelled')),
    CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT FK_Order_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    CONSTRAINT FK_Order_Branch FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
GO

CREATE TABLE OrderItem (
    OrderID VARCHAR(10) NOT NULL,
    CakeID VARCHAR(10) NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Subtotal AS (Quantity * UnitPrice) PERSISTED,
    CONSTRAINT PK_OrderItem PRIMARY KEY (OrderID, CakeID),
    CONSTRAINT CHK_OrderItemQuantity CHECK (Quantity > 0),
    CONSTRAINT CHK_OrderItemPrice CHECK (UnitPrice > 0),
    CONSTRAINT FK_OrderItem_Order FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    CONSTRAINT FK_OrderItem_Cake FOREIGN KEY (CakeID) REFERENCES Cake(CakeID)
);
GO

CREATE TABLE Payment (
    PaymentID VARCHAR(10) PRIMARY KEY,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL,
    OrderID VARCHAR(10) NOT NULL,
    CONSTRAINT CHK_PaymentAmount CHECK (Amount > 0),
    CONSTRAINT CHK_PaymentMethod CHECK (PaymentMethod IN ('Cash','Card','Bank Transfer')),
    CONSTRAINT FK_Payment_Order FOREIGN KEY (OrderID) REFERENCES [Order](OrderID)
);
GO

--Insert values into all 9 tables created above

INSERT INTO Customer(CustomerID,CustomerName,PhoneNumber,Email)VALUES
('C001','Amaya Perera','0771234567','amaya@gmail.com'),
('C002','Nimal Silva','0712345678','nimal@gmail.com'),
('C003','Kavindi Fernando','0763456789','kavindi@gmail.com'),
('C004','Ruwan Jayasinghe','0754567890','ruwan@gmail.com'),
('C005','Sahan Dias','0705678901','sahan@gmail.com'),
('C006','Dinithi Gunawardena','0776789012','dinithi@gmail.com'),
('C007','Tharindu Peris','0717890123','tharindu@gmail.com'),
('C008','Ishara Wijesinghe','0768901234','ishara@gmail.com'),
('C009','Sachini Ranasinghe','0759012345','sachini@gmail.com'),
('C010','Kasun Bandara','0700123456','kasun@gmail.com');
GO

INSERT INTO Employee (EmployeeID,EmployeeName,JobRole,Salary)VALUES
('E001','Malith Perera','Baker',75000.00),
('E002','Nadeesha Silva','Cashier',55000.00),
('E003','Akila Fernando','Baker',72000.00),
('E004','Shalini Dias','Manager',95000.00),
('E005','Dinesh Peris','Cashier',52000.00),
('E006','Nethmi Jayasinghe','Baker',70000.00),
('E007','Ravindu Bandara','Delivery Staff',50000.00),
('E008','Hansani Perera','Decorator',68000.00),
('E009','Supun Silva','Delivery Staff',49000.00),
('E010','Thilini Fernando','Decorator',67000.00);
GO

INSERT INTO EmployeePhone (EmployeeID, EmployeePhone) VALUES
('E001','0771607465'),
('E002','0743247465'),
('E003','0771652445'),
('E003','0112378578'),
('E004','0719556610'),
('E005','0771607465'),
('E006','0743416065'),
('E007','0771607465'),
('E007','0112485495'),
('E008','0777286644'),
('E009','0777234465'),
('E010','0729458905');
GO

INSERT INTO Category(CategoryID,CategoryName) VALUES
('CAT001','Birthday Cakes'),
('CAT002','Wedding Cakes'),
('CAT003','Chocolate Cakes'),
('CAT004','Fruit Cakes'),
('CAT005','Cupcakes'),
('CAT006','Cheesecakes'),
('CAT007','Vegan Cakes'),
('CAT008','Kids Cakes'),
('CAT009','Anniversary Cakes'),
('CAT010','Seasonal Cakes');
GO

INSERT INTO Cake(CakeID,CakeName,CakeSize,Price,CategoryID)VALUES
('CK001','Chocolate Birthday Cake','Medium',2500.00,'CAT001'),
('CK002','Classic Wedding Cake','Large',8000.00,'CAT002'),
('CK003','Dark Chocolate Cake','Medium',3500.00,'CAT003'),
('CK004','Fruit Delight Cake','Small',2000.00,'CAT004'),
('CK005','Vanilla Cupcake Box','Small',1500.00,'CAT005'),
('CK006','Strawberry Cheesecake','Medium',4500.00,'CAT006'),
('CK007','Vegan Chocolate Cake','Medium',3000.00,'CAT007'),
('CK008','Kids Rainbow Cake','Medium',2800.00,'CAT008'),
('CK009','Anniversary Red Velvet Cake','Large',5000.00,'CAT009'),
('CK010','Christmas Special Cake','Medium',4000.00,'CAT010');
GO

INSERT INTO Branch(BranchID,BranchName,BranchLocation) VALUES
('B001','Colombo Branch','Colombo'),
('B002','Kandy Branch','Kandy'),
('B003','Galle Branch','Galle'),
('B004','Negombo Branch','Negombo'),
('B005','Kurunegala Branch','Kurunegala'),
('B006','Matara Branch','Matara'),
('B007','Jaffna Branch','Jaffna'),
('B008','Kalutara Branch','Kalutara'),
('B009','Gampaha Branch','Gampaha'),
('B010','Ratnapura Branch','Ratnapura');
GO

INSERT INTO [Order](OrderID,OrderDate,TotalAmt,OrderStatus,CustomerID,EmployeeID,BranchID) VALUES
('O001','2026-09-01',6500.00,'Completed','C001','E001','B001'),
('O002','2026-09-03',4500.00,'Completed','C002','E002','B002'),
('O003','2026-09-05',9000.00,'Completed','C001','E003','B001'),
('O004','2026-09-07',3500.00,'Pending','C003','E001','B003'),
('O005','2026-09-10',12000.00,'Completed','C004','E004','B002'),
('O006','2026-09-12',6500.00,'Completed','C005','E005','B004'),
('O007','2026-09-15',5500.00,'Completed','C006','E002','B005'),
('O008','2026-09-18',7000.00,'Pending','C007','E006','B001'),
('O009','2026-09-20',8000.00,'Completed','C008','E003','B003'),
('O010','2026-09-22',10000.00,'Completed','C001','E001','B002');
GO

INSERT INTO OrderItem (OrderID,CakeID,Quantity,UnitPrice) VALUES
('O001','CK001',1,2500.00),
('O001','CK010',1,4000.00),
('O002','CK005',3,1500.00),
('O003','CK006',2,4500.00),
('O004','CK003',1,3500.00),
('O005','CK002',1,8000.00),
('O005','CK010',1,4000.00),
('O006','CK001',1,2500.00),
('O006','CK004',2,2000.00),
('O007','CK005',1,1500.00),
('O007','CK010',1,4000.00),
('O008','CK003',2,3500.00),
('O009','CK009',1,5000.00),
('O009','CK007',1,3000.00),
('O010','CK004',3,2000.00),
('O010','CK010',1,4000.00); 
GO

INSERT INTO Payment(PaymentID,Amount,PaymentMethod,OrderID) VALUES
('P001',6500.00,'Card','O001'),
('P002',4500.00,'Cash','O002'),
('P003',9000.00,'Bank Transfer','O003'),
('P004',3500.00,'Cash','O004'),
('P005',12000.00,'Card','O005'),
('P006',6500.00,'Bank Transfer','O006'),
('P007',5500.00,'Cash','O007'),
('P008',7000.00,'Card','O008'),
('P009',8000.00,'Bank Transfer','O009'),
('P010',10000.00,'Card','O010');
GO
