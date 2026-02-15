CREATE DATABASE StudentDB;

USE StudentDB;

----------------- Student Table ------------------

CREATE TABLE Students (
StudentID INT PRIMARY KEY IDENTITY (1,1),
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
DOB DATE,
Gender VARCHAR(10)
)

SELECT * FROM Students;


------------------ Subject Table ----------------------------

CREATE TABLE Subjects (
SubjectID INT PRIMARY KEY IDENTITY(1,1),
SubjectName VARCHAR(50) NOT NULL,
);


SELECT * FROM Subjects;


---------------- Exams Table ------------------

CREATE TABLE Exams (
    ExamID INT PRIMARY KEY IDENTITY(1,1),
    ExamName VARCHAR(100),
    ExamDate DATE
);


SELECT * FROM Exams;




---------------- Marks Table ----------------------------

CREATE TABLE Marks (
    MarkID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT NOT NULL,
    SubjectID INT NOT NULL,
    ExamID INT NOT NULL,
    MarksObtained INT CHECK (MarksObtained BETWEEN 0 AND 100),

    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID),
    FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
);

SELECT * FROM Marks;


------------------------ Inserting Students ---------------------

INSERT INTO Students ( FirstName,LastName, DOB, Gender)
VALUES 
('Rahul', 'Sharma', '2005-05-10', 'Male'),
('Priya', 'Verma', '2006-07-15', 'Female'),
('Amit', 'Singh', '2005-03-20', 'Male');


SELECT * FROM Students


-------------------------- Inserting Subjets -------------------

INSERT INTO Subjects (SubjectName)
VALUES 
('Mathematics'),
('Science'),
('English');

----------------- Inserting Exams --------------------

INSERT INTO Exams ( ExamName, ExamDate)
VALUES
('Mid Term', '2025-09-15'),
('Final Exam', '2025-12-20');


SELECT * FROM Students;
SELECT * FROM Subjects;
SELECT * FROM Exams;


-------------- Inserting Marks ---------------


INSERT INTO Marks (StudentID, SubjectID, ExamID, MarksObtained)
VALUES
(1, 1, 1, 78),
(1, 2, 1, 85),
(1, 3, 1, 72),

(2, 1, 1, 90),
(2, 2, 1, 88),
(2, 3, 1, 95),

(3, 1, 1, 60),
(3, 2, 1, 65),
(3, 3, 1, 70);

SELECT * FROM Marks;


