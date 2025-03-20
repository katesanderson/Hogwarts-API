-- Idea: It is a Library Book Management system which tracks which books are avaliable or not 

CREATE DATABASE LibraryManager;
USE LibraryManager;

CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(255) NOT NULL,
	Genre VARCHAR(255)
    );
    
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    BookTitle VARCHAR(255) NOT NULL,
    AuthorID INT,
    Genre VARCHAR(255),
    BookStatus VARCHAR(255) DEFAULT 'Avaliable',
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID));
    
CREATE TABLE Avaliability(
    BookID INT,
    BookAvaliability VARCHAR(255) NOT NULL,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID));

INSERT INTO Authors (AuthorName, Genre)
VALUES
('Madeline Miller', 'Romance'),
('J.K.Rowling', 'Fantasy'),
('J.R.R Tolkein', 'Fantasy'),
('Dolly Alderton', 'Romance'),
('Sally Rooney', 'Romance'),
('Coleen Hoover', 'Romance'),
('Adam Kay', 'Documentary'),
('Stephanie Meyer', 'Fantasy');

INSERT INTO Books (BookTitle, AuthorID, Genre, BookStatus)
VALUES
('Song of Achillies', 1,'Romance', 'Not Avaliable'),
('Harry Potter and the Prisoner of Askaban', 2, 'Fantasy','Avaliable'),
('The Hobbit', 3, 'Fantasy','Avaliable'),
('Everything I know about Love', 4, 'Romance','Avaliable'),
('Normal People', 5, 'Romance','Not Avaliable'),
('Verity', 6, 'Romance','Avaliable'),
('Twas the Night Before Christmas', 7, 'Documentary','Not Avaliable'),
('Twilight New Moon', 8,'Fantasy','Avaliable');

INSERT INTO Avaliability (BookID, BookAvaliability, BorrowDate, ReturnDate)
VALUES
(1,'Not Avaliable', '2025-10-05', NULL),
(2,'Avaliable', '2025-12-06','2025-12-07'),
(3,'Avaliable', '2025-05-01','2025-05-06'),
(4,'Avaliable', '2025-09-02','2025-09-11'),
(5,'Not Avaliable', '2025-05-03', NULL),
(6,'Avaliable', '2025-09-19', '2025-10-03'),
(7,'Not Avaliable', '2025-11-20',NULL),
(8,'Avaliable', '2025-10-15','2025-11-30');

-- What books are currently avaliable?
SELECT * FROM Avaliability
WHERE BookAvaliability = 'Avaliable'
ORDER BY BookID ASC;

-- What books are Fantasy?
SELECT * FROM Authors
WHERE Genre = 'Fantasy'
ORDER BY LENGTH(AuthorName) DESC;

-- What books are Romance?
SELECT * FROM Authors
WHERE Genre = 'Romance'
ORDER BY RAND();

-- First Join
SELECT b.BookID, b.BookTitle, a.BookAvaliability FROM Books b 
JOIN Avaliability a ON b.BookID = a.BookID;

-- Is Song of Achillies Avaliable?
SELECT b.BookTitle, a.BookAvaliability FROM Books b 
JOIN Avaliability a ON b.BookID = a.BookID
WHERE BookTitle = 'Song of Achillies';

-- What Fantasy Books are Avaliable?
SELECT DISTINCT b.BookID, b.BookTitle, a.BookAvaliability, b.Genre FROM Books b 
JOIN Avaliability a ON b.BookID = a.BookID
WHERE Genre = 'Fantasy' AND BookAvaliability = 'Avaliable';

-- Second Join
SELECT a.AuthorName, b.BookTitle FROM Books b 
JOIN Authors a ON b.AuthorID = a.AuthorID;

-- Who is the Author of The Hobbit?
SELECT a.AuthorName, b.BookTitle FROM Books b 
JOIN Authors a ON b.AuthorID = a.AuthorID
WHERE BookTitle = 'The Hobbit';

-- Deleting Data
DELETE FROM Books
WHERE BookTitle = 'Twas the Night Before Christmas';

-- Using Aggregate Function - Count
SELECT Count(*) 
FROM Avaliability
WHERE BookAvaliability = 'Avaliable';

-- Using Aggregate Function - Max Author ID Number
SELECT Max(AuthorID)
FROM Authors;

-- Using Built In Function - Upper
SELECT UPPER(AuthorName) from Authors;

-- Using Built In Function - Lower
SELECT LOWER(BookTitle) from Books;

-- Conditional Function for a Goal: To Tell User if Book is Avaliable or Not
SELECT BookTitle, IF(BookStatus = 'Avaliable', TRUE, FALSE) AS 'Avaliability'
FROM Books;







    
    
    
    