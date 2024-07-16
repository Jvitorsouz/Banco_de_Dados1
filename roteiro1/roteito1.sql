
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