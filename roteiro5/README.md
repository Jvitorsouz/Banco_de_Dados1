# ROTEIRO 5 - EXPLICAÇÃO

1. **Retorne quantas funcionárias estão cadastradas:**

```sql
SELECT COUNT(*) FROM employee WHERE sex='F';
```

- Como employee guarda a o sex do funcionario para diferenciar de masculinos para feminino podemos usar uma função de agregação para contar todas * as tuplas de employee onde o sex é igual a F.

---

2. **Retornar a média de salário dos funcionários homens que moran no estado do Texas (TX)**

```sql
SELECT AVG(salary) FROM employee WHERE sex='M' AND address LIKE '%TX';
```

- `AVG` → Retorna a media de todos os salarios cujo a condição where é verdadeira.
- `Like` → é utilizado para realizar buscaas dentro de uma tabela que correspondem a um padrão específico, nesse caso está sendo usado no address, porque os endereços cadastrados no banco todos terminam com a sigla do estado.

---

3. **Retornar os ssn dos supervisores e a quantidade de funcionarios que cada um deles supervisiona (contar também os que não são supervisionados por nunguem). Ordenar o resultado pela quantidade**
    
    `Primeira posivel solução:`
    
    ```sql
    SELECT S.ssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados 
    FROM employee S JOIN employee E ON S.ssn = E.superssn 
    GROUP BY S.ssn 
    ORDER BY COUNT(*) ASC;
    ```
    
    <aside>
    <img src="https://www.notion.so/icons/code_green.svg" alt="https://www.notion.so/icons/code_green.svg" width="40px" /> SAÍDA:
    
    ssn_supervisor | qtd_supervisionados
    ----------------+---------------------
    555555500      |                   1
    333333300      |                   1
    666666612      |                   1
    666666610      |                   1
    666666601      |                   1
    666666611      |                   1
    666666604      |                   1
    666666607      |                   1
    987654321      |                   2
    888665555      |                   2
    666666603      |                   2
    666666600      |                   2
    222222201      |                   2
    111111100        |                   3
    333445555      |                   3
    222222200      |                   3
    444444400      |                   3
    666666602      |                   3
    
    A saída está quase completa apenas o que não foi colocado na saída foi os funcionarios que não são supervisionados, como estamos tratando de funcionarios e funcionario está depois do join se usarmos um RIGHT JOIN os funcionarios sem supervisores também são incluidos.
    
    **Porque usar COUNT(*) e  não COUNT(E.superssn) já que estamos contando os funcionarios ?! É bem simples COUNT(E.superssn) está contando o número de ocorrências onde a coluna E.superssn não é NULL logo o COUNT(coluna) ignora valores NULL.** 
    
    </aside>
    

`Primeira solução corrigida:`

```sql
SELECT S.ssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados 
FROM employee S RIGHT JOIN employee E ON S.ssn = E.superssn 
GROUP BY S.ssn 
ORDER BY COUNT(*) ASC;
```

- Logo nessa solução os funcionarios com superssn NULL vão ser inclusos na saída.

### Porque usar `JOIN` e não uma claúsula `WHERE`:

`Possível solução com WHERE:`

```sql
SELECT S.ssn, COUNT(*) 
FROM employee E, employee S 
WHERE S.ssn = E.superssn 
GROUP BY S.ssn 
ORDER BY COUNT(*);
```

- A condição `WHERE S.ssn = E.superssn` funciona como um **INNER JOIN implícito**. Isso significa que a consulta retorna apenas os resultados onde há uma correspondência exata entre `S.ssn`  e `E.superssn`
- Assim, a consulta só trará supervisores que estão de fato supervisionando algum funcionário, porque a condição `WHERE` filtra as linhas sem correspondência.

### Solução `SEM RIGHT JOIN`:

```sql
SELECT superssn AS ssn_supervisor, COUNT (*) AS qtd_supervisionados 
FROM employee 
GROUP BY superssn 
ORDER BY qtd_supervisionados ASC;
```

### Por que não precisa de `JOIN`:

- **Tudo está em uma única tabela**: A própria tabela `employee` já contém todas as informações para fazer a contagem. Cada linha tem tanto o SSN do empregado quanto o SSN do supervisor (na coluna `superssn`).
- **`JOIN` seria desnecessário**: Como o relacionamento entre empregados e supervisores está contido dentro da própria tabela (através da coluna `superssn`), não há necessidade de `JOIN` com outra tabela.

---

