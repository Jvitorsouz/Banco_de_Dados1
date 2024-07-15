CREATE TABLE automovel(
    modelo_automovel VARCHAR(20),
    marca_automovel VARCHAR(20),
    ano_automovel INTEGER,
    placa_automovel VARCHAR(20) NOT NULL,
    dono_automovel CHAR(11) NOT NULL,
    PRIMARY KEY (placa_automovel),
    FOREIGN KEY (dono_automovel) REFERENCES segurado(cpf_segurado)
);

CREATE TABLE segurado(
    nome_segurado CHAR(20),
    cpf_segurado CHAR(11) NOT NULL,
    telefone_segurado VARCHAR(20),
    PRIMARY KEY (cpf_segurado)
);

CREATE TABLE perito(
    nome_perito CHAR(50),
    cpf_perito CHAR(11) NOT NULL,
    telefone_perito VARCHAR(20),
    especialidade_perito TEXT,
    oficina_perito VARCHAR(70) NOT NULL,
    PRIMARY KEY (cpf_perito),
    FOREIGN KEY (oficina_perito) REFERENCES oficina (nome_oficina, endereco_oficina)
);

CREATE TABLE oficina(
    nome_oficina VARCHAR(20) NOT NULL,
    endereco_oficina VARCHAR(50)  NOT NULL,
    telefone_oficina VARCHAR(20),
    gerente_oficina VARCHAR(50),
    servicos_oficina TEXT,
    PRIMARY KEY (nome_oficina, endereco_oficina)
);

CREATE TABLE seguro(
    id_segurado CHAR(11) NOT NULL,
    titular_seguro CHAR(11),
    numero_apolice VARCHAR(20) NOT NULL,
    data_inicio DATA,
    data_fim DATA,
    valor_seguro NUMERIC,
    -- Indica se o  seguro está em data valida
    status_seguro BOOLEAN,
    PRIMARY KEY (numero_apolice),
    FOREIGN KEY (id_segurado) REFERENCES segurado(cpf_segurado)
);

CREATE TABLE sinistro(
    numero_sinistro INTEGER NOT NULL,
    data_sinistro DATA,
    id_seguro VARCHAR(20) NOT NULL,
    id_oficina VARCHAR(70) NOT NULL,
    id_pericia VARCHAR(30) NOT NULL,
    valor_sinistro NUMERIC,
    PRIMARY KEY (numero_sinistro),
    FOREIGN KEY (id_seguro) REFERENCES seguro(numero_apolice),
    FOREIGN KEY (id_oficina) REFERENCES oficina(nome_oficina, endereco_oficina),
    FOREIGN KEY (id_perito) REFERENCES pericia (id_perito, data_pericia)
);

CREATE TABLE pericia(
    data_pericia DATA,
    id_perito CHAR(11) NOT NULL,
    resultado_pericia TEXT,
    valor_pericia NUMERIC,
    FOREIGN KEY (id_perito) REFERENCES perito(cpf),
    PRIMARY KEY (id_perito, data_pericia)
);

CREATE TABLE reparo(
    valor_reparo NUMERIC,
    descricao TEXT,
    id_sinistro INTEGER NOT NULL,
    FOREIGN KEY (id_sinistro) REFERENCES sinistro(numero_sinistro),
    PRIMARY KEY (descricao, id_sinistro)
);

