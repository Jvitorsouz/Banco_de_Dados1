-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-09-16 23:24:24.459

-- tables
-- Table: Contrato
CREATE TABLE Contrato (
    Time_id int  NOT NULL,
    Jogador_cpf varchar(11)  NOT NULL,
    eh_capitao boolean  NOT NULL,
    data_inicio date  NOT NULL,
    data_fim date  NOT NULL,
    CONSTRAINT Contrato_pk PRIMARY KEY (Time_id,Jogador_cpf)
);

-- Table: Jogador
CREATE TABLE Jogador (
    name varchar(30)  NOT NULL,
    cpf varchar(11)  NOT NULL,
    email varchar(50)  NOT NULL,
    phone char(11)  NOT NULL,
    CONSTRAINT Jogador_pk PRIMARY KEY (cpf)
);

-- Table: Jogador_jogo
CREATE TABLE Jogador_jogo (
    Jogador_cpf varchar(11)  NOT NULL,
    Jogo_id int  NOT NULL,
    Jogo_data date  NOT NULL,
    posicao varchar(30)  NOT NULL,
    CONSTRAINT Jogador_jogo_pk PRIMARY KEY (Jogador_cpf,Jogo_id,Jogo_data)
);

-- Table: Jogo
CREATE TABLE Jogo (
    id int  NOT NULL,
    duracao time  NOT NULL,
    data date  NOT NULL,
    CONSTRAINT Jogo_pk PRIMARY KEY (id,data)
);

-- Table: Jogou
CREATE TABLE Jogou (
    Time_id int  NOT NULL,
    ngols int  NOT NULL,
    uniforme varchar(30)  NOT NULL,
    Jogo_id int  NOT NULL,
    Jogo_data date  NOT NULL,
    CONSTRAINT Jogou_pk PRIMARY KEY (Time_id,Jogo_id,Jogo_data)
);

