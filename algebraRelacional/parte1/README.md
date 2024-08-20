# Álgebra Relacional - PARTE 1

- Álgebra relacional é o conjunto básico de operações para o modelo relacional
- O resultado de uma operação é uma nova relação
- Forma básica de recuperar dados do BD

## Operações Relacionais Unárias

Operações que envolvem apenas uma relação

### 1. Seleção **σ** - sigma

- Consiste em filtrar dados da relação a partir da condição
    
    **`Estrutura: σ<condição de seleção>(R) onde R é a relação`**
    

### **Exemplo 1:**

**Tabela: Estudantes**

| ID | Nome | Idade | Curso |
| --- | --- | --- | --- |
| 1 | Ana | 20 | Ciência da Computação |
| 2 | Bruno | 22 | Engenharia Elétrica |
| 3 | Carla | 21 | Matemática |
| 4 | Diego | 20 | Ciência da Computação |
| 5 | Elisa | 23 | Física |

**`σ idade=20 (Estudantes)`**

**Resultado**:

| ID | Nome | Idade | Curso |
| --- | --- | --- | --- |
| 1 | Ana | 20 | Ciência da Computação |
| 4 | Diego | 20 | Ciência da Computação |

### Exemplo 2: Seleção Composta

**Tabela: Funcionários**

| ID | Nome | Departamento | Salário |
| --- | --- | --- | --- |
| 1 | João | TI | 3000 |
| 2 | Maria | RH | 4000 |
| 3 | José | TI | 3500 |
| 4 | Ana | Marketing | 4500 |
| 5 | Pedro | TI | 2800 |
- **Consulta**: Selecionar todos os funcionários do departamento de TI que ganham mais de 3000.
    
    **`σ Departamento = ‘TI’ AND salario > 3000 (Funcionarios)`**
    

**Resultado**:

| ID | Nome | Departamento | Salário |
| --- | --- | --- | --- |
| 3 | José | TI | 3500 |

### **PROPRIEDADES:**

1. É comutativa
2. Uma sequencia de condições é equivalente a conjunção usando AND
    
    **`σ<cond1>(σ< cond2> (σ<cond3>  (R))) = σ<cond1> AND < cond2> AND < cond3>(R)`**
    

### **2. Projeção π - pi**

- Serve para selecionar quais atributos eu quero resgatar da relação
    
    **`Estrutura: π<lista de atributos> (R)`** 
    

### Exemplo 1: Projeção Simples

**Tabela: Estudantes**

| ID | Nome | Idade | Curso |
| --- | --- | --- | --- |
| 1 | Ana | 20 | Ciência da Computação |
| 2 | Bruno | 22 | Engenharia Elétrica |
| 3 | Carla | 21 | Matemática |
| 4 | Diego | 20 | Ciência da Computação |
| 5 | Elisa | 23 | Física |
- **Consulta**: Selecionar apenas os nomes e cursos dos estudantes.
    
    **`π nome, curso (Estudantes)`**
    

**Resultado**:

| Nome | Curso |
| --- | --- |
| Ana | Ciência da Computação |
| Bruno | Engenharia Elétrica |
| Carla | Matemática |
| Diego | Ciência da Computação |
| Elisa | Física |

### Exemplo 2: Projeção com Eliminação de Duplicatas

**Tabela: Funcionários**

| ID | Nome | Departamento | Salário |
| --- | --- | --- | --- |
| 1 | João | TI | 3000 |
| 2 | Maria | RH | 4000 |
| 3 | José | TI | 3500 |
| 4 | Ana | Marketing | 4500 |
| 5 | Pedro | TI | 2800 |
- **Consulta**: Selecionar apenas os departamentos (sem duplicatas).
    
    **`π Departamento (Funcionarios)`**
    

**Resultado**:

| Departamento |
| --- |
| TI |
| RH |
| Marketing |

<aside>
<img src="https://www.notion.so/icons/report_red.svg" alt="https://www.notion.so/icons/report_red.svg" width="40px" /> **A operação de projeção remover as duplicatas e não é comutativa**

</aside>

<aside>
<img src="https://www.notion.so/icons/exclamation-mark_purple.svg" alt="https://www.notion.so/icons/exclamation-mark_purple.svg" width="40px" /> **Pode-se escrever uma única Expressão de Álgebra Relacional com mais de um operador:**

**Ex:  `πFNAME, LNAME, SALARY(σ DNO=5  (EMPLOYEE))`**

