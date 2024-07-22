--  QUESTÃO 1;

CREATE TABLE tarefas(
    id INTEGER,
    descricao TEXT,
    telefone CHAR(11),
    id_serial INTEGER,
    nota CHAR(1)
)

-- QUESTÃO 2;
ALTER TABLE tarefas ALTER COLUMN id TYPE BIGINT;


-- QUESTAO 3;
ALTER TABLE tarefas ALTER COLUMN id_serial TYPE SMALLINT;
-- ALTER TABLE tarefas ADD CONSTRAINT id_serial_valor_valido CHECK (id_serial < 32768);

INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal','32322525199', 32768, 'A');
INSERT INTO tarefas VALUES (2147483650, 'limpar janelas da entrada principal', '32333233288', 32769, 'A'); -- ambas deram certo
INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1o andar','32323232911', 32767, 'A');
INSERT INTO tarefas VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 32766, 'A');
-- As duas não foram adicionados pelo fato de smallint em sql ir até 32767
-- também há um opção adicionando uma constraint há atributo id, mas como não é o foco da questão prefirir deixar como smallint




-- QUESTÃO 4;
-- atualizando os nomes das colunas
ALTER TABLE tarefas RENAME COLUMN telefone TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN id_serial TO prioridade;
ALTER TABLE tarefas RENAME COLUMN nota TO status;

-- apagando a tupla vazia onde for null
DELETE FROM tarefas WHERE id IS NULL;
DELETE FROM tarefas WHERE descricao IS NULL;
DELETE FROM tarefas WHERE func_resp_cpf IS NULL;
DELETE FROM tarefas WHERE prioridade IS NULL;
DELETE FROM tarefas WHERE status IS NULL;

-- adicionando restricao de not null
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;


-- QUESTÃO 5;
-- Adicionando o id como primary key faz com que o id passe a ser o id unico das tuplas e não permitir a repetição de ids 
ALTER TABLE tarefas ADD CONSTRAINT pk_tarefas PRIMARY KEY (id);

INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar','32323232911', 2, 'A');
--A inserção aconteceu normamelmente

INSERT INTO tarefas VALUES (2147483653, 'aparar a grama da área frontal', '32323232911', 3, 'A');
-- Não foi inserida pelo fato de já existir outro id dentro da tabela com o mesmo id que deseja ser adicionado..

-- QUESTAO 6;
--A:
-- Previamente no inicio do roteiro, definir um  func_resp_cpf como char(11), logo não vai aceitar.

INSERT INTO tarefas VALUES(20202021, 'limpar portas 3o andar', '12345678912', 3, 'B');
-- não aceitou

--B:
--atualizando os status
UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

-- adicionando a constraint
ALTER TABLE tarefas ADD CONSTRAINT tipo_status CHECK(status='P' OR status='E' OR status='C');


-- QUESTÃO 7;
-- atualizando as tuplas que tem prioridade maior que 5
UPDATE tarefas SET prioridade = 5 WHERE prioridade > 5;

-- adicionando constraint
ALTER TABLE  tarefas ADD CONSTRAINT valores_prioridade CHECK(prioridade <= 5);

-- QUESTÃO 8;

CREATE TABLE funcionario(
    cpf CHAR(11),
    data_nasc DATE NOT NULL,
    nome VARCHAR(25) NOT NULL,
    funcao VARCHAR(11) NOT NULL,
    nivel CHAR(1) NOT NULL,
    superior_cpf CHAR(11),

    CONSTRAINT pk_funcionario PRIMARY KEY (cpf),
    CONSTRAINT fk_funcionario FOREIGN KEY (superior_cpf) REFERENCES funcionario(cpf),
    CONSTRAINT nivel_valores CHECK(nivel='J' OR nivel='P' OR nivel='S'),
    CONSTRAINT funcao_valores CHECK(funcao='LIMPEZA' OR funcao='SUP_LIMPEZA'),
    CONSTRAINT superior_cpf_check CHECK((funcao='LIMPEZA' AND superior_cpf IS NOT NULL) OR (funcao='SUP_LIMPEZA' AND superior_cpf IS NULL) OR (funcao='SUP_LIMPEZA' AND superior_cpf IS NOT NULL))

);

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
-- ambas foram adicionadas

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', null);
-- não inseriu por violar a constraint da função ser igual a LIMPEZA e o superior_cpf ser igual a NULL


