CREATE TABLE first_user(
    userID NUMBER PRIMARY KEY,
    userType NUMBER,
    firstName VARCHAR2 (50 CHAR),
    lastName VARCHAR2 (50 CHAR)
);

    insert into first_user VALUES (3, 1, 'Jasdeep','Sekhon');
    insert into first_user values (369369, 01, 'Jessica', 'sekhon');
    insert into first_user values (112233, 01, 'Joe', 'Rogan');
    insert into first_user values (999999, 01, 'Jessica', 'Biel');
    insert into first_user values (123456, 01, 'Tristan', 'Davidson');
    insert into first_user values (888888, 01, 'Johnson', 'Smith');
    insert into first_user values (333333, 01, 'Niki', 'Daphney');
    insert into first_user values (444444, 01, 'Manjot', 'Singh');
    insert into first_user values (111111, 01, 'Becky', 'Johal');
    insert into first_user values (528528, 01, 'Nikola', 'Tesla');
    insert into first_user values (999333, 02, 'Abdol', 'Abhari');
    insert into first_user values (343434, 02, 'Isaac', 'Woungang');
    insert into first_user values (898989, 02, 'Jelena', 'Misic');
    insert into first_user values (898981, 02, 'Lester', 'Hirakyi');
    insert into first_user values (424242, 03, 'Muhammed', 'Amir');
    insert into first_user values (121212, 03, 'Tajali', 'Ahmed');
    insert into first_user values (848484, 03, 'John', 'Fish');
    insert into first_user values (893838, 03, 'Malahi', 'Kumon');

/*
Has courseID that is used in many methods
Has permissions that need to be met by TA and Prof permissions to be able teach
*/
CREATE TABLE Course(
    courseID NUMBER PRIMARY KEY NOT NULL,
    taPermissionCourse NUMBER NOT NULL,
    professorPermissionCourse NUMBER NOT NULL,
    courseName VARCHAR2 (50 CHAR)
);

insert into Course values (510, 3, 2, 'Database Systems');
insert into Course values (633, 3, 2, 'Computer Security');
insert into Course values (393, 3, 2, 'Unix, C and C++');
insert into Course values (420, 3, 2, 'Discrete Structures');
/*
Has a ID
has userId that can be accessed to see name
*/
CREATE TABLE Student(
    studentID NUMBER PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);

insert into Student VALUES (3, 3);
insert into Student values (369369,369369);
insert into Student values (112233,112233);
insert into Student values (999999,999999);
insert into Student values (123456,123456);
insert into Student values (888888,888888);
insert into Student values (333333,333333);
insert into Student values (444444,444444);
insert into Student values (111111,111111);
insert into Student values (528528,528528);


/*
Has a ID
has userId that can be accessed to see name
*/
CREATE TABLE Professor(
    professorID NUMBER PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);
insert into Professor values (999333, 999333);
insert into Professor values (343434, 343434);
insert into Professor values (898989, 898989);
insert into Professor values (898981, 898981);


/*
Has a ID
has userId that can be accessed to see name
*/

CREATE TABLE TA(
    taID NUMBER PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);
insert into TA values (424242, 424242);
insert into TA values (121212, 121212);
insert into TA values (848484, 848484);
insert into TA values (893838,893838);


