--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: variable; Type: SCHEMA; Schema: -; Owner: root
--

CREATE SCHEMA variable;


ALTER SCHEMA variable OWNER TO root;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activity_log; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.activity_log (
    id bigint NOT NULL,
    log_name character varying(255),
    description text NOT NULL,
    subject_type character varying(255),
    subject_id bigint,
    causer_type character varying(255),
    causer_id bigint,
    properties json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    event character varying(255),
    batch_uuid uuid
);


ALTER TABLE public.activity_log OWNER TO root;

--
-- Name: activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.activity_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_log_id_seq OWNER TO root;

--
-- Name: activity_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.activity_log_id_seq OWNED BY public.activity_log.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO root;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO root;

--
-- Name: channel_types; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.channel_types (
    id bigint NOT NULL,
    name character varying(55) NOT NULL
);


ALTER TABLE public.channel_types OWNER TO root;

--
-- Name: channel_types_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.channel_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_types_id_seq OWNER TO root;

--
-- Name: channel_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.channel_types_id_seq OWNED BY public.channel_types.id;


--
-- Name: channels; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.channels (
    id bigint NOT NULL,
    uuid uuid NOT NULL,
    name character varying(255) NOT NULL,
    identifier character varying(55) NOT NULL,
    settings jsonb,
    channel_type_id bigint NOT NULL,
    project_uuid uuid,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.channels OWNER TO root;

--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channels_id_seq OWNER TO root;

--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.channels_id_seq OWNED BY public.channels.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.cities (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    country_code character(2) NOT NULL,
    lat numeric(9,6) NOT NULL,
    lng numeric(9,6) NOT NULL,
    timezone character varying(64) NOT NULL,
    population bigint DEFAULT '0'::bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.cities OWNER TO root;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO root;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: city_names; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.city_names (
    id bigint NOT NULL,
    language character(55),
    name character varying(255) NOT NULL,
    is_preferred boolean DEFAULT false NOT NULL,
    is_short boolean DEFAULT false NOT NULL,
    city_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.city_names OWNER TO root;

--
-- Name: city_names_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.city_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.city_names_id_seq OWNER TO root;

--
-- Name: city_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.city_names_id_seq OWNED BY public.city_names.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO root;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO root;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO root;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO root;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO root;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO root;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO root;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO root;

--
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO root;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO root;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO root;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO root;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO root;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO root;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.projects (
    uuid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    city_id bigint NOT NULL,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.projects OWNER TO root;

--
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO root;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO root;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO root;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO root;

--
-- Name: users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    login character varying(255) NOT NULL,
    email character varying(255),
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: definitions; Type: TABLE; Schema: variable; Owner: root
--

CREATE TABLE variable.definitions (
    key character varying(55) NOT NULL,
    default_value character varying(255),
    description character varying(255),
    required boolean DEFAULT true NOT NULL,
    overridable boolean DEFAULT false NOT NULL,
    project_uuid uuid,
    channel_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    resolver character varying(55)
);


ALTER TABLE variable.definitions OWNER TO root;

--
-- Name: param_types; Type: TABLE; Schema: variable; Owner: root
--

CREATE TABLE variable.param_types (
    id bigint NOT NULL,
    name character varying(55) NOT NULL
);


ALTER TABLE variable.param_types OWNER TO root;

--
-- Name: param_types_id_seq; Type: SEQUENCE; Schema: variable; Owner: root
--

CREATE SEQUENCE variable.param_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE variable.param_types_id_seq OWNER TO root;

--
-- Name: param_types_id_seq; Type: SEQUENCE OWNED BY; Schema: variable; Owner: root
--

ALTER SEQUENCE variable.param_types_id_seq OWNED BY variable.param_types.id;


--
-- Name: param_values; Type: TABLE; Schema: variable; Owner: root
--

CREATE TABLE variable.param_values (
    id bigint NOT NULL,
    key character varying(55) NOT NULL,
    value character varying(255) NOT NULL,
    param_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE variable.param_values OWNER TO root;

--
-- Name: param_values_id_seq; Type: SEQUENCE; Schema: variable; Owner: root
--

CREATE SEQUENCE variable.param_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE variable.param_values_id_seq OWNER TO root;

--
-- Name: param_values_id_seq; Type: SEQUENCE OWNED BY; Schema: variable; Owner: root
--

ALTER SEQUENCE variable.param_values_id_seq OWNED BY variable.param_values.id;


--
-- Name: params; Type: TABLE; Schema: variable; Owner: root
--

CREATE TABLE variable.params (
    id bigint NOT NULL,
    key character varying(55) NOT NULL,
    default_value character varying(255),
    param_type_id bigint NOT NULL,
    "order" smallint DEFAULT '0'::smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    resolver character varying(55) NOT NULL
);


ALTER TABLE variable.params OWNER TO root;

--
-- Name: params_id_seq; Type: SEQUENCE; Schema: variable; Owner: root
--

CREATE SEQUENCE variable.params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE variable.params_id_seq OWNER TO root;

--
-- Name: params_id_seq; Type: SEQUENCE OWNED BY; Schema: variable; Owner: root
--

ALTER SEQUENCE variable.params_id_seq OWNED BY variable.params.id;


--
-- Name: resolvers; Type: TABLE; Schema: variable; Owner: root
--

CREATE TABLE variable.resolvers (
    key character varying(55) NOT NULL,
    description character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE variable.resolvers OWNER TO root;

--
-- Name: variable_param_values; Type: TABLE; Schema: variable; Owner: root
--

CREATE TABLE variable.variable_param_values (
    id bigint NOT NULL,
    value character varying(255),
    param_id bigint NOT NULL,
    variable_id bigint NOT NULL,
    param_value_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE variable.variable_param_values OWNER TO root;

--
-- Name: variable_param_values_id_seq; Type: SEQUENCE; Schema: variable; Owner: root
--

CREATE SEQUENCE variable.variable_param_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE variable.variable_param_values_id_seq OWNER TO root;

--
-- Name: variable_param_values_id_seq; Type: SEQUENCE OWNED BY; Schema: variable; Owner: root
--

ALTER SEQUENCE variable.variable_param_values_id_seq OWNED BY variable.variable_param_values.id;


--
-- Name: variables; Type: TABLE; Schema: variable; Owner: root
--

CREATE TABLE variable.variables (
    id bigint NOT NULL,
    value character varying(255),
    project_uuid uuid NOT NULL,
    channel_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    key character varying(55) NOT NULL,
    resolver character varying(55)
);


ALTER TABLE variable.variables OWNER TO root;

--
-- Name: variables_id_seq; Type: SEQUENCE; Schema: variable; Owner: root
--

CREATE SEQUENCE variable.variables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE variable.variables_id_seq OWNER TO root;

--
-- Name: variables_id_seq; Type: SEQUENCE OWNED BY; Schema: variable; Owner: root
--

ALTER SEQUENCE variable.variables_id_seq OWNED BY variable.variables.id;


--
-- Name: activity_log id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.activity_log ALTER COLUMN id SET DEFAULT nextval('public.activity_log_id_seq'::regclass);


--
-- Name: channel_types id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channel_types ALTER COLUMN id SET DEFAULT nextval('public.channel_types_id_seq'::regclass);


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channels ALTER COLUMN id SET DEFAULT nextval('public.channels_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: city_names id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.city_names ALTER COLUMN id SET DEFAULT nextval('public.city_names_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: param_types id; Type: DEFAULT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.param_types ALTER COLUMN id SET DEFAULT nextval('variable.param_types_id_seq'::regclass);


--
-- Name: param_values id; Type: DEFAULT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.param_values ALTER COLUMN id SET DEFAULT nextval('variable.param_values_id_seq'::regclass);


--
-- Name: params id; Type: DEFAULT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.params ALTER COLUMN id SET DEFAULT nextval('variable.params_id_seq'::regclass);


--
-- Name: variable_param_values id; Type: DEFAULT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variable_param_values ALTER COLUMN id SET DEFAULT nextval('variable.variable_param_values_id_seq'::regclass);


--
-- Name: variables id; Type: DEFAULT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variables ALTER COLUMN id SET DEFAULT nextval('variable.variables_id_seq'::regclass);


--
-- Name: activity_log activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: channel_types channel_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channel_types
    ADD CONSTRAINT channel_types_name_unique UNIQUE (name);


--
-- Name: channel_types channel_types_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channel_types
    ADD CONSTRAINT channel_types_pkey PRIMARY KEY (id);


--
-- Name: channels channels_name_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_name_unique UNIQUE (name);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: channels channels_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_uuid_unique UNIQUE (uuid);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: city_names city_names_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.city_names
    ADD CONSTRAINT city_names_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (uuid);


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_login_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_unique UNIQUE (login);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: definitions definitions_pkey; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.definitions
    ADD CONSTRAINT definitions_pkey PRIMARY KEY (key);


--
-- Name: param_types param_types_pkey; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.param_types
    ADD CONSTRAINT param_types_pkey PRIMARY KEY (id);


--
-- Name: param_values param_values_pkey; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.param_values
    ADD CONSTRAINT param_values_pkey PRIMARY KEY (id);


--
-- Name: params params_pkey; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.params
    ADD CONSTRAINT params_pkey PRIMARY KEY (id);


--
-- Name: resolvers resolvers_pkey; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.resolvers
    ADD CONSTRAINT resolvers_pkey PRIMARY KEY (key);


--
-- Name: definitions variable_definitions_project_uuid_key_channel_id_unique; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.definitions
    ADD CONSTRAINT variable_definitions_project_uuid_key_channel_id_unique UNIQUE (project_uuid, key, channel_id);


--
-- Name: param_types variable_param_types_name_unique; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.param_types
    ADD CONSTRAINT variable_param_types_name_unique UNIQUE (name);


--
-- Name: param_values variable_param_values_param_id_key_unique; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.param_values
    ADD CONSTRAINT variable_param_values_param_id_key_unique UNIQUE (param_id, key);


--
-- Name: variable_param_values variable_param_values_pkey; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variable_param_values
    ADD CONSTRAINT variable_param_values_pkey PRIMARY KEY (id);


--
-- Name: params variable_params_key_resolver_unique; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.params
    ADD CONSTRAINT variable_params_key_resolver_unique UNIQUE (key, resolver);


--
-- Name: variable_param_values variable_variable_param_values_variable_id_param_id_unique; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variable_param_values
    ADD CONSTRAINT variable_variable_param_values_variable_id_param_id_unique UNIQUE (variable_id, param_id);


--
-- Name: variables variable_variables_project_uuid_key_channel_id_unique; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variables
    ADD CONSTRAINT variable_variables_project_uuid_key_channel_id_unique UNIQUE (project_uuid, key, channel_id);


--
-- Name: variables variables_pkey; Type: CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variables
    ADD CONSTRAINT variables_pkey PRIMARY KEY (id);


--
-- Name: activity_log_log_name_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX activity_log_log_name_index ON public.activity_log USING btree (log_name);


--
-- Name: causer; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX causer ON public.activity_log USING btree (causer_type, causer_id);


--
-- Name: cities_country_code_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX cities_country_code_index ON public.cities USING btree (country_code);


--
-- Name: cities_timezone_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX cities_timezone_index ON public.cities USING btree (timezone);


--
-- Name: city_names_city_id_language_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX city_names_city_id_language_index ON public.city_names USING btree (city_id, language);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: subject; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX subject ON public.activity_log USING btree (subject_type, subject_id);


--
-- Name: variable_variables_project_uuid_channel_id_index; Type: INDEX; Schema: variable; Owner: root
--

CREATE INDEX variable_variables_project_uuid_channel_id_index ON variable.variables USING btree (project_uuid, channel_id);


--
-- Name: variable_variables_resolver_index; Type: INDEX; Schema: variable; Owner: root
--

CREATE INDEX variable_variables_resolver_index ON variable.variables USING btree (resolver);


--
-- Name: channels channels_channel_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_channel_type_id_foreign FOREIGN KEY (channel_type_id) REFERENCES public.channel_types(id);


--
-- Name: channels channels_project_uuid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_project_uuid_foreign FOREIGN KEY (project_uuid) REFERENCES public.projects(uuid) ON DELETE CASCADE;


--
-- Name: city_names city_names_city_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.city_names
    ADD CONSTRAINT city_names_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: projects projects_city_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: definitions variable_definitions_channel_id_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.definitions
    ADD CONSTRAINT variable_definitions_channel_id_foreign FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON DELETE CASCADE;


--
-- Name: definitions variable_definitions_project_uuid_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.definitions
    ADD CONSTRAINT variable_definitions_project_uuid_foreign FOREIGN KEY (project_uuid) REFERENCES public.projects(uuid) ON DELETE CASCADE;


--
-- Name: definitions variable_definitions_resolver_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.definitions
    ADD CONSTRAINT variable_definitions_resolver_foreign FOREIGN KEY (resolver) REFERENCES variable.resolvers(key) ON DELETE CASCADE;


--
-- Name: param_values variable_param_values_param_id_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.param_values
    ADD CONSTRAINT variable_param_values_param_id_foreign FOREIGN KEY (param_id) REFERENCES variable.params(id) ON DELETE CASCADE;


--
-- Name: params variable_params_param_type_id_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.params
    ADD CONSTRAINT variable_params_param_type_id_foreign FOREIGN KEY (param_type_id) REFERENCES variable.param_types(id);


--
-- Name: params variable_params_resolver_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.params
    ADD CONSTRAINT variable_params_resolver_foreign FOREIGN KEY (resolver) REFERENCES variable.resolvers(key) ON DELETE CASCADE;


--
-- Name: variable_param_values variable_variable_param_values_param_id_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variable_param_values
    ADD CONSTRAINT variable_variable_param_values_param_id_foreign FOREIGN KEY (param_id) REFERENCES variable.params(id) ON DELETE CASCADE;


--
-- Name: variable_param_values variable_variable_param_values_param_value_id_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variable_param_values
    ADD CONSTRAINT variable_variable_param_values_param_value_id_foreign FOREIGN KEY (param_value_id) REFERENCES variable.param_values(id) ON DELETE CASCADE;


--
-- Name: variable_param_values variable_variable_param_values_variable_id_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variable_param_values
    ADD CONSTRAINT variable_variable_param_values_variable_id_foreign FOREIGN KEY (variable_id) REFERENCES variable.variables(id) ON DELETE CASCADE;


--
-- Name: variables variable_variables_channel_id_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variables
    ADD CONSTRAINT variable_variables_channel_id_foreign FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON DELETE CASCADE;


--
-- Name: variables variable_variables_key_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variables
    ADD CONSTRAINT variable_variables_key_foreign FOREIGN KEY (key) REFERENCES variable.definitions(key) ON DELETE CASCADE;


--
-- Name: variables variable_variables_project_uuid_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variables
    ADD CONSTRAINT variable_variables_project_uuid_foreign FOREIGN KEY (project_uuid) REFERENCES public.projects(uuid) ON DELETE CASCADE;


--
-- Name: variables variable_variables_resolver_foreign; Type: FK CONSTRAINT; Schema: variable; Owner: root
--

ALTER TABLE ONLY variable.variables
    ADD CONSTRAINT variable_variables_resolver_foreign FOREIGN KEY (resolver) REFERENCES variable.resolvers(key) ON DELETE CASCADE;

