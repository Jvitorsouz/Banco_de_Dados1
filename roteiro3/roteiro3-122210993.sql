CREATE TYPE estados AS ENUM ('PB', 'PE', 'RN', 'MA', 'BA', 'SE', 'CE', 'AL', 'PI');

CREATE TABLE farmacia(
    bairro VARCHAR(10),
    cidade VARCHAR(20),
    -- não é necessario verificar se o valor fornecido é valido ou não pois o enum so aceita valores que estão dentro do conjunto
    estado estados,
    id_farmacia SERIAL PRIMARY KEY,
    tipo CHAR(1) NOT NULL,
    gerente CHAR(11) NOT NULL,
    tipo_gerente CHAR(1) NOT NULL,

    CONSTRAINT tipo_check CHECK(tipo='S' OR tipo='F'),

    CONSTRAINT fk_farmacia FOREIGN KEY(gerente, tipo_gerente) REFERENCES funcionario(cpf, tipo),
    CONSTRAINT tipo_gerente_check CHECK(tipo_gerente='A' OR tipo_gerente='F'),
    CONSTRAINT gerente_unique UNIQUE(gerente),
    CONSTRAINT bairro_unique UNIQUE(bairro),
    CONSTRAINT tipo_exclude EXCLUDE USING gist(tipo WITH=) WHERE (tipo='S')
    
);


CREATE TABLE funcionario(
    nome VARCHAR(30),
    cpf CHAR(11) PRIMARY KEY,
    tipo CHAR(1) NOT NULL,
    id_farmacia SERIAL,

    CONSTRAINT fk_funcionario FOREIGN KEY (id_farmacia) REFERENCES farmacia(id_farmacia),
    CONSTRAINT tipo_valor_check CHECK(tipo='V' OR tipo='F' OR tipo='E' OR tipo='C' OR tipo='A'),
    --para que consiga referenciar o par cpf/tipo em farmacia
    CONSTRAINT cpf_tipo_unique UNIQUE(cpf, tipo)
);

--FARMACIA NÃO PODE ESTA ALOCADO EM NENHUMA FARMACIA, COMO USEI SERIAL ELE NÃO DEIXA ENTRAR COM VALORES NULL
ALTER TABLE funcionario ALTER COLUMN id_farmacia DROP NOT NULL;

CREATE TABLE medicamento(
    nome CHAR(30) PRIMARY KEY,
    valor FLOAT,
    vende_com_receita BOOLEAN NOT NULL,

    CONSTRAINT nome_venda_com_receita_unique UNIQUE(nome, vende_com_receita)
);

CREATE TABLE venda(
    id_venda SERIAL,
    cpf_cliente CHAR(11) NOT NULL,
    cpf_vendedor CHAR(11) NOT NULL,
    tipo_vendedor CHAR(1) NOT NULL,
    id_medicamento CHAR(30) NOT NULL,
    venda_com_receita BOOLEAN NOT NULL,
    valor FLOAT,


    CONSTRAINT fk_venda_cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
    CONSTRAINT fk_venda_cpf_vendedor FOREIGN KEY (cpf_vendedor, tipo_vendedor) REFERENCES funcionario(cpf, tipo) ON DELETE RESTRICT,
    CONSTRAINT tipo_vendedor_check CHECK(tipo_vendedor='V'),
    CONSTRAINT fk_venda_medicamento FOREIGN KEY (id_medicamento, venda_com_receita) REFERENCES medicamento(nome, vende_com_receita) ON DELETE RESTRICT,
    CONSTRAINT receita_cliente_check CHECK(venda_com_receita = 'true' AND cpf_cliente IS NOT NULL),
    --pelo fato de existir dois atributos serial em entrega
    CONSTRAINT id_venda_unique UNIQUE(id_venda)

);

CREATE TABLE entrega(
    -- na relação tabela já tem cliente então não é necessario guardar essa informação aqui
    id_endereco SERIAL,
    id_venda SERIAL,

    CONSTRAINT fk_entrega FOREIGN KEY (id_endereco) REFERENCES cliente_endereco(id),
    CONSTRAINT fk_entrega_venda FOREIGN KEY (id_venda) REFERENCES venda(id_venda)
);

CREATE TABLE cliente(
    nome CHAR(20),
    cpf CHAR(11) PRIMARY KEY,
    telefone CHAR(11),
    email VARCHAR(30),
    idade INT,

    CONSTRAINT idade_check CHECK(idade > 17)
);

CREATE TABLE cliente_endereco(
    id SERIAL PRIMARY KEY,
    bairro VARCHAR(10) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    rua CHAR(30) NOT NULL,
    numero INT NOT NULL,
    tipo CHAR(1) NOT NULL,
    --pelo fato de não puder cadastrar entregas sem um cliente cadastrado
    id_cliente CHAR(11) NOT NULL,

    CONSTRAINT fk_cliente_endereco FOREIGN KEY (id_cliente) REFERENCES cliente(cpf),
    CONSTRAINT tipo_cliente_endereco CHECK(tipo='R' OR tipo='T' OR tipo='O')

);