</aside>

### 3. Renomeação P - rho

- Permite alterar o nome da relação, de seus atributos ou de ambos
- A renomeação é temporária, ou seja, é valida apenas para o escopo da expressão

### Exemplo 1: Renomeando uma Tabela

**Tabela Original: Funcionários**

| ID | Nome | Departamento | Salário |
| --- | --- | --- | --- |
| 1 | João | TI | 3000 |
| 2 | Maria | RH | 4000 |
| 3 | José | TI | 3500 |
| 4 | Ana | Marketing | 4500 |
| 5 | Pedro | TI | 2800 |
- **Consulta**: Renomear a tabela "Funcionários" para "Empregados".
    
    **`P Empregados(Funcionários)`**
    

**Resultado**:

**Tabela Renomeada: Empregados**

| ID | Nome | Departamento | Salário |
| --- | --- | --- | --- |
| 1 | João | TI | 3000 |
| 2 | Maria | RH | 4000 |
| 3 | José | TI | 3500 |
| 4 | Ana | Marketing | 4500 |
| 5 | Pedro | TI | 2800 |

### Exemplo 2: Renomeando Colunas

**Tabela Original: Produtos**

| ID_Produto | Nome | Categoria | Preço |
| --- | --- | --- | --- |
| 1 | Caneta | Papelaria | 1.50 |
| 2 | Caderno | Papelaria | 7.00 |
| 3 | Mochila | Acessórios | 45.00 |
| 4 | Lápis | Papelaria | 0.75 |
| 5 | Borracha | Papelaria | 0.50 |
- **Consulta**: Renomear a coluna "Nome" para "Produto_Nome" e "Preço" para "Valor".
    
    **`P (Produto_Nome, Categoria, Valor)(Produtos)`**
    

**Resultado**:

| ID_Produto | Produto_Nome | Categoria | Valor |
| --- | --- | --- | --- |
| 1 | Caneta | Papelaria | 1.50 |
| 2 | Caderno | Papelaria | 7.00 |
| 3 | Mochila | Acessórios | 45.00 |
| 4 | Lápis | Papelaria | 0.75 |
| 5 | Borracha | Papelaria | 0.50 |

<aside>
<img src="https://www.notion.so/icons/exclamation-mark_purple.svg" alt="https://www.notion.so/icons/exclamation-mark_purple.svg" width="40px" /> **Por conveniência, usa-se uma forma abreviada para renomear atributos em uma relação intermediária:**

**`TEMP (X,Y,Z) ← π(A,B,C)(R)`**

**Os atributos A, B e C de R são renomeados para X, Y e Z em TEMP                                                                              Note que o siímobolo ← é um operador de atribuição**

</aside>

## Operações da Teoria dos Conjuntos

### 1. União U

- União de **`R U S`** inclui todas as tuplas que estão em R e S
- As relações R e S devem ser compativeis por tipo
    1. R e S devem possuir o mesmo número de atributos
    2. Cada par de atributos correspondentes deve ser de tipo
    compatível (i.e. dom(Ai)=dom(Bi) para i=1, 2, ..., n)

### Exemplo 1: União Simples

**Tabela 1: Alunos_Matemática**

| ID | Nome |
| --- | --- |
| 1 | Ana |
| 2 | Bruno |
| 3 | Carla |

**Tabela 2: Alunos_Física**

| ID | Nome |
| --- | --- |
| 2 | Bruno |
| 3 | Carla |
| 4 | Diego |
- **Consulta**: Unir os alunos das duas disciplinas.
    
    **`Alunos_Matemática ∪ Alunos_Física`**
    

**Resultado**:

| ID | Nome |
| --- | --- |
| 1 | Ana |
| 2 | Bruno |
| 3 | Carla |
| 4 | Diego |

### Exemplo 2:

- Para recuperar os números de seguridade social de todos os
funcionários que trabalham no departamento 5 **`(RESULT1)`** ou
supervisionam diretamente um empregado que trabalha no
departamento 5 **`(RESULT2)`**

**Tabela: Funcionários (Employees)**

| SSN | Nome | Departamento | Supervisor_SSN |
| --- | --- | --- | --- |
| 123456789 | João | 5 | 987654321 |
| 987654321 | Maria | 4 | 123456789 |
| 111111111 | Ana | 5 | 222222222 |
| 222222222 | Bruno | 3 | 333333333 |
| 333333333 | Carla | 5 | 444444444 |

