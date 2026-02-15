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
    MarksID INT PRIMARY KEY IDENTITY(1,1),
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


--------------- First JOIN Query -----------------------------


SELECT 
    s.FirstName,
    s.LastName,
    sub.SubjectName,
    e.ExamName,
    m.MarksObtained
FROM Marks m
JOIN Students s ON m.StudentID = s.StudentID
JOIN Subjects sub ON m.SubjectID = sub.SubjectID
JOIN Exams e ON m.ExamID = e.ExamID;


--------------- Average Marks Per Student ------------------------

SELECT s.FirstName,
       s.LastName,
       SUM(m.MarksObtained) AS TotalMarks
FROM Marks m
JOIN Students s
     ON m.StudentID = s.StudentID
GROUP BY 
      s.FirstName,
      s.LastName;



---------------------- Find Topper (Highest Total Marks) ---------------------------------


SELECT TOP 1 
         s.FirstName,
         SUM(m.MarksObtained) AS TotalMarks
FROM Marks m
JOIN Students s
     ON m.StudentID = s.StudentID
     GROUP BY s.FirstName
     ORDER BY TotalMarks DESC;


------------ Find Failed Students (< 35 in Any Subject) ---------------------

SELECT s.FirstName,
       sub.SubjectName,
       m.MarksObtained
FROM Marks m
JOIN Students s
     ON m.studentID = s.StudentID
JOIN Subjects sub
     ON m.SubjectID = sub.SubjectID
WHERE m.MarksObtained < 35; 


-------------------- Add Grade Using CASE (Very Important)  -------------------

SELECT 
    s.FirstName,
    sub.SubjectName,
    m.MarksObtained,
    CASE 
        WHEN m.MarksObtained >= 90 THEN 'A'
        WHEN m.MarksObtained >= 75 THEN 'B'
        WHEN m.MarksObtained >= 50 THEN 'C'
        ELSE 'Fail'
    END AS Grade
FROM Marks m
JOIN Students s 
    ON m.StudentID = s.StudentID
JOIN Subjects sub
    ON m.SubjectID = sub.SubjectID;


------------------------- Pehle Total Marks Per Student Per Exam ------------------------------


SELECT 
    s.StudentID,
    s.FirstName,
    e.ExamName,
    SUM(m.MarksObtained) AS TotalMarks
FROM Marks m
JOIN Students s 
    ON m.StudentID = s.StudentID
JOIN Exams e
    ON m.ExamID = e.ExamID
GROUP BY 
    s.StudentID,
    s.FirstName,
    e.ExamName;


--------------- Add Rank (Window Function) -------------------



      SELECT 
    s.StudentID,
    s.FirstName,
    e.ExamName,
    SUM(m.MarksObtained) AS TotalMarks,
    RANK() OVER (
        PARTITION BY e.ExamName
        ORDER BY SUM(m.MarksObtained) DESC
    ) AS StudentRank
FROM Marks m
JOIN Students s 
    ON m.StudentID = s.StudentID
JOIN Exams e
    ON m.ExamID = e.ExamID
GROUP BY 
    s.StudentID,
    s.FirstName,
    e.ExamName;
