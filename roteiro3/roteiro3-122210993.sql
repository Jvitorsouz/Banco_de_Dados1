CREATE TYPE estados AS ENUM ('PB', 'PE', 'RN', 'MA', 'BA', 'SE', 'CE', 'AL', 'PI');

CREATE TABLE farmacia(
    bairro VARCHAR(10),
    cidade VARCHAR(20),
    estado estados,
    id_farmacia SERIAL PRIMARY KEY,
    tipo CHAR(1),
    gerente CHAR(11),
    tipo_gerente CHAR(1),

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
    tipo CHAR(1),
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
    vende_com_receita BOOLEAN

    CONSTRAINT nome_venda_com_receita_unique UNIQUE(nome, vende_com_receita)
);

CREATE TABLE venda(
    id_venda SERIAL,
    cpf_cliente CHAR(11),
    cpf_vendedor CHAR(11),
    tipo_vendedor CHAR(1),
    id_medicamento CHAR(30),
    venda_com_receita BOOLEAN,


    CONSTRAINT fk_venda_cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
    CONSTRAINT fk_venda_cpf_vendedor FOREIGN KEY (cpf_vendedor, tipo_vendedor) REFERENCES funcionario(cpf, tipo) ON DELETE RESTRICT,
    CONSTRAINT tipo_vendedor_check CHECK(tipo_vendedor='V'),
    CONSTRAINT fk_venda_medicamento FOREIGN KEY (id_medicamento, venda_com_receita) REFERENCES medicamento(nome, vende_com_receita),
    CONSTRAINT receita_cliente_check CHECK(venda_com_receita = 'true' AND cpf_cliente IS NOT NULL)

);

CREATE TABLE entrega(
    rua_endereco CHAR(30),
    numero_endereco INT,
    bairro_endereco VARCHAR(10),

    CONSTRAINT fk_entrega FOREIGN KEY (rua_endereco, numero_endereco, bairro_endereco) REFERENCES cliente_endereco(rua, numero, bairro)

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
    bairro VARCHAR(10),
    cidade VARCHAR(20),
    rua CHAR(30),
    numero INT,
    tipo CHAR(1),
    --pelo fato de não puder cadastrar entregas sem um cliente cadastrado
    id_cliente CHAR(11) NOT NULL,

    CONSTRAINT pk_cliente_endereco PRIMARY KEY(rua, numero, bairro),
    CONSTRAINT fk_cliente_endereco FOREIGN KEY (id_cliente) REFERENCES cliente(cpf),
    CONSTRAINT tipo_cliente_endereco CHECK(tipo='R' OR tipo='T' OR tipo='O')

);
