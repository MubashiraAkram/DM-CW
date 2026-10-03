Cake Shop Database Management System

This repository contains the database design and implementation developed for the **Data Management 1 coursework** as part of the Diploma in Software Engineering.

The project is based on a small cake shop that manages customers, employees, cakes, categories, orders, payments and branches.

## Project Overview

The Cake Shop Database was designed to organize and manage the main business activities of a cake shop using a relational database.

The system allows the cake shop to:

- Store customer details
- Store employee information
- Manage cakes and cake categories
- Record customer orders
- Store multiple cakes within an order
- Record payment information
- Associate orders with different branches
- Retrieve business information using SQL queries
- Control database access using different user roles

## Database Entities

The database contains the following main entities:

- Customer
- Employee
- EmployeePhone
- Cake
- Category
- Order
- OrderItem
- Payment
- Branch

`EmployeePhone` is used to store multiple phone numbers for an employee.

## Database Relationships

Some of the main relationships include:

- A customer can place multiple orders.
- An employee can handle multiple orders.
- A branch can have multiple orders.
- A category can contain multiple cakes.
- An order can contain multiple cakes.
- A cake can appear in multiple orders.
- `OrderItem` resolves the many-to-many relationship between Order and Cake.
- An order can have payment information.
- An employee can have multiple phone numbers.

## Database Normalization

The database was normalized up to **Third Normal Form (3NF)**.

Normalization was used to:

- Reduce data duplication
- Remove repeating groups
- Remove partial dependencies
- Remove transitive dependencies
- Improve data consistency
- Reduce insertion, update and deletion anomalies

## SQL Implementation

The database was implemented using **Microsoft SQL Server**.

The SQL implementation includes:

- Database creation
- Table creation
- Primary keys
- Foreign keys
- Composite primary keys
- UNIQUE constraints
- CHECK constraints
- Sample records
- Normal SELECT queries
- JOIN queries
- Advanced SELECT queries
- GROUP BY
- HAVING
- ORDER BY
- Database roles and permissions

## Database Security

Different user roles were created to demonstrate database security.

### Manager

Permissions:

- SELECT
- INSERT
- UPDATE
- DELETE

### Staff

Permissions:

- SELECT
- INSERT
- UPDATE

### Viewer

Permissions:

- SELECT

## Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio
- SQL
- Git
- GitHub


## Project Purpose

The purpose of this project is to demonstrate the process of database analysis, design, normalization, implementation, querying and security using a real-world cake shop scenario.

## Future Improvements

The database could be expanded in the future by adding:

- Inventory management
- Supplier management
- Delivery tracking
- Customer loyalty programs
- Online ordering
- Employee scheduling
- Sales reports and dashboards

## Author

Created as part of the Data Management 1 coursework for the Diploma in Software Engineering.
