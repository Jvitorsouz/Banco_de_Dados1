--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.tarefas DROP CONSTRAINT fk_tarefas;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fk_funcionario;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT pk_tarefas;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT pk_funcionario;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(25) NOT NULL,
    funcao character varying(11) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT funcao_valores CHECK ((((funcao)::text = 'LIMPEZA'::text) OR ((funcao)::text = 'SUP_LIMPEZA'::text))),
    CONSTRAINT nivel_valores CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar))),
    CONSTRAINT superior_cpf_check CHECK (((((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NOT NULL))))
);


ALTER TABLE public.funcionario OWNER TO joaovdss;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11) NOT NULL,
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT func_resp_cpf_check CHECK ((((func_resp_cpf IS NULL) AND (status = 'P'::bpchar)) OR ((func_resp_cpf IS NOT NULL) AND (status = 'P'::bpchar)) OR ((func_resp_cpf IS NOT NULL) AND (status = 'C'::bpchar)) OR ((func_resp_cpf IS NOT NULL) AND (status = 'E'::bpchar)))),
    CONSTRAINT tipo_status CHECK (((status = 'P'::bpchar) OR (status = 'E'::bpchar) OR (status = 'C'::bpchar))),
    CONSTRAINT valores_prioridade CHECK ((prioridade <= 5))
);


ALTER TABLE public.tarefas OWNER TO joaovdss;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: joaovdss
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1999-01-17', 'Rodraigs', 'SUP_LIMPEZA', 'S', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '2000-01-13', 'Liendri', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '2001-01-11', 'Gustevi', 'LIMPEZA', 'J', '12345678915');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1999-08-31', 'Cleide', 'LIMPEZA', 'P', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1999-04-27', 'DanyBenny', 'SUP_LIMPEZA', 'S', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1995-04-24', 'Jesga', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1998-04-02', 'Henrisgue', 'LIMPEZA', 'J', '12345678915');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1996-02-24', 'Mathelus', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1999-03-16', 'Robsu', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '2020-09-21', 'Heloísa', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32322525199', '2023-10-21', 'Fernanda', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '2003-01-11', 'Gustavo', 'LIMPEZA', 'J', '12345678915');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '2023-09-21', 'Marta', 'SUP_LIMPEZA', 'S', NULL);


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: joaovdss
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483649, 'limpar portas do 1o andar', '32322525199', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32322525199', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147482355, 'limpar portas do 1o andar', '98765432111', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147482357, 'Comprar cadernos', '98765432111', 2, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147482345, 'Comprar uma cadeira', '98765432111', 2, 'E');


--
-- Name: funcionario pk_funcionario; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT pk_funcionario PRIMARY KEY (cpf);


--
-- Name: tarefas pk_tarefas; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT pk_tarefas PRIMARY KEY (id);


--
-- Name: funcionario fk_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fk_funcionario FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- Name: tarefas fk_tarefas; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT fk_tarefas FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

