--Q1:
--LETRA A:
CREATE VIEW vw_dptmgr AS SELECT dnumber, fname FROM department, employee WHERE ssn = mgrssn; 

-- LETRA B:
CREATE VIEW vw_empl_houston AS SELECT ssn, fname FROM employee WHERE address LIKE '%Houston%';

--LETRA C:
CREATE VIEW vw_deptstats AS SELECT D.dnumber, D.dname, COUNT(E.ssn) FROM department D, employee E WHERE E.dno = D.dnumber GROUP BY D.dnumber; 

--LETRA D:
CREATE VIEW vw_projstats AS SELECT P.pnumber, COUNT(W.pno) FROM project P, works_on W WHERE P.pnumber = W.pno GROUP BY P.pnumber;

