--
-- PostgreSQL database dump
--

\restrict hgjejDtEi1AtuKU1GVPZb7eDH5gOkHZOWA09dU4WnjdhASezjKN6OOoGvjyqnYr

-- Dumped from database version 15.17
-- Dumped by pg_dump version 15.17

-- Started on 2026-03-04 00:46:34

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16464)
-- Name: adult_census; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adult_census (
    person_id bigint NOT NULL,
    age integer,
    workclass text,
    fnlwgt integer,
    education text,
    education_num integer,
    marital_status text,
    occupation text,
    relationship text,
    race text,
    sex text,
    capital_gain integer,
    capital_loss integer,
    hours_per_week integer,
    native_country text,
    income text
);


ALTER TABLE public.adult_census OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16463)
-- Name: adult_census_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adult_census_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adult_census_person_id_seq OWNER TO postgres;

--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 214
-- Name: adult_census_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adult_census_person_id_seq OWNED BY public.adult_census.person_id;


--
-- TOC entry 3173 (class 2604 OID 16467)
-- Name: adult_census person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adult_census ALTER COLUMN person_id SET DEFAULT nextval('public.adult_census_person_id_seq'::regclass);


--
-- TOC entry 3319 (class 0 OID 16464)
-- Dependencies: 215
-- Data for Name: adult_census; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adult_census (person_id, age, workclass, fnlwgt, education, education_num, marital_status, occupation, relationship, race, sex, capital_gain, capital_loss, hours_per_week, native_country, income) FROM stdin;
1	90	\N	77053	HS-grad	9	Widowed	\N	Not-in-family	White	Female	0	4356	40	United-States	<=50K
2	82	Private	132870	HS-grad	9	Widowed	Exec-managerial	Not-in-family	White	Female	0	4356	18	United-States	<=50K
3	66	\N	186061	Some-college	10	Widowed	\N	Unmarried	Black	Female	0	4356	40	United-States	<=50K
4	54	Private	140359	7th-8th	4	Divorced	Machine-op-inspct	Unmarried	White	Female	0	3900	40	United-States	<=50K
5	41	Private	264663	Some-college	10	Separated	Prof-specialty	Own-child	White	Female	0	3900	40	United-States	<=50K
6	34	Private	216864	HS-grad	9	Divorced	Other-service	Unmarried	White	Female	0	3770	45	United-States	<=50K
7	38	Private	150601	10th	6	Separated	Adm-clerical	Unmarried	White	Male	0	3770	40	United-States	<=50K
8	74	State-gov	88638	Doctorate	16	Never-married	Prof-specialty	Other-relative	White	Female	0	3683	20	United-States	>50K
9	68	Federal-gov	422013	HS-grad	9	Divorced	Prof-specialty	Not-in-family	White	Female	0	3683	40	United-States	<=50K
10	41	Private	70037	Some-college	10	Never-married	Craft-repair	Unmarried	White	Male	0	3004	60	\N	>50K
11	45	Private	172274	Doctorate	16	Divorced	Prof-specialty	Unmarried	Black	Female	0	3004	35	United-States	>50K
12	38	Self-emp-not-inc	164526	Prof-school	15	Never-married	Prof-specialty	Not-in-family	White	Male	0	2824	45	United-States	>50K
13	52	Private	129177	Bachelors	13	Widowed	Other-service	Not-in-family	White	Female	0	2824	20	United-States	>50K
14	32	Private	136204	Masters	14	Separated	Exec-managerial	Not-in-family	White	Male	0	2824	55	United-States	>50K
15	51	\N	172175	Doctorate	16	Never-married	\N	Not-in-family	White	Male	0	2824	40	United-States	>50K
16	46	Private	45363	Prof-school	15	Divorced	Prof-specialty	Not-in-family	White	Male	0	2824	40	United-States	>50K
17	45	Private	172822	11th	7	Divorced	Transport-moving	Not-in-family	White	Male	0	2824	76	United-States	>50K
18	57	Private	317847	Masters	14	Divorced	Exec-managerial	Not-in-family	White	Male	0	2824	50	United-States	>50K
19	22	Private	119592	Assoc-acdm	12	Never-married	Handlers-cleaners	Not-in-family	Black	Male	0	2824	40	\N	>50K
20	34	Private	203034	Bachelors	13	Separated	Sales	Not-in-family	White	Male	0	2824	50	United-States	>50K
21	37	Private	188774	Bachelors	13	Never-married	Exec-managerial	Not-in-family	White	Male	0	2824	40	United-States	>50K
22	29	Private	77009	11th	7	Separated	Sales	Not-in-family	White	Female	0	2754	42	United-States	<=50K
23	61	Private	29059	HS-grad	9	Divorced	Sales	Unmarried	White	Female	0	2754	25	United-States	<=50K
24	51	Private	153870	Some-college	10	Married-civ-spouse	Transport-moving	Husband	White	Male	0	2603	40	United-States	<=50K
25	61	\N	135285	HS-grad	9	Married-civ-spouse	\N	Husband	White	Male	0	2603	32	United-States	<=50K
26	21	Private	34310	Assoc-voc	11	Married-civ-spouse	Craft-repair	Husband	White	Male	0	2603	40	United-States	<=50K
27	33	Private	228696	1st-4th	2	Married-civ-spouse	Craft-repair	Not-in-family	White	Male	0	2603	32	Mexico	<=50K
28	49	Private	122066	5th-6th	3	Married-civ-spouse	Other-service	Husband	White	Male	0	2603	40	Greece	<=50K
29	37	Self-emp-inc	107164	10th	6	Never-married	Transport-moving	Not-in-family	White	Male	0	2559	50	United-States	>50K
30	38	Private	175360	10th	6	Never-married	Prof-specialty	Not-in-family	White	Male	0	2559	90	United-States	>50K
31	23	Private	44064	Some-college	10	Separated	Other-service	Not-in-family	White	Male	0	2559	40	United-States	>50K
32	59	Self-emp-inc	107287	10th	6	Widowed	Exec-managerial	Unmarried	White	Female	0	2559	50	United-States	>50K
33	52	Private	198863	Prof-school	15	Divorced	Exec-managerial	Not-in-family	White	Male	0	2559	60	United-States	>50K
34	51	Private	123011	Bachelors	13	Divorced	Exec-managerial	Not-in-family	White	Male	0	2559	50	United-States	>50K
35	60	Self-emp-not-inc	205246	HS-grad	9	Never-married	Exec-managerial	Not-in-family	Black	Male	0	2559	50	United-States	>50K
36	63	Federal-gov	39181	Doctorate	16	Divorced	Exec-managerial	Not-in-family	White	Female	0	2559	60	United-States	>50K
37	53	Private	149650	HS-grad	9	Never-married	Sales	Not-in-family	White	Male	0	2559	48	United-States	>50K
38	51	Private	197163	Prof-school	15	Never-married	Prof-specialty	Not-in-family	White	Female	0	2559	50	United-States	>50K
39	37	Self-emp-not-inc	137527	Doctorate	16	Never-married	Prof-specialty	Not-in-family	White	Female	0	2559	60	United-States	>50K
40	54	Private	161691	Masters	14	Divorced	Prof-specialty	Not-in-family	White	Female	0	2559	40	United-States	>50K
41	44	Private	326232	Bachelors	13	Divorced	Exec-managerial	Unmarried	White	Male	0	2547	50	United-States	>50K
42	43	Private	115806	Masters	14	Divorced	Exec-managerial	Unmarried	White	Female	0	2547	40	United-States	>50K
43	51	Private	115066	Some-college	10	Divorced	Adm-clerical	Unmarried	White	Female	0	2547	40	United-States	>50K
44	43	Private	289669	Masters	14	Divorced	Prof-specialty	Unmarried	White	Female	0	2547	40	United-States	>50K
45	71	\N	100820	HS-grad	9	Married-civ-spouse	\N	Husband	White	Male	0	2489	15	United-States	<=50K
46	48	Private	121253	Bachelors	13	Married-spouse-absent	Sales	Unmarried	White	Female	0	2472	70	United-States	>50K
47	71	Private	110380	HS-grad	9	Married-civ-spouse	Sales	Husband	White	Male	0	2467	52	United-States	<=50K
48	73	Self-emp-not-inc	233882	HS-grad	9	Married-civ-spouse	Farming-fishing	Husband	Asian-Pac-Islander	Male	0	2457	40	Vietnam	<=50K
49	68	\N	192052	Some-college	10	Married-civ-spouse	\N	Wife	White	Female	0	2457	40	United-States	<=50K
50	67	\N	174995	Some-college	10	Married-civ-spouse	\N	Husband	White	Male	0	2457	40	United-States	<=50K
51	40	Self-emp-not-inc	335549	Prof-school	15	Never-married	Prof-specialty	Not-in-family	White	Male	0	2444	45	United-States	>50K
52	50	Private	237729	HS-grad	9	Widowed	Sales	Not-in-family	White	Female	0	2444	72	United-States	>50K
53	51	State-gov	68898	Assoc-voc	11	Divorced	Tech-support	Not-in-family	White	Male	0	2444	39	United-States	>50K
54	42	Private	107276	Some-college	10	Never-married	Exec-managerial	Not-in-family	White	Female	0	2444	40	United-States	>50K
55	39	Private	141584	Masters	14	Never-married	Sales	Not-in-family	White	Male	0	2444	45	United-States	>50K
56	32	Private	207668	Bachelors	13	Never-married	Exec-managerial	Other-relative	White	Male	0	2444	50	United-States	>50K
57	53	Private	313243	Some-college	10	Separated	Craft-repair	Not-in-family	White	Male	0	2444	45	United-States	>50K
58	40	Local-gov	147372	Some-college	10	Never-married	Protective-serv	Not-in-family	White	Male	0	2444	40	United-States	>50K
59	38	Private	237608	Bachelors	13	Never-married	Sales	Not-in-family	White	Female	0	2444	45	United-States	>50K
60	33	Private	194901	Assoc-voc	11	Separated	Craft-repair	Not-in-family	White	Male	0	2444	42	United-States	>50K
61	43	Private	155106	Assoc-acdm	12	Divorced	Craft-repair	Not-in-family	White	Male	0	2444	70	United-States	>50K
62	50	Self-emp-inc	121441	11th	7	Never-married	Exec-managerial	Other-relative	White	Male	0	2444	40	United-States	>50K
63	44	Private	162028	Some-college	10	Married-civ-spouse	Adm-clerical	Wife	White	Female	0	2415	6	United-States	>50K
64	51	Self-emp-not-inc	160724	Bachelors	13	Married-civ-spouse	Sales	Husband	Asian-Pac-Islander	Male	0	2415	40	China	>50K
65	41	Private	132222	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	40	United-States	>50K
66	60	Self-emp-inc	226355	Assoc-voc	11	Married-civ-spouse	Machine-op-inspct	Husband	White	Male	0	2415	70	\N	>50K
67	37	Private	329980	Masters	14	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	60	United-States	>50K
68	55	Self-emp-inc	124137	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	35	Greece	>50K
69	39	Self-emp-inc	329980	Bachelors	13	Married-civ-spouse	Sales	Husband	White	Male	0	2415	60	United-States	>50K
70	42	Self-emp-inc	187702	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	60	United-States	>50K
71	49	Private	199029	Bachelors	13	Married-civ-spouse	Sales	Husband	White	Male	0	2415	55	United-States	>50K
72	47	Self-emp-not-inc	145290	HS-grad	9	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	50	United-States	>50K
73	41	Local-gov	297248	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	45	United-States	>50K
74	55	Self-emp-inc	227856	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	50	United-States	>50K
75	39	Private	179731	Masters	14	Married-civ-spouse	Exec-managerial	Wife	White	Female	0	2415	65	United-States	>50K
76	42	Private	154374	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	60	United-States	>50K
77	41	\N	27187	Assoc-voc	11	Married-civ-spouse	\N	Husband	White	Male	0	2415	12	United-States	>50K
78	46	Private	326857	Masters	14	Married-civ-spouse	Sales	Husband	White	Male	0	2415	65	United-States	>50K
79	40	Private	160369	Masters	14	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	45	United-States	>50K
80	32	Private	396745	Bachelors	13	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	48	United-States	>50K
81	41	Self-emp-inc	151089	Some-college	10	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	55	United-States	>50K
82	60	Self-emp-inc	336188	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	80	United-States	>50K
83	31	Private	279015	Masters	14	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	70	Taiwan	>50K
84	58	Self-emp-not-inc	43221	Some-college	10	Married-civ-spouse	Farming-fishing	Husband	White	Male	0	2415	40	United-States	>50K
85	37	Self-emp-inc	30529	Bachelors	13	Married-civ-spouse	Sales	Husband	White	Male	0	2415	50	United-States	>50K
86	44	Self-emp-not-inc	201742	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	50	United-States	>50K
87	39	Self-emp-not-inc	218490	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	50	\N	>50K
88	43	Federal-gov	156996	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	Asian-Pac-Islander	Male	0	2415	55	\N	>50K
89	55	Self-emp-inc	298449	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	50	United-States	>50K
90	44	Self-emp-inc	191712	Masters	14	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	55	United-States	>50K
91	39	Private	198654	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	Asian-Pac-Islander	Male	0	2415	67	India	>50K
92	46	Self-emp-not-inc	102308	Bachelors	13	Married-civ-spouse	Sales	Husband	White	Male	0	2415	40	United-States	>50K
93	39	Private	348521	Some-college	10	Married-civ-spouse	Farming-fishing	Husband	White	Male	0	2415	99	United-States	>50K
94	62	Self-emp-inc	56248	Bachelors	13	Married-civ-spouse	Farming-fishing	Husband	White	Male	0	2415	60	United-States	>50K
95	31	Self-emp-not-inc	252752	HS-grad	9	Married-civ-spouse	Other-service	Wife	White	Female	0	2415	40	United-States	>50K
96	46	Private	192963	Bachelors	13	Married-civ-spouse	Adm-clerical	Husband	Asian-Pac-Islander	Male	0	2415	35	Philippines	>50K
97	46	Self-emp-not-inc	198759	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	80	United-States	>50K
98	39	Self-emp-inc	143123	Assoc-voc	11	Married-civ-spouse	Craft-repair	Husband	White	Male	0	2415	40	United-States	>50K
99	39	Private	237713	Prof-school	15	Married-civ-spouse	Sales	Husband	White	Male	0	2415	99	United-States	>50K
100	59	Private	81929	Doctorate	16	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	45	United-States	>50K
101	50	Self-emp-inc	167793	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	60	United-States	>50K
102	46	Private	456062	Doctorate	16	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	55	United-States	>50K
103	53	Self-emp-not-inc	105478	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	40	United-States	>50K
104	50	Self-emp-not-inc	42402	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	30	United-States	>50K
105	41	Self-emp-inc	114580	Prof-school	15	Married-civ-spouse	Exec-managerial	Wife	White	Female	0	2415	55	United-States	>50K
106	36	Private	346478	Bachelors	13	Married-civ-spouse	Sales	Husband	White	Male	0	2415	45	United-States	>50K
107	38	Private	187870	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	90	United-States	>50K
108	54	Private	35576	Some-college	10	Married-civ-spouse	Sales	Husband	White	Male	0	2415	50	United-States	>50K
109	50	Private	102346	Bachelors	13	Married-civ-spouse	Exec-managerial	Wife	White	Female	0	2415	20	United-States	>50K
110	47	Private	148995	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2415	60	United-States	>50K
111	47	Self-emp-inc	102308	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2415	45	United-States	>50K
112	67	Private	105252	Bachelors	13	Widowed	Exec-managerial	Not-in-family	White	Male	0	2392	40	United-States	>50K
113	67	Self-emp-inc	106175	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2392	75	United-States	>50K
114	72	Self-emp-not-inc	52138	Doctorate	16	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2392	25	United-States	>50K
115	72	\N	118902	Doctorate	16	Married-civ-spouse	\N	Husband	White	Male	0	2392	6	United-States	>50K
116	46	Self-emp-inc	191978	Masters	14	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2392	50	United-States	>50K
117	78	Self-emp-inc	188044	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2392	40	United-States	>50K
118	71	Self-emp-inc	66624	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2392	60	United-States	>50K
119	83	Self-emp-inc	153183	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2392	55	United-States	>50K
120	68	Private	211287	Masters	14	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2392	40	United-States	>50K
121	26	Private	181655	Assoc-voc	11	Married-civ-spouse	Adm-clerical	Husband	White	Male	0	2377	45	United-States	<=50K
122	68	State-gov	235882	Doctorate	16	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2377	60	United-States	>50K
123	49	Self-emp-inc	158685	HS-grad	9	Married-civ-spouse	Adm-clerical	Wife	White	Female	0	2377	40	United-States	>50K
124	36	Private	370767	HS-grad	9	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2377	60	United-States	<=50K
125	70	Self-emp-not-inc	155141	Bachelors	13	Married-civ-spouse	Craft-repair	Husband	White	Male	0	2377	12	United-States	>50K
126	27	Private	156516	Some-college	10	Married-civ-spouse	Adm-clerical	Wife	Black	Female	0	2377	20	United-States	<=50K
127	35	Local-gov	177305	Some-college	10	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2377	40	United-States	<=50K
128	23	Private	162945	HS-grad	9	Married-civ-spouse	Sales	Husband	White	Male	0	2377	40	United-States	<=50K
129	81	Private	177408	HS-grad	9	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2377	26	United-States	>50K
130	66	Self-emp-not-inc	427422	Doctorate	16	Married-civ-spouse	Sales	Husband	White	Male	0	2377	25	United-States	>50K
131	71	Private	152307	HS-grad	9	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2377	45	United-States	>50K
132	68	Private	218637	Some-college	10	Married-civ-spouse	Sales	Husband	White	Male	0	2377	55	United-States	>50K
133	68	State-gov	202699	Masters	14	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2377	42	\N	>50K
134	65	\N	240857	Bachelors	13	Married-civ-spouse	\N	Husband	White	Male	0	2377	40	United-States	>50K
135	52	Private	222405	HS-grad	9	Married-civ-spouse	Sales	Husband	Black	Male	0	2377	40	United-States	<=50K
136	40	Self-emp-inc	110862	Assoc-acdm	12	Married-civ-spouse	Craft-repair	Husband	White	Male	0	2377	50	United-States	<=50K
137	68	\N	257269	Bachelors	13	Married-civ-spouse	\N	Husband	White	Male	0	2377	35	United-States	>50K
138	21	Private	377931	Some-college	10	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2377	48	United-States	<=50K
139	35	Private	192923	HS-grad	9	Married-civ-spouse	Craft-repair	Husband	White	Male	0	2377	40	United-States	<=50K
140	70	Self-emp-inc	207938	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2377	50	United-States	>50K
141	61	Self-emp-not-inc	36671	HS-grad	9	Married-civ-spouse	Farming-fishing	Husband	White	Male	0	2352	50	United-States	<=50K
142	65	Self-emp-inc	81413	HS-grad	9	Married-civ-spouse	Farming-fishing	Husband	White	Male	0	2352	65	United-States	<=50K
143	46	Private	214955	5th-6th	3	Divorced	Craft-repair	Not-in-family	White	Female	0	2339	45	United-States	<=50K
144	26	Local-gov	166295	Bachelors	13	Never-married	Prof-specialty	Not-in-family	White	Male	0	2339	55	United-States	<=50K
145	59	Local-gov	147707	HS-grad	9	Widowed	Farming-fishing	Unmarried	White	Male	0	2339	40	United-States	<=50K
146	61	Private	43554	5th-6th	3	Never-married	Handlers-cleaners	Not-in-family	Black	Male	0	2339	40	United-States	<=50K
147	60	State-gov	358893	Bachelors	13	Divorced	Prof-specialty	Not-in-family	White	Female	0	2339	40	United-States	<=50K
148	49	Self-emp-inc	141058	Some-college	10	Divorced	Exec-managerial	Not-in-family	White	Male	0	2339	50	United-States	<=50K
149	34	Private	25322	Bachelors	13	Married-spouse-absent	Machine-op-inspct	Not-in-family	Asian-Pac-Islander	Male	0	2339	40	\N	<=50K
150	25	Private	77071	Bachelors	13	Never-married	Prof-specialty	Own-child	White	Female	0	2339	35	United-States	<=50K
151	55	Private	158702	Some-college	10	Never-married	Adm-clerical	Not-in-family	Black	Female	0	2339	45	\N	<=50K
152	59	Local-gov	171328	HS-grad	9	Separated	Protective-serv	Other-relative	Black	Female	0	2339	40	United-States	<=50K
153	28	State-gov	381789	Some-college	10	Separated	Exec-managerial	Own-child	White	Male	0	2339	40	United-States	<=50K
154	43	\N	152569	Assoc-voc	11	Widowed	\N	Not-in-family	White	Female	0	2339	36	United-States	<=50K
155	56	Self-emp-not-inc	346635	Masters	14	Divorced	Sales	Unmarried	White	Female	0	2339	60	United-States	<=50K
156	41	Private	162140	HS-grad	9	Divorced	Craft-repair	Not-in-family	White	Male	0	2339	40	United-States	<=50K
157	42	Private	191765	HS-grad	9	Never-married	Adm-clerical	Other-relative	Black	Female	0	2339	40	Trinadad&Tobago	<=50K
158	28	Private	251905	Prof-school	15	Never-married	Prof-specialty	Not-in-family	White	Male	0	2339	40	Canada	<=50K
159	40	Self-emp-not-inc	33310	Prof-school	15	Divorced	Other-service	Not-in-family	White	Female	0	2339	35	United-States	<=50K
160	69	Private	228921	Bachelors	13	Widowed	Prof-specialty	Not-in-family	White	Male	0	2282	40	United-States	>50K
161	66	Local-gov	36364	HS-grad	9	Married-civ-spouse	Craft-repair	Husband	White	Male	0	2267	40	United-States	<=50K
162	69	Private	124930	5th-6th	3	Married-civ-spouse	Machine-op-inspct	Husband	White	Male	0	2267	40	United-States	<=50K
163	55	Local-gov	176046	Masters	14	Married-civ-spouse	Prof-specialty	Wife	White	Female	0	2267	40	United-States	<=50K
164	57	Federal-gov	370890	HS-grad	9	Never-married	Adm-clerical	Not-in-family	White	Male	0	2258	40	United-States	<=50K
165	20	Self-emp-not-inc	157145	Some-college	10	Never-married	Farming-fishing	Own-child	White	Male	0	2258	10	United-States	<=50K
166	33	Private	288825	HS-grad	9	Divorced	Craft-repair	Not-in-family	White	Male	0	2258	84	United-States	<=50K
167	30	Self-emp-not-inc	257295	Some-college	10	Never-married	Sales	Other-relative	Asian-Pac-Islander	Male	0	2258	40	South	<=50K
168	40	Private	287983	Bachelors	13	Never-married	Tech-support	Not-in-family	Asian-Pac-Islander	Female	0	2258	48	Philippines	<=50K
169	38	Private	101978	Some-college	10	Separated	Machine-op-inspct	Not-in-family	White	Male	0	2258	55	United-States	>50K
170	46	State-gov	192779	Assoc-acdm	12	Divorced	Adm-clerical	Unmarried	White	Male	0	2258	38	United-States	>50K
171	29	Private	135296	Bachelors	13	Never-married	Exec-managerial	Not-in-family	White	Female	0	2258	45	United-States	>50K
172	57	Federal-gov	199114	Bachelors	13	Never-married	Adm-clerical	Not-in-family	White	Male	0	2258	40	United-States	<=50K
173	39	Private	156897	HS-grad	9	Never-married	Craft-repair	Own-child	White	Male	0	2258	42	United-States	>50K
174	47	Private	138107	Bachelors	13	Divorced	Exec-managerial	Not-in-family	White	Male	0	2258	40	United-States	>50K
175	26	Private	279833	Bachelors	13	Never-married	Exec-managerial	Not-in-family	White	Male	0	2258	45	United-States	>50K
176	27	Self-emp-not-inc	208577	HS-grad	9	Never-married	Craft-repair	Not-in-family	White	Male	0	2258	50	United-States	<=50K
177	23	Private	102942	Bachelors	13	Never-married	Prof-specialty	Own-child	White	Female	0	2258	40	United-States	>50K
178	34	Private	36385	Masters	14	Never-married	Prof-specialty	Not-in-family	White	Male	0	2258	50	United-States	<=50K
179	33	Private	176185	12th	8	Divorced	Craft-repair	Not-in-family	White	Male	0	2258	42	United-States	<=50K
180	38	Local-gov	162613	Masters	14	Never-married	Prof-specialty	Not-in-family	White	Female	0	2258	60	United-States	<=50K
181	57	Private	121362	Some-college	10	Widowed	Adm-clerical	Unmarried	White	Female	0	2258	38	United-States	>50K
182	36	Private	145933	HS-grad	9	Never-married	Exec-managerial	Not-in-family	White	Male	0	2258	70	United-States	<=50K
183	44	Federal-gov	29591	Bachelors	13	Divorced	Tech-support	Not-in-family	White	Male	0	2258	40	United-States	>50K
184	49	State-gov	269417	Doctorate	16	Never-married	Exec-managerial	Not-in-family	White	Female	0	2258	50	United-States	>50K
185	44	Self-emp-inc	178510	Some-college	10	Never-married	Sales	Not-in-family	White	Male	0	2258	60	United-States	<=50K
186	55	Private	41108	Some-college	10	Widowed	Farming-fishing	Not-in-family	White	Male	0	2258	62	United-States	>50K
187	45	Private	187901	HS-grad	9	Divorced	Farming-fishing	Not-in-family	White	Male	0	2258	44	United-States	>50K
188	48	Private	175070	HS-grad	9	Divorced	Exec-managerial	Not-in-family	White	Female	0	2258	40	United-States	>50K
189	31	Private	263561	Bachelors	13	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2246	45	United-States	>50K
190	55	Local-gov	99131	HS-grad	9	Married-civ-spouse	Prof-specialty	Other-relative	White	Female	0	2246	40	United-States	>50K
191	70	Self-emp-not-inc	143833	Some-college	10	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2246	40	United-States	>50K
192	70	Self-emp-not-inc	124449	Masters	14	Married-civ-spouse	Exec-managerial	Husband	White	Male	0	2246	8	United-States	>50K
193	73	Private	336007	Bachelors	13	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2246	40	United-States	>50K
194	72	Self-emp-not-inc	285408	Prof-school	15	Married-civ-spouse	Prof-specialty	Husband	White	Male	0	2246	28	United-States	>50K
195	31	Private	327825	HS-grad	9	Separated	Machine-op-inspct	Unmarried	White	Female	0	2238	40	United-States	<=50K
196	28	Private	129460	10th	6	Widowed	Adm-clerical	Unmarried	White	Female	0	2238	35	United-States	<=50K
197	23	Self-emp-not-inc	258298	Bachelors	13	Never-married	Adm-clerical	Own-child	White	Male	0	2231	40	United-States	>50K
198	49	Local-gov	102359	9th	5	Widowed	Handlers-cleaners	Unmarried	White	Male	0	2231	40	United-States	>50K
199	27	Local-gov	92431	Some-college	10	Never-married	Protective-serv	Not-in-family	White	Male	0	2231	40	United-States	>50K
200	90	Private	51744	HS-grad	9	Never-married	Other-service	Not-in-family	Black	Male	0	2206	40	United-States	<=50K
201	68	Private	166149	HS-grad	9	Widowed	Adm-clerical	Not-in-family	White	Female	0	2206	30	United-States	<=50K
202	65	Private	149811	HS-grad	9	Divorced	Adm-clerical	Unmarried	White	Female	0	2206	59	Canada	<=50K
203	65	\N	143118	HS-grad	9	Widowed	\N	Unmarried	White	Female	0	2206	10	United-States	<=50K
204	67	Private	118363	Bachelors	13	Divorced	Exec-managerial	Not-in-family	White	Female	0	2206	5	United-States	<=50K
205	66	Local-gov	362165	Bachelors	13	Widowed	Prof-specialty	Not-in-family	Black	Female	0	2206	25	United-States	<=50K
206	24	Private	379066	Some-college	10	Never-married	Adm-clerical	Not-in-family	White	Male	0	2205	24	United-States	<=50K
207	44	Self-emp-not-inc	171424	Some-college	10	Divorced	Machine-op-inspct	Not-in-family	White	Male	0	2205	35	United-States	<=50K
208	35	Private	108293	Some-college	10	Never-married	Adm-clerical	Own-child	White	Female	0	2205	40	United-States	<=50K
209	20	Private	107801	Assoc-acdm	12	Never-married	Other-service	Own-child	White	Female	0	2205	18	United-States	<=50K
210	38	Private	126675	HS-grad	9	Divorced	Craft-repair	Not-in-family	White	Male	0	2205	40	United-States	<=50K
211	39	Private	155603	Some-college	10	Never-married	Other-service	Own-child	Black	Female	0	2205	40	United-States	<=50K
212	32	Private	27882	Some-college	10	Never-married	Machine-op-inspct	Other-relative	White	Female	0	2205	40	Holand-Netherlands	<=50K
213	42	Private	242564	7th-8th	4	Never-married	Handlers-cleaners	Not-in-family	Black	Male	0	2205	40	United-States	<=50K
214	63	\N	234083	HS-grad	9	Divorced	\N	Not-in-family	White	Female	0	2205	40	United-States	<=50K
215	42	Self-emp-inc	23510	Masters	14	Divorced	Exec-managerial	Unmarried	Asian-Pac-Islander	Male	0	2201	60	India	>50K
216	64	Private	181232	11th	7	Married-civ-spouse	Craft-repair	Husband	White	Male	0	2179	40	United-States	<=50K
217	28	Private	166481	7th-8th	4	Married-civ-spouse	Handlers-cleaners	Husband	Other	Male	0	2179	40	Puerto-Rico	<=50K
218	41	Self-emp-inc	139916	Assoc-voc	11	Married-civ-spouse	Sales	Husband	Other	Male	0	2179	84	Mexico	<=50K
219	41	Self-emp-not-inc	144594	7th-8th	4	Married-civ-spouse	Craft-repair	Husband	White	Male	0	2179	40	United-States	<=50K
\.


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 214
-- Name: adult_census_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adult_census_person_id_seq', 219, true);


--
-- TOC entry 3175 (class 2606 OID 16471)
-- Name: adult_census adult_census_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adult_census
    ADD CONSTRAINT adult_census_pkey PRIMARY KEY (person_id);


-- Completed on 2026-03-04 00:46:34

--
-- PostgreSQL database dump complete
--

\unrestrict hgjejDtEi1AtuKU1GVPZb7eDH5gOkHZOWA09dU4WnjdhASezjKN6OOoGvjyqnYr

