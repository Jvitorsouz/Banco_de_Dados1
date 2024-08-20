# Cálculo Relacional

- Uma expressão de cálculo relacional cria uma **`nova relação`**
- Uma expressão é especificada em termos de variáveis.

<aside>
<img src="https://www.notion.so/icons/exclamation-mark_red.svg" alt="https://www.notion.so/icons/exclamation-mark_red.svg" width="40px" /> **Uma linguagem L é relacionalmente completa se pudermos expressar em L qualquer consulta que puder ser expressa em cálculo relacional**

</aside>

<aside>
<img src="https://www.notion.so/icons/exclamation-mark_red.svg" alt="https://www.notion.so/icons/exclamation-mark_red.svg" width="40px" /> **O cálculo relacional de tupla é baseado na especificação de variáveis de tupla**

</aside>

## `ESTRUTURA: {t| COND(t)}`

- `t` → é uma variável de tupla
- `CON(t)` → é uma expressão condicional (ou fórmula) que envolve t.
- Resultado → o resultado de uma consulta com cálculo relacional é o conjunto de todas as tuplas `t` que satisfazem a `COND(t)`

## QUANTIFICADORES: Existencial e Universal

## 1. Existencial **∃**

- Uma fórmula `(**∃**t)(F)` é verdadeira se a fórmula F for avaliada como
verdadeira para pelo menos uma tupla atribuída às ocorrências
livre de t em F; caso contrário `(**∃**t)(F)` é falsa.
- É chamado de quantificador universal ou `“existe um”`

## 2. Universal ∀

- A fórmula `(∀t)(F)` é verdadeira se a fórmula F é avaliada como
verdadeira para cada tupla (no universo) atribuída às ocorrências
livres de t em F; caso contrário `(∀t)(F)` é falsa.
- É chamado de quantificador universal ou `“para todos”`

## LISTA CÁLCULO RELACIONAL

### Banco de dados usada na lista:

### Tabela: STUDENT

| Name | Student_number | Class | Major |
| --- | --- | --- | --- |
| Intro to Computer Science | CS1310 | 4 | CS |
| Data Structures | CS3320 | 4 | CS |
| Discrete Mathematics | MATH2410 | 3 | MATH |
| Database | CS3380 | 3 | CS |

### Tabela: COURSE

| Course_name | Course_number | Credit_hours | Department |
| --- | --- | --- | --- |
| Intro to Computer Science | CS1310 | 4 | CS |
| Data Structures | CS3320 | 4 | CS |
| Discrete Mathematics | MATH2410 | 3 | MATH |
| Database | CS3380 | 3 | CS |

### Tabela: SECTION

| Section_identifier | Course_number | Semester | Year | Instructor |
| --- | --- | --- | --- | --- |
| 85 | MATH2410 | Fall | 07 | King |
| 92 | CS1310 | Fall | 07 | Anderson |
| 102 | CS3320 | Spring | 08 | Knuth |
| 112 | MATH2410 | Fall | 08 | Chang |
| 119 | CS1310 | Fall | 08 | Anderson |
| 135 | CS3380 | Fall | 08 | Stone |

### Tabela: GRADE_REPORT

| Student_number | Section_identifier | Grade |
| --- | --- | --- |
| 17 | 112 | B |
| 17 | 119 | C |
| 8 | 85 | A |
| 8 | 92 | A |
| 8 | 102 | B |
| 8 | 135 | A |

### Tabela: PREREQUISITE

| Course_number | Prerequisite_number |
| --- | --- |
| CS3380 | CS3320 |
| CS3380 | MATH2410 |
| CS3320 | CS1310 |

### Tabela: EMPLOYEE