/*
Permission has two seperate keys, ta permissions and prof permissions
inherites TA ID and Professor ID and matches them to a courseID, and permission
Permission inherites CourseID so it can check the permission needed by TA and Prof for specific course
*/
CREATE TABLE Permission(
    profPermissionID NUMBER NOT NULL,
    taPermissionID NUMBER NOT NULL,
    professorID NUMBER,
    FOREIGN KEY (professorID) REFERENCES Professor(professorID),    
    taID NUMBER,
    FOREIGN KEY (taID) REFERENCES TA(taID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);


insert into Permission values (12345,12354,999333,424242,510);
insert into Permission values (54321,12435,343434,121212,633);
insert into Permission values (99999,88888,898989,848484,420);
insert into Permission values (99989,88828,898981,893838,393);

/*
This prequistie checks for certain course ID if the prerequite is satisfied
*/

CREATE TABLE Prerequisite(
    prerequisiteID NUMBER PRIMARY KEY NOT NULL,
    payment NUMBER NOT NULL,
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);

insert into Prerequisite values (123, 1000, 510);
insert into Prerequisite values (456, 1000, 633);
insert into Prerequisite values (789, 1000, 420);
insert into Prerequisite values (111, 1000, 393);


/*
Section ID shows the class list, who is teaching, who is ta and courseid
*/
CREATE TABLE Section( 
    sectionID NUMBER PRIMARY KEY NOT NULL,
    classList VARCHAR2 (1000 CHAR),
    professorID NUMBER,
    FOREIGN KEY (professorID) REFERENCES Professor(professorID),    
    taID NUMBER,
    FOREIGN KEY (taID) REFERENCES TA(taID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);

insert into Section values(1,'Jessica Sekhon, Joe Rogan',999333,424242,510);
insert into Section values (2, 'Jessica Biel, Tristan Davidson, Johnson Smith', 343434,121212, 633);
insert into Section values (3, 'Niki Daphney, Manjot Singh',898981,893838,393);
insert into Section values (4, 'Becky Johal, Nikola Tesla', 898989, 848484, 420);

/*
Contains Lecture Contents
*/

CREATE TABLE Lecture_Material(
    lectureID NUMBER PRIMARY KEY NOT NULL,
    lectureContents VARCHAR2 (1000 CHAR)
);

insert into Lecture_Material values (20210910, 'Course Outline');

/*
Shows what Professors are teaching what courses
*/
CREATE TABLE Course_List(
    professorID NUMBER,
    FOREIGN KEY (professorID) REFERENCES Professor(professorID), 
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);

insert into Course_List values (999333, 510);
insert into Course_List values (343434, 633);
insert into Course_List values (898981,393);
insert into Course_List values (898989,420);

/*
Used to check score of specific test for a course for certain student
*/


CREATE TABLE Tests(
    testID NUMBER PRIMARY KEY NOT NULL,
    testWeight NUMBER NOT NULL,
    testEvaluationStatus VARCHAR2 (20 CHAR),
    sectionID NUMBER,
    FOREIGN KEY (sectionID) REFERENCES Section(sectionID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    studentID NUMBER,
    FOREIGN KEY (studentID) REFERENCES Student(studentID)
);

insert into Tests values(20210912, 25, 'Complete',1,510,369369);
insert into Tests values (20212939, 25, 'Complete', 1, 510,112233);
insert into Tests values (20211011, 40, 'Complete',2, 633, 999999);
insert into Tests values (19239123, 35, 'Complete',2, 633, 888888);
insert into Tests values (12389123, 20, 'Not Complete', 2, 633, 123456);
insert into Tests values (123923929, 10, 'Complete', 3, 393,333333 );
insert into Tests values (12189238, 10, 'Complete',3, 393, 444444);
insert into Tests values (19238192, 50, 'Complete',4, 420, 111111);
insert into Tests values (12192839, 50, 'Complete',4, 420,528528);

/*
Used to check score of specific Assignment for a course for certain student
*/


CREATE TABLE Assignments(
    assignmentID NUMBER PRIMARY KEY NOT NULL,
    assignmentWeight NUMBER NOT NULL,
    assignmentEvaluationStatus VARCHAR2 (20 CHAR),
    sectionID NUMBER,
    FOREIGN KEY (sectionID) REFERENCES Section(sectionID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    studentID NUMBER,
    FOREIGN KEY (studentID) REFERENCES Student(studentID)
);

insert into Assignments values(20210912, 25, 'Complete',1,510,369369);
insert into Assignments values (20212939, 25, 'Complete', 1, 510,112233);
insert into Assignments values (20211011, 40, 'Complete',2, 633, 999999);
insert into Assignments values (19239123, 35, 'Complete',2, 633, 888888);
insert into Assignments values (12389123, 20, 'Not Complete', 2, 633, 123456);
insert into Assignments values (123923929, 10, 'Complete', 3, 393,333333 );
insert into Assignments values (12189238, 10, 'Complete',3, 393, 444444);
insert into Assignments values (19238192, 50, 'Complete',4, 420, 111111);
insert into Assignments values (12192839, 50, 'Complete',4, 420,528528);

/*
Says if the assignment/test has been completed and gives result
For each course and student 
*/
CREATE TABLE Grades(
    assignmentCompletion VARCHAR2 (10 CHAR),
    assignmentResult NUMBER,
    testCompletion VARCHAR2 (10 CHAR),
    testResult NUMBER, 
    sectionID NUMBER,
    FOREIGN KEY (sectionID) REFERENCES Section(sectionID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    studentID NUMBER,
    FOREIGN KEY (studentID) REFERENCES Student(studentID)
);
insert into Grades values ('Yes',90,'Yes',88,1, 510,369369);
insert into Grades values ('Yes',69,'Yes',96,1, 510,112233);
insert into Grades values ('Yes',92,'Yes',75,2, 633,999999);
insert into Grades values ('Yes',90,'Yes',90,2, 633,888888);
insert into Grades values ('No',92, 'No', 88,2, 633,123456);
insert into Grades values ('Yes',99,'Yes',89,3, 393,333333);
insert into Grades values ('Yes',66,'Yes',99,3, 393,444444);
insert into Grades values ('Yes',85,'Yes',87,4, 420,111111);
insert into Grades values ('Yes',89,'Yes',98,4, 420,528528);


/*
Discussion board for a certain section and certain section,
Also for certain assignments
*/
CREATE TABLE Discussion_Board(
    discussionContent VARCHAR2(1000 CHAR),
    sectionID NUMBER,
    FOREIGN KEY (sectionID) REFERENCES Section(sectionID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID) ,
    assignmentID NUMBER,
    FOREIGN KEY (assignmentID) REFERENCES Assignments(assignmentID) ON DELETE CASCADE
);

insert into Discussion_Board values ('Database ER Diagram Discussion', 1, 510,20210912);
insert into Discussion_Board values ('SQL Tables and Queries Discussion', 1, 510, 20212939);
insert into Discussion_Board values ('SetUID Lab Discussion',2,633,20211011);
insert into Discussion_Board values ('MD5 Collision Attack',2, 633, 19239123);
insert into Discussion_Board values ('Strong Induction Questions',4,420,19238192);


/*
Course offerings basically shows based on prereqs for each students 
what courses can be taken and what they are exactly.
*/
CREATE TABLE Course_Offerings(
    availablity VARCHAR2 (50 CHAR),
    levelOfCourse VARCHAR2 (50 CHAR),
    subject VARCHAR2 (50 CHAR),
    program VARCHAR2 (50 CHAR),
    professorID NUMBER,
    FOREIGN KEY (professorID) REFERENCES Professor(professorID),    
    taID NUMBER,
    FOREIGN KEY (taID) REFERENCES TA(taID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);

insert into Course_Offerings values('Winter Term', '3rd Year','Database Systems','Computer Science',999333,424242, 510);
insert into Course_Offerings values('Winter Term', '3rd Year','Computer Security','Computer Science',343434,121212, 633);
insert into Course_Offerings values ('Fall Term', '2nd year', 'Unix, C and C++', 'Computer Science',898981, 893838, 393);
insert into Course_Offerings values ('Fall Term', '2nd year', 'Discrete Structures', 'Computer Science',898989,848484 , 420);


/*
Below tables are for relations that signify the many to many relationships 
*/

CREATE TABLE enrolled (
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    studentID NUMBER,
    FOREIGN KEY (studentID) REFERENCES Student(studentID)
);
insert into enrolled values(510,369369);
insert into enrolled values(510,112233);
insert into enrolled values (633,999999);
insert into enrolled values(633,123456);
insert into enrolled values(633,888888);
insert into enrolled values(393,333333);
insert into enrolled values(393,444444);
insert into enrolled values(420,111111);
insert into enrolled values(420,528528);

CREATE TABLE checks (
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    prerequisiteID  NUMBER NOT NULL,
    FOREIGN KEY(prerequisiteID) REFERENCES Prerequisite(prerequisiteID)
);
insert into checks values(510,123);
insert into checks values(633,456);
insert into checks values(393,789);
insert into checks values(420,111);

CREATE TABLE creates (
    professorID NUMBER NOT NULL,
    FOREIGN KEY (professorID) REFERENCES Professor(professorID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);
insert into creates values(999333,510);
insert into creates values(343434,633);
insert into creates values(898981,393);
insert into creates values(898989,420);

/*
Queries: Table 1
*/
SELECT *
FROM first_user
WHERE userType =1;

SELECT *
FROM first_user
WHERE userType =2;

SELECT *
FROM first_user
WHERE userType =3;

SELECT *
FROM first_user
ORDER BY userType DESC;

/*
Queries: Table 2
*/

SELECT CourseID, Coursename
FROM   Course
ORDER BY CourseID DESC;

/*
Queries: Table 3 
*/
SELECT studentID,userID
FROM Student
ORDER BY userid DESC;

/*
Queries: Table 4
*/

SELECT professorID, userID
FROM PROFESSOR
ORDER BY userID DESC;

/*
Queries: Table 5
*/

SELECT taID, userID
FROM ta
ORDER BY userID DESC;


/*
Queries: Table 6
*/
SELECT courseID 
FROM permission
where taid = 121212;

/*
Queries: Table 7
*/
SELECT classList, courseID, studentID
FROM   section, student
WHERE  sectionID = 1
       AND  professorID = 999333
ORDER BY StudentID ASC;



/*
Query for Lecture Materials Table
*/
SELECT *
FROM Lecture_Material, Course
WHERE courseName LIKE 'D%';

/*
Query for Course List Table
*/
SELECT DISTINCT *
FROM Course_List, Course;

/*
Query for Tests Table
*/
SELECT Tests.courseID, Course.courseName, Tests.studentID, Tests.testID, Tests.testWeight, Tests.testEvaluationStatus, Grades.testResult
FROM Tests
INNER JOIN Course
ON Tests.courseID = Course.courseID
INNER JOIN Grades
ON Tests.courseID = Grades.courseID;

/*
Query for Assignments Table
*/
SELECT *
FROM Assignments
LEFT JOIN Course 
ON Assignments.courseID = Course.courseID;

/*
Query for Grades Table
*/
SELECT Grades.testCompletion, Grades.testResult, Tests.testWeight
FROM Grades
LEFT JOIN Tests 
ON Grades.studentID = Tests.studentID ;

/*
Query for Discussion Board Table
*/
SELECT DISTINCT sectionID, discussionContent, courseID, assignmentID
FROM Discussion_Board;

/*
Query for Course Offerings Table
*/
SELECT *
FROM Course_Offerings
ORDER BY levelOfCourse;

/*
Query for relational Enrolled Table
*/
SELECT *
FROM enrolled
LEFT JOIN Course_List
ON enrolled.courseID = Course_List.courseID;

/*
Query for relational Checks Table
*/
SELECT enrolled.courseID, course.courseName, Course_List.professorID,  enrolled.studentID
FROM enrolled
INNER JOIN Course_List
ON enrolled.courseID = Course_List.courseID
INNER JOIN Course
ON enrolled.courseID = Course.courseID
WHERE enrolled.courseID LIKE '633';

/*
Query for relational Creates Table
*/ 
SELECT creates.professorID, first_user.firstName, first_user.lastName, creates.courseID, course.courseName
FROM creates
INNER JOIN first_user
ON creates.professorID = first_user.userID
INNER JOIN course
ON creates.courseID = course.courseID
WHERE creates.professorID > '300000'
ORDER BY creates.professorID;

/*
View for Students Enrolled in CPS 633
*/

CREATE VIEW Students_enrolled_CPS_633 
AS
SELECT classList, courseID
from SECTION
where courseID = 633;
    
SELECT *
FROM Students_enrolled_CPS_633

/*
View for Students Enrolled in CPS 510
*/

CREATE VIEW Students_enrolled_CPS_510 
AS
SELECT classList, courseID
from SECTION
where courseID = 510;

SELECT *
FROM Students_enrolled_CPS_510

/*
View for Students Enrolled in CPS 420
*/

CREATE VIEW Students_enrolled_CPS_420
AS
SELECT classList, courseID
from SECTION
where courseID = 420;

SELECT *
FROM Students_enrolled_CPS_420

/*
View for students Assignment Grades
*/

CREATE VIEW students_grades
AS 
SELECT DISTINCT student.studentID, Assignments.assignmentID, Grades.assignmentResult
from Student, Course, Assignments, Grades
WHERE 
Student.studentID = Assignments.studentID AND
grades.studentID = Assignments.studentID;

SELECT *
FROM students_grades

/*
Checking which students are enrolled in CPS 510 and have completed their tests
(WHERE EXISTS)
*/

SELECT s.studentID
FROM Student s
WHERE EXISTS
(SELECT t.studentID
FROM Tests t
WHERE t.testEvaluationStatus = 'Complete' AND
t.courseID = 510
AND t.studentID = s.studentID);

/*
Checking which students did complete completed both their tests and assignments
(UNION)
*/

SELECT s.studentID
FROM Student s
WHERE EXISTS
(SELECT t.studentID
FROM Tests t
WHERE t.testEvaluationStatus = 'Complete'
AND t.studentID = s.studentID)

UNION

(SELECT s.studentID
FROM Student s
WHERE EXISTS
(SELECT a.studentID
FROM Assignments a
WHERE a.assignmentEvaluationStatus = 'Complete'
AND a.studentID = s.studentID));

/*
List of courses not offered in the Winter Term
(MINUS)
*/

SELECT c.subject, c.levelOfCourse, c.program, c.courseID
 FROM   Course_Offerings c
MINUS
SELECT c.subject, c.levelOfCourse, c.program, c.courseID
 FROM   Course_Offerings c
 WHERE  c.availablity = 'Winter Term';
 
 /*
 Find Average of all students on their test results
 (AVERAGE)
 */
 
 SELECT 'Average test result is ', AVG (testResult)
 FROM Grades;
  /*
 Find Average of all students in all sections on their assignment results
 (AVERAGE)
 */
 
SELECT 'Average assignment result is ', AVG (assignmentResult)
FROM Grades;

/*
List for each course, the number of students registered for the course
*/

SELECT COUNT( DISTINCT studentID) AS Number_Enrolled
FROM   enrolled

/*
GROUP BY studentID for average assignment results
*/
SELECT studentID, AVG(assignmentResult) AS Average_Assignment_Results
FROM Grades
GROUP BY studentID;



 