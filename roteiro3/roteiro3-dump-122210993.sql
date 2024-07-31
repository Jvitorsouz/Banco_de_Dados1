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

ALTER TABLE ONLY public.venda DROP CONSTRAINT fk_venda_medicamento;
ALTER TABLE ONLY public.venda DROP CONSTRAINT fk_venda_cpf_vendedor;
ALTER TABLE ONLY public.venda DROP CONSTRAINT fk_venda_cpf_cliente;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fk_funcionario;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT fk_farmacia;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT fk_entrega_venda;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT fk_entrega;
ALTER TABLE ONLY public.cliente_endereco DROP CONSTRAINT fk_cliente_endereco;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT tipo_exclude;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT nome_venda_com_receita_unique;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_pkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT id_venda_unique;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT gerente_unique;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT cpf_tipo_unique;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
ALTER TABLE ONLY public.cliente_endereco DROP CONSTRAINT cliente_endereco_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT bairro_unique;
ALTER TABLE public.venda ALTER COLUMN id_venda DROP DEFAULT;
ALTER TABLE public.funcionario ALTER COLUMN id_farmacia DROP DEFAULT;
ALTER TABLE public.farmacia ALTER COLUMN id_farmacia DROP DEFAULT;
ALTER TABLE public.entrega ALTER COLUMN id_venda DROP DEFAULT;
ALTER TABLE public.entrega ALTER COLUMN id_endereco DROP DEFAULT;
ALTER TABLE public.cliente_endereco ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.venda_id_venda_seq;
DROP TABLE public.venda;
DROP TABLE public.medicamento;
DROP SEQUENCE public.funcionario_id_farmacia_seq;
DROP TABLE public.funcionario;
DROP SEQUENCE public.farmacia_id_farmacia_seq;
DROP TABLE public.farmacia;
DROP SEQUENCE public.entrega_id_venda_seq;
DROP SEQUENCE public.entrega_id_endereco_seq;
DROP TABLE public.entrega;
DROP SEQUENCE public.cliente_endereco_id_seq;
DROP TABLE public.cliente_endereco;
DROP TABLE public.cliente;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.cliente (
    nome character(20),
    cpf character(11) NOT NULL,
    telefone character(11),
    email character varying(30),
    idade integer,
    CONSTRAINT idade_check CHECK ((idade > 17))
);


ALTER TABLE public.cliente OWNER TO joaovdss;

--
-- Name: cliente_endereco; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.cliente_endereco (
    id integer NOT NULL,
    bairro character varying(10) NOT NULL,
    cidade character varying(20) NOT NULL,
    rua character(30) NOT NULL,
    numero integer NOT NULL,
    tipo character(1) NOT NULL,
    id_cliente character(11) NOT NULL,
    CONSTRAINT tipo_cliente_endereco CHECK (((tipo = 'R'::bpchar) OR (tipo = 'T'::bpchar) OR (tipo = 'O'::bpchar)))
);


ALTER TABLE public.cliente_endereco OWNER TO joaovdss;

--
-- Name: cliente_endereco_id_seq; Type: SEQUENCE; Schema: public; Owner: joaovdss
--

CREATE SEQUENCE public.cliente_endereco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_endereco_id_seq OWNER TO joaovdss;

--
-- Name: cliente_endereco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joaovdss
--

ALTER SEQUENCE public.cliente_endereco_id_seq OWNED BY public.cliente_endereco.id;


--
-- Name: entrega; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.entrega (
    id_endereco integer NOT NULL,
    id_venda integer NOT NULL
);


ALTER TABLE public.entrega OWNER TO joaovdss;

--
-- Name: entrega_id_endereco_seq; Type: SEQUENCE; Schema: public; Owner: joaovdss
--

CREATE SEQUENCE public.entrega_id_endereco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entrega_id_endereco_seq OWNER TO joaovdss;

--
-- Name: entrega_id_endereco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joaovdss
--

ALTER SEQUENCE public.entrega_id_endereco_seq OWNED BY public.entrega.id_endereco;


--
-- Name: entrega_id_venda_seq; Type: SEQUENCE; Schema: public; Owner: joaovdss
--

CREATE SEQUENCE public.entrega_id_venda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entrega_id_venda_seq OWNER TO joaovdss;

--
-- Name: entrega_id_venda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joaovdss
--

ALTER SEQUENCE public.entrega_id_venda_seq OWNED BY public.entrega.id_venda;


