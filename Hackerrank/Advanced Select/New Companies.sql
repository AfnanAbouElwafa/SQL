/*
New Companies

Write a query to print the company_code, founder name, total number of lead managers, 
total number of senior managers, total number of managers, and total number of employees.
Order your output by ascending company_code.

Note:
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. 
For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be
C_1, C_10, and C_2.
*/


CREATE TABLE Company(
company_code varchar(100) PRIMARY KEY,
founder varchar(100)
)


CREATE TABLE Lead_Manager(
lead_manager_code varchar(100) PRIMARY KEY,
company_code varchar(100)FOREIGN KEY REFERENCES Company(company_code)
)

CREATE TABLE Senior_Manager(
senior_manager_code varchar(100) PRIMARY KEY,
lead_manager_code varchar(100) FOREIGN KEY REFERENCES Lead_Manager(lead_manager_code),
company_code varchar(100)FOREIGN KEY REFERENCES Company(company_code)
)

CREATE TABLE Manager(
manager_code varchar(100) PRIMARY KEY,
senior_manager_code varchar(100) FOREIGN KEY REFERENCES Senior_Manager(senior_manager_code),
lead_manager_code varchar(100) FOREIGN KEY REFERENCES Lead_Manager(lead_manager_code),
company_code varchar(100)FOREIGN KEY REFERENCES Company(company_code)
)

CREATE TABLE Employee(
employee_code varchar(100) PRIMARY KEY,
manager_code varchar(100) FOREIGN KEY REFERENCES Manager(manager_code),
senior_manager_code varchar(100) FOREIGN KEY REFERENCES Senior_Manager(senior_manager_code),
lead_manager_code varchar(100) FOREIGN KEY REFERENCES Lead_Manager(lead_manager_code),
company_code varchar(100)FOREIGN KEY REFERENCES Company(company_code)
)

INSERT INTO Company
VALUES ('C1', 'Monika'),
('C2','Samantha');

INSERT INTO Lead_Manager
VALUES ('LM1', 'C1'),
('LM2','C2');

INSERT INTO Senior_Manager
VALUES ('SM1','LM1', 'C1'),
('SM2','LM1', 'C1'),
('SM3','LM2','C2');

INSERT INTO Manager
VALUES ('M1','SM1','LM1', 'C1'),
('M2','SM3','LM2','C2'),
('M3','SM3','LM2','C2');

INSERT INTO Employee
VALUES ('E1','M1','SM1','LM1', 'C1'),
('E2','M1','SM1','LM1', 'C1'),
('E3','M2','SM3','LM2','C2'),
('E4','M3','SM3','LM2','C2');

SELECT c1.company_code, c1.founder, 
(SELECT COUNT(distinct lead_manager_code) FROM Lead_Manager l WHERE c1.company_code = l.company_code  
GROUP BY l.company_code),
(SELECT COUNT(distinct senior_manager_code) FROM Senior_Manager s WHERE c1.company_code = s.company_code  
GROUP BY s.company_code),
(SELECT COUNT(distinct manager_code) FROM Manager m WHERE c1.company_code = m.company_code  
GROUP BY m.company_code),
(SELECT COUNT(distinct employee_code) FROM Employee e WHERE c1.company_code = e.company_code  
GROUP BY e.company_code)
FROM Company c1
GROUP BY c1.company_code,c1.founder
ORDER BY c1.company_code

