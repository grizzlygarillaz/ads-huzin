--
-- PostgreSQL database dump
--

\restrict 5CCBfHHEcHvaC589XVMX54DraNqEIcu3GLm9yOYk65os1FXU8wUBsPSqEdXKn6z

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: cache; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO sail;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO sail;

--
-- Name: channel_types; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.channel_types (
    id bigint NOT NULL,
    code character varying(55) NOT NULL,
    name character varying(55) NOT NULL
);


ALTER TABLE public.channel_types OWNER TO sail;

--
-- Name: channel_types_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.channel_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channel_types_id_seq OWNER TO sail;

--
-- Name: channel_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.channel_types_id_seq OWNED BY public.channel_types.id;


--
-- Name: channels; Type: TABLE; Schema: public; Owner: sail
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


ALTER TABLE public.channels OWNER TO sail;

--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.channels_id_seq OWNER TO sail;

--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.channels_id_seq OWNED BY public.channels.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: sail
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


ALTER TABLE public.cities OWNER TO sail;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO sail;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: city_names; Type: TABLE; Schema: public; Owner: sail
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


ALTER TABLE public.city_names OWNER TO sail;

--
-- Name: city_names_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.city_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.city_names_id_seq OWNER TO sail;

--
-- Name: city_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.city_names_id_seq OWNED BY public.city_names.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: sail
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


