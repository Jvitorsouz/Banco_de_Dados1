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

ALTER TABLE ONLY public.tarefas DROP CONSTRAINT pk_tarefas;
DROP TABLE public.tarefas;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character varying(11) NOT NULL,
    prioridade smallint NOT NULL,
    status character(1) NOT NULL
);


ALTER TABLE public.tarefas OWNER TO joaovdss;

--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: joaovdss
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483649, 'limpar portas do 1o andar', '32322525199', 32767, 'A');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32322525199', 32766, 'A');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');


--
-- Name: tarefas pk_tarefas; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT pk_tarefas PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