### Passo 1: Seleção e Projeção para `RESULT1` - Funcionários no Departamento 5

- **Consulta:** Selecionar os SSNs dos funcionários que trabalham no departamento 5.
    
    **`DEP5_EMPS ← σ dno=5 (EMPLOYEE)`**
    

**Resultado `DEP5_EMPS`:**

| SSN | Nome | Departamento | Supervisor_SSN |
| --- | --- | --- | --- |
| 123456789 | João | 5 | 987654321 |
| 111111111 | Ana | 5 | 222222222 |
| 333333333 | Carla | 5 | 444444444 |

**`RESULT1 ← π ssn(DEMP5_EMPS)`**

**Resultado `RESULT1`:**

| SSN |
| --- |
| 123456789 |
| 111111111 |
| 333333333 |

### Passo 2: Seleção e Projeção para `RESULT2` - Funcionários que Supervisionam Empregados no Departamento 5

- **Consulta:** Selecionar os SSNs dos supervisores que supervisionam diretamente um empregado que trabalha no departamento 5.
    
    **`RESULT2(SSN) ← πsuperssn(DEP5_EMPS)`**
    

**Resultado `RESULT2`:**

| SSN |
| --- |
| 987654321 |
| 222222222 |
| 444444444 |

### Passo 3: União de `RESULT1` e `RESULT2`

- **Consulta:** Unir **`RESULT1`** e **`RESULT2`** para obter todos os SSNs dos funcionários que satisfazem qualquer uma das duas condições.
    
    **`RESULT1 U RESULT2`**
    

**Resultado:**

| SSN |
| --- |
| 123456789 |
| 111111111 |
| 333333333 |
| 987654321 |
| 222222222 |
| 444444444 |

<aside>
<img src="https://www.notion.so/icons/exclamation-mark_purple.svg" alt="https://www.notion.so/icons/exclamation-mark_purple.svg" width="40px" /> **Note que foi necessário ao projetar apenas o superssn em `RESULT2` houve uma alteração no nome para ssn para que na operação `R1 U R2` não haja conflito de compatibilidade**

</aside>

### 2. INTERSEÇÃO **∩** (INTERSECTION)

- O resultado da operação **`R ∩ S`** é uma relação que inclui
todas as tuplas que estão em ambas as relações R e S
- As duas relações R e S devem ser de tipos compatíveis
- É comutativa

### Exemplo:

**Tabela 1: Estudantes_Matemática**

| ID | Nome | Curso |
| --- | --- | --- |
| 101 | Ana | Matemática |
| 102 | Bruno | Matemática |
| 103 | Carla | Matemática |
| 104 | Diego | Engenharia Elétrica |

**Tabela 2: Estudantes_Física**

| ID | Nome | Curso |
| --- | --- | --- |
| 103 | Carla | Matemática |
| 104 | Diego | Engenharia Elétrica |
| 105 | Elisa | Física |
| 106 | Fabio | Física |

### Passo 1: Verificação de Compatibilidade

- As duas tabelas possuem os mesmos atributos (**`ID`, `Nome`, `Curso`**) com os mesmos nomes e tipos de dados, portanto, podem ser usadas para a operação de interseção, caso não uma renomeação resolveria

### Passo 2: Realizando a Interseção

**`Resultado = Estudantes_Matemática ∩ Estudantes_Física`**

**Resultado:**

| ID | Nome | Curso |
| --- | --- | --- |
| 103 | Carla | Matemática |
| 104 | Diego | Engenharia Elétrica |

### 3. DIFERENÇA — (DIFFERENCE)

- O resultado da operação **`R – S`** é uma relação que inclui
todas as tuplas contidas em R, mas que não estão
em S.
- As duas relações R e S devem ser de tipos compatíveis

### Exemplo:

**Tabela 1: Alunos_Inscritos**

| ID | Nome | Curso |
| --- | --- | --- |
| 101 | Ana | Matemática |
| 102 | Bruno | Física |
| 103 | Carla | Matemática |
| 104 | Diego | Engenharia Elétrica |
| 105 | Elisa | Física |

**Tabela 2: Alunos_Aprovados**

| ID | Nome | Curso |
| --- | --- | --- |
| 102 | Bruno | Física |
| 103 | Carla | Matemática |
| 105 | Elisa | Física |

