# Álgebra Relacional - PARTE 2

## Operações Binárias

### 1. Junção ⨝ - Join

- A sequência de **`PRODUTO CARTESIANO`** e **`SELECT`** é muito usada para identifica e selecionar tuplas relacionadas em duas relações
- Join combina esta sequência em uma única operação

**`Estrutura: R ⨝ <condição de junçao> S`**

**Exemplo**:

- Queremos recuperar o nome do manager de cada departamento. Precisamos combinar cada tupla de `DEPARTMENT` com as tuplas de `EMPLOYEE` cujo valor de `SSN` corresponde ao valor de `MGRSSN` na tupla `DEPARTMENT`

**Tabela: DEPARTMENT**

| DNO | DNAME | MGRSSN |
| --- | --- | --- |
| 10 | Recursos Humanos | 123456789 |
| 20 | TI | 987654321 |
| 30 | Marketing | 111111111 |

**Tabela: EMPLOYEE**

| SSN | FNAME | LNAME | SEX |
| --- | --- | --- | --- |
| 123456789 | João | Silva | M |
| 987654321 | Maria | Souza | F |
| 111111111 | Ana | Costa | F |
| 222222222 | Bruno | Lima | M |

**`DEPT_MGR ← DEPARTMENT ⨝  mgrssn = ssn EMPLOYEE`**

**Resultado `DEPT_MGR`:**

| DNO | DNAME | MGRSSN | FNAME | LNAME |
| --- | --- | --- | --- | --- |
| 10 | Recursos Humanos | 123456789 | João | Silva |
| 20 | TI | 987654321 | Maria | Souza |
| 30 | Marketing | 111111111 | Ana | Costa |

### 2. NaturalJoin *

- Variação da operação **`JOIN`** para se livrar do segundo atributo (supérfluo) em uma condição de junção por igualdade
- Requer que o nome dos atributos tenho o mesmo nome e tipo em ambas relaçoes, caso não basta aplicar uma renomeação primeiro

**Exemplo:**

- Para aplicar natural join nos atributos **`DNUMBER`** de
`DEPARTMENT` e **`DEPT_LOCATIONS`**:

**Tabela: DEPARTMENT**

| DNUMBER | DNAME | MGRSSN |
| --- | --- | --- |
| 10 | Recursos Humanos | 123456789 |
| 20 | TI | 987654321 |
| 30 | Marketing | 111111111 |

**Tabela: DEPT_LOCATIONS**

| DNUMBER | LOCATION |
| --- | --- |
| 10 | São Paulo |
| 10 | Rio de Janeiro |
| 20 | Belo Horizonte |
| 30 | Recife |
| 40 | Fortaleza |

**`DEPT_LOCS ← DEPARTMENT * DEPT_LOCATIONS`**

**Resultado `DEPT_LOCS`:**

| DNUMBER | DNAME | MGRSSN | LOCATION |
| --- | --- | --- | --- |
| 10 | Recursos Humanos | 123456789 | São Paulo |
| 10 | Recursos Humanos | 123456789 | Rio de Janeiro |
| 20 | TI | 987654321 | Belo Horizonte |
| 30 | Marketing | 111111111 | Recife |

## Funções de Agregação - F

- Operações adicionais que não podem ser expressas em álgeba relacional basica

Exemplos:

**`SUM`** - soma total de um atributo

**`AVERAGE`** - media de um atritubo

**`MAXIMUN`** - maximo de um atributo

**`MINIMUM`** - minimo de um atributo

**`COUNT`** - conta de tuplas de um relação/atributo, todas as linhas são contadas inclusive as duplicatas

**`F count ssn, AVERAGE salary (EMPLOYEE) calcula a contagem de funcionários e o salario médio entre eles`**

<aside>
<img src="https://www.notion.so/icons/exclamation-mark_purple.svg" alt="https://www.notion.so/icons/exclamation-mark_purple.svg" width="40px" /> **É possivel fazer agrupamento com funções de agregação**

</aside>

## JUNÇÃO EXTERNA - OUTER UNION

- No Join e Natural **`JOIN`** tuplas sem outra tupla corresponde (matching) são eliminadas do resultado da junção
- tuplas com atributos null presentes na condição de junção são perdidas de informação
- **`OUTER UNION`** resolve isso

