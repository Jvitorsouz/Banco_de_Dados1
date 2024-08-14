-- QUESTÃO 1
SELECT * FROM department;

-- QUESTÃO 2
SELECT * FROM dependent;

-- QUESTÃO 3
SELECT * FROM dept_locations;

-- QUESTÃO 4
SELECT * FROM employee;

-- QUESTÃO 5
SELECT * FROM project;

-- QUESTÃO 6
SELECT * FROM works_on;

-- QUESTÃO 7
SELECT fname, lname FROM employee WHERE sex='M';

-- QUESTÃO 8
SELECT fname FROM employee WHERE sex='M' AND superssn IS NULL;

-- QUESTÃO 9
SELECT E.fname, S.fname FROM employee E, employee S WHERE e.superssn=S.ssn;

-- QEUSTÃO 10
SELECT E.fname FROM employee E, employee S WHERE E.superssn = S.ssn AND S.fname='Franklin';

-- QUESTÃO 11
SELECT D.dname, L.dlocation FROM department D, dept_locations L WHERE D.dnumber=L.dnumber;

-- QUESTÃO 12
SELECT D.dname FROM department D, dept_locations L WHERE D.dnumber=L.dnumber AND L.dlocation LIKE 'S%';

-- QUESTÃO 13
SELECT E.fname, E.lname, D.dependent_name FROM employee E, dependent D WHERE E.ssn = D.essn;

-- QUESTÃO 14
SELECT fname || ' ' || minit || ' ' || lname AS full_name, salary FROM employee WHERE salary > 50000;

-- QUESTÃO 15
SELECT P.pname, D.dname FROM PROJECT P, department D WHERE P.dnum = D.dnumber;

-- QUESTÃO 16
SELECT P.pname, E.fname FROM project P, employee E, department D WHERE P.dnum = D.dnumber AND E.ssn = D.mgrssn AND P.pnumber > 30;

-- QUESTÃO 17
SELECT P.pname, E.fname FROM project P, employee E, works_on W WHERE p.pnumber = W.pno AND E.ssn = W.essn; 

-- QUESTÃO 18
SELECT E.fname, D.dependent_name, D.relationship FROM dependent D , employee E , works_on W WHERE D.essn = E.ssn AND W.pno = 91 AND W.essn = E.ssn; 
