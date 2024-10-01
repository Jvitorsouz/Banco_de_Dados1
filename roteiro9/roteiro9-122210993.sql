-- Q1:
--LETRA A:
CREATE VIEW vw_dptmgr AS SELECT d.dnumber AS department, e.fname AS manager FROM department AS d, employee AS e WHERE e.ssn = d.mgrssn




-- LETRA B:
CREATE VIEW vw_empl_houston AS SELECT e.ssn, e.fname FROM employee AS e WHERE e.address LIKE '%Houston%';

-- LETRA C:
CREATE VIEW vw_deptstats AS SELECT d.dnumber, d.dname, COUNT (e.dno) AS qtd_funcionarios FROM department AS d, employee AS e  WHERE d.dnumber = e.dno GROUP BY d.dnumber;

-- LETRA D:
CREATE VIEW vw_projstats AS SELECT p.pnumber AS project_id, COUNT (w.pno) AS qtd_func FROM project AS p, works_on AS w WHERE p.pnumber = w.pno GROUP BY p.pnumber;

--Q2:
SELECT * FROM vw_dptmgr;
SELECT * FROM vw_empl_houston;
SELECT * FROM vw_deptstats;
SELECT * FROM vw_projstats;
SELECT * FROM vw_deptstats WHERE qtd_funcionarios > 9;
SELECT * FROM vw_projstats WHERE qtd_func > 5;

--Q3:
DROP VIEW vw_dptmgr;
DROP VIEW vw_empl_houston;
DROP VIEW vw_deptstats;
DROP VIEW vw_projstats;

-- Q4:
CREATE FUNCTION check_age(essn CHAR(9))
RETURNS text AS $$

DECLARE bdate date;

BEGIN
  SELECT e.bdate INTO bdate FROM employee AS e WHERE e.ssn = essn;
  IF bdate IS NULL THEN
    RETURN 'UNKNOWN';
  ELSIF bdate > CURRENT_DATE THEN
    RETURN 'INVALID';
  ELSIF EXTRACT(YEAR FROM AGE(CURRENT_DATE, bdate)) > 49 THEN
    RETURN 'SENIOR';
  ELSE RETURN 'YOUNG';
  END IF;
END;
$$  LANGUAGE plpgsql;

-- Q5:
-- LETRA A:
DROP TRIGGER check_mgr ON department;

-- LETRA B:
INSERT INTO department VALUES ('Test', 2, '999999999', now());

-- LETRA C:
INSERT INTO employee VALUES ('Joao','A','Silva','999999999','10-OCT-1950','123 Peachtree, Atlanta, GA','M',85000,null,2);

INSERT INTO employee VALUES ('Jose','A','Santos','999999998','10-OCT-1950','123 Peachtree, Atlanta, GA','M',85000,'999999999',2);

-- LETRA D:
CREATE FUNCTION check_mgr() RETURNS TRIGGER AS $check_mgr$
  BEGIN

    -- Se não for um funcionário atualmente alocado no departamento
    IF NOT EXISTS (SELECT e.ssn FROM employee AS e WHERE e.ssn = NEW.mgrssn AND e.dno = NEW.dnumber) THEN
      RAISE EXCEPTION 'manager must be a department''s employee';
    END IF;

    -- Se não possuir subordinados
    IF NOT EXISTS (SELECT e.ssn FROM employee AS e WHERE e.superssn = NEW.mgrssn) THEN
      RAISE EXCEPTION 'manager must have supevisees';
    END IF;

    -- Se não for 'SENIOR'
    IF check_age(NEW.mgrssn) != 'SENIOR' THEN
      RAISE EXCEPTION 'manager must be a SENIOR employee';
    END IF;
  
  RETURN NEW;
  END;
  $check_mgr$ LANGUAGE plpgsql;

CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department
  FOR EACH ROW EXECUTE PROCEDURE check_mgr();

-- LETRA E:

-- o update funciona normalmente
UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;

-- não permite executar update
-- ERROR:  manager must be a department's employee
UPDATE department SET mgrssn = null WHERE dnumber=2;

-- não permite executar update porque esse employee não existe
-- ERROR:  manager must be a department's employee
UPDATE department SET mgrssn = '999' WHERE dnumber=2;

-- não permite executar update pois o employee não é do departamento
-- ERROR:  manager must be a department's employee
UPDATE department SET mgrssn = '111111100' WHERE dnumber=2;

-- altera a data de nascimento do employee para que ele deixe de ser Sênior
-- UPDATE 1
UPDATE employee SET bdate = '10-OCT-2000' WHERE ssn = '999999999';

-- não permite executar update
-- ERROR:  manager must be a SENIOR employee
UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;

-- altera a data de nascimento do employee para que ele volte a ser Sênior
-- UPDATE 1
UPDATE employee SET bdate = '10-OCT-1950' WHERE ssn = '999999999';

-- o update funciona normalmente
-- UPDATE 1
UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;

--remove os subordinados
-- DELETE 1
DELETE FROM employee WHERE superssn = '999999999';

-- não permite executar update pois o empregado não tem subordinados
-- ERROR:  manager must have supevisees
UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;

--remove o employee '999999999'
-- DELETE 1
DELETE FROM employee WHERE ssn = '999999999';

--Remove o departamento 2
-- DELETE 1
DELETE FROM department where dnumber=2;