-- Table: Time
CREATE TABLE Time (
    estado varchar(30)  NOT NULL,
    id int  NOT NULL,
    name varchar(30)  NOT NULL,
    CONSTRAINT Time_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Contrato_Jogador (table: Contrato)
ALTER TABLE Contrato ADD CONSTRAINT Contrato_Jogador
    FOREIGN KEY (Jogador_cpf)
    REFERENCES Jogador (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Contrato_Time (table: Contrato)
ALTER TABLE Contrato ADD CONSTRAINT Contrato_Time
    FOREIGN KEY (Time_id)
    REFERENCES Time (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Jogador_jogo_Jogador (table: Jogador_jogo)
ALTER TABLE Jogador_jogo ADD CONSTRAINT Jogador_jogo_Jogador
    FOREIGN KEY (Jogador_cpf)
    REFERENCES Jogador (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Jogador_jogo_Jogo (table: Jogador_jogo)
ALTER TABLE Jogador_jogo ADD CONSTRAINT Jogador_jogo_Jogo
    FOREIGN KEY (Jogo_id, Jogo_data)
    REFERENCES Jogo (id, data)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Jogou_Jogo (table: Jogou)
ALTER TABLE Jogou ADD CONSTRAINT Jogou_Jogo
    FOREIGN KEY (Jogo_id, Jogo_data)
    REFERENCES Jogo (id, data)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Jogou_Time (table: Jogou)
ALTER TABLE Jogou ADD CONSTRAINT Jogou_Time
    FOREIGN KEY (Time_id)
    REFERENCES Time (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

-- Minha Inserções
INSERT INTO Time (estado, id, name)
VALUES ('Paraíba', 1, 'Campina Grande FC'),
       ('São Paulo', 2, 'São Paulo FC'),
       ('Rio de Janeiro', 3, 'Flamengo'),
       ('Bahia', 4, 'Bahia EC'),
       ('Minas Gerais', 5, 'Atlético Mineiro'),
       ('Paraná', 6, 'Coritiba FC'),
       ('Ceará', 7, 'Fortaleza EC'),
       ('Rio Grande do Sul', 8, 'Internacional'),
       ('Goiás', 9, 'Goiás EC');



INSERT INTO Jogador (name, cpf, email, phone)
VALUES ('João Vitor', '12345678900', 'joao@example.com', '83999999999'),
       ('Pedro Silva', '98765432100', 'pedro@example.com', '21999999999'),
       ('Maria Costa', '55555555500', 'maria@example.com', '11999999999'),
       ('Lucas Ferreira', '66666666600', 'lucas@example.com', '31999999999'),
       ('Ana Souza', '77777777700', 'ana@example.com', '41999999999'),
       ('Carlos Mendes', '88888888800', 'carlos@example.com', '71999999999'),
       ('Felipe Araújo', '99999999900', 'felipe@example.com', '85999999999'),
       ('Bruna Lima', '10101010101', 'bruna@example.com', '51999999999');



INSERT INTO Contrato (Time_id, Jogador_cpf, eh_capitao, data_inicio, data_fim)
VALUES (1, '12345678900', TRUE, '2024-01-01', '2024-12-31'),
       (2, '98765432100', FALSE, '2024-01-01', '2024-12-31'),
       (3, '55555555500', TRUE, '2024-01-01', '2024-12-31'),
       (4, '66666666600', FALSE, '2024-02-01', '2024-12-31'),
       (5, '77777777700', TRUE, '2024-03-01', '2024-11-30'),
       (6, '88888888800', FALSE, '2024-04-01', '2024-10-31'),
       (7, '99999999900', TRUE, '2024-05-01', '2024-12-31'),
       (8, '10101010101', FALSE, '2024-06-01', '2024-12-31'),
       (9, '77777777700', TRUE, '2024-07-01', '2024-12-31');

INSERT INTO Jogo (id, duracao, data)
VALUES (1, '01:30:00', '2024-09-01'),
       (2, '01:45:00', '2024-09-02'),
       (3, '02:00:00', '2024-09-03'),
       (4, '01:30:00', '2024-09-04'),
       (5, '01:50:00', '2024-09-05'),
       (6, '02:10:00', '2024-09-06'),
       (7, '01:40:00', '2024-09-07'),
       (8, '01:35:00', '2024-09-08'),
       (9, '01:30:00', '2024-09-09');




INSERT INTO Jogador_jogo (Jogador_cpf, Jogo_id, Jogo_data, posicao)
VALUES ('12345678900', 1, '2024-09-01', 'Atacante'),
       ('98765432100', 2, '2024-09-02', 'Goleiro'),
       ('55555555500', 3, '2024-09-03', 'Zagueiro'),
       ('66666666600', 4, '2024-09-04', 'Meia'),
       ('77777777700', 5, '2024-09-05', 'Atacante'),
       ('88888888800', 6, '2024-09-06', 'Volante'),
       ('99999999900', 7, '2024-09-07', 'Atacante'),
       ('10101010101', 8, '2024-09-08', 'Zagueiro'),
       ('77777777700', 9, '2024-09-09', 'Atacante');



INSERT INTO Jogou (Time_id, ngols, uniforme, Jogo_id, Jogo_data)
VALUES (1, 2, 'Vermelho', 1, '2024-09-01'),
       (2, 0, 'Branco', 2, '2024-09-02'),
       (3, 1, 'Preto', 3, '2024-09-03'),
       (4, 3, 'Azul', 4, '2024-09-04'),
       (5, 2, 'Preto', 5, '2024-09-05'),
       (6, 1, 'Verde', 6, '2024-09-06'),
       (7, 4, 'Vermelho', 7, '2024-09-07'),
       (8, 2, 'Branco', 8, '2024-09-08'),
       (9, 1, 'Amarelo', 9, '2024-09-09'),
       (1, 3, 'Vermelho', 9, '2024-09-09');



