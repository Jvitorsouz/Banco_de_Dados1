-- QUESTÃO 1 E 2:

CREATE TABLE automovel(
    modelo_automovel VARCHAR(20),
    marca_automovel VARCHAR(20),
    ano_automovel INTEGER,
    placa_automovel VARCHAR(20)
);

CREATE TABLE segurado(
    nome_segurado CHAR(20),
    cpf_segurado CHAR(11),
    telefone_segurado VARCHAR(20),
    automovel_segurado VARCHAR(20)
);

CREATE TABLE perito(
    nome_perito CHAR(50),
    cpf_perito CHAR(11),
    telefone_perito VARCHAR(20),
    especialidade_perito TEXT,
    oficina_perito VARCHAR(14)
);

CREATE TABLE oficina(
    nome_oficina VARCHAR(20),
    cnpj_oficina CHAR(14),
    endereco_oficina VARCHAR(50),
    telefone_oficina VARCHAR(20),
    gerente_oficina VARCHAR(50),
    servicos_oficina TEXT
);

CREATE TABLE seguro(
    id_segurado CHAR(11),
    titular_seguro CHAR(11),
    numero_apolice VARCHAR(20),
    data_validade DATE,
    valor_seguro NUMERIC
);

CREATE TABLE sinistro(
    id_sinistro INTEGER,
    data_sinistro DATE,
    id_seguro VARCHAR(20),
    id_oficina VARCHAR(14),
    valor_sinistro NUMERIC
);

CREATE TABLE pericia(
    id_pericia INTEGER,
    data_pericia DATE,
    id_perito CHAR(11),
    id_sinistro INTEGER,
    resultado_pericia TEXT,
    valor_pericia NUMERIC
);

CREATE TABLE reparo(
    id_reparo INTEGER,
    valor_reparo NUMERIC,
    descricao TEXT,
    id_sinistro INTEGER
);


-- QUESTÃO 3:
ALTER TABLE automovel ADD CONSTRAINT pk_automovel PRIMARY KEY (placa_automovel);
ALTER TABLE segurado ADD CONSTRAINT pk_segurado PRIMARY KEY (cpf_segurado);
ALTER TABLE perito ADD CONSTRAINT pk_perito PRIMARY KEY (cpf_perito);
ALTER TABLE oficina ADD CONSTRAINT pk_oficina PRIMARY KEY (cnpj_oficina);
ALTER TABLE seguro ADD CONSTRAINT pk_seguro PRIMARY KEY (numero_apolice);
ALTER TABLE sinistro ADD CONSTRAINT pk_sinistro PRIMARY KEY (id_sinistro);
ALTER TABLE pericia ADD CONSTRAINT pk_pericia PRIMARY KEY (id_pericia);
ALTER TABLE reparo ADD CONSTRAINT pk_reparo PRIMARY KEY (id_reparo);

-- QUESTÃO 4:

-- CHAVES ESTRANGEIRAS DE SEGURADO
ALTER TABLE segurado ADD CONSTRAINT fk_segurado FOREIGN KEY (automovel_segurado) REFERENCES automovel (placa_automovel);

-- CHAVES ESTRANGEIRAS DE PERITO
ALTER TABLE perito ADD CONSTRAINT fk_perito FOREIGN KEY (oficina_perito) REFERENCES oficina (cnpj_oficina);

-- CHAVES ESTRANGEIRAS DE SEGURO
ALTER TABLE seguro ADD CONSTRAINT fk_seguro FOREIGN KEY (id_segurado) REFERENCES segurado (cpf_segurado);

-- CHAVES ESTRANGEIRAS DE SINISTRO
ALTER TABLE sinistro ADD CONSTRAINT fk_sinistro_id_seguro FOREIGN KEY (id_seguro) REFERENCES seguro (numero_apolice);
ALTER TABLE sinistro ADD CONSTRAINT fk_sinistro_id_oficina FOREIGN KEY (id_oficina) REFERENCES oficina (cnpj_oficina);

-- CHAVES ESTRANGEIRAS PERICIA
ALTER TABLE pericia ADD CONSTRAINT fk_pericia_id_perito FOREIGN KEY (id_perito) REFERENCES perito (cpf_perito);
ALTER TABLE pericia ADD CONSTRAINT fk_pericia_id_sinistro FOREIGN KEY (id_sinistro) REFERENCES sinistro (id_sinistro);

-- CHAVES ESTRANGEIRAS REPARO
ALTER TABLE reparo ADD CONSTRAINT fk_reparo FOREIGN KEY (id_sinistro) REFERENCES sinistro (id_sinistro);

-- QUESTÃO 5

-- NOT NULL AUTOMOVEL
ALTER TABLE automovel ALTER COLUMN placa_automovel SET NOT NULL;

-- NOT NULL OFICINA
ALTER TABLE oficina ALTER COLUMN cnpj_oficina SET NOT NULL;

-- NOT NULL PERICIA
ALTER TABLE pericia ALTER COLUMN id_pericia SET NOT NULL;
ALTER TABLE pericia ALTER COLUMN id_perito SET NOT NULL;
ALTER TABLE pericia ALTER COLUMN id_sinistro SET NOT NULL;

