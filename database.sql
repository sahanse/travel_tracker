--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2024-10-12 05:12:23

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
-- TOC entry 214 (class 1259 OID 49176)
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    country_code character varying(3),
    country_name text
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 49184)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    color character varying(50)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 49183)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 218 (class 1259 OID 49251)
-- Name: visited_countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visited_countries (
    visit_id integer NOT NULL,
    user_id integer,
    country_code character varying(3)
);


ALTER TABLE public.visited_countries OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 49250)
-- Name: visited_countries_visit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visited_countries_visit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visited_countries_visit_id_seq OWNER TO postgres;

--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 217
-- Name: visited_countries_visit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visited_countries_visit_id_seq OWNED BY public.visited_countries.visit_id;


--
-- TOC entry 3182 (class 2604 OID 49187)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 3183 (class 2604 OID 49254)
-- Name: visited_countries visit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visited_countries ALTER COLUMN visit_id SET DEFAULT nextval('public.visited_countries_visit_id_seq'::regclass);


--
-- TOC entry 3333 (class 0 OID 49176)
-- Dependencies: 214
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (id, country_code, country_name) FROM stdin;
1	AF	Afghanistan
2	AX	Aland Islands
3	AL	Albania
4	DZ	Algeria
5	AS	American Samoa
6	AD	Andorra
7	AO	Angola
8	AI	Anguilla
9	AQ	Antarctica
10	AG	Antigua and Barbuda
11	AR	Argentina
12	AM	Armenia
13	AW	Aruba
14	AU	Australia
15	AT	Austria
16	AZ	Azerbaijan
17	ST	Sao Tome and Principe
18	BS	Bahamas
19	BH	Bahrain
20	BD	Bangladesh
21	BB	Barbados
22	BY	Belarus
23	BE	Belgium
24	BZ	Belize
25	BJ	Benin
26	BT	Bhutan
27	BO	Bolivia
28	BA	Bosnia and Herzegovina
29	BW	Botswana
30	BV	Bouvet Island
31	BR	Brazil
32	VG	British Virgin Islands
34	BN	Brunei Darussalam
35	BG	Bulgaria
36	BF	Burkina Faso
37	BI	Burundi
38	KH	Cambodia
39	CM	Cameroon
40	CA	Canada
41	CV	Cape Verde
42	KY	Cayman Islands
43	CF	Central African Republic
44	TD	Chad
45	CL	Chile
46	CN	China
48	CR	Costa Rica
50	CX	Christmas Island
51	CC	Cocos (Keeling) Islands
52	CO	Colombia
53	KM	Comoros
54	CD	Congo, (Kinshasa)
55	CK	Cook Islands
56	CI	Côte d'Ivoire
57	HR	Croatia
58	CU	Cuba
59	CY	Cyprus
60	CZ	Czech Republic
61	DK	Denmark
62	DJ	Djibouti
63	DM	Dominica
64	DO	Dominican Republic
65	EC	Ecuador
66	EG	Egypt
67	SV	El Salvador
68	GQ	Equatorial Guinea
69	ER	Eritrea
70	EE	Estonia
71	ET	Ethiopia
72	FK	Falkland Islands (Malvinas)
73	FO	Faroe Islands
74	FJ	Fiji
75	FI	Finland
76	FR	France
77	GF	French Guiana
78	PF	French Polynesia
79	TF	French Southern Territories
80	GA	Gabon
81	GM	Gambia
82	GE	Georgia
83	DE	Germany
84	GH	Ghana
85	GI	Gibraltar
86	GR	Greece
87	GL	Greenland
88	GD	Grenada
89	GP	Guadeloupe
90	GU	Guam
91	GT	Guatemala
92	GG	Guernsey
93	GN	Guinea
94	GW	Guinea-Bissau
95	GY	Guyana
96	HT	Haiti
97	HM	Heard and Mcdonald Islands
98	VA	Holy See (Vatican City State)
99	HN	Honduras
100	HU	Hungary
101	IS	Iceland
102	FM	Micronesia, Federated States of
103	RE	Réunion
104	ID	Indonesia
105	IR	Iran, Islamic Republic of
106	IQ	Iraq
107	IE	Ireland
108	IM	Isle of Man
109	IL	Israel
110	IT	Italy
111	JM	Jamaica
112	JP	Japan
113	JE	Jersey
114	JO	Jordan
115	MD	Moldova
116	KZ	Kazakhstan
117	KE	Kenya
118	KI	Kiribati
119	KP	Korea (North)
120	KR	Korea (South)
121	KW	Kuwait
122	KG	Kyrgyzstan
123	LA	Lao PDR
124	LV	Latvia
125	LB	Lebanon
126	LS	Lesotho
127	LR	Liberia
128	LY	Libya
129	LI	Liechtenstein
130	LT	Lithuania
131	LU	Luxembourg
132	MK	Macedonia, Republic of
133	MG	Madagascar
134	MW	Malawi
135	MY	Malaysia
136	MV	Maldives
137	BM	Bermuda
138	ML	Mali
139	MT	Malta
140	MH	Marshall Islands
141	MQ	Martinique
142	MR	Mauritania
143	MU	Mauritius
144	YT	Mayotte
145	MX	Mexico
146	MC	Monaco
147	MN	Mongolia
148	ME	Montenegro
149	MS	Montserrat
150	MA	Morocco
151	MZ	Mozambique
152	MM	Myanmar
153	NA	Namibia
154	NR	Nauru
155	NP	Nepal
156	NL	Netherlands
157	AN	Netherlands Antilles
158	NC	New Caledonia
159	NZ	New Zealand
160	NI	Nicaragua
161	NE	Niger
162	NG	Nigeria
163	NU	Niue
164	NF	Norfolk Island
165	MP	Northern Mariana Islands
166	NO	Norway
167	OM	Oman
33	IO	BIOT
168	PK	Pakistan
169	PW	Palau
170	PS	Palestinian Territory
171	PA	Panama
172	PG	Papua New Guinea
173	PY	Paraguay
174	PE	Peru
175	PH	Philippines
176	PN	Pitcairn
177	PT	Portugal
178	PR	Puerto Rico
179	QA	Qatar
180	RO	Romania
181	RU	Russian Federation
182	RW	Rwanda
183	BL	Saint-Barthélemy
184	SH	Saint Helena
185	KN	Saint Kitts and Nevis
186	LC	Saint Lucia
187	MF	Saint-Martin (French part)
188	PM	Saint Pierre and Miquelon
189	VC	Saint Vincent and Grenadines
190	WS	Samoa
191	SM	San Marino
192	SA	Saudi Arabia
193	SN	Senegal
194	RS	Serbia
195	SC	Seychelles
196	SL	Sierra Leone
197	SG	Singapore
198	SK	Slovakia
199	SI	Slovenia
200	SB	Solomon Islands
201	SO	Somalia
202	ZA	South Africa
203	GS	South Georgia and the South Sandwich Islands
204	SS	South Sudan
205	ES	Spain
206	LK	Sri Lanka
207	SD	Sudan
208	SR	Suriname
209	SJ	Svalbard and Jan Mayen Islands
210	SZ	Swaziland
211	SE	Sweden
212	CH	Switzerland
213	SY	Syrian Arab Republic (Syria)
215	TJ	Tajikistan
216	TZ	Tanzania, United Republic of
217	TH	Thailand
218	IN	India
219	CG	Congo (Brazzaville)
220	PL	Poland
221	TL	Timor-Leste
222	TG	Togo
223	TK	Tokelau
224	TO	Tonga
225	TT	Trinidad and Tobago
226	TN	Tunisia
227	TR	Turkey
228	TM	Turkmenistan
229	TC	Turks and Caicos Islands
230	TV	Tuvalu
231	UG	Uganda
232	UA	Ukraine
233	AE	United Arab Emirates
234	GB	United Kingdom
235	US	United States of America
236	UM	US Minor Outlying Islands
237	UY	Uruguay
238	UZ	Uzbekistan
239	VU	Vanuatu
240	VE	Venezuela (Bolivarian Republic)
241	VN	Viet Nam
242	VI	Virgin Islands, US
243	WF	Wallis and Futuna Islands
244	EH	Western Sahara
245	YE	Yemen
246	ZM	Zambia
247	ZW	Zimbabwe
47	HK	Hong Kong
49	MO	Macao
214	TW	Taiwan
\.


--
-- TOC entry 3335 (class 0 OID 49184)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, first_name, last_name, color) FROM stdin;
219	sahan	shetty	#ff0000
220	vikas	ks	#1aa243
221	lilly	mummy	#e6cd28
\.


--
-- TOC entry 3337 (class 0 OID 49251)
-- Dependencies: 218
-- Data for Name: visited_countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visited_countries (visit_id, user_id, country_code) FROM stdin;
63	219	IN
64	219	JP
65	219	CN
66	220	IN
67	220	CN
68	221	IN
69	221	JP
70	221	CN
\.


--
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 221, true);


--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 217
-- Name: visited_countries_visit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.visited_countries_visit_id_seq', 70, true);


--
-- TOC entry 3185 (class 2606 OID 49182)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- TOC entry 3187 (class 2606 OID 49189)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3189 (class 2606 OID 49256)
-- Name: visited_countries visited_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visited_countries
    ADD CONSTRAINT visited_countries_pkey PRIMARY KEY (visit_id);


--
-- TOC entry 3190 (class 2606 OID 49257)
-- Name: visited_countries visited_countries_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visited_countries
    ADD CONSTRAINT visited_countries_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


-- Completed on 2024-10-12 05:12:23

--
-- PostgreSQL database dump complete
--

