--  QUESTÃO 1;

CREATE TABLE tarefas(
    id INTEGER,
    descricao TEXT,
    telefone VARCHAR(11),
    id_serial INTEGER,
    nota CHAR(1)
)

-- QUESTÃO 2;
ALTER TABLE tarefas ALTER COLUMN id TYPE BIGINT;


-- QUESTAO 3;
ALTER TABLE tarefas ALTER COLUMN id_serial TYPE SMALLINT;
-- ALTER TABLE tarefas ADD CONSTRAINT id_serial_valor_valido CHECK (id_serial < 32768);

-- QUESTÃO 4;
-- atualizando os nomes das colunas
ALTER TABLE tarefas RENAME COLUMN telefone TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN id_serial TO prioridade;
ALTER TABLE tarefas RENAME COLUMN nota TO status;

-- apagando a tupla vazia
DELETE FROM tarefas WHERE descricao IS NULL;

-- adicionando restricao de not null
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;