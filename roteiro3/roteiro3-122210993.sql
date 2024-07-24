CREATE TABLE farmacia(
    bairro VARCHAR(10),
    cidade VARCHAR(20),
    estado VARCHAR(15),
    id_farmacia SERIAL,
    tipo CHAR(6),
    gerente CHAR(11),
);

CONSTRAINT fk_farmacia FOREIGN KEY (gerente) REFERENCES funcionario(cpf)

CREATE TABLE funcionario(
    nome VARCHAR(30),
    cpf CHAR(11) PRIMARY KEY,
    tipo CHAR(1),
    id_farmacia SERIAL,

    CONSTRAINT tipo_valor_check CHECK(tipo='V' OR tipo='F' OR tipo='E' OR tipo='C' OR tipo='A')
);

CONSTRAINT fk_funcionario FOREIGN KEY (id_farmacia) REFERENCES farmacia(id_farmacia),
CREATE TABLE medicamento(

);

CREATE TABLE vendas(

);

CREATE TABLE entrega(

);

CREATE TABLE cliente(

);

CREATE TABLE cliente_endereco(
    bairro VARCHAR(10),
    cidade VARCHAR(20),
    estado VARCHAR(15)

);