| Fname | Minit | Lname | Ssn | Bdate | Address | Sex | Salary | Super_ssn | Dno |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| John | B | Smith | 123456789 | 1965-01-09 | 731 Fondren, Houston, TX | M | 30000 | 333445555 | 5 |
| Franklin | T | Wong | 333445555 | 1955-12-08 | 638 Voss, Houston, TX | M | 40000 | 888665555 | 5 |
| Alicia | J | Zelaya | 999887777 | 1968-01-19 | 3321 Castle, Spring, TX | F | 25000 | 987654321 | 4 |
| Jennifer | S | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire, TX | F | 43000 | 888665555 | 4 |
| Ramesh | K | Narayan | 666884444 | 1942-09-15 | 575 Fire Oak, Humble, TX | M | 38000 | 333445555 | 5 |
| Joyce | A | English | 453453453 | 1972-07-31 | 5631 Rice, Houston, TX | F | 25000 | 333445555 | 5 |
| James | E | Borg | 888665555 | 1937-11-10 | 450 Stone, Houston, TX | M | 55000 | NULL | 1 |

### Tabela: DEPARTMENT

| Dname | Dnumber | Mgr_ssn | Mgr_start_date |
| --- | --- | --- | --- |
| Research | 5 | 333445555 | 1988-05-22 |
| Administration | 4 | 987654321 | 1995-01-01 |
| Headquarters | 1 | 888665555 | 1981-06-19 |

### Tabela: DEPT_LOCATIONS

| Dnumber | Dlocation |
| --- | --- |
| 1 | Houston |
| 4 | Stafford |
| 5 | Bellaire |
| 5 | Sugarland |
| 5 | Houston |

### Tabela: WORKS_ON

| Essn | Pno | Hours |
| --- | --- | --- |
| 123456789 | 1 | 32.5 |
| 123456789 | 2 | 7.5 |
| 666884444 | 3 | 40.0 |
| 453453453 | 1 | 20.0 |
| 453453453 | 2 | 20.0 |
| 333445555 | 2 | 10.0 |
| 333445555 | 3 | 10.0 |
| 333445555 | 10 | 10.0 |
| 999887777 | 30 | 30.0 |
| 987654321 | 30 | 30.0 |
| 987654321 | 20 | 20.0 |
| 888665555 | 20 | NULL |

### Tabela: PROJECT

| Pname | Pnumber | Plocation | Dnum |
| --- | --- | --- | --- |
| ProductX | 1 | Bellaire | 5 |
| ProductY | 2 | Sugarland | 5 |
| ProductZ | 3 | Houston | 5 |
| Computerization | 10 | Stafford | 4 |
| Reorganization | 20 | Houston | 1 |
| Newbenefits | 30 | Stafford | 4 |

### Tabela: DEPENDENT

| Essn | Dependent_name | Sex | Bdate | Relationship |
| --- | --- | --- | --- | --- |
| 333445555 | Alice | F | 1986-04-05 | Daughter |
| 333445555 | Theodore | M | 1983-10-25 | Son |
| 333445555 | Joy | F | 1958-05-03 | Spouse |
| 123456789 | Abner | M | 1942-02-28 | Spouse |
| 123456789 | Michael | M | 1988-01-04 | Son |
| 123456789 | Elizabeth | F | 1967-05-05 | Spouse |

### **8.24 - Especificar consultas (a), (b), (c), (e), (f), (i) e (j) do exercício 6.16 no cálculo relacional de tupla.**

(a) Recuperar os nomes de funcionários do departamento 5 que trabalham mais de 10 horas por semana no projeto 'ProdutoX'.

**`{e.fname, e.lname | employee e  AND e.dno = 5 AND ∃w ∃p(works_on w and project p AND e.ssn = E.ssn AND w.pno = p.pnumber AND w.hours > 10 AND pname ‘productx')}`**

(b) Listar os nomes dos funcionários que têm algum dependente cujo primeiro nome é igual ao do funcionário.

**`{e.fname, e.lname | employee e AND ∃d (dependet d AND e.snn = d.essn AND e.fname = d.dependent_name)}`**

(c) Encontre os nomes dos funcionários que são diretamente supervisionados por 'Franklin Wong'.