### Passo 1: Verificação de Compatibilidade

- As duas tabelas têm os mesmos atributos (**`ID`, `Nome`, `Curso`)** com os mesmos nomes e tipos de dados, portanto, podem ser usadas para a operação de diferença.

### Passo 2: Realizando a Diferença

**`Resultado = Alunos_Inscritos − Alunos_Aprovados`**

**Resultado:**

| ID | Nome | Curso |
| --- | --- | --- |
| 101 | Ana | Matemática |
| 104 | Diego | Engenharia Elétrica |

**`Resultado = Alunos_Aprovados − Alunos_Inscritos`**

**Resultado**:

| ID | Nome | Curso |
| --- | --- | --- |

<aside>
<img src="https://www.notion.so/icons/exclamation-mark_purple.svg" alt="https://www.notion.so/icons/exclamation-mark_purple.svg" width="40px" /> **Note que a operação `Alunos_inscritos - Alunos_aprovados` ≠ `Alunos-aprovados - Alunos_inscritos` Logo a operação de diferenção NÃO É COMUTATIVA**

</aside>

### 4. Produto Cartesiano X

- Produz tuplas a partir de duas relações de forma combinatoria
    
    **`Estrutura: R(A1, A2, ……, AN) X S(B1, B2, ……, BN)`**
    
    **`Resultado: Q(A1,A2, …., AN, B1, B2, …., BN)`**
    

### Exemplo:

**Tabela: EMPLOYEE**

| SSN | FNAME | LNAME | SEX |
| --- | --- | --- | --- |
| 123456789 | João | Silva | M |
| 987654321 | Maria | Souza | F |
| 111111111 | Ana | Costa | F |
| 222222222 | Bruno | Lima | M |

**Tabela: DEPENDENT**

| ESSN | DEPENDENT_NAME | RELATIONSHIP |
| --- | --- | --- |
| 123456789 | Pedro | Filho |
| 987654321 | Sofia | Filha |
| 111111111 | Carlos | Marido |
| 222222222 | Fernanda | Filha |

### Passo 1: Seleção de Empregados Femininos

**`FEMALE_EMPS ← σ SEX = ‘F’(EMPLOYEE)`**

**Resultado `FEMALE_EMPS`:**

| SSN | FNAME | LNAME | SEX |
| --- | --- | --- | --- |
| 987654321 | Maria | Souza | F |
| 111111111 | Ana | Costa | F |

### Passo 2: Projeção dos Nomes e SSNs das Funcionárias

**`EMPNAMES ←π fname, lname, ssn (FEMALE_EMPS)`**

**Resultado `EMPNAMES`:**

| FNAME | LNAME | SSN |
| --- | --- | --- |
| Maria | Souza | 987654321 |
| Ana | Costa | 111111111 |

### Passo 3: Produto Cartesiano entre `EMPNAMES` e `DEPENDENT`

**`EMP_DEPENDENTS ← EMPNAMES x DEPENDENT`**

**Resultado `EMP_DEPENDENTS`:**

| FNAME | LNAME | SSN | ESSN | DEPENDENT_NAME | RELATIONSHIP |
| --- | --- | --- | --- | --- | --- |
| Maria | Souza | 987654321 | 123456789 | Pedro | Filho |
| Maria | Souza | 987654321 | 987654321 | Sofia | Filha |
| Maria | Souza | 987654321 | 111111111 | Carlos | Marido |
| Maria | Souza | 987654321 | 222222222 | Fernanda | Filha |
| Ana | Costa | 111111111 | 123456789 | Pedro | Filho |
| Ana | Costa | 111111111 | 987654321 | Sofia | Filha |
| Ana | Costa | 111111111 | 111111111 | Carlos | Marido |
| Ana | Costa | 111111111 | 222222222 | Fernanda | Filha |

### Passo 4: Seleção das Tuplas Onde SSN = ESSN

**`ACTUAL_DEPS ← σ ssn=essn(EMP_DEPENDENTS)`**

**`RESULT ← π fname, lname, dependet_name (ACTUAL_DEPS)`**

**Resultado `RESULT`:**

| FNAME | LNAME | DEPENDENT_NAME |
| --- | --- | --- |
| Maria | Souza | Sofia |
| Ana | Costa | Carlos |
- **`RESULT`** agora conterá o nome das funcionárias e seu(s)
respectivo(as) dependentes
- Produto Cartesiano com significado!
