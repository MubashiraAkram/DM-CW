USE AMCUPCAKES;
GO

--creating roles
CREATE ROLE CakeShopManager;
GO
CREATE ROLE CakeShopStaff;
GO
CREATE ROLE CakeShopViewer;
GO

--granting permissions to users
GRANT SELECT,INSERT,UPDATE,DELETE ON SCHEMA::dbo TO CakeShopManager; --grants permission to every table in the db
GO
GRANT SELECT,INSERT,UPDATE ON SCHEMA::dbo TO CakeShopStaff;
GO
GRANT SELECT ON SCHEMA::dbo TO CakeShopViewer;
GO
--creating users with no login
CREATE USER ManagerUser WITHOUT LOGIN;
GO
CREATE USER StaffUser WITHOUT LOGIN;
GO
CREATE USER ViewerUser WITHOUT LOGIN;
GO

--assigning users to the roles
ALTER ROLE CakeShopManager ADD MEMBER ManagerUser;
GO
ALTER ROLE CakeShopStaff ADD MEMBER StaffUser;
GO
ALTER ROLE CakeShopViewer ADD MEMBER ViewerUser;
GO


--test1: as ManagerUser
EXECUTE AS USER = 'ManagerUser';
GO
SELECT * FROM Customer;
INSERT INTO Customer (CustomerID, CustomerName, PhoneNumber, Email) VALUES 
('C999', 'Temp Customer', '0770000000', 'temp@gmail.com');
DELETE FROM Customer WHERE CustomerID = 'C999'; --managerUser has full access so they can select & delete records too
GO
REVERT;
GO

--test2: as StaffUser
EXECUTE AS USER = 'StaffUser';
GO
SELECT * FROM Customer; --select operation succeessfully works
GO
DELETE FROM Customer WHERE CustomerID = 'C001'; --delete operation fails bcz staffuser does not hv access to delete records
GO
REVERT;
GO

--test3: as viewerUser
EXECUTE AS USER = 'ViewerUser';
GO
SELECT * FROM Customer; --select access will work for ViewerUser
INSERT INTO Customer (CustomerID, CustomerName, PhoneNumber, Email) VALUES 
('C099', 'Test Customer', '0771234567', 'test@gmail.com'); --access will be denied as ViewerUser only has select permissions
GO
REVERT;
GO