-- NOT NULL PERITO
ALTER TABLE perito ALTER COLUMN cpf_perito SET NOT NULL;

-- NOT NULL REPARO
ALTER TABLE reparo ALTER COLUMN id_reparo SET NOT NULL;

-- NOT NULL SEGURADO
ALTER TABLE segurado ALTER COLUMN cpf_segurado SET NOT NULL;
ALTER TABLE segurado ALTER COLUMN automovel_segurado SET NOT NULL;

-- NOT NULL SEGURO
ALTER TABLE seguro ALTER COLUMN id_segurado SET NOT NULL;
ALTER TABLE seguro ALTER COLUMN numero_apolice SET NOT NULL;

-- NOT NULL SINISTRO
ALTER TABLE sinistro ALTER COLUMN id_sinistro SET NOT NULL;
ALTER TABLE sinistro ALTER COLUMN id_seguro SET NOT NULL;
ALTER TABLE sinistro ALTER COLUMN id_oficina SET NOT NULL;

-- QUESTAO 6:

DROP TABLE reparo;
DROP TABLE pericia;
DROP TABLE sinistro;
DROP TABLE seguro;
DROP TABLE perito;
DROP TABLE segurado;
DROP TABLE oficina;
DROP TABLE automovel;

-- QUESTAO 7:

CREATE TABLE automovel(
    modelo_automovel VARCHAR(20),
    marca_automovel VARCHAR(20),
    ano_automovel INTEGER,
    placa_automovel VARCHAR(20) NOT NULL,

    CONSTRAINT pk_automovel PRIMARY KEY (placa_automovel)
);

CREATE TABLE segurado(
    nome_segurado CHAR(20),
    cpf_segurado CHAR(11) NOT NULL,
    telefone_segurado VARCHAR(20),
    automovel_segurado VARCHAR(20) NOT NULL,

    CONSTRAINT pk_segurado PRIMARY KEY (cpf_segurado),
    CONSTRAINT fk_segurado FOREIGN KEY (automovel_segurado) REFERENCES automovel (placa_automovel)
);

CREATE TABLE perito(
    nome_perito CHAR(50),
    cpf_perito CHAR(11) NOT NULL,
    telefone_perito VARCHAR(20),
    especialidade_perito TEXT,
    oficina_perito VARCHAR(14),

    CONSTRAINT pk_perito PRIMARY KEY (cpf_perito),
    CONSTRAINT fk_perito FOREIGN KEY (oficina_perito) REFERENCES oficina (cnpj_oficina)
);

CREATE TABLE oficina(
    nome_oficina VARCHAR(20),
    cnpj_oficina CHAR(14) NOT NULL,
    endereco_oficina VARCHAR(50),
    telefone_oficina VARCHAR(20),
    gerente_oficina VARCHAR(50),
    servicos_oficina TEXT,

    CONSTRAINT pk_oficina PRIMARY KEY (cnpj_oficina)
);

CREATE TABLE seguro(
    id_segurado CHAR(11) NOT NULL,
    titular_seguro CHAR(11),
    numero_apolice VARCHAR(20) NOT NULL,
    data_validade DATE,
    valor_seguro NUMERIC,

    CONSTRAINT pk_seguro PRIMARY KEY (numero_apolice),
    CONSTRAINT fk_seguro FOREIGN KEY (id_segurado) REFERENCES segurado (cpf_segurado)
);

CREATE TABLE sinistro(
    id_sinistro INTEGER NOT NULL,
    data_sinistro DATE,
    id_seguro VARCHAR(20) NOT NULL,
    id_oficina VARCHAR(14) NOT NULL,
    valor_sinistro NUMERIC,

    CONSTRAINT pk_sinistro PRIMARY KEY (id_sinistro),
    CONSTRAINT fk_sinistro_id_seguro FOREIGN KEY (id_seguro) REFERENCES seguro (numero_apolice),
    CONSTRAINT fk_sinistro_id_oficina FOREIGN KEY (id_oficina) REFERENCES oficina (cnpj_oficina)
);

CREATE TABLE pericia(
    id_pericia INTEGER NOT NULL,
    data_pericia DATE,
    id_perito CHAR(11) NOT NULL,
    id_sinistro INTEGER NOT NULL,
    resultado_pericia TEXT,
    valor_pericia NUMERIC,

    CONSTRAINT pk_pericia PRIMARY KEY (id_pericia),
    CONSTRAINT fk_pericia_id_perito FOREIGN KEY (id_perito) REFERENCES perito (cpf_perito),
    CONSTRAINT fk_pericia_id_sinistro FOREIGN KEY (id_sinistro) REFERENCES sinistro (id_sinistro)
);

CREATE TABLE reparo(
    id_reparo INTEGER NOT NULL,
    valor_reparo NUMERIC,
    descricao TEXT,
    id_sinistro INTEGER ,

    CONSTRAINT pk_reparo PRIMARY KEY (id_reparo),
    CONSTRAINT fk_reparo FOREIGN KEY (id_sinistro) REFERENCES sinistro (id_sinistro)
);

-- QUESTAO 10
-- Infelizmente não sei muito sobre carros então não tenho nada a adicionar =)