### 1. LEFT OUTER JOIN ⟕ - JUNÇÃO EXTERNA à esquerda

- Mantem todas as tuplas da primeira relação - relação a esquerda

**Exemplo:**

**Tabela: EMPLOYEE**

| SSN | FNAME | LNAME | DNUMBER |
| --- | --- | --- | --- |
| 123456789 | João | Silva | 10 |
| 987654321 | Maria | Souza | 20 |
| 111111111 | Ana | Costa | 10 |
| 222222222 | Bruno | Lima | NULL |
| 333333333 | Carla | Oliveira | 20 |

**Tabela: DEPARTMENT**

| DNUMBER | DNAME |
| --- | --- |
| 10 | Recursos Humanos |
| 20 | TI |
| 30 | Marketing |
|  |  |

**`EMP_DEPT ← EMPLOYEE ⟕ employee.dnumber = department.dnumber DEPARTMENT`**

**Resultado `EMP_DEPT`:**

| SSN | FNAME | LNAME | DNUMBER | DNAME |
| --- | --- | --- | --- | --- |
| 123456789 | João | Silva | 10 | Recursos Humanos |
| 987654321 | Maria | Souza | 20 | TI |
| 111111111 | Ana | Costa | 10 | Recursos Humanos |
| 222222222 | Bruno | Lima | NULL | NULL |
| 333333333 | Carla | Oliveira | 20 | TI |

### 2. RIGHT OUTER JOIN - JUNÇÃO EXTERNA À DIREITA

- Mantem todas as tuplas da seguda relação - relação a direita

**Exemplo:**

**Tabela: EMPLOYEE**

| SSN | FNAME | LNAME | DNUMBER |
| --- | --- | --- | --- |
| 123456789 | João | Silva | 10 |
| 987654321 | Maria | Souza | 20 |
| 111111111 | Ana | Costa | 10 |
| 222222222 | Bruno | Lima | NULL |
| 333333333 | Carla | Oliveira | 20 |

**Tabela: DEPARTMENT**

| DNUMBER | DNAME |
| --- | --- |
| 10 | Recursos Humanos |
| 20 | TI |
| 30 | Marketing |

**`EMP_DEPT ← EMPLOYEE ⟖  employee.dnumber = department.dnumber DEPARTMENT`**

**Resultado `EMP_DEPT`:**

| DNUMBER | DNAME | SSN | FNAME | LNAME |
| --- | --- | --- | --- | --- |
| 10 | Recursos Humanos | 123456789 | João | Silva |
| 10 | Recursos Humanos | 111111111 | Ana | Costa |
| 20 | TI | 987654321 | Maria | Souza |
| 20 | TI | 333333333 | Carla | Oliveira |
| 30 | Marketing | NULL | NULL | NULL |

### 3. FULL OUTER JOIN

- Mantém todas as tuplas de ambas a relção

**Exemplo:**

**Tabela: EMPLOYEE**

| SSN | FNAME | LNAME | DNUMBER |
| --- | --- | --- | --- |
| 123456789 | João | Silva | 10 |
| 987654321 | Maria | Souza | 20 |
| 111111111 | Ana | Costa | 10 |
| 222222222 | Bruno | Lima | NULL |
| 333333333 | Carla | Oliveira | 20 |

**Tabela: DEPARTMENT**

| DNUMBER | DNAME |
| --- | --- |
| 10 | Recursos Humanos |
| 20 | TI |
| 30 | Marketing |
| 40 | Design |

**`FULL_JOIN_RESULT ← EMPLOYEE ⟗ employee.dnumber = department.dnumber DEPARTMENT`**

**Resultado `FULL_JOIN_RESULT`:**

| SSN | FNAME | LNAME | DNUMBER | DNAME |
| --- | --- | --- | --- | --- |
| 123456789 | João | Silva | 10 | Recursos Humanos |
| 111111111 | Ana | Costa | 10 | Recursos Humanos |
| 987654321 | Maria | Souza | 20 | TI |
| 333333333 | Carla | Oliveira | 20 | TI |
| 222222222 | Bruno | Lima | NULL | NULL |
| NULL | NULL | NULL | 30 | Marketing |
| NULL | NULL | NULL | 40 | Design |

## OUTER UNION U*

- Une tuplas das duas relçaões quando estás não forem compativeis por tipo, mas se forem parcialmente compativeis