-- QUESTAO 9;
--A:
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678914', '1999-1-17', 'Rodraigs', 'SUP_LIMPEZA', 'S', '12345678911');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678915', '2000-01-13', 'Liendri', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678916', '2001-01-11', 'Gustevi', 'LIMPEZA', 'J', '12345678915');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678917', '1999-08-31', 'Cleide', 'LIMPEZA', 'P', '12345678914');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678918', '1999-04-27', 'DanyBenny', 'SUP_LIMPEZA', 'S', '12345678911');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678919', '1995-04-24', 'Jesga', 'SUP_LIMPEZA', 'P', NULL);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678920', '1998-04-02', 'Henrisgue', 'LIMPEZA', 'J', '12345678915');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678921', '1996-02-24', 'Mathelus', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678922', '1999-03-16', 'Robsu', 'SUP_LIMPEZA', 'S', NULL)

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678923', '2020-09-21', 'Heloísa', 'SUP_LIMPEZA', 'S', NULL);


-- B:
-- Data maior que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678924', '1999-181-17', 'mary', 'SUP_LIMPEZA', 'S', '12345678911');

-- CPF maior do que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('123456785497859', '2001-01-13', 'may', 'SUP_LIMPEZA', 'S', NULL);

-- CPF em formato invalido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678925', '2001-01-11', 'clara', 'LIMPA', 'J', '12345678915');

-- CPF do superior maior do que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678926', '1999-08-31', 'clara', 'LIMPEZA', 'P', '123456787410852');

-- Função Limpeza e superior é NULL
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345578927', '1999-04-27', 'marcos', 'LIMPEZA', 'S', NULL);

-- Função Limpeza e superior é NULL e a data está em formato errado
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678948', '19955-04-24', 'maria', 'LIMPEZA', 'P', NULL);

-- CPF do superior inexistente e menor do que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678929', '1998-04-02', 'iza', 'LIMPEZA', 'J', '1234565');

-- CPF maior que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678930111', '1996-02-24', 'Matheus', 'SUP_LIMPEZA', 'S', NULL);

-- Nível inválido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678931', '1999-03-16', 'Robsu', 'SUP_LIMPEZA', 'X', NULL);

--  Nível igual a NULL
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678932', '2020-09-21', 'Heloísa', 'SUP_LIMPEZA', NULL, NULL);


-- QUESTÃO 10;

-- adicionando a tabela funcionario os cpf_func_resp que estão em tarefas
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('98765432111', '2023-09-21', 'Marta', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('32322525199', '2023-10-21', 'Fernanda', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('98765432122', '2003-01-11', 'Gustavo', 'LIMPEZA', 'J', '12345678915');


-- OPÇAO 1: ON DELETE CASCADE
ALTER TABLE tarefas ADD CONSTRAINT fk_tarefas FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;

DELETE FROM funcionario WHERE cpf = '98765432111';
-- Acabou deletando juntamente com a tupla de funcionario associado ao cpf, a tarefa que o func_resp_cpf estava associado ao mesmo cpf.

-- OPCAO 2: ON DELETE RESTRIC;
ALTER TABLE tarefas DROP CONSTRAINT fk_tarefas;
ALTER TABLE tarefas ADD CONSTRAINT fk_tarefas FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE RESTRICT;

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('98765432111', '2023-09-21', 'Marta', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO tarefas VALUES(2147482355, 'limpar portas do 1o andar', '98765432111', 2, 'P');

DELETE FROM funcionario WHERE cpf = '98765432111';
-- Encontrei o erro que viola a constraint que eu adicionei e a chave primaria de funcionario esta sendo referenciada por uma chave estrangeira a tabela tarefas, que há uma tupla associada a ela e não pode deletar por causa disso.

-- QUESTÃO 11;

-- Adicionando a constraint
ALTER TABLE tarefas ADD CONSTRAINT func_resp_cpf_check CHECK((func_resp_cpf IS NULL AND status = 'P') OR (func_resp_cpf IS NOT NULL AND status = 'P') OR (func_resp_cpf IS NOT NULL AND status = 'C') OR
(func_resp_cpf IS NOT NULL AND status = 'E'));

-- Alteradando a constraint
ALTER TABLE tarefas DROP CONSTRAINT fk_tarefas;
ALTER TABLE tarefas ADD CONSTRAINT fk_tarefas FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE SET NULL;

INSERT INTO tarefas VALUES(2147482357, 'Comprar cadernos', '98765432111', 2, 'C');
INSERT INTO tarefas VALUES(2147482345, 'Comprar uma cadeira', '98765432111', 2, 'E');

DELETE FROM funcionario WHERE (cpf = '98765432111');
-- erro apresentado: null value in column "func_resp_cpf" of relation "tarefas" violates not-null constraint