ALTER TABLE public.failed_jobs OWNER TO sail;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO sail;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.files (
    id bigint NOT NULL,
    disk character varying(55) DEFAULT 'local'::character varying NOT NULL,
    path character varying(255) NOT NULL,
    filename character varying(128) NOT NULL,
    mime_type character varying(128),
    size integer,
    duration smallint,
    width smallint,
    height smallint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.files OWNER TO sail;

--
-- Name: COLUMN files.size; Type: COMMENT; Schema: public; Owner: sail
--

COMMENT ON COLUMN public.files.size IS 'bytes';


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_id_seq OWNER TO sail;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: sail
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


ALTER TABLE public.job_batches OWNER TO sail;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: sail
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


ALTER TABLE public.jobs OWNER TO sail;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO sail;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO sail;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO sail;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO sail;

--
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO sail;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO sail;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO sail;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO sail;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: sail
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


ALTER TABLE public.personal_access_tokens OWNER TO sail;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO sail;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: sail
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


ALTER TABLE public.projects OWNER TO sail;

--
-- Name: publication_channel_files; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.publication_channel_files (
    id bigint NOT NULL,
    channel_id bigint NOT NULL,
    file_id bigint NOT NULL,
    external_id character varying(255) NOT NULL,
    meta jsonb,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.publication_channel_files OWNER TO sail;

--
-- Name: TABLE publication_channel_files; Type: COMMENT; Schema: public; Owner: sail
--

COMMENT ON TABLE public.publication_channel_files IS 'Files stored on an external channel server';


--
-- Name: publication_channel_files_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.publication_channel_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_channel_files_id_seq OWNER TO sail;

--
-- Name: publication_channel_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.publication_channel_files_id_seq OWNED BY public.publication_channel_files.id;


--
-- Name: publication_external_ids; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.publication_external_ids (
    id bigint NOT NULL,
    external_id character varying(255) NOT NULL,
    publication_id bigint NOT NULL,
    stage character varying(255) DEFAULT 'published'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT publication_external_ids_stage_check CHECK (((stage)::text = ANY ((ARRAY['scheduled'::character varying, 'published'::character varying, 'edited'::character varying, 'deleted'::character varying])::text[])))
);


ALTER TABLE public.publication_external_ids OWNER TO sail;

--
-- Name: publication_external_ids_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.publication_external_ids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_external_ids_id_seq OWNER TO sail;

--
-- Name: publication_external_ids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.publication_external_ids_id_seq OWNED BY public.publication_external_ids.id;


--
-- Name: publication_file; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.publication_file (
    publication_id bigint NOT NULL,
    file_id bigint NOT NULL,
    "position" smallint DEFAULT '0'::smallint NOT NULL,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.publication_file OWNER TO sail;

--
-- Name: publication_types; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.publication_types (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.publication_types OWNER TO sail;

--
-- Name: publication_types_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.publication_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_types_id_seq OWNER TO sail;

--
-- Name: publication_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.publication_types_id_seq OWNED BY public.publication_types.id;


--
-- Name: publications; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.publications (
    id bigint NOT NULL,
    body text,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    options jsonb,
    last_error jsonb,
    publication_type_id bigint NOT NULL,
    channel_id bigint NOT NULL,
    expires_at timestamp(0) without time zone,
    scheduled_at timestamp(0) without time zone,
    published_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT publications_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'scheduled'::character varying, 'published'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.publications OWNER TO sail;

--
-- Name: publications_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.publications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publications_id_seq OWNER TO sail;

--
-- Name: publications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.publications_id_seq OWNED BY public.publications.id;


--
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO sail;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO sail;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO sail;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO sail;

--
-- Name: template_definitions; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.template_definitions (
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


ALTER TABLE public.template_definitions OWNER TO sail;

--
-- Name: template_param_types; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.template_param_types (
    id bigint NOT NULL,
    name character varying(55) NOT NULL
);


ALTER TABLE public.template_param_types OWNER TO sail;

--
-- Name: template_param_types_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.template_param_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.template_param_types_id_seq OWNER TO sail;

--
-- Name: template_param_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.template_param_types_id_seq OWNED BY public.template_param_types.id;


--
-- Name: template_param_values; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.template_param_values (
    id bigint NOT NULL,
    key character varying(55) NOT NULL,
    value character varying(255) NOT NULL,
    param_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.template_param_values OWNER TO sail;

--
-- Name: template_param_values_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.template_param_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.template_param_values_id_seq OWNER TO sail;

--
-- Name: template_param_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.template_param_values_id_seq OWNED BY public.template_param_values.id;


--
-- Name: template_params; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.template_params (
    id bigint NOT NULL,
    key character varying(55) NOT NULL,
    default_value character varying(255),
    param_type_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    resolver character varying(55) NOT NULL
);


ALTER TABLE public.template_params OWNER TO sail;

--
-- Name: template_params_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.template_params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.template_params_id_seq OWNER TO sail;

--
-- Name: template_params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.template_params_id_seq OWNED BY public.template_params.id;


--
-- Name: template_resolvers; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.template_resolvers (
    key character varying(55) NOT NULL,
    description character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.template_resolvers OWNER TO sail;

--
-- Name: template_variable_params; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.template_variable_params (
    id bigint NOT NULL,
    value character varying(255),
    param_id bigint NOT NULL,
    variable_id bigint NOT NULL,
    param_value_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.template_variable_params OWNER TO sail;

--
-- Name: template_variable_params_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.template_variable_params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.template_variable_params_id_seq OWNER TO sail;

--
-- Name: template_variable_params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.template_variable_params_id_seq OWNED BY public.template_variable_params.id;


--
-- Name: template_variables; Type: TABLE; Schema: public; Owner: sail
--

CREATE TABLE public.template_variables (
    id bigint NOT NULL,
    value character varying(255),
    project_uuid uuid NOT NULL,
    channel_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    key character varying(55) NOT NULL,
    resolver character varying(55)
);


ALTER TABLE public.template_variables OWNER TO sail;

--
-- Name: template_variables_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.template_variables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.template_variables_id_seq OWNER TO sail;

--
-- Name: template_variables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.template_variables_id_seq OWNED BY public.template_variables.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: sail
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
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO sail;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: sail
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO sail;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sail
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: channel_types id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channel_types ALTER COLUMN id SET DEFAULT nextval('public.channel_types_id_seq'::regclass);


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channels ALTER COLUMN id SET DEFAULT nextval('public.channels_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: city_names id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.city_names ALTER COLUMN id SET DEFAULT nextval('public.city_names_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: publication_channel_files id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_channel_files ALTER COLUMN id SET DEFAULT nextval('public.publication_channel_files_id_seq'::regclass);


--
-- Name: publication_external_ids id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_external_ids ALTER COLUMN id SET DEFAULT nextval('public.publication_external_ids_id_seq'::regclass);


--
-- Name: publication_types id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_types ALTER COLUMN id SET DEFAULT nextval('public.publication_types_id_seq'::regclass);


--
-- Name: publications id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publications ALTER COLUMN id SET DEFAULT nextval('public.publications_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: template_param_types id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_param_types ALTER COLUMN id SET DEFAULT nextval('public.template_param_types_id_seq'::regclass);


--
-- Name: template_param_values id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_param_values ALTER COLUMN id SET DEFAULT nextval('public.template_param_values_id_seq'::regclass);


--
-- Name: template_params id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_params ALTER COLUMN id SET DEFAULT nextval('public.template_params_id_seq'::regclass);


--
-- Name: template_variable_params id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variable_params ALTER COLUMN id SET DEFAULT nextval('public.template_variable_params_id_seq'::regclass);


--
-- Name: template_variables id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variables ALTER COLUMN id SET DEFAULT nextval('public.template_variables_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: channel_types channel_types_code_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channel_types
    ADD CONSTRAINT channel_types_code_unique UNIQUE (code);


--
-- Name: channel_types channel_types_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channel_types
    ADD CONSTRAINT channel_types_pkey PRIMARY KEY (id);


--
-- Name: channels channels_name_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_name_unique UNIQUE (name);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: channels channels_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_uuid_unique UNIQUE (uuid);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: city_names city_names_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.city_names
    ADD CONSTRAINT city_names_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (uuid);


--
-- Name: publication_channel_files publication_channel_files_channel_id_file_id_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_channel_files
    ADD CONSTRAINT publication_channel_files_channel_id_file_id_unique UNIQUE (channel_id, file_id);


--
-- Name: publication_channel_files publication_channel_files_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_channel_files
    ADD CONSTRAINT publication_channel_files_pkey PRIMARY KEY (id);


--
-- Name: publication_external_ids publication_external_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_external_ids
    ADD CONSTRAINT publication_external_ids_pkey PRIMARY KEY (id);


--
-- Name: publication_external_ids publication_external_ids_publication_id_stage_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_external_ids
    ADD CONSTRAINT publication_external_ids_publication_id_stage_unique UNIQUE (publication_id, stage);


--
-- Name: publication_file publication_file_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_file
    ADD CONSTRAINT publication_file_pkey PRIMARY KEY (publication_id, file_id);


--
-- Name: publication_file publication_file_publication_id_position_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_file
    ADD CONSTRAINT publication_file_publication_id_position_unique UNIQUE (publication_id, "position");


--
-- Name: publication_types publication_types_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_types
    ADD CONSTRAINT publication_types_pkey PRIMARY KEY (id);


--
-- Name: publications publications_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_pkey PRIMARY KEY (id);


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: template_definitions template_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_definitions
    ADD CONSTRAINT template_definitions_pkey PRIMARY KEY (key);


--
-- Name: template_definitions template_definitions_project_uuid_key_channel_id_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_definitions
    ADD CONSTRAINT template_definitions_project_uuid_key_channel_id_unique UNIQUE (project_uuid, key, channel_id);


--
-- Name: template_param_types template_param_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_param_types
    ADD CONSTRAINT template_param_types_name_unique UNIQUE (name);


--
-- Name: template_param_types template_param_types_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_param_types
    ADD CONSTRAINT template_param_types_pkey PRIMARY KEY (id);


--
-- Name: template_param_values template_param_values_param_id_key_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_param_values
    ADD CONSTRAINT template_param_values_param_id_key_unique UNIQUE (param_id, key);


--
-- Name: template_param_values template_param_values_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_param_values
    ADD CONSTRAINT template_param_values_pkey PRIMARY KEY (id);


--
-- Name: template_params template_params_key_resolver_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_params
    ADD CONSTRAINT template_params_key_resolver_unique UNIQUE (key, resolver);


--
-- Name: template_params template_params_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_params
    ADD CONSTRAINT template_params_pkey PRIMARY KEY (id);


--
-- Name: template_resolvers template_resolvers_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_resolvers
    ADD CONSTRAINT template_resolvers_pkey PRIMARY KEY (key);


--
-- Name: template_variable_params template_variable_params_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variable_params
    ADD CONSTRAINT template_variable_params_pkey PRIMARY KEY (id);


--
-- Name: template_variable_params template_variable_params_variable_id_param_id_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variable_params
    ADD CONSTRAINT template_variable_params_variable_id_param_id_unique UNIQUE (variable_id, param_id);


--
-- Name: template_variables template_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variables
    ADD CONSTRAINT template_variables_pkey PRIMARY KEY (id);


--
-- Name: template_variables template_variables_project_uuid_key_channel_id_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variables
    ADD CONSTRAINT template_variables_project_uuid_key_channel_id_unique UNIQUE (project_uuid, key, channel_id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_login_unique; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_unique UNIQUE (login);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cities_country_code_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX cities_country_code_index ON public.cities USING btree (country_code);


--
-- Name: cities_timezone_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX cities_timezone_index ON public.cities USING btree (timezone);


--
-- Name: city_names_city_id_language_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX city_names_city_id_language_index ON public.city_names USING btree (city_id, language);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: template_variables_project_uuid_channel_id_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX template_variables_project_uuid_channel_id_index ON public.template_variables USING btree (project_uuid, channel_id);


--
-- Name: template_variables_resolver_index; Type: INDEX; Schema: public; Owner: sail
--

CREATE INDEX template_variables_resolver_index ON public.template_variables USING btree (resolver);


--
-- Name: channels channels_channel_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_channel_type_id_foreign FOREIGN KEY (channel_type_id) REFERENCES public.channel_types(id);


--
-- Name: channels channels_project_uuid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_project_uuid_foreign FOREIGN KEY (project_uuid) REFERENCES public.projects(uuid) ON DELETE CASCADE;


--
-- Name: city_names city_names_city_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.city_names
    ADD CONSTRAINT city_names_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: projects projects_city_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- Name: publication_channel_files publication_channel_files_channel_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_channel_files
    ADD CONSTRAINT publication_channel_files_channel_id_foreign FOREIGN KEY (channel_id) REFERENCES public.channels(id);


--
-- Name: publication_channel_files publication_channel_files_file_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_channel_files
    ADD CONSTRAINT publication_channel_files_file_id_foreign FOREIGN KEY (file_id) REFERENCES public.files(id);


--
-- Name: publication_external_ids publication_external_ids_publication_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_external_ids
    ADD CONSTRAINT publication_external_ids_publication_id_foreign FOREIGN KEY (publication_id) REFERENCES public.publications(id);


--
-- Name: publication_file publication_file_file_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_file
    ADD CONSTRAINT publication_file_file_id_foreign FOREIGN KEY (file_id) REFERENCES public.files(id);


--
-- Name: publication_file publication_file_publication_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publication_file
    ADD CONSTRAINT publication_file_publication_id_foreign FOREIGN KEY (publication_id) REFERENCES public.publications(id);


--
-- Name: publications publications_channel_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_channel_id_foreign FOREIGN KEY (channel_id) REFERENCES public.channels(id);


--
-- Name: publications publications_publication_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.publications
    ADD CONSTRAINT publications_publication_type_id_foreign FOREIGN KEY (publication_type_id) REFERENCES public.publication_types(id);


--
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: template_definitions template_definitions_channel_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_definitions
    ADD CONSTRAINT template_definitions_channel_id_foreign FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON DELETE CASCADE;


--
-- Name: template_definitions template_definitions_project_uuid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_definitions
    ADD CONSTRAINT template_definitions_project_uuid_foreign FOREIGN KEY (project_uuid) REFERENCES public.projects(uuid) ON DELETE CASCADE;


--
-- Name: template_definitions template_definitions_resolver_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_definitions
    ADD CONSTRAINT template_definitions_resolver_foreign FOREIGN KEY (resolver) REFERENCES public.template_resolvers(key) ON DELETE CASCADE;


--
-- Name: template_param_values template_param_values_param_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_param_values
    ADD CONSTRAINT template_param_values_param_id_foreign FOREIGN KEY (param_id) REFERENCES public.template_params(id) ON DELETE CASCADE;


--
-- Name: template_params template_params_param_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_params
    ADD CONSTRAINT template_params_param_type_id_foreign FOREIGN KEY (param_type_id) REFERENCES public.template_param_types(id);


--
-- Name: template_params template_params_resolver_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_params
    ADD CONSTRAINT template_params_resolver_foreign FOREIGN KEY (resolver) REFERENCES public.template_resolvers(key) ON DELETE CASCADE;


--
-- Name: template_variable_params template_variable_params_param_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variable_params
    ADD CONSTRAINT template_variable_params_param_id_foreign FOREIGN KEY (param_id) REFERENCES public.template_params(id) ON DELETE CASCADE;


--
-- Name: template_variable_params template_variable_params_param_value_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variable_params
    ADD CONSTRAINT template_variable_params_param_value_id_foreign FOREIGN KEY (param_value_id) REFERENCES public.template_param_values(id) ON DELETE CASCADE;


--
-- Name: template_variable_params template_variable_params_variable_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variable_params
    ADD CONSTRAINT template_variable_params_variable_id_foreign FOREIGN KEY (variable_id) REFERENCES public.template_variables(id) ON DELETE CASCADE;


--
-- Name: template_variables template_variables_channel_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variables
    ADD CONSTRAINT template_variables_channel_id_foreign FOREIGN KEY (channel_id) REFERENCES public.channels(id) ON DELETE CASCADE;


--
-- Name: template_variables template_variables_key_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variables
    ADD CONSTRAINT template_variables_key_foreign FOREIGN KEY (key) REFERENCES public.template_definitions(key) ON DELETE CASCADE;


--
-- Name: template_variables template_variables_project_uuid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variables
    ADD CONSTRAINT template_variables_project_uuid_foreign FOREIGN KEY (project_uuid) REFERENCES public.projects(uuid) ON DELETE CASCADE;


--
-- Name: template_variables template_variables_resolver_foreign; Type: FK CONSTRAINT; Schema: public; Owner: sail
--

ALTER TABLE ONLY public.template_variables
    ADD CONSTRAINT template_variables_resolver_foreign FOREIGN KEY (resolver) REFERENCES public.template_resolvers(key) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 5CCBfHHEcHvaC589XVMX54DraNqEIcu3GLm9yOYk65os1FXU8wUBsPSqEdXKn6z