4. **Para cada funcionário que supervisiona alguem, retornar seu nome e a quantidade de funcionários que supervisiona. O resultado deve ser ordenado pela quantidade de funcionários supervisionados. Não é permitido cáusula WHERE**
    
    ```sql
    SELECT S.fname, COUNT(*) 
    FROM employee S JOIN employee E ON S.ssn = E.superssn 
    GROUP BY S.fname 
    ORDER BY COUNT(*);
    ```
    
    - Como queremos cada funcionario e quantidade de funcionatios que ele supervisiona, a `função join` junta o funcionario ao seu supervisor, e precisamos fazer a contagem de todas essas ocorrências agrupando pelo o nome do funcionario.
    
    ---
    
5. **Faça uma consulta equivalente à anterior, porém considerando os funcionários que não possuem supervisor, Não deve também ter cláusula WHERE**
    
    ```sql
    SELECT S.fname, COUNT(*) 
    FROM employee S RIGHT JOIN employee E ON S.ssn = E.superssn 
    GROUP BY S.fname 
    ORDER BY COUNT(*);
    ```
    
    - Simples como precisamos também fazer a contagem dos funcionarios que não são supervisionador bastar usar um dos `OUTER JOIN`, como queremos saber sobre os funcionarios e ele vem depois do `JOIN` a sua direita, logo é necessário usar um `RIGHT JOIN`
    
    ---
    
6. **Retornar a quantidade de funcionários que trabalham nos projetos que contém menos funcionarios:**
    
    `Envolve subconsulta`
    
    1. Precisamos primeiro saber a quantidade de funcionarios para cada projeto:
        
        ```sql
        SELECT COUNT(*) FROM works_on GROUP BY pno;
        ```
        
        - Aqui estaram as contagens de funcionarios para cada projeto e sendo agrupado pelo projeto
    2. Basta saber qual o minino do resultado dessa consulta
        
        ```sql
        SELECT MIN(count) AS qtd 
        FROM (SELECT COUNT(*) 
        	FROM works_on 
        GROUP BY pno) AS subconsulta;
        ```
        

---

7. **Faça uma consulta equivalente à anterior, porém retorne também o número do projeto.**

```sql
SELECT pno, COUNT(*) 
FROM works_on 
GROUP BY pno 
HAVING COUNT(*) = (SELECT MIN(count) 
			FROM (SELECT COUNT(*) 
				FROM works_on 
				GROUP BY pno) AS subconsulta) 
ORDER BY pno ASC;
```

`Explicando consulta:`

- Queremos retornar os projetos cujo o numero de funcionarios seja igual a o MIN().
- Na questão anterior definimos esse minimo basta apenas reultilizado uma vez que eu sei como achamos esse mínimo.
- Sabendo o minimo precisamos projetar o pno e a contagem de todas as ocorrencias desse pno com o `COUNT(*)`  tudo isso vindo da tabela works_on e sendo agrupados pelo pno que é o número do projeto.
- Uma vez sabendo o min podemos colocar uma condição `HAVING` para que o `COUNT(*)` seja igual ao `MIN()` .

`OBS: caso use HAVING tem que ser depois do GROUP BY`

---

8. **Retornar  a média salarial por projeto:**
    
    1. Queremos a média salarial por projeto, uma vez que na tabela works_on armazena tanto o ssn do funcionário e o n° do projeto, e o salario do funcionario está na tabela employee, precisamos fazendo uma junção de works_on com employee a partir da igualdade do ssn
    
    1. Uma vez tendo essa junção podemos pegar a media salarial para cada projeto e agrupar pelo numero do projeto
    
    ```sql
     SELECT W.pno AS Num_proj, AVG(E.salary) AS media_sal 
     FROM works_on W JOIN employee E ON W.essn = E.ssn 
     GROUP BY W.pno;
    ```
    

---

9. **Alterar a consulta anterior para retornar também os nomes dos projetos:**
    
    ```sql
    SELECT W.pno AS Num_proj, P.pname AS proj_name, AVG(E.salary) AS media_sal 
    FROM (works_on W JOIN employee E ON W.essn = E.ssn) --PRIMEIRA JUNÇÃO
    JOIN project P ON W.pno = P.pnumber -- SEGUNDA JUNÇÃO COM O RESULTADO DA PRIMEIRA JUNÇÃO
    GROUP BY W.pno, P.pname;
    ```
    
    - Os nomes do projetos estão na tabela Project uma vez que eu tenho o numero de projeto na minha relação da questão anterior, basta eu fazer um JOIN do resultado anterior com a tabela project com a condicao de junção de fkey para pkey
    - OBS: Ao declarar no select que eu tbm quero o nome do projeto e uma vez que ela não faz parte da relação onde a função de agregação está sendo atribuida ao atributo  é necessário declarar o pname na cláusula `GROUP BY`

