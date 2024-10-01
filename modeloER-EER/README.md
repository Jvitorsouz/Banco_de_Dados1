# MODELO ER - EER

# 1. ER

### **ER ⇒ Entidade - Relacionamento**

- **Entidades** ⇒ Representam objetos/coisas do mini mundo, tem seu conjunto de atributos e cada atributo tem seu domínio, cada entidade possuem seu conjunto de chaves candidatas, usadas para identificar a entidade.
    - **Entidade Fraca** ⇒ Não tem é identificado por uma chave, ela passar a ser identificada a partir de outro relacionamento.
- **Relacionamentos** ⇒ Representam relacionamento entre entidades, e podem conter atributos.

**Os atributos podem ser representados em três formas:**

- **Simples**
- **Compostos** ⇒ que possuem uma hierarquia, e posteriormente quando for mapeado para o modelo lógico podem ser representados como entidades.
- **Multivalorados** ⇒ São atributos que podem assumir mais de um valor, também podem virar entidades quando passar pelo mapeamento lógico.

### Exemplo de entidades:

![Aula08_ModeloER_Ch03_page-0015.jpg](MODELO%20ER%20-%20EER%20dfe608a518ca4da98405e0545fe51884/8337367e-8861-4c2b-8ebf-c071b08c572d.png)

**O modelo ER possui 3 conceitos ⇒ Entidade, Atributos e Relacionamentos.**

## Relacionamentos:

- **Um relacionamento, relaciona duas ou mais entidades, a quantidade de entidades representa o grau do relacionamento.**

O conjunto de relacionamentos representa o estado atual do banco de dados.

**Restrições em relacionamentos:**

- Um-para-um ⇒ [1:1]
- Um-para-Muitos ⇒ [1:M] ou Muitos-para-Um ⇒ [M:1], os atributos de relacionamento podem ser associados ao lado M.
- Muitos para muitos ⇒ [M:N], maioria dos atributos de relacionamento aparecem aqui.

**OBS ⇒ Há como ter participação zero de uma entidade em um relacionamento.**

- **Há como ter participação total e participação parcial**:
    - **`Participação Total`** é representado por linha dupla, ou seja, não ha como ter participação zero da entidade.
    - **`Participação parcial`** é representado por linha simples, e pode ter participação zero da entidade.

Exemplo [1:1]:

![Aula08_ModeloER_Ch03_page-0025.jpg](MODELO%20ER%20-%20EER%20dfe608a518ca4da98405e0545fe51884/64f01c26-d6fc-4bd6-b3d1-9b5dc5426a97.png)

**Exemplo de diagrama ER:**

![Aula08_ModeloER_Ch03_page-0030.jpg](MODELO%20ER%20-%20EER%20dfe608a518ca4da98405e0545fe51884/9aa54dce-2a1d-4a16-a2d1-022f496f0b10.png)

**Exemplo de diagrama ER com notação (min, max):**

![Aula08_ModeloER_Ch03_page-0038.jpg](MODELO%20ER%20-%20EER%20dfe608a518ca4da98405e0545fe51884/d2572b09-ca4c-47b2-abc1-b1ccd312783f.png)

### Sumário da notação de diagramas ER

![Aula08_ModeloER_Ch03_page-0040.jpg](MODELO%20ER%20-%20EER%20dfe608a518ca4da98405e0545fe51884/aeaf6349-a398-409f-9ad5-2cc8003014ce.png)
