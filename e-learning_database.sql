/*
Main function that ever other type uses as a main building block
Turns into Student, Professor and TA
*/
CREATE TABLE first_user(
    userID NUMBER PRIMARY KEY,
    userType NUMBER,
    firstName VARCHAR2 (50 CHAR),
    lastName VARCHAR2 (50 CHAR)
);

insert into first_user values (506748,1,'Jack','Smith');
insert into first_user values (123456,1,'Justin','Bieb');
insert into first_user values (506749,3,'Emily','Ilis');
insert into first_user values (903945,2,'Josephina','Beck');
insert into first_user values (127381,1,'Joseph','Beckham');
insert into first_user values (903940,1,'Brandy','Melville');
insert into first_user values (903945,1,'Barack','Obama');
insert into first_user values (903949,1,'Prince','Jackson');
insert into first_user values (783039,2, 'Jelena', 'Misic');
insert into first_user values (283923,2, 'Abdol', 'Abhari');
insert into first_user values (412938,2, 'Isaac', 'Woungang');
/*
Has courseID that is used in many methods
Has permissions that need to be met by TA and Prof permissions to be able teach
*/


CREATE TABLE Course(
    courseID NUMBER CHECK (courseID BETWEEN 100 AND 9999),
    taPermissionCourse NUMBER NOT NULL,
    professorPermissionCourse NUMBER NOT NULL,
    courseName VARCHAR2 (50 CHAR)
);

insert into Course values (501, 123, 506, 'Database Systems');
insert into Course values (633, 321, 605, 'Computer Security');
insert into Course values (420, 213, 650, 'Discrete Structures');

/*
Has a ID
has userId that can be accessed to see name
*/



CREATE TABLE Student(
    studentID NUMBER UNIQUE PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);
ALTER TABLE Student
    Add StudentName VARCHAR2 (100 CHAR);

insert into Student values (123456,506748,'Jack Smith');
insert into Student values (12323490,903949,'Prince Jackson');


/*
Has a ID 
has userId that can be accessed to see name
*/
CREATE TABLE Professor(
    professorID NUMBER UNIQUE PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);
ALTER TABLE Professor
    Add ProfessorName VARCHAR2 (100 CHAR);


insert into Professor values (12,903945,'Josephina Beck');
insert into Professor values (13, 783039,'Jelena Misic');
insert into Professor values (14,283923,'Abdol Abhari');
insert into Professor values (15,412938,'Isaac Woungang');
/*
Has a ID
has userId that can be accessed to see name
*/

CREATE TABLE TA(
    taID NUMBER UNIQUE PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);
ALTER TABLE TA
    Add TAName VARCHAR2 (100 CHAR);

insert into TA values (7, 506749, 'Emily Ilis');

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

/*
This prequistie checks for certain course ID if the prerequite is satisfied
*/
CREATE TABLE Prerequisite(
    prerequisiteSatisfied VARCHAR2(5) PRIMARY KEY NOT NULL,
    payment NUMBER NOT NULL,
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);

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

/*
Shows Lecture Contents
*/
CREATE TABLE Lecture_Material(
    lectureID NUMBER PRIMARY KEY NOT NULL,
    lectureContents VARCHAR2 (1000 CHAR)
);

/*
Shows what Professors are teaching what courses
*/
CREATE TABLE Course_List(
    professorID NUMBER,
    FOREIGN KEY (professorID) REFERENCES Professor(professorID), 
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);

/*
Used to check score of specific test for a course for certain student
*/
CREATE TABLE Tests(
    testID NUMBER PRIMARY KEY NOT NULL,
    testWeight NUMBER NOT NULL,
    testEvaluationStatus VARCHAR2 (10 CHAR),
    sectionID NUMBER,
    FOREIGN KEY (sectionID) REFERENCES Section(sectionID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    studentID NUMBER,
    FOREIGN KEY (studentID) REFERENCES Student(studentID)
);

/*
Used to check score of specific Assignment for a course for certain student
*/
CREATE TABLE Assignments(
    assignmentID NUMBER PRIMARY KEY NOT NULL,
    assignmentWeight NUMBER NOT NULL,
    assignmentEvaluationStatus VARCHAR2 (10 CHAR),
    sectionID NUMBER,
    FOREIGN KEY (sectionID) REFERENCES Section(sectionID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    studentID NUMBER,
    FOREIGN KEY (studentID) REFERENCES Student(studentID)

);

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

/*
Discussion board for a certain section and certain section,
Also for certain assignments
*/
CREATE TABLE Discussion_Board(
    dicussionContent VARCHAR2(1000 CHAR),
    sectionID NUMBER,
    FOREIGN KEY (sectionID) REFERENCES Section(sectionID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    assignmentID NUMBER,
    FOREIGN KEY (assignmentID) REFERENCES Assignments(assignmentID)
);

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
insert into Course_Offering values ('Winter','Undergraduate','Database Systems','Computer Science',14,
7,501);

/*

Following tables are for the many to many relationships

*/


CREATE TABLE enrolled (
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    studentID NUMBER,
    FOREIGN KEY (studentID) REFERENCES Student(studentID)
);

ALTER TABLE enrolled 
    add name VARCHAR2 (50 CHAR);

insert into enrolled values (501,123456,'jack smith');
insert into enrolled values (633,12323490,'prince jackson');



CREATE TABLE checks (
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    prerequisiteSatisfied VARCHAR2 (5 CHAR) NOT NULL,
    FOREIGN KEY(prerequisiteSatisfied) REFERENCES Prerequisite(prerequisiteSatisfied)
);

CREATE TABLE creates (
    professorID NUMBER NOT NULL,
    FOREIGN KEY (professorID) REFERENCES Professor(professorID),
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);




SELECT name, courseID, studentID 
FROM enrolled
ORDER BY name, courseID DESC, studentID ASC;