**`{e.fname, e.lname | employee e AND ∃s(employee s AND e.superssn = s.ssn AND s.fname = ‘Franklin’ AND s.lname = ‘Wong’)}`**

(e) Recupere os nomes dos funcionários que trabalham em **`todos`** os projetos.

<aside>
<img src="https://www.notion.so/icons/exclamation-mark_purple.svg" alt="https://www.notion.so/icons/exclamation-mark_purple.svg" width="40px" /> **`∀project → ∃w : para todo projeto existe um works_on`                                                                                               `A → b equivale NOT A OR B`**

</aside>

**`{e.fname , e.lname | employee e AND ∀p (not project p OR ∃w(works_on and w.pno = p.pnumber and w.essn = e.snn)) }`**

(f) Recuperar os nomes de funcionários que não trabalham em projeto algum.

**`{e.fname, e.lname | employee e AND not ∃w(works_on w AND e.ssn = w.essn}`**

(i) Encontrar os nomes e endereços dos funcionários que trabalham em pelo menos um projeto localizado em Houston, mas cujo departamento (do funcionário) não tem nenhuma localização em Houston.

**`{e.fname, e.lname, e.adress | employee e AND ∃p∃w (project p AND works_on w AND e.ssn = w.essn and w.pno = p.pnumber and p.plocation = ‘houston’ AND not ∃d(dept_locations d AND e.dno = d.number and d.location = ‘houston’))}`**

(j) Listar os últimos nomes dos gerentes de departamento que não possuem dependentes.

**`{e.lname | employee e and ∃d(departament d AND e.ssn = d.mgr_ssn and NOT ∃i (dependent i AND e.ssn = i.essn))}`**

### 8.26 - Especificar consultas c, d e e do exercício 6.18 no cálculo relacional de tupla. Estas consultas estão descritas a seguir.

(c) Para cada turma (section), ministrada pelo professor King, recuperar o número de curso, semestre, ano e número de alunos que completou a section.

**`ISSO NÃO É POSSIVEL PORUQE NÃO HÁ FUNÇÃO DE CONTAGEM NO CÁLCULO RELACIONAL`**

(d) Recuperar um relatório de desempenho de cada estudante sênior (classe = 5) estudandono departamento de Ciência da Computação (Computer Science - ‘CS’). O relatório inclui o nome do aluno, o nome do curso, o número do curso, as horas de crédito, o semestre, o ano e a nota (grade) para cada curso concluído pelo aluno.

**`{s.name, c.course_name, c.credit_hours, t.semester, t.year, g.grade | student s AND course c AND section t AND grade g AND s.class = 5 AND s.major = ‘cs’ AND g.student_number = s.student_number AND g.section_identifier = t.section_identifier AND c.course_number = t.course_number}`** 

(e) Recuperar os nomes e os departamentos de todos os estudantes com desempenho acadêmico impecável (estudantes que têm Nota A em todos os seus cursos).

**`{s.name , s.major | student s and ∀g(not grade_report g AND not(s.student = g.grade_report) OR g.grade = ‘A’)}`**

### 8.30 - Mostrar como podemos especificar as seguintes operações de álgebra relacional utilizando cálculo relacional.

(a) σ A=c (R(A, B, C)) **`{t | R(t) AND t.a = t.c}`**

(b) π <A, B> (R(A, B, C)) **`{t.a, t.b | R(t)}`**

(c) R(A, B, C) * S(C, D, E) **`{t.a, t.b, q.d, q.e | R(t) AND S(q) AND t.c = q.c}`**

(d) R(A, B, C) U S(A, B, C) **`{t | R(t) OR S(t)}`**

(e) R(A, B, C) ∩ S(A, B, C) **`{t | R(t) AND S(t)}`**

(f) R(A, B, C) ̶ S(A, B, C) **`{t| R(t) AND NOT S(t)}`**

(g) R(A, B, C) X S(D, E, F) **`{t.A, t.B, t.C, q.D, q.E, q.F | R(t) AND S(q)}`**