--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.farmacia (
    bairro character varying(10),
    cidade character varying(20),
    estado public.estados,
    id_farmacia integer NOT NULL,
    tipo character(1) NOT NULL,
    gerente character(11) NOT NULL,
    tipo_gerente character(1) NOT NULL,
    CONSTRAINT tipo_check CHECK (((tipo = 'S'::bpchar) OR (tipo = 'F'::bpchar))),
    CONSTRAINT tipo_gerente_check CHECK (((tipo_gerente = 'A'::bpchar) OR (tipo_gerente = 'F'::bpchar)))
);


ALTER TABLE public.farmacia OWNER TO joaovdss;

--
-- Name: farmacia_id_farmacia_seq; Type: SEQUENCE; Schema: public; Owner: joaovdss
--

CREATE SEQUENCE public.farmacia_id_farmacia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.farmacia_id_farmacia_seq OWNER TO joaovdss;

--
-- Name: farmacia_id_farmacia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joaovdss
--

ALTER SEQUENCE public.farmacia_id_farmacia_seq OWNED BY public.farmacia.id_farmacia;


--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.funcionario (
    nome character varying(30),
    cpf character(11) NOT NULL,
    tipo character(1) NOT NULL,
    id_farmacia integer,
    CONSTRAINT tipo_valor_check CHECK (((tipo = 'V'::bpchar) OR (tipo = 'F'::bpchar) OR (tipo = 'E'::bpchar) OR (tipo = 'C'::bpchar) OR (tipo = 'A'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO joaovdss;

--
-- Name: funcionario_id_farmacia_seq; Type: SEQUENCE; Schema: public; Owner: joaovdss
--

CREATE SEQUENCE public.funcionario_id_farmacia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.funcionario_id_farmacia_seq OWNER TO joaovdss;

--
-- Name: funcionario_id_farmacia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joaovdss
--

ALTER SEQUENCE public.funcionario_id_farmacia_seq OWNED BY public.funcionario.id_farmacia;


--
-- Name: medicamento; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.medicamento (
    nome character(30) NOT NULL,
    valor double precision,
    vende_com_receita boolean NOT NULL
);


ALTER TABLE public.medicamento OWNER TO joaovdss;

--
-- Name: venda; Type: TABLE; Schema: public; Owner: joaovdss
--

CREATE TABLE public.venda (
    id_venda integer NOT NULL,
    cpf_cliente character(11) NOT NULL,
    cpf_vendedor character(11) NOT NULL,
    tipo_vendedor character(1) NOT NULL,
    id_medicamento character(30) NOT NULL,
    venda_com_receita boolean NOT NULL,
    valor double precision,
    CONSTRAINT receita_cliente_check CHECK (((venda_com_receita = true) AND (cpf_cliente IS NOT NULL))),
    CONSTRAINT tipo_vendedor_check CHECK ((tipo_vendedor = 'V'::bpchar))
);


ALTER TABLE public.venda OWNER TO joaovdss;

--
-- Name: venda_id_venda_seq; Type: SEQUENCE; Schema: public; Owner: joaovdss
--

CREATE SEQUENCE public.venda_id_venda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venda_id_venda_seq OWNER TO joaovdss;

--
-- Name: venda_id_venda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joaovdss
--

ALTER SEQUENCE public.venda_id_venda_seq OWNED BY public.venda.id_venda;


--
-- Name: cliente_endereco id; Type: DEFAULT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.cliente_endereco ALTER COLUMN id SET DEFAULT nextval('public.cliente_endereco_id_seq'::regclass);


--
-- Name: entrega id_endereco; Type: DEFAULT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.entrega ALTER COLUMN id_endereco SET DEFAULT nextval('public.entrega_id_endereco_seq'::regclass);


--
-- Name: entrega id_venda; Type: DEFAULT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.entrega ALTER COLUMN id_venda SET DEFAULT nextval('public.entrega_id_venda_seq'::regclass);


--
-- Name: farmacia id_farmacia; Type: DEFAULT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.farmacia ALTER COLUMN id_farmacia SET DEFAULT nextval('public.farmacia_id_farmacia_seq'::regclass);


--
-- Name: funcionario id_farmacia; Type: DEFAULT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.funcionario ALTER COLUMN id_farmacia SET DEFAULT nextval('public.funcionario_id_farmacia_seq'::regclass);


--
-- Name: venda id_venda; Type: DEFAULT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.venda ALTER COLUMN id_venda SET DEFAULT nextval('public.venda_id_venda_seq'::regclass);


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: joaovdss
--



--
-- Data for Name: cliente_endereco; Type: TABLE DATA; Schema: public; Owner: joaovdss
--



--
-- Data for Name: entrega; Type: TABLE DATA; Schema: public; Owner: joaovdss
--



--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: joaovdss
--



--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: joaovdss
--



--
-- Data for Name: medicamento; Type: TABLE DATA; Schema: public; Owner: joaovdss
--



--
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: joaovdss
--



--
-- Name: cliente_endereco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joaovdss
--

SELECT pg_catalog.setval('public.cliente_endereco_id_seq', 1, false);


--
-- Name: entrega_id_endereco_seq; Type: SEQUENCE SET; Schema: public; Owner: joaovdss
--

SELECT pg_catalog.setval('public.entrega_id_endereco_seq', 1, false);


--
-- Name: entrega_id_venda_seq; Type: SEQUENCE SET; Schema: public; Owner: joaovdss
--

SELECT pg_catalog.setval('public.entrega_id_venda_seq', 1, false);


--
-- Name: farmacia_id_farmacia_seq; Type: SEQUENCE SET; Schema: public; Owner: joaovdss
--

SELECT pg_catalog.setval('public.farmacia_id_farmacia_seq', 1, false);


--
-- Name: funcionario_id_farmacia_seq; Type: SEQUENCE SET; Schema: public; Owner: joaovdss
--

SELECT pg_catalog.setval('public.funcionario_id_farmacia_seq', 1, false);


--
-- Name: venda_id_venda_seq; Type: SEQUENCE SET; Schema: public; Owner: joaovdss
--

SELECT pg_catalog.setval('public.venda_id_venda_seq', 1, false);


--
-- Name: farmacia bairro_unique; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT bairro_unique UNIQUE (bairro);


--
-- Name: cliente_endereco cliente_endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.cliente_endereco
    ADD CONSTRAINT cliente_endereco_pkey PRIMARY KEY (id);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf);


--
-- Name: funcionario cpf_tipo_unique; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT cpf_tipo_unique UNIQUE (cpf, tipo);


--
-- Name: farmacia farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id_farmacia);


--
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: farmacia gerente_unique; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT gerente_unique UNIQUE (gerente);


--
-- Name: venda id_venda_unique; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT id_venda_unique UNIQUE (id_venda);


--
-- Name: medicamento medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_pkey PRIMARY KEY (nome);


--
-- Name: medicamento nome_venda_com_receita_unique; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT nome_venda_com_receita_unique UNIQUE (nome, vende_com_receita);


--
-- Name: farmacia tipo_exclude; Type: CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT tipo_exclude EXCLUDE USING gist (tipo WITH =) WHERE ((tipo = 'S'::bpchar));


--
-- Name: cliente_endereco fk_cliente_endereco; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.cliente_endereco
    ADD CONSTRAINT fk_cliente_endereco FOREIGN KEY (id_cliente) REFERENCES public.cliente(cpf);


--
-- Name: entrega fk_entrega; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT fk_entrega FOREIGN KEY (id_endereco) REFERENCES public.cliente_endereco(id);


--
-- Name: entrega fk_entrega_venda; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT fk_entrega_venda FOREIGN KEY (id_venda) REFERENCES public.venda(id_venda);


--
-- Name: farmacia fk_farmacia; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT fk_farmacia FOREIGN KEY (gerente, tipo_gerente) REFERENCES public.funcionario(cpf, tipo);


--
-- Name: funcionario fk_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fk_funcionario FOREIGN KEY (id_farmacia) REFERENCES public.farmacia(id_farmacia);


--
-- Name: venda fk_venda_cpf_cliente; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT fk_venda_cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: venda fk_venda_cpf_vendedor; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT fk_venda_cpf_vendedor FOREIGN KEY (cpf_vendedor, tipo_vendedor) REFERENCES public.funcionario(cpf, tipo) ON DELETE RESTRICT;


--
-- Name: venda fk_venda_medicamento; Type: FK CONSTRAINT; Schema: public; Owner: joaovdss
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT fk_venda_medicamento FOREIGN KEY (id_medicamento, venda_com_receita) REFERENCES public.medicamento(nome, vende_com_receita) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

