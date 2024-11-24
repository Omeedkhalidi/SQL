--CREATING TABLES

CREATE TABLE Author (
    ID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL
);



CREATE TABLE Books (
    ISBN13 CHAR(13) PRIMARY KEY CHECK (LEN(ISBN13) = 13),
    Title NVARCHAR(100) NOT NULL,
    Language NVARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    DateReleased DATE NOT NULL,
    AuthorID INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Author(ID)
);



CREATE TABLE Stores (
    ID INT IDENTITY PRIMARY KEY,
    StoreName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL
);



CREATE TABLE InventoryBalance (
    StoreID INT NOT NULL,
    ISBN13 CHAR(13) NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    PRIMARY KEY (StoreID, ISBN13),
    FOREIGN KEY (StoreID) REFERENCES Stores(ID),
    FOREIGN KEY (ISBN13) REFERENCES Books(ISBN13)
);



CREATE TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(15)
);


CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ISBN13 CHAR(13) NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (OrderID, ISBN13),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ISBN13) REFERENCES Books(ISBN13)
);



CREATE TABLE BookAuthors (
    ISBN13 CHAR(13) NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (ISBN13, AuthorID),
    FOREIGN KEY (ISBN13) REFERENCES Books(ISBN13),
    FOREIGN KEY (AuthorID) REFERENCES Author(ID)
);




--INSERTING DATA

INSERT INTO dbo.Author (FirstName, LastName, DateOfBirth)
VALUES 
('John', 'Smith', '1980-05-15'),
('Emma', 'Johnson', '1975-11-22'),
('Michael', 'Williams', '1990-03-10'),
('Sophia', 'Davis', '1985-08-30');


INSERT INTO dbo.Stores (StoreName, Address)
VALUES 
('Central Bookstore', '123 Main St, Cityville'),
('Downtown Books', '456 Elm St, Townsville'),
('Suburban Reads', '789 Oak St, Suburbia');


INSERT INTO dbo.Books (ISBN13, Title, Language, Price, DateReleased, AuthorID)
VALUES
('9781234567890', 'The Great Adventure', 'English', 19.99, '2021-05-10', 1),
('9781234567891', 'Mystery of the Lost City', 'English', 12.99, '2022-03-15', 2),
('9781234567892', 'Science and Nature', 'English', 15.49, '2020-08-12', 3),
('9781234567893', 'Cooking with Love', 'English', 9.99, '2021-06-20', 4),
('9781234567894', 'Tech Innovations', 'English', 29.99, '2023-01-05', 1),
('9781234567895', 'Journey Through Time', 'English', 22.99, '2019-11-30', 2),
('9781234567896', 'The Art of Painting', 'English', 17.99, '2021-02-10', 3),
('9781234567897', 'Philosophy and Life', 'English', 13.49, '2020-05-15', 4),
('9781234567898', 'Rising Stars', 'English', 24.99, '2022-07-25', 1),
('9781234567899', 'Adventure Awaits', 'English', 14.49, '2023-04-20', 2);



-- Inserting inventory for Store 1
INSERT INTO dbo.InventoryBalance (StoreID, ISBN13, Quantity)
VALUES
(1, '9781234567890', 15),
(1, '9781234567891', 10),
(1, '9781234567892', 20),
(1, '9781234567893', 12),
(1, '9781234567894', 5),
(1, '9781234567895', 8),
(1, '9781234567896', 18),
(1, '9781234567897', 22),
(1, '9781234567898', 11),
(1, '9781234567899', 16);

-- Inserting inventory for Store 2
INSERT INTO dbo.InventoryBalance (StoreID, ISBN13, Quantity)
VALUES
(2, '9781234567890', 10),
(2, '9781234567891', 7),
(2, '9781234567892', 15),
(2, '9781234567893', 20),
(2, '9781234567894', 8),
(2, '9781234567895', 12),
(2, '9781234567896', 5),
(2, '9781234567897', 17),
(2, '9781234567898', 14),
(2, '9781234567899', 9);

-- Inserting inventory for Store 3
INSERT INTO dbo.InventoryBalance (StoreID, ISBN13, Quantity)
VALUES
(3, '9781234567890', 18),
(3, '9781234567891', 12),
(3, '9781234567892', 8),
(3, '9781234567893', 10),
(3, '9781234567894', 6),
(3, '9781234567895', 20),
(3, '9781234567896', 10),
(3, '9781234567897', 25),
(3, '9781234567898', 5),
(3, '9781234567899', 13);