---

10. **Observe que o projeto 92 tem a maior média salarial. Faça uma consulta para retornar os funcionários que não trabalham neste projeto mas que possuam salário maior do que todos os funcionários que trabalham neste projeto. Basta retornar o primeiro nome e o salário destes funcionários. O numero 92 pode aparecer na consulta:**
    
    ```sql
    SELECT E.fname, E.salary 
    FROM employee E 
    WHERE E.salary  > ALL (SELECT S.salary 
    				FROM works_on W 
    				JOIN Employee S ON S.ssn = W.essn AND W.pno = '92');
    ```
    
    - Primeiro precisamos saber quais são todos os salarios do funcionarios que trabalham no projeto ‘92’, juntando works_on com employee conseguimos pegar todos os funcionarios o essn de works_on é igual a o ssn de employee `AND` pnum é igual a 92, sendo esta ultima uma condição de filtragem
    - Tendo uma vez os salarios em mãos, que sera resultado de uma consulta agora precisamos apenas dos nomes e salarios do funcionarios que tenham seu salario maior que `ALL(todos)` os salarios presentes na subconsulta

---

11. **Retornar a quantidade de projeto por funcionário, ordenado pela quantidade:**
    
    ```sql
    SELECT E.ssn, COUNT(W.pno) 
    FROM works_on W RIGHT JOIN employee E 
    ON W.essn = E.ssn -- CONDIÇÃO DE JUNÇÃO
    GROUP BY E.ssn 
    ORDER BY COUNT(W.pno);
    ```
    
    - Como precisamos saber o numero de projeto para todos os funcionários presentes em employee, por mais que works_on guarde o ssn do funcionario, vai existir funcionarios sem projetos que precisam ser listados também.
    - Para isso é necessário fazer um `RIGHT JOIN` com employee a direita para as tuplas onde a condição for `NULL` ser consideradas.
    - O `COUNT` precisa ser com `W.pno` uma vez que vai existir funcionarios sem projetos.

---

12. **Retornar a quantidade de funcionários por projeto (incluindo os funcionarios sem projeto) retornar apenas os projetos que possuem menos de 5 funcionarios, orderna pela quantidade.**
    
    ```sql
    SELECT pno, count 
    FROM (SELECT W.pno, COUNT(*) 
    		FROM employee E LEFT JOIN works_on W 
    		ON E.ssn = W.essn GROUP BY W.pno) AS sub 
    WHERE count < 5 ORDER BY count;
    ```
    
    - Primeiro precisamos achar a quantidade de funcionarios por cada projeto, isso vai resultar em uma consulta interna
    - Depois precisamos filtrar em uma consulta externa onde as contagens de funcionarios por projeto é menor que 5

---

13. **Usando consultas aninhadas e sem usar junções, formule uma consulta para retornar os primeiros nomes dos funcionários que trabalham no(s) projetos localizados em ‘Sgarland’ e que possuem dependentes**
    
    1. Primeiro retornar o numero projeto cujo a localização é em `‘Sugarland’`
    
    ```sql
    SELECT pnumber 
    FROM project 
    WHERE plocation = 'Sugarland';
    ```
    
    1. Retornar agora os essn dos projetos cujo o pno é igual a consulta anterior
    
    ```sql
    SELECT essn 
    FROM works_on 
    WHERE pno = (SELECT pnumber 
     		 FROM project 
    		 WHERE plocation = 'Sugarland');
    ```
    
    1. Retonar o essn em dependent que estão presentes na consulta anterior
    
    ```sql
    	SELECT DISTINCT essn
    	 FROM dependent 
    	 WHERE essn IN (SELECT essn 
    			FROM works_on 
    			WHERE pno = (SELECT pnumber 													     FROM project
    				     WHERE plocation = 'Sugarland'));
    
    ```
    
    1. Por ultimo retornar o primeiro nome dos funcionarios que o ssn está na ultima consulta
    
    ```sql
    SELECT fname 
    FROM employee 
    WHERE ssn IN (SELECT DISTINCT essn 
    		  FROM dependent 
    		   WHERE essn IN (SELECT essn 
    				  FROM works_on 
    				  WHERE pno = (SELECT pnumber 
				  	       FROM project
    					       WHERE plocation = 'Sugarland')));
    
    ```
