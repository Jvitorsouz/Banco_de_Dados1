-- QUESTÃO 1
SELECT COUNT(*) FROM employee WHERE sex='F';

-- QUESTÃO 2
SELECT AVG(salary) FROM employee WHERE sex = 'M' AND address LIKE '%TX';

-- QUESTÃO 3
SELECT superssn AS ssn_supervisor, COUNT (*) AS qtd_supervisionados FROM employee GROUP BY superssn ORDER BY qtd_supervisionados ASC;

-- QUESTÃO 4
SELECT S.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM(employee S JOIN employee E ON S.ssn=E.superssn) GROUP BY S.ssn ORDER BY qtd_supervisionados ASC;


-- QUESTÃO 5
SELECT S.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados FROM(employee S RIGHT OUTER JOIN employee E ON S.ssn=E.superssn) GROUP BY S.ssn;

-- QUESTÃO 6
SELECT MIN(COUNT) AS qtd FROM(SELECT COUNT(*) FROM works_on GROUP BY pno) AS res;

-- QUESTÃO 7
SELECT pno AS num_projeto, COUNT(*) qtd_func FROM works_on GROUP BY pno HAVING COUNT(*) = (SELECT MIN(count) FROM (SELECT COUNT(*) FROM works_on GROUP BY pno) AS res) ORDER BY pno ASC;

-- QUESTÃO 8
SELECT P.pno AS num_proj, AVG(E.salary) AS media_sal FROM( works_on P JOIN employee E ON E.ssn = P.essn) GROUP BY P.pno;

-- QUESTÃO 9
SELECT P.pno AS num_proj, W.pname AS proj_nome, AVG(E.salary) AS media_sal FROM(( works_on P JOIN employee E ON E.ssn = P.essn) JOIN project W ON P.Pno = W.pnumber) GROUP BY P.pno, W.pname;

-- QUESTÃO 10
SELECT S.fname, S.salary FROM employee S WHERE s.salary > ALL(SELECT E.salary FROM employee E JOIN works_on W ON E.ssn = W.essn AND w.pno = '92');

-- QUESTÃO 11
SELECT E.ssn, COUNT(W.pno) AS qtd_proj FROM employee E LEFT JOIN works_on W ON E.ssn = W.essn GROUP BY E.ssn ORDER BY qtd_proj ASC;

-- QUESTÃO 12
SELECT pno AS num_proj, count as qtd_func FROM (SELECT W.pno, COUNT(E.ssn) FROM works_on W RIGHT JOIN employee E ON E.ssn = W.essn GROUP BY W.pno)AS res WHERE count < 5 ORDER BY count ASC;

-- QEUSTÃO 13
SELECT fname FROM employee WHERE ssn IN (SELECT essn FROM dependent WHERE essn IN (SELECT essn FROM works_on WHERE pno = (SELECT pnumber FROM project WHERE plocation = 'Sugarland')));

-- QUESTÃO 14
SELECT dname FROM department D  WHERE NOT EXISTS(SELECT * FROM project P where D.dnumber = P.dnum);
 
-- QUESTÕ 15
SELECT fname, lname FROM employee WHERE ssn != '123456789' AND NOT EXISTS ((SELECT pno FROM works_on WHERE essn = '123456789') EXCEPT (SELECT pno FROM works_on WHERE essn = ssn));
