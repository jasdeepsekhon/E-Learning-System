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

/*
Has a ID
has userId that can be accessed to see name
*/
CREATE TABLE Student(
    studentID NUMBER PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);

/*
Has a ID
has userId that can be accessed to see name
*/
CREATE TABLE Professor(
    professorID NUMBER PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);

/*
Has a ID
has userId that can be accessed to see name
*/

CREATE TABLE TA(
    taID NUMBER PRIMARY KEY,
    userID NUMBER,
    FOREIGN KEY (userID) REFERENCES first_user(userID)
);

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
Contains Lecture Contents
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
    FOREIGN KEY (courseID) REFERENCES Course(courseID) ,
    assignmentID NUMBER,
    FOREIGN KEY (assignmentID) REFERENCES Assignments(assignmentID) ON DELETE CASCADE
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

/*
Below tables are for relations that signify the many to many relationships 
*/

CREATE TABLE enrolled (
    courseID NUMBER NOT NULL,
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    studentID NUMBER,
    FOREIGN KEY (studentID) REFERENCES Student(studentID)
);


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
