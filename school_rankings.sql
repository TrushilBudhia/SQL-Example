-- Drops the database if it exists currently --
DROP DATABASE IF EXISTS school_rankings_db;

-- Creates the database --
CREATE DATABASE school_rankings_db;

-- Creates the tables for colleges, students and rankings within school_rankings_db --
CREATE TABLE school_rankings_db.colleges (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE school_rankings_db.students (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  collegeId INTEGER REFERENCES colleges(id)
);

CREATE TABLE school_rankings_db.rankings (
  studentId INTEGER REFERENCES students(id),
  ranking INTEGER NOT NULL,
  year INTEGER NOT NULL
);

-- Inserts the below information into the respective tables --
INSERT INTO school_rankings_db.colleges(id, name) VALUES(1, 'Pi Institute Of Engineering');
INSERT INTO school_rankings_db.colleges(id, name) VALUES(2, 'Kappa Institute Of Technology');
INSERT INTO school_rankings_db.colleges(id, name) VALUES(3, 'Omega Science Academy');

INSERT INTO school_rankings_db.students(id, name, collegeId) VALUES(1, 'Rob', 1);
INSERT INTO school_rankings_db.students(id, name, collegeId) VALUES(2, 'Shawn', 1);
INSERT INTO school_rankings_db.students(id, name, collegeId) VALUES(3, 'Bill', 2);
INSERT INTO school_rankings_db.students(id, name, collegeId) VALUES(4, 'Steve', 2);
INSERT INTO school_rankings_db.students(id, name, collegeId) VALUES(5, 'Roger', 3);
INSERT INTO school_rankings_db.students(id, name, collegeId) VALUES(6, 'Megan', 3);

INSERT INTO school_rankings_db.rankings(studentId, ranking, year) VALUES(1, 1, 2014);
INSERT INTO school_rankings_db.rankings(studentId, ranking, year) VALUES(6, 2, 2014);
INSERT INTO school_rankings_db.rankings(studentId, ranking, year) VALUES(3, 1, 2015);
INSERT INTO school_rankings_db.rankings(studentId, ranking, year) VALUES(4, 2, 2015);
INSERT INTO school_rankings_db.rankings(studentId, ranking, year) VALUES(2, 3, 2015);
INSERT INTO school_rankings_db.rankings(studentId, ranking, year) VALUES(5, 4, 2015);
INSERT INTO school_rankings_db.rankings(studentId, ranking, year) VALUES(3, 1, 2016);
INSERT INTO school_rankings_db.rankings(studentId, ranking, year) VALUES(4, 2, 2016);

-- Querying the tables in the database to display all colleges that have at least one student with a ranking between 1 and 3 for the year 2015 --
SELECT school_rankings_db.colleges.name as Name, school_rankings_db.rankings.ranking as TopRank, COUNT(school_rankings_db.students.collegeId) as NumberOfStudents
FROM school_rankings_db.colleges
LEFT JOIN school_rankings_db.students ON school_rankings_db.students.collegeId = colleges.id
LEFT JOIN school_rankings_db.rankings ON school_rankings_db.rankings.studentId = students.id
WHERE school_rankings_db.rankings.year = "2015" && school_rankings_db.rankings.ranking < 4
GROUP BY school_rankings_db.students.collegeId;
