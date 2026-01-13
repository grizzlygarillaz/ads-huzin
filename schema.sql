--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23 (Ubuntu 10.23-0ubuntu0.18.04.2)
-- Dumped by pg_dump version 10.23 (Ubuntu 10.23-0ubuntu0.18.04.2)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO vktenantuser;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.account_emailaddress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailaddress_id_seq OWNER TO vktenantuser;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.account_emailaddress_id_seq OWNED BY public.account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO vktenantuser;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.account_emailconfirmation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailconfirmation_id_seq OWNER TO vktenantuser;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.account_emailconfirmation_id_seq OWNED BY public.account_emailconfirmation.id;


--
-- Name: auctions_auction; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_auction (
    id integer NOT NULL,
    "auctionRunned" boolean NOT NULL,
    start_time timestamp with time zone,
    finish_time timestamp with time zone,
    standardcost integer NOT NULL,
    blitz integer NOT NULL,
    start_cost integer NOT NULL,
    cost integer NOT NULL,
    currentusers integer[],
    config_id integer,
    group_id integer NOT NULL,
    lot_id integer,
    tenant_id integer NOT NULL,
    CONSTRAINT auctions_auction_blitz_check CHECK ((blitz >= 0)),
    CONSTRAINT auctions_auction_cost_check CHECK ((cost >= 0)),
    CONSTRAINT auctions_auction_standardcost_check CHECK ((standardcost >= 0)),
    CONSTRAINT auctions_auction_start_cost_check CHECK ((start_cost >= 0))
);


ALTER TABLE public.auctions_auction OWNER TO vktenantuser;

--
-- Name: auctions_auction_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auctions_auction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_auction_id_seq OWNER TO vktenantuser;

--
-- Name: auctions_auction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auctions_auction_id_seq OWNED BY public.auctions_auction.id;


--
-- Name: auctions_auctioncost; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_auctioncost (
    id integer NOT NULL,
    userid integer,
    "time" timestamp with time zone,
    cost integer,
    accept boolean NOT NULL,
    auct_id integer NOT NULL,
    tenant_id integer NOT NULL,
    reason character varying(500),
    completed boolean NOT NULL
);


ALTER TABLE public.auctions_auctioncost OWNER TO vktenantuser;

--
-- Name: auctions_auctioncost_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auctions_auctioncost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_auctioncost_id_seq OWNER TO vktenantuser;

--
-- Name: auctions_auctioncost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auctions_auctioncost_id_seq OWNED BY public.auctions_auctioncost.id;


--
-- Name: auctions_auctlot; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_auctlot (
    id integer NOT NULL,
    lotname text NOT NULL,
    lotdescription text,
    standard_cost integer,
    start_cost integer NOT NULL,
    blitz_cost integer,
    image character varying(100),
    property_id integer,
    tenant_id integer NOT NULL,
    CONSTRAINT auctions_auctlot_blitz_cost_check CHECK ((blitz_cost >= 0)),
    CONSTRAINT auctions_auctlot_standard_cost_check CHECK ((standard_cost >= 0)),
    CONSTRAINT auctions_auctlot_start_cost_check CHECK ((start_cost >= 0))
);


ALTER TABLE public.auctions_auctlot OWNER TO vktenantuser;

--
-- Name: auctions_auctlot_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auctions_auctlot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_auctlot_id_seq OWNER TO vktenantuser;

--
-- Name: auctions_auctlot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auctions_auctlot_id_seq OWNED BY public.auctions_auctlot.id;


--
-- Name: auctions_historicalauctlot; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_historicalauctlot (
    id integer NOT NULL,
    lotname text NOT NULL,
    lotdescription text,
    standard_cost integer,
    start_cost integer NOT NULL,
    blitz_cost integer,
    image text,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    property_id integer,
    tenant_id integer,
    CONSTRAINT auctions_historicalauctlot_blitz_cost_check CHECK ((blitz_cost >= 0)),
    CONSTRAINT auctions_historicalauctlot_standard_cost_check CHECK ((standard_cost >= 0)),
    CONSTRAINT auctions_historicalauctlot_start_cost_check CHECK ((start_cost >= 0))
);


ALTER TABLE public.auctions_historicalauctlot OWNER TO vktenantuser;

--
-- Name: auctions_historicalauctlot_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auctions_historicalauctlot_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_historicalauctlot_history_id_seq OWNER TO vktenantuser;

--
-- Name: auctions_historicalauctlot_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auctions_historicalauctlot_history_id_seq OWNED BY public.auctions_historicalauctlot.history_id;


--
-- Name: auctions_historicalscheduledauctionforgroup; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_historicalscheduledauctionforgroup (
    id integer NOT NULL,
    active boolean NOT NULL,
    "auctionTemplate" text,
    "winTemplate" text,
    currency_symbol character varying(300) NOT NULL,
    "winTime" integer,
    "timeLimitAuction" integer,
    wait_time integer,
    kratnost integer,
    "minAddCost" integer,
    "maxAddCost" integer,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    CONSTRAINT "auctions_historicalscheduledauctionforgr_timeLimitAuction_check" CHECK (("timeLimitAuction" >= 0)),
    CONSTRAINT auctions_historicalscheduledauctionforgroup_kratnost_check CHECK ((kratnost >= 0)),
    CONSTRAINT "auctions_historicalscheduledauctionforgroup_maxAddCost_check" CHECK (("maxAddCost" >= 0)),
    CONSTRAINT "auctions_historicalscheduledauctionforgroup_minAddCost_check" CHECK (("minAddCost" >= 0)),
    CONSTRAINT auctions_historicalscheduledauctionforgroup_wait_time_check CHECK ((wait_time >= 0)),
    CONSTRAINT "auctions_historicalscheduledauctionforgroup_winTime_check" CHECK (("winTime" >= 0))
);


ALTER TABLE public.auctions_historicalscheduledauctionforgroup OWNER TO vktenantuser;

--
-- Name: auctions_historicalscheduledauctionforgroup_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auctions_historicalscheduledauctionforgroup_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_historicalscheduledauctionforgroup_history_id_seq OWNER TO vktenantuser;

--
-- Name: auctions_historicalscheduledauctionforgroup_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auctions_historicalscheduledauctionforgroup_history_id_seq OWNED BY public.auctions_historicalscheduledauctionforgroup.history_id;


--
-- Name: auctions_scheduledauction; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauction (
    id integer NOT NULL,
    date date,
    "time" time without time zone,
    lot_id integer,
    property_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.auctions_scheduledauction OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauction_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auctions_scheduledauction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_scheduledauction_id_seq OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auctions_scheduledauction_id_seq OWNED BY public.auctions_scheduledauction.id;


--
-- Name: auctions_scheduledauctionch; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauctionch (
    scheduledauction_ptr_id integer NOT NULL
);


ALTER TABLE public.auctions_scheduledauctionch OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauctionforgroup; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauctionforgroup (
    id integer NOT NULL,
    active boolean NOT NULL,
    "auctionTemplate" text,
    "winTemplate" text,
    currency_symbol character varying(300) NOT NULL,
    "winTime" integer,
    "timeLimitAuction" integer,
    wait_time integer,
    kratnost integer,
    "minAddCost" integer,
    "maxAddCost" integer,
    group_id integer,
    tenant_id integer NOT NULL,
    CONSTRAINT auctions_scheduledauctionforgroup_kratnost_check CHECK ((kratnost >= 0)),
    CONSTRAINT "auctions_scheduledauctionforgroup_maxAddCost_check" CHECK (("maxAddCost" >= 0)),
    CONSTRAINT "auctions_scheduledauctionforgroup_minAddCost_check" CHECK (("minAddCost" >= 0)),
    CONSTRAINT "auctions_scheduledauctionforgroup_timeLimitAuction_check" CHECK (("timeLimitAuction" >= 0)),
    CONSTRAINT auctions_scheduledauctionforgroup_wait_time_check CHECK ((wait_time >= 0)),
    CONSTRAINT "auctions_scheduledauctionforgroup_winTime_check" CHECK (("winTime" >= 0))
);


ALTER TABLE public.auctions_scheduledauctionforgroup OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauctionforgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auctions_scheduledauctionforgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_scheduledauctionforgroup_id_seq OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauctionforgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auctions_scheduledauctionforgroup_id_seq OWNED BY public.auctions_scheduledauctionforgroup.id;


--
-- Name: auctions_scheduledauctionpn; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauctionpn (
    scheduledauction_ptr_id integer NOT NULL
);


ALTER TABLE public.auctions_scheduledauctionpn OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauctionpt; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauctionpt (
    scheduledauction_ptr_id integer NOT NULL
);


ALTER TABLE public.auctions_scheduledauctionpt OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauctionsb; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauctionsb (
    scheduledauction_ptr_id integer NOT NULL
);


ALTER TABLE public.auctions_scheduledauctionsb OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauctionsr; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauctionsr (
    scheduledauction_ptr_id integer NOT NULL
);


ALTER TABLE public.auctions_scheduledauctionsr OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauctionvs; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauctionvs (
    scheduledauction_ptr_id integer NOT NULL
);


ALTER TABLE public.auctions_scheduledauctionvs OWNER TO vktenantuser;

--
-- Name: auctions_scheduledauctionvt; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_scheduledauctionvt (
    scheduledauction_ptr_id integer NOT NULL
);


ALTER TABLE public.auctions_scheduledauctionvt OWNER TO vktenantuser;

--
-- Name: auctions_setauctlot; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auctions_setauctlot (
    id integer NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.auctions_setauctlot OWNER TO vktenantuser;

--
-- Name: auctions_setauctlot_forGroups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."auctions_setauctlot_forGroups" (
    id integer NOT NULL,
    setauctlot_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public."auctions_setauctlot_forGroups" OWNER TO vktenantuser;

--
-- Name: auctions_setauctlot_forGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."auctions_setauctlot_forGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."auctions_setauctlot_forGroups_id_seq" OWNER TO vktenantuser;

--
-- Name: auctions_setauctlot_forGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."auctions_setauctlot_forGroups_id_seq" OWNED BY public."auctions_setauctlot_forGroups".id;


--
-- Name: auctions_setauctlot_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auctions_setauctlot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auctions_setauctlot_id_seq OWNER TO vktenantuser;

--
-- Name: auctions_setauctlot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auctions_setauctlot_id_seq OWNED BY public.auctions_setauctlot.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO vktenantuser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO vktenantuser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO vktenantuser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO vktenantuser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO vktenantuser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO vktenantuser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO vktenantuser;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO vktenantuser;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO vktenantuser;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO vktenantuser;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO vktenantuser;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO vktenantuser;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO vktenantuser;

--
-- Name: background_task; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.background_task (
    id integer NOT NULL,
    task_name character varying(190) NOT NULL,
    task_params text NOT NULL,
    task_hash character varying(40) NOT NULL,
    verbose_name character varying(255),
    priority integer NOT NULL,
    run_at timestamp with time zone NOT NULL,
    repeat bigint NOT NULL,
    repeat_until timestamp with time zone,
    queue character varying(190),
    attempts integer NOT NULL,
    failed_at timestamp with time zone,
    last_error text NOT NULL,
    locked_by character varying(64),
    locked_at timestamp with time zone,
    creator_object_id integer,
    creator_content_type_id integer,
    CONSTRAINT background_task_creator_object_id_check CHECK ((creator_object_id >= 0))
);


ALTER TABLE public.background_task OWNER TO vktenantuser;

--
-- Name: background_task_completedtask; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.background_task_completedtask (
    id integer NOT NULL,
    task_name character varying(190) NOT NULL,
    task_params text NOT NULL,
    task_hash character varying(40) NOT NULL,
    verbose_name character varying(255),
    priority integer NOT NULL,
    run_at timestamp with time zone NOT NULL,
    repeat bigint NOT NULL,
    repeat_until timestamp with time zone,
    queue character varying(190),
    attempts integer NOT NULL,
    failed_at timestamp with time zone,
    last_error text NOT NULL,
    locked_by character varying(64),
    locked_at timestamp with time zone,
    creator_object_id integer,
    creator_content_type_id integer,
    CONSTRAINT background_task_completedtask_creator_object_id_check CHECK ((creator_object_id >= 0))
);


ALTER TABLE public.background_task_completedtask OWNER TO vktenantuser;

--
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.background_task_completedtask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.background_task_completedtask_id_seq OWNER TO vktenantuser;

--
-- Name: background_task_completedtask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.background_task_completedtask_id_seq OWNED BY public.background_task_completedtask.id;


--
-- Name: background_task_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.background_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.background_task_id_seq OWNER TO vktenantuser;

--
-- Name: background_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.background_task_id_seq OWNED BY public.background_task.id;


--
-- Name: bday_bdayposttemplate; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.bday_bdayposttemplate (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_time time without time zone NOT NULL,
    "postTemplate" text,
    "bdayBgImage" character varying(100),
    cropping character varying(255) NOT NULL,
    textcolor character varying(18) NOT NULL,
    "postImage" character varying(100),
    primage character varying(100),
    group_id integer NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.bday_bdayposttemplate OWNER TO vktenantuser;

--
-- Name: bday_bdayposttemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.bday_bdayposttemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bday_bdayposttemplate_id_seq OWNER TO vktenantuser;

--
-- Name: bday_bdayposttemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.bday_bdayposttemplate_id_seq OWNED BY public.bday_bdayposttemplate.id;


--
-- Name: bday_historicalbdayposttemplate; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.bday_historicalbdayposttemplate (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_time time without time zone NOT NULL,
    "postTemplate" text,
    "bdayBgImage" text,
    cropping character varying(255) NOT NULL,
    textcolor character varying(18) NOT NULL,
    "postImage" text,
    primage text,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer
);


ALTER TABLE public.bday_historicalbdayposttemplate OWNER TO vktenantuser;

--
-- Name: bday_historicalbdayposttemplate_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.bday_historicalbdayposttemplate_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bday_historicalbdayposttemplate_history_id_seq OWNER TO vktenantuser;

--
-- Name: bday_historicalbdayposttemplate_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.bday_historicalbdayposttemplate_history_id_seq OWNED BY public.bday_historicalbdayposttemplate.history_id;


--
-- Name: bday_historicalmsgtemplate; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.bday_historicalmsgtemplate (
    id integer NOT NULL,
    dayoffset integer,
    "lsTemplate" text,
    image text,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    property_id integer,
    tenant_id integer
);


ALTER TABLE public.bday_historicalmsgtemplate OWNER TO vktenantuser;

--
-- Name: bday_historicalmsgtemplate_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.bday_historicalmsgtemplate_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bday_historicalmsgtemplate_history_id_seq OWNER TO vktenantuser;

--
-- Name: bday_historicalmsgtemplate_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.bday_historicalmsgtemplate_history_id_seq OWNED BY public.bday_historicalmsgtemplate.history_id;


--
-- Name: bday_historicalsetmsgtemplate; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.bday_historicalsetmsgtemplate (
    id integer NOT NULL,
    active boolean NOT NULL,
    msg_time time without time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer
);


ALTER TABLE public.bday_historicalsetmsgtemplate OWNER TO vktenantuser;

--
-- Name: bday_historicalsetmsgtemplate_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.bday_historicalsetmsgtemplate_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bday_historicalsetmsgtemplate_history_id_seq OWNER TO vktenantuser;

--
-- Name: bday_historicalsetmsgtemplate_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.bday_historicalsetmsgtemplate_history_id_seq OWNED BY public.bday_historicalsetmsgtemplate.history_id;


--
-- Name: bday_msgtemplate; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.bday_msgtemplate (
    id integer NOT NULL,
    dayoffset integer,
    "lsTemplate" text,
    image character varying(100),
    property_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.bday_msgtemplate OWNER TO vktenantuser;

--
-- Name: bday_msgtemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.bday_msgtemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bday_msgtemplate_id_seq OWNER TO vktenantuser;

--
-- Name: bday_msgtemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.bday_msgtemplate_id_seq OWNED BY public.bday_msgtemplate.id;


--
-- Name: bday_setmsgtemplate; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.bday_setmsgtemplate (
    id integer NOT NULL,
    active boolean NOT NULL,
    msg_time time without time zone NOT NULL,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.bday_setmsgtemplate OWNER TO vktenantuser;

--
-- Name: bday_setmsgtemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.bday_setmsgtemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bday_setmsgtemplate_id_seq OWNER TO vktenantuser;

--
-- Name: bday_setmsgtemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.bday_setmsgtemplate_id_seq OWNED BY public.bday_setmsgtemplate.id;


--
-- Name: datacollect_phonetosheet; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.datacollect_phonetosheet (
    id bigint NOT NULL,
    active boolean NOT NULL,
    step_id character varying(500),
    sheetname character varying(500),
    gsheet character varying(300),
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    "lsTemplate" text
);


ALTER TABLE public.datacollect_phonetosheet OWNER TO vktenantuser;

--
-- Name: datacollect_phonetosheet_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.datacollect_phonetosheet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datacollect_phonetosheet_id_seq OWNER TO vktenantuser;

--
-- Name: datacollect_phonetosheet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.datacollect_phonetosheet_id_seq OWNED BY public.datacollect_phonetosheet.id;


--
-- Name: daywinners_daywinnersprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_daywinnersprize (
    prize_ptr_id integer NOT NULL,
    contest_id integer,
    count integer NOT NULL,
    CONSTRAINT daywinners_daywinnersprize_count_check CHECK ((count >= 0))
);


ALTER TABLE public.daywinners_daywinnersprize OWNER TO vktenantuser;

--
-- Name: daywinners_daywinnersprize2; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_daywinnersprize2 (
    prize_ptr_id integer NOT NULL,
    contest_id integer,
    count integer NOT NULL,
    CONSTRAINT daywinners_daywinnersprize2_count_check CHECK ((count >= 0))
);


ALTER TABLE public.daywinners_daywinnersprize2 OWNER TO vktenantuser;

--
-- Name: daywinners_daywinnersprize3; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_daywinnersprize3 (
    prize_ptr_id integer NOT NULL,
    contest_id integer,
    count integer NOT NULL,
    CONSTRAINT daywinners_daywinnersprize3_count_check CHECK ((count >= 0))
);


ALTER TABLE public.daywinners_daywinnersprize3 OWNER TO vktenantuser;

--
-- Name: daywinners_doppost; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_doppost (
    id integer NOT NULL,
    "dopPostDate" timestamp with time zone NOT NULL,
    "dopPostText" text,
    "dopPostImage" character varying(100),
    contest_id integer,
    tenant_id integer NOT NULL,
    "dopPostId" integer NOT NULL,
    CONSTRAINT "daywinners_doppost_dopPostId_check" CHECK (("dopPostId" >= 0))
);


ALTER TABLE public.daywinners_doppost OWNER TO vktenantuser;

--
-- Name: daywinners_doppost_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.daywinners_doppost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.daywinners_doppost_id_seq OWNER TO vktenantuser;

--
-- Name: daywinners_doppost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.daywinners_doppost_id_seq OWNED BY public.daywinners_doppost.id;


--
-- Name: daywinners_hashsearch; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_hashsearch (
    makewinnerstime_ptr_id integer NOT NULL,
    search_hashtag character varying(500),
    need_senler boolean NOT NULL,
    post_link character varying(500),
    add_check_groups text,
    current_check_groups text,
    current_check_groups_ids text
);


ALTER TABLE public.daywinners_hashsearch OWNER TO vktenantuser;

--
-- Name: daywinners_historicalhashsearch; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_historicalhashsearch (
    id integer NOT NULL,
    makewinnerstime_ptr_id integer,
    active boolean NOT NULL,
    "dayOfTheWeek" character varying(1),
    "oddWeek" character varying(1),
    "makeWinnerDate" date,
    "makeWinnerTime" time without time zone,
    searchdays integer NOT NULL,
    image text,
    post_template_text text,
    last_run timestamp with time zone,
    sheetname character varying(500),
    lifetime integer NOT NULL,
    lifetimewrite character varying(500),
    lifetimewrite_clear boolean NOT NULL,
    block_days integer NOT NULL,
    dopprizeinfo character varying(500),
    postpone_id integer,
    exclude_admins boolean NOT NULL,
    post_url character varying(500),
    "autopostDate" date,
    "autopostDayOfTheWeek" character varying(1),
    "autopostTime" time without time zone,
    autopost_text text,
    autopostimage text,
    ask_mobile_phone boolean NOT NULL,
    lastvideos text[],
    sendpromos integer[],
    ask_phones integer[],
    contest_status_text text NOT NULL,
    contest_status_date timestamp with time zone NOT NULL,
    selected_winners text,
    selected_posts text,
    promokod_interval boolean NOT NULL,
    promokod_interval_text text,
    winners_there text,
    allusers_there text,
    comment_answer text,
    search_hashtag character varying(500),
    need_senler boolean NOT NULL,
    post_link character varying(500),
    add_check_groups text,
    current_check_groups text,
    current_check_groups_ids text,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    vid_id integer,
    comment_answer_check character varying(1),
    winner_ls_text text,
    autopostimage2 text,
    CONSTRAINT daywinners_historicalhashsearch_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT daywinners_historicalhashsearch_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT daywinners_historicalhashsearch_postpone_id_check CHECK ((postpone_id >= 0)),
    CONSTRAINT daywinners_historicalhashsearch_searchdays_check CHECK ((searchdays >= 0))
);


ALTER TABLE public.daywinners_historicalhashsearch OWNER TO vktenantuser;

--
-- Name: daywinners_historicalhashsearch_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.daywinners_historicalhashsearch_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.daywinners_historicalhashsearch_history_id_seq OWNER TO vktenantuser;

--
-- Name: daywinners_historicalhashsearch_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.daywinners_historicalhashsearch_history_id_seq OWNED BY public.daywinners_historicalhashsearch.history_id;


--
-- Name: daywinners_historicalrandomactivity; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_historicalrandomactivity (
    id integer NOT NULL,
    makewinnerstime_ptr_id integer,
    active boolean NOT NULL,
    "dayOfTheWeek" character varying(1),
    "oddWeek" character varying(1),
    "makeWinnerDate" date,
    "makeWinnerTime" time without time zone,
    searchdays integer NOT NULL,
    image text,
    post_template_text text,
    last_run timestamp with time zone,
    sheetname character varying(500),
    lifetime integer NOT NULL,
    lifetimewrite character varying(500),
    lifetimewrite_clear boolean NOT NULL,
    block_days integer NOT NULL,
    dopprizeinfo character varying(500),
    postpone_id integer,
    exclude_admins boolean NOT NULL,
    post_url character varying(500),
    "autopostDate" date,
    "autopostDayOfTheWeek" character varying(1),
    "autopostTime" time without time zone,
    autopost_text text,
    autopostimage text,
    ask_mobile_phone boolean NOT NULL,
    lastvideos text[],
    sendpromos integer[],
    ask_phones integer[],
    contest_status_text text NOT NULL,
    contest_status_date timestamp with time zone NOT NULL,
    selected_winners text,
    selected_posts text,
    promokod_interval boolean NOT NULL,
    promokod_interval_text text,
    winners_there text,
    allusers_there text,
    comment_answer text,
    need_like boolean NOT NULL,
    need_repost boolean NOT NULL,
    need_comment boolean NOT NULL,
    post_own boolean NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    vid_id integer,
    comment_answer_check character varying(1),
    winner_ls_text text,
    autopostimage2 text,
    CONSTRAINT daywinners_historicalrandomactivity_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT daywinners_historicalrandomactivity_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT daywinners_historicalrandomactivity_postpone_id_check CHECK ((postpone_id >= 0)),
    CONSTRAINT daywinners_historicalrandomactivity_searchdays_check CHECK ((searchdays >= 0))
);


ALTER TABLE public.daywinners_historicalrandomactivity OWNER TO vktenantuser;

--
-- Name: daywinners_historicalrandomactivity_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.daywinners_historicalrandomactivity_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.daywinners_historicalrandomactivity_history_id_seq OWNER TO vktenantuser;

--
-- Name: daywinners_historicalrandomactivity_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.daywinners_historicalrandomactivity_history_id_seq OWNED BY public.daywinners_historicalrandomactivity.history_id;


--
-- Name: daywinners_historicalrandomphotoreviews; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_historicalrandomphotoreviews (
    id integer NOT NULL,
    makewinnerstime_ptr_id integer,
    active boolean NOT NULL,
    "dayOfTheWeek" character varying(1),
    "oddWeek" character varying(1),
    "makeWinnerDate" date,
    "makeWinnerTime" time without time zone,
    searchdays integer NOT NULL,
    image text,
    post_template_text text,
    last_run timestamp with time zone,
    sheetname character varying(500),
    lifetime integer NOT NULL,
    lifetimewrite character varying(500),
    lifetimewrite_clear boolean NOT NULL,
    block_days integer NOT NULL,
    dopprizeinfo character varying(500),
    postpone_id integer,
    exclude_admins boolean NOT NULL,
    post_url character varying(500),
    "autopostDate" date,
    "autopostDayOfTheWeek" character varying(1),
    "autopostTime" time without time zone,
    autopost_text text,
    autopostimage text,
    ask_mobile_phone boolean NOT NULL,
    lastvideos text[],
    sendpromos integer[],
    ask_phones integer[],
    contest_status_text text NOT NULL,
    contest_status_date timestamp with time zone NOT NULL,
    selected_winners text,
    selected_posts text,
    promokod_interval boolean NOT NULL,
    promokod_interval_text text,
    winners_there text,
    allusers_there text,
    comment_answer text,
    hashtag character varying(500),
    runbgtime integer NOT NULL,
    send_coupon boolean NOT NULL,
    coupon_lifetime integer NOT NULL,
    coupon text,
    coupon_description character varying(500),
    comment_text text,
    comment_no_hash boolean NOT NULL,
    comment_userpost_no_hash text,
    ls_text text,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    vid_id integer,
    comment_answer_check character varying(1),
    winner_ls_text text,
    autopostimage2 text,
    CONSTRAINT daywinners_historicalrandomphotoreviews_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT daywinners_historicalrandomphotoreviews_coupon_lifetime_check CHECK ((coupon_lifetime >= 0)),
    CONSTRAINT daywinners_historicalrandomphotoreviews_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT daywinners_historicalrandomphotoreviews_postpone_id_check CHECK ((postpone_id >= 0)),
    CONSTRAINT daywinners_historicalrandomphotoreviews_runbgtime_check CHECK ((runbgtime >= 0)),
    CONSTRAINT daywinners_historicalrandomphotoreviews_searchdays_check CHECK ((searchdays >= 0))
);


ALTER TABLE public.daywinners_historicalrandomphotoreviews OWNER TO vktenantuser;

--
-- Name: daywinners_historicalrandomphotoreviews_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.daywinners_historicalrandomphotoreviews_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.daywinners_historicalrandomphotoreviews_history_id_seq OWNER TO vktenantuser;

--
-- Name: daywinners_historicalrandomphotoreviews_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.daywinners_historicalrandomphotoreviews_history_id_seq OWNED BY public.daywinners_historicalrandomphotoreviews.history_id;


--
-- Name: daywinners_historicalweeklywinners; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_historicalweeklywinners (
    id integer NOT NULL,
    makewinnerstime_ptr_id integer,
    active boolean NOT NULL,
    "dayOfTheWeek" character varying(1),
    "oddWeek" character varying(1),
    "makeWinnerDate" date,
    "makeWinnerTime" time without time zone,
    searchdays integer NOT NULL,
    image text,
    post_template_text text,
    last_run timestamp with time zone,
    sheetname character varying(500),
    lifetime integer NOT NULL,
    lifetimewrite character varying(500),
    lifetimewrite_clear boolean NOT NULL,
    block_days integer NOT NULL,
    dopprizeinfo character varying(500),
    postpone_id integer,
    exclude_admins boolean NOT NULL,
    post_url character varying(500),
    "autopostDate" date,
    "autopostDayOfTheWeek" character varying(1),
    "autopostTime" time without time zone,
    autopost_text text,
    autopostimage text,
    ask_mobile_phone boolean NOT NULL,
    lastvideos text[],
    sendpromos integer[],
    ask_phones integer[],
    contest_status_text text NOT NULL,
    contest_status_date timestamp with time zone NOT NULL,
    selected_winners text,
    selected_posts text,
    promokod_interval boolean NOT NULL,
    promokod_interval_text text,
    winners_there text,
    allusers_there text,
    comment_answer text,
    need_senler boolean NOT NULL,
    needs character varying(255) NOT NULL,
    needs2 character varying(255) NOT NULL,
    needs3 character varying(255) NOT NULL,
    photo_in_comment boolean NOT NULL,
    add_check_groups text,
    current_check_groups text,
    current_check_groups_ids text,
    strong_video boolean NOT NULL,
    post_link character varying(500),
    "pinCurrentPost" boolean NOT NULL,
    "unpinCurrentPost" boolean NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    vid_id integer,
    comment_answer_check character varying(1),
    winner_ls_text text,
    autopostimage2 text,
    CONSTRAINT daywinners_historicalweeklywinners_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT daywinners_historicalweeklywinners_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT daywinners_historicalweeklywinners_postpone_id_check CHECK ((postpone_id >= 0)),
    CONSTRAINT daywinners_historicalweeklywinners_searchdays_check CHECK ((searchdays >= 0))
);


ALTER TABLE public.daywinners_historicalweeklywinners OWNER TO vktenantuser;

--
-- Name: daywinners_historicalweeklywinners_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.daywinners_historicalweeklywinners_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.daywinners_historicalweeklywinners_history_id_seq OWNER TO vktenantuser;

--
-- Name: daywinners_historicalweeklywinners_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.daywinners_historicalweeklywinners_history_id_seq OWNED BY public.daywinners_historicalweeklywinners.history_id;


--
-- Name: daywinners_makewinnerstime; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_makewinnerstime (
    id integer NOT NULL,
    active boolean NOT NULL,
    "dayOfTheWeek" character varying(1),
    "makeWinnerTime" time without time zone,
    searchdays integer NOT NULL,
    image character varying(100),
    post_template_text text,
    last_run timestamp with time zone,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    lifetimewrite_clear boolean NOT NULL,
    postpone_id integer,
    exclude_admins boolean NOT NULL,
    post_url character varying(500),
    "autopostDayOfTheWeek" character varying(1),
    "autopostTime" time without time zone,
    autopost_text text,
    autopostimage character varying(100),
    lastvideos text[],
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    vid_id integer,
    dopprizeinfo character varying(500),
    block_days integer NOT NULL,
    sendpromos integer[],
    "autopostDate" date,
    "makeWinnerDate" date,
    lifetime integer NOT NULL,
    ask_mobile_phone boolean NOT NULL,
    ask_phones integer[],
    "oddWeek" character varying(1),
    contest_status_date timestamp with time zone NOT NULL,
    contest_status_text text NOT NULL,
    selected_winners text,
    promokod_interval boolean NOT NULL,
    promokod_interval_text text,
    selected_posts text,
    winners_there text,
    allusers_there text,
    comment_answer text,
    comment_answer_check character varying(1),
    winner_ls_text text,
    autopostimage2 character varying(100),
    CONSTRAINT daywinners_makewinnerstime_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT daywinners_makewinnerstime_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT daywinners_makewinnerstime_postpone_id_check CHECK ((postpone_id >= 0)),
    CONSTRAINT daywinners_makewinnerstime_searchdays_check CHECK ((searchdays >= 0))
);


ALTER TABLE public.daywinners_makewinnerstime OWNER TO vktenantuser;

--
-- Name: daywinners_makewinnerstime_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.daywinners_makewinnerstime_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.daywinners_makewinnerstime_id_seq OWNER TO vktenantuser;

--
-- Name: daywinners_makewinnerstime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.daywinners_makewinnerstime_id_seq OWNED BY public.daywinners_makewinnerstime.id;


--
-- Name: daywinners_randomactivity; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_randomactivity (
    makewinnerstime_ptr_id integer NOT NULL,
    need_like boolean NOT NULL,
    need_repost boolean NOT NULL,
    need_comment boolean NOT NULL,
    post_own boolean NOT NULL
);


ALTER TABLE public.daywinners_randomactivity OWNER TO vktenantuser;

--
-- Name: daywinners_randomphotoreviews; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_randomphotoreviews (
    makewinnerstime_ptr_id integer NOT NULL,
    hashtag character varying(500),
    send_coupon boolean NOT NULL,
    coupon_lifetime integer NOT NULL,
    coupon text,
    coupon_description character varying(500),
    comment_text text,
    ls_text text,
    comment_no_hash boolean NOT NULL,
    comment_userpost_no_hash text,
    runbgtime integer NOT NULL,
    CONSTRAINT daywinners_randomphotoreviews_coupon_lifetime_check CHECK ((coupon_lifetime >= 0)),
    CONSTRAINT daywinners_randomphotoreviews_runbgtime_check CHECK ((runbgtime >= 0))
);


ALTER TABLE public.daywinners_randomphotoreviews OWNER TO vktenantuser;

--
-- Name: daywinners_weeklywinners; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.daywinners_weeklywinners (
    makewinnerstime_ptr_id integer NOT NULL,
    need_senler boolean NOT NULL,
    post_link character varying(500),
    "unpinCurrentPost" boolean NOT NULL,
    needs character varying(255) NOT NULL,
    needs2 character varying(255) NOT NULL,
    needs3 character varying(255) NOT NULL,
    "pinCurrentPost" boolean NOT NULL,
    strong_video boolean NOT NULL,
    add_check_groups text,
    current_check_groups text,
    current_check_groups_ids text,
    photo_in_comment boolean NOT NULL
);


ALTER TABLE public.daywinners_weeklywinners OWNER TO vktenantuser;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO vktenantuser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO vktenantuser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO vktenantuser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO vktenantuser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO vktenantuser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO vktenantuser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO vktenantuser;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO vktenantuser;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO vktenantuser;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: easy_thumbnails_source; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.easy_thumbnails_source (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL
);


ALTER TABLE public.easy_thumbnails_source OWNER TO vktenantuser;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.easy_thumbnails_source_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_source_id_seq OWNER TO vktenantuser;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.easy_thumbnails_source_id_seq OWNED BY public.easy_thumbnails_source.id;


--
-- Name: easy_thumbnails_thumbnail; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.easy_thumbnails_thumbnail (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL,
    source_id integer NOT NULL
);


ALTER TABLE public.easy_thumbnails_thumbnail OWNER TO vktenantuser;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.easy_thumbnails_thumbnail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnail_id_seq OWNER TO vktenantuser;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.easy_thumbnails_thumbnail_id_seq OWNED BY public.easy_thumbnails_thumbnail.id;


--
-- Name: easy_thumbnails_thumbnaildimensions; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.easy_thumbnails_thumbnaildimensions (
    id integer NOT NULL,
    thumbnail_id integer NOT NULL,
    width integer,
    height integer,
    CONSTRAINT easy_thumbnails_thumbnaildimensions_height_check CHECK ((height >= 0)),
    CONSTRAINT easy_thumbnails_thumbnaildimensions_width_check CHECK ((width >= 0))
);


ALTER TABLE public.easy_thumbnails_thumbnaildimensions OWNER TO vktenantuser;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.easy_thumbnails_thumbnaildimensions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnaildimensions_id_seq OWNER TO vktenantuser;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.easy_thumbnails_thumbnaildimensions_id_seq OWNED BY public.easy_thumbnails_thumbnaildimensions.id;


--
-- Name: gameroulet_banditimageslosing; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_banditimageslosing (
    id integer NOT NULL,
    image character varying(100),
    property_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.gameroulet_banditimageslosing OWNER TO vktenantuser;

--
-- Name: gameroulet_banditimageslosing_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_banditimageslosing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_banditimageslosing_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_banditimageslosing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_banditimageslosing_id_seq OWNED BY public.gameroulet_banditimageslosing.id;


--
-- Name: gameroulet_banditimageswin; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_banditimageswin (
    id integer NOT NULL,
    image character varying(100),
    property_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.gameroulet_banditimageswin OWNER TO vktenantuser;

--
-- Name: gameroulet_banditimageswin_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_banditimageswin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_banditimageswin_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_banditimageswin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_banditimageswin_id_seq OWNED BY public.gameroulet_banditimageswin.id;


--
-- Name: gameroulet_banditsetimages; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_banditsetimages (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.gameroulet_banditsetimages OWNER TO vktenantuser;

--
-- Name: gameroulet_banditsetimages_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_banditsetimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_banditsetimages_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_banditsetimages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_banditsetimages_id_seq OWNED BY public.gameroulet_banditsetimages.id;


--
-- Name: gameroulet_doprouletpost; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_doprouletpost (
    id integer NOT NULL,
    "dopPostDate" timestamp with time zone NOT NULL,
    "dopPostText" text,
    "dopPostImage" character varying(100),
    "dopPostId" integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tenant_id integer NOT NULL,
    CONSTRAINT "gameroulet_doprouletpost_dopPostId_check" CHECK (("dopPostId" >= 0)),
    CONSTRAINT gameroulet_doprouletpost_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.gameroulet_doprouletpost OWNER TO vktenantuser;

--
-- Name: gameroulet_doprouletpost_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_doprouletpost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_doprouletpost_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_doprouletpost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_doprouletpost_id_seq OWNED BY public.gameroulet_doprouletpost.id;


--
-- Name: gameroulet_historicalkostigame; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_historicalkostigame (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autostop_date timestamp with time zone,
    autopost_text text,
    autopostimage text,
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userlives_like integer,
    userlives_repost integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage text,
    "pinCurrentPost" boolean NOT NULL,
    "KostiBgImage" text,
    game_field character varying(255) NOT NULL,
    draw_user_ava boolean NOT NULL,
    user_ava character varying(255) NOT NULL,
    draw_group_logo boolean NOT NULL,
    group_logo character varying(255) NOT NULL,
    color character varying(18) NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    kostiimages_id integer,
    tenant_id integer,
    CONSTRAINT gameroulet_historicalkostigame_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_historicalkostigame_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_historicalkostigame_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_historicalkostigame_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_historicalkostigame_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_historicalkostigame_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_historicalkostigame_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_historicalkostigame OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalkostigame_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_historicalkostigame_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_historicalkostigame_history_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalkostigame_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_historicalkostigame_history_id_seq OWNED BY public.gameroulet_historicalkostigame.history_id;


--
-- Name: gameroulet_historicalrandstop; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_historicalrandstop (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autopost_text text,
    autopostimage text,
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userlives_like integer,
    userlives_repost integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage text,
    "pinCurrentPost" boolean NOT NULL,
    autostop_date timestamp with time zone NOT NULL,
    start_t integer NOT NULL,
    end_t integer NOT NULL,
    limit_per_day integer NOT NULL,
    generated integer NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    CONSTRAINT gameroulet_historicalrandstop_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_end_t_check CHECK ((end_t >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_limit_per_day_check CHECK ((limit_per_day >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_start_t_check CHECK ((start_t >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_historicalrandstop_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_historicalrandstop OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalrandstop_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_historicalrandstop_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_historicalrandstop_history_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalrandstop_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_historicalrandstop_history_id_seq OWNED BY public.gameroulet_historicalrandstop.history_id;


--
-- Name: gameroulet_historicalrouletbanditgame; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_historicalrouletbanditgame (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autostop_date timestamp with time zone,
    autopost_text text,
    autopostimage text,
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    userlives integer,
    userlives_like integer,
    userlives_repost integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage text,
    "pinCurrentPost" boolean NOT NULL,
    chances integer,
    game_cmd character varying(500),
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    rouletimages_id integer,
    tenant_id integer,
    CONSTRAINT gameroulet_historicalrouletbanditgame_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_historicalrouletbanditgame_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_historicalrouletbanditgame_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_historicalrouletbanditgame_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_historicalrouletbanditgame_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_historicalrouletbanditgame_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_historicalrouletbanditgame_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_historicalrouletbanditgame OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalrouletbanditgame_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_historicalrouletbanditgame_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_historicalrouletbanditgame_history_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalrouletbanditgame_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_historicalrouletbanditgame_history_id_seq OWNED BY public.gameroulet_historicalrouletbanditgame.history_id;


--
-- Name: gameroulet_historicalrouletbombergame; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_historicalrouletbombergame (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autostop_date timestamp with time zone,
    autopost_text text,
    autopostimage text,
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    userlives_like integer,
    userlives_repost integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage text,
    "pinCurrentPost" boolean NOT NULL,
    sizefield integer,
    chances integer,
    userlives integer,
    gamefield integer[],
    bombs integer[],
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    CONSTRAINT gameroulet_historicalrouletbombergame_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_historicalrouletbombergame_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_historicalrouletbombergame_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_historicalrouletbombergame_sizefield_check CHECK ((sizefield >= 0)),
    CONSTRAINT gameroulet_historicalrouletbombergame_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_historicalrouletbombergame_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_historicalrouletbombergame_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_historicalrouletbombergame_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_historicalrouletbombergame OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalrouletbombergame_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_historicalrouletbombergame_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_historicalrouletbombergame_history_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalrouletbombergame_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_historicalrouletbombergame_history_id_seq OWNED BY public.gameroulet_historicalrouletbombergame.history_id;


--
-- Name: gameroulet_historicalroulethide; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_historicalroulethide (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autostop_date timestamp with time zone,
    autopost_text text,
    autopostimage text,
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userlives_like integer,
    userlives_repost integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage text,
    "pinCurrentPost" boolean NOT NULL,
    minv integer NOT NULL,
    maxv integer NOT NULL,
    true_answer character varying(500),
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    CONSTRAINT gameroulet_historicalroulethide_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_historicalroulethide_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_historicalroulethide_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_historicalroulethide_maxv_check CHECK ((maxv >= 0)),
    CONSTRAINT gameroulet_historicalroulethide_minv_check CHECK ((minv >= 0)),
    CONSTRAINT gameroulet_historicalroulethide_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_historicalroulethide_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_historicalroulethide_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_historicalroulethide_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_historicalroulethide OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalroulethide_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_historicalroulethide_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_historicalroulethide_history_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalroulethide_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_historicalroulethide_history_id_seq OWNED BY public.gameroulet_historicalroulethide.history_id;


--
-- Name: gameroulet_historicalseabattlegame; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_historicalseabattlegame (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autostop_date timestamp with time zone,
    autopost_text text,
    autopostimage text,
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userlives_like integer,
    userlives_repost integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    ts timestamp with time zone NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage text,
    "pinCurrentPost" boolean NOT NULL,
    "SeaBgImage" text,
    seabattle_field character varying(255) NOT NULL,
    "mapSize" integer,
    currentgame integer[],
    "currCellColor" character varying(18) NOT NULL,
    "colorDot" character varying(18) NOT NULL,
    "colorCross" character varying(18) NOT NULL,
    "colorCell" character varying(18) NOT NULL,
    "colorText" character varying(18) NOT NULL,
    "colorShadow" character varying(18) NOT NULL,
    "shadowPx" integer,
    lastpostedit timestamp with time zone,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    CONSTRAINT gameroulet_historicalseabattlegame_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_historicalseabattlegame_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_historicalseabattlegame_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT "gameroulet_historicalseabattlegame_mapSize_check" CHECK (("mapSize" >= 0)),
    CONSTRAINT "gameroulet_historicalseabattlegame_shadowPx_check" CHECK (("shadowPx" >= 0)),
    CONSTRAINT gameroulet_historicalseabattlegame_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_historicalseabattlegame_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_historicalseabattlegame_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_historicalseabattlegame_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_historicalseabattlegame OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalseabattlegame_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_historicalseabattlegame_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_historicalseabattlegame_history_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_historicalseabattlegame_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_historicalseabattlegame_history_id_seq OWNED BY public.gameroulet_historicalseabattlegame.history_id;


--
-- Name: gameroulet_kostigame; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_kostigame (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autopost_text text,
    autopostimage character varying(100),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    only_one_prize boolean NOT NULL,
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    "KostiBgImage" character varying(100),
    game_field character varying(255) NOT NULL,
    draw_user_ava boolean NOT NULL,
    user_ava character varying(255) NOT NULL,
    draw_group_logo boolean NOT NULL,
    group_logo character varying(255) NOT NULL,
    color character varying(18) NOT NULL,
    group_id integer,
    kostiimages_id integer,
    tenant_id integer NOT NULL,
    ts timestamp with time zone NOT NULL,
    need_senler boolean NOT NULL,
    dopprizeinfo character varying(500),
    sheetname character varying(500),
    autostop_date timestamp with time zone,
    need_group_join boolean NOT NULL,
    senler_link character varying(500),
    need_like_post boolean NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage character varying(100),
    userlives_like integer,
    userlives_repost integer,
    "pinCurrentPost" boolean NOT NULL,
    CONSTRAINT gameroulet_kostigame_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_kostigame_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_kostigame_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_kostigame_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_kostigame_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_kostigame_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_kostigame_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_kostigame OWNER TO vktenantuser;

--
-- Name: gameroulet_kostigame_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_kostigame_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_kostigame_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_kostigame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_kostigame_id_seq OWNED BY public.gameroulet_kostigame.id;


--
-- Name: gameroulet_kostigameprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_kostigameprize (
    rouletprizebase_ptr_id integer NOT NULL,
    contest_id integer
);


ALTER TABLE public.gameroulet_kostigameprize OWNER TO vktenantuser;

--
-- Name: gameroulet_kostisetimages; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_kostisetimages (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    k1 character varying(100),
    k2 character varying(100),
    k3 character varying(100),
    k4 character varying(100),
    k5 character varying(100),
    k6 character varying(100),
    tenant_id integer NOT NULL
);


ALTER TABLE public.gameroulet_kostisetimages OWNER TO vktenantuser;

--
-- Name: gameroulet_kostisetimages_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_kostisetimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_kostisetimages_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_kostisetimages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_kostisetimages_id_seq OWNED BY public.gameroulet_kostisetimages.id;


--
-- Name: gameroulet_randstop; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_randstop (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autopost_text text,
    autopostimage character varying(100),
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    autostop_date timestamp with time zone NOT NULL,
    start_t integer NOT NULL,
    end_t integer NOT NULL,
    group_id integer,
    tenant_id integer NOT NULL,
    generated integer NOT NULL,
    limit_per_day integer NOT NULL,
    winnerimage character varying(100),
    userlives_like integer,
    userlives_repost integer,
    "pinCurrentPost" boolean NOT NULL,
    CONSTRAINT gameroulet_randstop_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_randstop_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_randstop_end_t_check CHECK ((end_t >= 0)),
    CONSTRAINT gameroulet_randstop_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_randstop_limit_per_day_check CHECK ((limit_per_day >= 0)),
    CONSTRAINT gameroulet_randstop_start_t_check CHECK ((start_t >= 0)),
    CONSTRAINT gameroulet_randstop_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_randstop_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_randstop_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_randstop_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_randstop OWNER TO vktenantuser;

--
-- Name: gameroulet_randstop_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_randstop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_randstop_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_randstop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_randstop_id_seq OWNED BY public.gameroulet_randstop.id;


--
-- Name: gameroulet_rouletbanditgame; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletbanditgame (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autopost_text text,
    autopostimage character varying(100),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    game_cmd character varying(500),
    chances integer,
    userlives integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    only_one_prize boolean NOT NULL,
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    group_id integer,
    rouletimages_id integer,
    tenant_id integer NOT NULL,
    ts timestamp with time zone NOT NULL,
    need_senler boolean NOT NULL,
    dopprizeinfo character varying(500),
    sheetname character varying(500),
    autostop_date timestamp with time zone,
    need_group_join boolean NOT NULL,
    senler_link character varying(500),
    need_like_post boolean NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage character varying(100),
    userlives_like integer,
    userlives_repost integer,
    "pinCurrentPost" boolean NOT NULL,
    CONSTRAINT gameroulet_rouletbanditgame_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_rouletbanditgame_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_rouletbanditgame_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_rouletbanditgame_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_rouletbanditgame_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_rouletbanditgame_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_rouletbanditgame_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_rouletbanditgame OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletbanditgame_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_rouletbanditgame_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_rouletbanditgame_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletbanditgame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_rouletbanditgame_id_seq OWNED BY public.gameroulet_rouletbanditgame.id;


--
-- Name: gameroulet_rouletbombergame; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletbombergame (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autopost_text text,
    autopostimage character varying(100),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    only_one_prize boolean NOT NULL,
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    chances integer,
    userlives integer,
    group_id integer,
    tenant_id integer NOT NULL,
    gamefield integer[],
    sizefield integer,
    bombs integer[],
    ts timestamp with time zone NOT NULL,
    need_senler boolean NOT NULL,
    dopprizeinfo character varying(500),
    sheetname character varying(500),
    autostop_date timestamp with time zone,
    need_group_join boolean NOT NULL,
    senler_link character varying(500),
    need_like_post boolean NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage character varying(100),
    userlives_like integer,
    userlives_repost integer,
    "pinCurrentPost" boolean NOT NULL,
    CONSTRAINT gameroulet_rouletbombergame_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_rouletbombergame_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_rouletbombergame_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_rouletbombergame_sizefield_check CHECK ((sizefield >= 0)),
    CONSTRAINT gameroulet_rouletbombergame_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_rouletbombergame_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_rouletbombergame_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_rouletbombergame_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_rouletbombergame OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletbombergame_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_rouletbombergame_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_rouletbombergame_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletbombergame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_rouletbombergame_id_seq OWNED BY public.gameroulet_rouletbombergame.id;


--
-- Name: gameroulet_rouletbomberprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletbomberprize (
    rouletprizebase_ptr_id integer NOT NULL,
    contest_id integer
);


ALTER TABLE public.gameroulet_rouletbomberprize OWNER TO vktenantuser;

--
-- Name: gameroulet_roulethide; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_roulethide (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autostop_date timestamp with time zone,
    autopost_text text,
    autopostimage character varying(100),
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    minv integer NOT NULL,
    maxv integer NOT NULL,
    true_answer character varying(500),
    group_id integer,
    tenant_id integer NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage character varying(100),
    userlives_like integer,
    userlives_repost integer,
    "pinCurrentPost" boolean NOT NULL,
    CONSTRAINT gameroulet_roulethide_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_roulethide_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_roulethide_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_roulethide_maxv_check CHECK ((maxv >= 0)),
    CONSTRAINT gameroulet_roulethide_minv_check CHECK ((minv >= 0)),
    CONSTRAINT gameroulet_roulethide_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_roulethide_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_roulethide_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_roulethide_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_roulethide OWNER TO vktenantuser;

--
-- Name: gameroulet_roulethide_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_roulethide_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_roulethide_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_roulethide_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_roulethide_id_seq OWNED BY public.gameroulet_roulethide.id;


--
-- Name: gameroulet_rouletprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletprize (
    contest_id integer,
    rouletprizebase_ptr_id integer NOT NULL
);


ALTER TABLE public.gameroulet_rouletprize OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletprizebase; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletprizebase (
    prize_ptr_id integer NOT NULL,
    count integer NOT NULL,
    CONSTRAINT gameroulet_rouletprizebase_count_check CHECK ((count >= 0))
);


ALTER TABLE public.gameroulet_rouletprizebase OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletprizehide; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletprizehide (
    rouletprizebase_ptr_id integer NOT NULL,
    contest_id integer
);


ALTER TABLE public.gameroulet_rouletprizehide OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletprizesafe; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletprizesafe (
    rouletprizebase_ptr_id integer NOT NULL,
    contest_id integer
);


ALTER TABLE public.gameroulet_rouletprizesafe OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletprizestop; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletprizestop (
    rouletprizebase_ptr_id integer NOT NULL,
    contest_id integer
);


ALTER TABLE public.gameroulet_rouletprizestop OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletsafe; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletsafe (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autostop_date timestamp with time zone,
    autopost_text text,
    autopostimage character varying(100),
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    need_like_post boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    minv integer NOT NULL,
    maxv integer NOT NULL,
    group_id integer,
    tenant_id integer NOT NULL,
    safeimages_id integer,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage character varying(100),
    userlives_like integer,
    userlives_repost integer,
    "pinCurrentPost" boolean NOT NULL,
    CONSTRAINT gameroulet_rouletsafe_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_rouletsafe_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_rouletsafe_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT gameroulet_rouletsafe_maxv_check CHECK ((maxv >= 0)),
    CONSTRAINT gameroulet_rouletsafe_minv_check CHECK ((minv >= 0)),
    CONSTRAINT gameroulet_rouletsafe_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_rouletsafe_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_rouletsafe_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_rouletsafe_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_rouletsafe OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletsafe_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_rouletsafe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_rouletsafe_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletsafe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_rouletsafe_id_seq OWNED BY public.gameroulet_rouletsafe.id;


--
-- Name: gameroulet_rouletuserlives; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_rouletuserlives (
    id integer NOT NULL,
    userid integer,
    lives integer NOT NULL,
    usertime timestamp with time zone,
    post_id integer NOT NULL,
    contest_id integer,
    tenant_id integer NOT NULL,
    subscribed boolean NOT NULL,
    group_joined boolean NOT NULL,
    liked_post boolean NOT NULL,
    make_repost boolean NOT NULL
);


ALTER TABLE public.gameroulet_rouletuserlives OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletuserlives_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_rouletuserlives_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_rouletuserlives_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_rouletuserlives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_rouletuserlives_id_seq OWNED BY public.gameroulet_rouletuserlives.id;


--
-- Name: gameroulet_seabattlegame; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_seabattlegame (
    id integer NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    autopost_date timestamp with time zone,
    autostop_date timestamp with time zone,
    autopost_text text,
    autopostimage character varying(100),
    dopprizeinfo character varying(500),
    lifetime integer NOT NULL,
    block_days integer NOT NULL,
    prizes_shuffle boolean NOT NULL,
    chances integer,
    userlives integer,
    userwait integer NOT NULL,
    user_reset_lives_time integer NOT NULL,
    need_senler boolean NOT NULL,
    senler_link character varying(500),
    need_group_join boolean NOT NULL,
    only_one_prize boolean NOT NULL,
    sheetname character varying(500),
    lifetimewrite character varying(500),
    gameprizes integer[],
    currentgame integer[],
    ts timestamp with time zone NOT NULL,
    "SeaBgImage" character varying(100),
    group_id integer,
    tenant_id integer NOT NULL,
    seabattle_field character varying(255) NOT NULL,
    "colorCell" character varying(18) NOT NULL,
    "colorCross" character varying(18) NOT NULL,
    "colorDot" character varying(18) NOT NULL,
    "colorShadow" character varying(18) NOT NULL,
    "colorText" character varying(18) NOT NULL,
    "currCellColor" character varying(18) NOT NULL,
    "mapSize" integer,
    "shadowPx" integer,
    lastpostedit timestamp with time zone,
    need_like_post boolean NOT NULL,
    game_start_time timestamp with time zone NOT NULL,
    winnertextls text,
    winnerimage character varying(100),
    userlives_like integer,
    userlives_repost integer,
    "pinCurrentPost" boolean NOT NULL,
    CONSTRAINT gameroulet_seabattlegame_block_days_check CHECK ((block_days >= 0)),
    CONSTRAINT gameroulet_seabattlegame_chances_check CHECK ((chances >= 0)),
    CONSTRAINT gameroulet_seabattlegame_lifetime_check CHECK ((lifetime >= 0)),
    CONSTRAINT "gameroulet_seabattlegame_mapSize_check" CHECK (("mapSize" >= 0)),
    CONSTRAINT "gameroulet_seabattlegame_shadowPx_check" CHECK (("shadowPx" >= 0)),
    CONSTRAINT gameroulet_seabattlegame_userlives_check CHECK ((userlives >= 0)),
    CONSTRAINT gameroulet_seabattlegame_userlives_like_check CHECK ((userlives_like >= 0)),
    CONSTRAINT gameroulet_seabattlegame_userlives_repost_check CHECK ((userlives_repost >= 0)),
    CONSTRAINT gameroulet_seabattlegame_userwait_check CHECK ((userwait >= 0))
);


ALTER TABLE public.gameroulet_seabattlegame OWNER TO vktenantuser;

--
-- Name: gameroulet_seabattlegame_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gameroulet_seabattlegame_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gameroulet_seabattlegame_id_seq OWNER TO vktenantuser;

--
-- Name: gameroulet_seabattlegame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gameroulet_seabattlegame_id_seq OWNED BY public.gameroulet_seabattlegame.id;


--
-- Name: gameroulet_seabattlegameprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gameroulet_seabattlegameprize (
    rouletprizebase_ptr_id integer NOT NULL,
    contest_id integer
);


ALTER TABLE public.gameroulet_seabattlegameprize OWNER TO vktenantuser;

--
-- Name: gpt_gptdialog; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gpt_gptdialog (
    id bigint NOT NULL,
    question text,
    answer text,
    raw_data_question text,
    raw_data_answer text,
    created_at timestamp with time zone NOT NULL,
    key_id bigint
);


ALTER TABLE public.gpt_gptdialog OWNER TO vktenantuser;

--
-- Name: gpt_gptdialog_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gpt_gptdialog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gpt_gptdialog_id_seq OWNER TO vktenantuser;

--
-- Name: gpt_gptdialog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gpt_gptdialog_id_seq OWNED BY public.gpt_gptdialog.id;


--
-- Name: gpt_gptkey; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gpt_gptkey (
    id bigint NOT NULL,
    openai_key character varying(500),
    auth_errors integer NOT NULL
);


ALTER TABLE public.gpt_gptkey OWNER TO vktenantuser;

--
-- Name: gpt_gptkey_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gpt_gptkey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gpt_gptkey_id_seq OWNER TO vktenantuser;

--
-- Name: gpt_gptkey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gpt_gptkey_id_seq OWNED BY public.gpt_gptkey.id;


--
-- Name: gpthelper_commentanswer; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gpthelper_commentanswer (
    id bigint NOT NULL,
    active boolean NOT NULL,
    main_prompt text NOT NULL,
    post_settings character varying(1),
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    max_wait integer NOT NULL,
    min_wait integer NOT NULL,
    CONSTRAINT gpthelper_commentanswer_max_wait_check CHECK ((max_wait >= 0)),
    CONSTRAINT gpthelper_commentanswer_min_wait_check CHECK ((min_wait >= 0))
);


ALTER TABLE public.gpthelper_commentanswer OWNER TO vktenantuser;

--
-- Name: gpthelper_commentanswer_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gpthelper_commentanswer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gpthelper_commentanswer_id_seq OWNER TO vktenantuser;

--
-- Name: gpthelper_commentanswer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gpthelper_commentanswer_id_seq OWNED BY public.gpthelper_commentanswer.id;


--
-- Name: gpthelper_gptanswerkey; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gpthelper_gptanswerkey (
    id bigint NOT NULL,
    openai_key character varying(500),
    url_endpoint character varying(500),
    auth_errors integer NOT NULL
);


ALTER TABLE public.gpthelper_gptanswerkey OWNER TO vktenantuser;

--
-- Name: gpthelper_gptanswerkey_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gpthelper_gptanswerkey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gpthelper_gptanswerkey_id_seq OWNER TO vktenantuser;

--
-- Name: gpthelper_gptanswerkey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gpthelper_gptanswerkey_id_seq OWNED BY public.gpthelper_gptanswerkey.id;


--
-- Name: gpthelper_gptdialog; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gpthelper_gptdialog (
    id bigint NOT NULL,
    question text,
    answer text,
    raw_data_question text,
    raw_data_answer text,
    created_at timestamp with time zone NOT NULL,
    key_id bigint
);


ALTER TABLE public.gpthelper_gptdialog OWNER TO vktenantuser;

--
-- Name: gpthelper_gptdialog_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gpthelper_gptdialog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gpthelper_gptdialog_id_seq OWNER TO vktenantuser;

--
-- Name: gpthelper_gptdialog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gpthelper_gptdialog_id_seq OWNED BY public.gpthelper_gptdialog.id;


--
-- Name: gpthelper_postsettings; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.gpthelper_postsettings (
    id bigint NOT NULL,
    post_id integer NOT NULL,
    answer_enabled boolean NOT NULL,
    dop_info text,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    post_text text
);


ALTER TABLE public.gpthelper_postsettings OWNER TO vktenantuser;

--
-- Name: gpthelper_postsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.gpthelper_postsettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gpthelper_postsettings_id_seq OWNER TO vktenantuser;

--
-- Name: gpthelper_postsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.gpthelper_postsettings_id_seq OWNED BY public.gpthelper_postsettings.id;


--
-- Name: greeting_commentpromo; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.greeting_commentpromo (
    id bigint NOT NULL,
    active boolean NOT NULL,
    stop_date timestamp with time zone,
    post_link character varying(500) NOT NULL,
    text_ls text NOT NULL,
    promos text,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    attachment_check character varying(10),
    need_text character varying(500)
);


ALTER TABLE public.greeting_commentpromo OWNER TO vktenantuser;

--
-- Name: greeting_commentpromo_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.greeting_commentpromo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.greeting_commentpromo_id_seq OWNER TO vktenantuser;

--
-- Name: greeting_commentpromo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.greeting_commentpromo_id_seq OWNED BY public.greeting_commentpromo.id;


--
-- Name: greeting_communityreviewspromo; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.greeting_communityreviewspromo (
    id bigint NOT NULL,
    active boolean NOT NULL,
    text_ls text NOT NULL,
    promos text,
    last_id integer NOT NULL,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    min_mark integer NOT NULL,
    status text,
    CONSTRAINT greeting_communityreviewspromo_last_id_check CHECK ((last_id >= 0)),
    CONSTRAINT greeting_communityreviewspromo_min_mark_check CHECK ((min_mark >= 0))
);


ALTER TABLE public.greeting_communityreviewspromo OWNER TO vktenantuser;

--
-- Name: greeting_communityreviewspromo_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.greeting_communityreviewspromo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.greeting_communityreviewspromo_id_seq OWNER TO vktenantuser;

--
-- Name: greeting_communityreviewspromo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.greeting_communityreviewspromo_id_seq OWNED BY public.greeting_communityreviewspromo.id;


--
-- Name: greeting_greeting; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.greeting_greeting (
    id bigint NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    senler_subscribelink character varying(500),
    senler_needgroup integer,
    senler_utm integer,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    senler_subscribelink_saved character varying(500),
    CONSTRAINT greeting_greeting_senler_needgroup_check CHECK ((senler_needgroup >= 0)),
    CONSTRAINT greeting_greeting_senler_utm_check CHECK ((senler_utm >= 0))
);


ALTER TABLE public.greeting_greeting OWNER TO vktenantuser;

--
-- Name: greeting_greeting_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.greeting_greeting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.greeting_greeting_id_seq OWNER TO vktenantuser;

--
-- Name: greeting_greeting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.greeting_greeting_id_seq OWNED BY public.greeting_greeting.id;


--
-- Name: greeting_historicalgreeting; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.greeting_historicalgreeting (
    id bigint NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    senler_subscribelink character varying(500),
    senler_needgroup integer,
    senler_utm integer,
    senler_subscribelink_saved character varying(500),
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    CONSTRAINT greeting_historicalgreeting_senler_needgroup_check CHECK ((senler_needgroup >= 0)),
    CONSTRAINT greeting_historicalgreeting_senler_utm_check CHECK ((senler_utm >= 0))
);


ALTER TABLE public.greeting_historicalgreeting OWNER TO vktenantuser;

--
-- Name: greeting_historicalgreeting_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.greeting_historicalgreeting_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.greeting_historicalgreeting_history_id_seq OWNER TO vktenantuser;

--
-- Name: greeting_historicalgreeting_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.greeting_historicalgreeting_history_id_seq OWNED BY public.greeting_historicalgreeting.history_id;


--
-- Name: greeting_historicalrepostpromo; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.greeting_historicalrepostpromo (
    id bigint NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    text_ls text NOT NULL,
    promos text,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    stop_date timestamp with time zone
);


ALTER TABLE public.greeting_historicalrepostpromo OWNER TO vktenantuser;

--
-- Name: greeting_historicalrepostpromo_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.greeting_historicalrepostpromo_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.greeting_historicalrepostpromo_history_id_seq OWNER TO vktenantuser;

--
-- Name: greeting_historicalrepostpromo_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.greeting_historicalrepostpromo_history_id_seq OWNED BY public.greeting_historicalrepostpromo.history_id;


--
-- Name: greeting_jointemplate; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.greeting_jointemplate (
    id bigint NOT NULL,
    text text,
    parent_id bigint NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.greeting_jointemplate OWNER TO vktenantuser;

--
-- Name: greeting_jointemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.greeting_jointemplate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.greeting_jointemplate_id_seq OWNER TO vktenantuser;

--
-- Name: greeting_jointemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.greeting_jointemplate_id_seq OWNED BY public.greeting_jointemplate.id;


--
-- Name: greeting_repostpromo; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.greeting_repostpromo (
    id bigint NOT NULL,
    active boolean NOT NULL,
    post_link character varying(500),
    text_ls text NOT NULL,
    promos text,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    stop_date timestamp with time zone
);


ALTER TABLE public.greeting_repostpromo OWNER TO vktenantuser;

--
-- Name: greeting_repostpromo_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.greeting_repostpromo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.greeting_repostpromo_id_seq OWNER TO vktenantuser;

--
-- Name: greeting_repostpromo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.greeting_repostpromo_id_seq OWNED BY public.greeting_repostpromo.id;


--
-- Name: newcontest_historicalnewcontestprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.newcontest_historicalnewcontestprize (
    id integer NOT NULL,
    prize_ptr_id integer,
    title text NOT NULL,
    lifetime integer,
    promokod character varying(255),
    promokodes text,
    maxcount integer,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    contest_id bigint,
    history_user_id integer,
    tenant_id integer,
    CONSTRAINT newcontest_historicalnewcontestprize_lifetime_check CHECK ((lifetime >= 0))
);


ALTER TABLE public.newcontest_historicalnewcontestprize OWNER TO vktenantuser;

--
-- Name: newcontest_historicalnewcontestprize_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.newcontest_historicalnewcontestprize_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.newcontest_historicalnewcontestprize_history_id_seq OWNER TO vktenantuser;

--
-- Name: newcontest_historicalnewcontestprize_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.newcontest_historicalnewcontestprize_history_id_seq OWNED BY public.newcontest_historicalnewcontestprize.history_id;


--
-- Name: newcontest_historicalrepostcontest; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.newcontest_historicalrepostcontest (
    id bigint NOT NULL,
    contest_title character varying(500) NOT NULL,
    contest_subtitle text,
    dopcontestinfo text,
    link_title text NOT NULL,
    active boolean NOT NULL,
    autopost_date timestamp with time zone,
    autopost_text text NOT NULL,
    autopost_image text,
    post_template_text text,
    userpost_text text,
    userpost_image text,
    result_date timestamp with time zone,
    add_check_groups text,
    current_check_groups text,
    current_check_groups_ids text,
    need_comment boolean NOT NULL,
    need_comment_text text,
    post_link character varying(500),
    post_links text[],
    groupscount integer,
    "pinCurrentPost" boolean NOT NULL,
    "unpinCurrentPost" boolean NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    tenant_id integer
);


ALTER TABLE public.newcontest_historicalrepostcontest OWNER TO vktenantuser;

--
-- Name: newcontest_historicalrepostcontest_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.newcontest_historicalrepostcontest_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.newcontest_historicalrepostcontest_history_id_seq OWNER TO vktenantuser;

--
-- Name: newcontest_historicalrepostcontest_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.newcontest_historicalrepostcontest_history_id_seq OWNED BY public.newcontest_historicalrepostcontest.history_id;


--
-- Name: newcontest_newcontestprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.newcontest_newcontestprize (
    prize_ptr_id integer NOT NULL,
    promokodes text,
    contest_id bigint,
    maxcount integer
);


ALTER TABLE public.newcontest_newcontestprize OWNER TO vktenantuser;

--
-- Name: newcontest_participantcontest; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.newcontest_participantcontest (
    id bigint NOT NULL,
    userid integer,
    first_name character varying(120),
    last_name character varying(120),
    post_id integer,
    created_at timestamp with time zone NOT NULL,
    contest_id bigint NOT NULL,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.newcontest_participantcontest OWNER TO vktenantuser;

--
-- Name: newcontest_participantcontest_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.newcontest_participantcontest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.newcontest_participantcontest_id_seq OWNER TO vktenantuser;

--
-- Name: newcontest_participantcontest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.newcontest_participantcontest_id_seq OWNED BY public.newcontest_participantcontest.id;


--
-- Name: newcontest_repostcontest; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.newcontest_repostcontest (
    id bigint NOT NULL,
    active boolean NOT NULL,
    autopost_date timestamp with time zone,
    autopost_text text NOT NULL,
    autopost_image character varying(100),
    dopcontestinfo text,
    userpost_text text,
    userpost_image character varying(100),
    result_date timestamp with time zone,
    tenant_id integer NOT NULL,
    contest_subtitle text,
    contest_title character varying(500) NOT NULL,
    add_check_groups text,
    current_check_groups text,
    current_check_groups_ids text,
    link_title text NOT NULL,
    need_comment boolean NOT NULL,
    need_comment_text text,
    post_link character varying(500),
    post_template_text text,
    post_links text[],
    groupscount integer,
    "pinCurrentPost" boolean NOT NULL,
    "unpinCurrentPost" boolean NOT NULL
);


ALTER TABLE public.newcontest_repostcontest OWNER TO vktenantuser;

--
-- Name: newcontest_repostcontest_forGroups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."newcontest_repostcontest_forGroups" (
    id integer NOT NULL,
    repostcontest_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public."newcontest_repostcontest_forGroups" OWNER TO vktenantuser;

--
-- Name: newcontest_repostcontest_forGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."newcontest_repostcontest_forGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."newcontest_repostcontest_forGroups_id_seq" OWNER TO vktenantuser;

--
-- Name: newcontest_repostcontest_forGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."newcontest_repostcontest_forGroups_id_seq" OWNED BY public."newcontest_repostcontest_forGroups".id;


--
-- Name: newcontest_repostcontest_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.newcontest_repostcontest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.newcontest_repostcontest_id_seq OWNER TO vktenantuser;

--
-- Name: newcontest_repostcontest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.newcontest_repostcontest_id_seq OWNED BY public.newcontest_repostcontest.id;


--
-- Name: ownerCoverPhoto_ownercoverphotobg; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."ownerCoverPhoto_ownercoverphotobg" (
    id integer NOT NULL,
    active boolean NOT NULL,
    image character varying(100),
    primage character varying(100),
    last_winners_count integer NOT NULL,
    draw_last_winners boolean NOT NULL,
    draw_group_logo boolean NOT NULL,
    last_winners character varying(255) NOT NULL,
    group_logo character varying(255) NOT NULL,
    textcolor character varying(18) NOT NULL,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    updated timestamp with time zone,
    CONSTRAINT "ownerCoverPhoto_ownercoverphotobg_last_winners_count_check" CHECK ((last_winners_count >= 0))
);


ALTER TABLE public."ownerCoverPhoto_ownercoverphotobg" OWNER TO vktenantuser;

--
-- Name: ownerCoverPhoto_ownercoverphotobg_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."ownerCoverPhoto_ownercoverphotobg_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ownerCoverPhoto_ownercoverphotobg_id_seq" OWNER TO vktenantuser;

--
-- Name: ownerCoverPhoto_ownercoverphotobg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."ownerCoverPhoto_ownercoverphotobg_id_seq" OWNED BY public."ownerCoverPhoto_ownercoverphotobg".id;


--
-- Name: photoTickets_historicalticket; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."photoTickets_historicalticket" (
    id bigint NOT NULL,
    date timestamp with time zone,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    comment_id integer NOT NULL,
    ticket_num integer NOT NULL,
    text text,
    imgs text,
    link text,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    tset_id bigint
);


ALTER TABLE public."photoTickets_historicalticket" OWNER TO vktenantuser;

--
-- Name: photoTickets_historicalticket_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."photoTickets_historicalticket_history_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."photoTickets_historicalticket_history_id_seq" OWNER TO vktenantuser;

--
-- Name: photoTickets_historicalticket_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."photoTickets_historicalticket_history_id_seq" OWNED BY public."photoTickets_historicalticket".history_id;


--
-- Name: photoTickets_historicalticketsettings; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."photoTickets_historicalticketsettings" (
    id bigint NOT NULL,
    active boolean NOT NULL,
    hashtag character varying(500) NOT NULL,
    "ticketComment" text,
    "autoTicketPost" character varying(1),
    "autoTicketComment" character varying(1),
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer
);


ALTER TABLE public."photoTickets_historicalticketsettings" OWNER TO vktenantuser;

--
-- Name: photoTickets_historicalticketsettings_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."photoTickets_historicalticketsettings_history_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."photoTickets_historicalticketsettings_history_id_seq" OWNER TO vktenantuser;

--
-- Name: photoTickets_historicalticketsettings_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."photoTickets_historicalticketsettings_history_id_seq" OWNED BY public."photoTickets_historicalticketsettings".history_id;


--
-- Name: photoTickets_ticket; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."photoTickets_ticket" (
    id bigint NOT NULL,
    date timestamp with time zone,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    comment_id integer NOT NULL,
    imgs text,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    link text,
    tset_id bigint NOT NULL,
    text text,
    ticket_num integer NOT NULL
);


ALTER TABLE public."photoTickets_ticket" OWNER TO vktenantuser;

--
-- Name: photoTickets_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."photoTickets_ticket_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."photoTickets_ticket_id_seq" OWNER TO vktenantuser;

--
-- Name: photoTickets_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."photoTickets_ticket_id_seq" OWNED BY public."photoTickets_ticket".id;


--
-- Name: photoTickets_ticketsettings; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."photoTickets_ticketsettings" (
    id bigint NOT NULL,
    active boolean NOT NULL,
    hashtag character varying(500) NOT NULL,
    "ticketComment" text,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    "autoTicketComment" character varying(1),
    "autoTicketPost" character varying(1)
);


ALTER TABLE public."photoTickets_ticketsettings" OWNER TO vktenantuser;

--
-- Name: photoTickets_ticketsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."photoTickets_ticketsettings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."photoTickets_ticketsettings_id_seq" OWNER TO vktenantuser;

--
-- Name: photoTickets_ticketsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."photoTickets_ticketsettings_id_seq" OWNED BY public."photoTickets_ticketsettings".id;


--
-- Name: pinnedPost_firstpost; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."pinnedPost_firstpost" (
    id bigint NOT NULL,
    link character varying(300),
    text text,
    images text,
    attachments text,
    post_id integer,
    is_pinned boolean NOT NULL,
    updated timestamp with time zone,
    group_id integer,
    tenant_id integer NOT NULL,
    date_endcontest timestamp with time zone,
    is_contest boolean NOT NULL,
    need_update boolean NOT NULL
);


ALTER TABLE public."pinnedPost_firstpost" OWNER TO vktenantuser;

--
-- Name: pinnedPost_firstpost_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."pinnedPost_firstpost_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pinnedPost_firstpost_id_seq" OWNER TO vktenantuser;

--
-- Name: pinnedPost_firstpost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."pinnedPost_firstpost_id_seq" OWNED BY public."pinnedPost_firstpost".id;


--
-- Name: posting_postpone; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_postpone (
    id integer NOT NULL,
    text text,
    date timestamp with time zone,
    image character varying(100),
    post_id integer,
    group_id integer,
    owner_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.posting_postpone OWNER TO vktenantuser;

--
-- Name: posting_postpone_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.posting_postpone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posting_postpone_id_seq OWNER TO vktenantuser;

--
-- Name: posting_postpone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.posting_postpone_id_seq OWNED BY public.posting_postpone.id;


--
-- Name: posting_setposts; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setposts (
    id integer NOT NULL,
    text text,
    date date,
    "time" time without time zone,
    image character varying(100),
    property_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.posting_setposts OWNER TO vktenantuser;

--
-- Name: posting_setposts_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.posting_setposts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posting_setposts_id_seq OWNER TO vktenantuser;

--
-- Name: posting_setposts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.posting_setposts_id_seq OWNED BY public.posting_setposts.id;


--
-- Name: posting_setpostsch; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setpostsch (
    setposts_ptr_id integer NOT NULL
);


ALTER TABLE public.posting_setpostsch OWNER TO vktenantuser;

--
-- Name: posting_setpostsin; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setpostsin (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    startdate date NOT NULL,
    msk_time boolean NOT NULL,
    post_auto_delete boolean NOT NULL,
    setgroup_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.posting_setpostsin OWNER TO vktenantuser;

--
-- Name: posting_setpostsin_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.posting_setpostsin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posting_setpostsin_id_seq OWNER TO vktenantuser;

--
-- Name: posting_setpostsin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.posting_setpostsin_id_seq OWNED BY public.posting_setpostsin.id;


--
-- Name: posting_setpostspn; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setpostspn (
    setposts_ptr_id integer NOT NULL
);


ALTER TABLE public.posting_setpostspn OWNER TO vktenantuser;

--
-- Name: posting_setpostspt; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setpostspt (
    setposts_ptr_id integer NOT NULL
);


ALTER TABLE public.posting_setpostspt OWNER TO vktenantuser;

--
-- Name: posting_setpostssb; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setpostssb (
    setposts_ptr_id integer NOT NULL
);


ALTER TABLE public.posting_setpostssb OWNER TO vktenantuser;

--
-- Name: posting_setpostssr; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setpostssr (
    setposts_ptr_id integer NOT NULL
);


ALTER TABLE public.posting_setpostssr OWNER TO vktenantuser;

--
-- Name: posting_setpostsvs; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setpostsvs (
    setposts_ptr_id integer NOT NULL
);


ALTER TABLE public.posting_setpostsvs OWNER TO vktenantuser;

--
-- Name: posting_setpostsvt; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.posting_setpostsvt (
    setposts_ptr_id integer NOT NULL
);


ALTER TABLE public.posting_setpostsvt OWNER TO vktenantuser;

--
-- Name: prizes_blocked; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_blocked (
    id integer NOT NULL,
    userlink text,
    first_name character varying(100),
    last_name character varying(100),
    username character varying(300),
    userid integer,
    title text,
    userblock timestamp with time zone,
    tenant_id integer NOT NULL
);


ALTER TABLE public.prizes_blocked OWNER TO vktenantuser;

--
-- Name: prizes_blocked_forGroups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."prizes_blocked_forGroups" (
    id integer NOT NULL,
    blocked_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public."prizes_blocked_forGroups" OWNER TO vktenantuser;

--
-- Name: prizes_blocked_forGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."prizes_blocked_forGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."prizes_blocked_forGroups_id_seq" OWNER TO vktenantuser;

--
-- Name: prizes_blocked_forGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."prizes_blocked_forGroups_id_seq" OWNED BY public."prizes_blocked_forGroups".id;


--
-- Name: prizes_blocked_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_blocked_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_blocked_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_blocked_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_blocked_id_seq OWNED BY public.prizes_blocked.id;


--
-- Name: prizes_cached_screen_names; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_cached_screen_names (
    id integer NOT NULL,
    screen_name text,
    userid integer
);


ALTER TABLE public.prizes_cached_screen_names OWNER TO vktenantuser;

--
-- Name: prizes_cached_screen_names_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_cached_screen_names_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_cached_screen_names_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_cached_screen_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_cached_screen_names_id_seq OWNED BY public.prizes_cached_screen_names.id;


--
-- Name: prizes_contestusers; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_contestusers (
    id integer NOT NULL,
    date timestamp with time zone,
    jsonwinners text,
    jsonparticipants text,
    group_id integer,
    tenant_id integer NOT NULL,
    link character varying(300)
);


ALTER TABLE public.prizes_contestusers OWNER TO vktenantuser;

--
-- Name: prizes_contestusers_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_contestusers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_contestusers_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_contestusers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_contestusers_id_seq OWNED BY public.prizes_contestusers.id;


--
-- Name: prizes_modelprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_modelprize (
    id integer NOT NULL,
    title text NOT NULL,
    comment text,
    promo text,
    tenant_id integer NOT NULL
);


ALTER TABLE public.prizes_modelprize OWNER TO vktenantuser;

--
-- Name: prizes_modelprize_forGroups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."prizes_modelprize_forGroups" (
    id integer NOT NULL,
    modelprize_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public."prizes_modelprize_forGroups" OWNER TO vktenantuser;

--
-- Name: prizes_modelprize_forGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."prizes_modelprize_forGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."prizes_modelprize_forGroups_id_seq" OWNER TO vktenantuser;

--
-- Name: prizes_modelprize_forGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."prizes_modelprize_forGroups_id_seq" OWNED BY public."prizes_modelprize_forGroups".id;


--
-- Name: prizes_modelprize_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_modelprize_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_modelprize_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_modelprize_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_modelprize_id_seq OWNED BY public.prizes_modelprize.id;


--
-- Name: prizes_modelwinnerspost; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_modelwinnerspost (
    id integer NOT NULL,
    post_id integer,
    sendpromos integer[],
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.prizes_modelwinnerspost OWNER TO vktenantuser;

--
-- Name: prizes_modelwinnerspost_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_modelwinnerspost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_modelwinnerspost_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_modelwinnerspost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_modelwinnerspost_id_seq OWNED BY public.prizes_modelwinnerspost.id;


--
-- Name: prizes_morpher; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_morpher (
    id integer NOT NULL,
    value text,
    n integer,
    normal text,
    jsondata text
);


ALTER TABLE public.prizes_morpher OWNER TO vktenantuser;

--
-- Name: prizes_morpher_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_morpher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_morpher_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_morpher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_morpher_id_seq OWNED BY public.prizes_morpher.id;


--
-- Name: prizes_prize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_prize (
    id integer NOT NULL,
    title text NOT NULL,
    lifetime integer,
    promokod character varying(255),
    tenant_id integer NOT NULL,
    CONSTRAINT prizes_prize_lifetime_check CHECK ((lifetime >= 0))
);


ALTER TABLE public.prizes_prize OWNER TO vktenantuser;

--
-- Name: prizes_prize_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_prize_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_prize_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_prize_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_prize_id_seq OWNED BY public.prizes_prize.id;


--
-- Name: prizes_prizessendmsg; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_prizessendmsg (
    id integer NOT NULL,
    userid integer,
    msg text,
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.prizes_prizessendmsg OWNER TO vktenantuser;

--
-- Name: prizes_prizessendmsg_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_prizessendmsg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_prizessendmsg_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_prizessendmsg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_prizessendmsg_id_seq OWNED BY public.prizes_prizessendmsg.id;


--
-- Name: prizes_promointerval; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_promointerval (
    id integer NOT NULL,
    userid integer,
    title text NOT NULL,
    promokod character varying(255),
    senddate timestamp with time zone,
    promokod_interval_text text,
    typecontest character varying(100),
    link character varying(300),
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.prizes_promointerval OWNER TO vktenantuser;

--
-- Name: prizes_promointerval_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_promointerval_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_promointerval_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_promointerval_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_promointerval_id_seq OWNED BY public.prizes_promointerval.id;


--
-- Name: prizes_promointervalmany; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_promointervalmany (
    id integer NOT NULL,
    userid integer,
    title text NOT NULL,
    promokods text,
    senddate integer NOT NULL,
    promokod_interval_text text,
    typecontest character varying(100),
    link character varying(300),
    last_send timestamp with time zone,
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.prizes_promointervalmany OWNER TO vktenantuser;

--
-- Name: prizes_promointervalmany_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_promointervalmany_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_promointervalmany_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_promointervalmany_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_promointervalmany_id_seq OWNED BY public.prizes_promointervalmany.id;


--
-- Name: prizes_sendmsg; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_sendmsg (
    id integer NOT NULL,
    userid integer,
    "limit" timestamp with time zone,
    msg text,
    group_id integer,
    tenant_id integer NOT NULL,
    winnerimage character varying(100)
);


ALTER TABLE public.prizes_sendmsg OWNER TO vktenantuser;

--
-- Name: prizes_sendmsg_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_sendmsg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_sendmsg_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_sendmsg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_sendmsg_id_seq OWNED BY public.prizes_sendmsg.id;


--
-- Name: prizes_winner; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.prizes_winner (
    id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    username character varying(300),
    userid integer,
    typecontest character varying(100),
    title text NOT NULL,
    promokod character varying(255),
    windate timestamp with time zone,
    "limit" timestamp with time zone,
    userblock timestamp with time zone,
    link character varying(300),
    group_id integer,
    tenant_id integer NOT NULL,
    txtlimit text,
    dopprizeinfo character varying(500),
    status character varying(300),
    shortdopprizeinfo character varying(500),
    winnerimage character varying(100),
    send_text text
);


ALTER TABLE public.prizes_winner OWNER TO vktenantuser;

--
-- Name: prizes_winner_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.prizes_winner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prizes_winner_id_seq OWNER TO vktenantuser;

--
-- Name: prizes_winner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.prizes_winner_id_seq OWNED BY public.prizes_winner.id;


--
-- Name: randomdata_randomcontest; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.randomdata_randomcontest (
    id bigint NOT NULL,
    input_users text,
    list_prizes text,
    list_winners text,
    out_files text,
    sheetname character varying(500),
    tenant_id integer NOT NULL,
    status character varying(500),
    allusers_title character varying(500),
    hide_phones boolean NOT NULL,
    intro text,
    num_title character varying(500),
    show_allusers boolean NOT NULL,
    show_winners boolean NOT NULL,
    winners_title character varying(500),
    name character varying(500) NOT NULL
);


ALTER TABLE public.randomdata_randomcontest OWNER TO vktenantuser;

--
-- Name: randomdata_randomcontest_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.randomdata_randomcontest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.randomdata_randomcontest_id_seq OWNER TO vktenantuser;

--
-- Name: randomdata_randomcontest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.randomdata_randomcontest_id_seq OWNED BY public.randomdata_randomcontest.id;


--
-- Name: randomdata_randomnumbers; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.randomdata_randomnumbers (
    id bigint NOT NULL,
    allcount integer NOT NULL,
    list_prizes text,
    list_winners text,
    intro text,
    show_winners boolean NOT NULL,
    num_title character varying(500),
    sheetname character varying(500),
    status character varying(500),
    out_files text,
    tenant_id integer NOT NULL,
    name character varying(500) NOT NULL,
    CONSTRAINT randomdata_randomnumbers_allcount_check CHECK ((allcount >= 0))
);


ALTER TABLE public.randomdata_randomnumbers OWNER TO vktenantuser;

--
-- Name: randomdata_randomnumbers_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.randomdata_randomnumbers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.randomdata_randomnumbers_id_seq OWNER TO vktenantuser;

--
-- Name: randomdata_randomnumbers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.randomdata_randomnumbers_id_seq OWNED BY public.randomdata_randomnumbers.id;


--
-- Name: senlergame_senlercodework; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.senlergame_senlercodework (
    id bigint NOT NULL,
    active boolean NOT NULL,
    game_cmd character varying(500) NOT NULL,
    need_group_join boolean NOT NULL,
    senler_secret character varying(200),
    senler_needgroup integer,
    senler_utm integer,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    need_group_join_text text,
    answer_text text,
    answer_image character varying(100),
    CONSTRAINT senlergame_senlercodework_senler_needgroup_check CHECK ((senler_needgroup >= 0)),
    CONSTRAINT senlergame_senlercodework_senler_utm_check CHECK ((senler_utm >= 0))
);


ALTER TABLE public.senlergame_senlercodework OWNER TO vktenantuser;

--
-- Name: senlergame_senlercodework_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.senlergame_senlercodework_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.senlergame_senlercodework_id_seq OWNER TO vktenantuser;

--
-- Name: senlergame_senlercodework_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.senlergame_senlercodework_id_seq OWNED BY public.senlergame_senlercodework.id;


--
-- Name: senlergame_senlerprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.senlergame_senlerprize (
    id bigint NOT NULL,
    title text NOT NULL,
    senlerpromokodes text NOT NULL,
    contest_id bigint,
    tenant_id integer NOT NULL
);


ALTER TABLE public.senlergame_senlerprize OWNER TO vktenantuser;

--
-- Name: senlergame_senlerprize_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.senlergame_senlerprize_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.senlergame_senlerprize_id_seq OWNER TO vktenantuser;

--
-- Name: senlergame_senlerprize_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.senlergame_senlerprize_id_seq OWNED BY public.senlergame_senlerprize.id;


--
-- Name: senlergame_senlerwinners; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.senlergame_senlerwinners (
    id bigint NOT NULL,
    active boolean NOT NULL,
    post_template_text text,
    "makeWinnerDate" timestamp with time zone,
    image character varying(100),
    senler_needgroup integer,
    senler_utm integer,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    vid_id integer,
    tmp_senler_needgroup text,
    tmp_senler_utm text,
    last_upd timestamp with time zone,
    subscribers text,
    tmp_participants text,
    tmp_post_text text,
    tmp_winners text,
    sendpromos integer[],
    CONSTRAINT senlergame_senlerwinners_senler_needgroup_check CHECK ((senler_needgroup >= 0)),
    CONSTRAINT senlergame_senlerwinners_senler_utm_check CHECK ((senler_utm >= 0))
);


ALTER TABLE public.senlergame_senlerwinners OWNER TO vktenantuser;

--
-- Name: senlergame_senlerwinners_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.senlergame_senlerwinners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.senlergame_senlerwinners_id_seq OWNER TO vktenantuser;

--
-- Name: senlergame_senlerwinners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.senlergame_senlerwinners_id_seq OWNED BY public.senlergame_senlerwinners.id;


--
-- Name: simple_dopsimplepost; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.simple_dopsimplepost (
    id bigint NOT NULL,
    "dopPostDate" timestamp with time zone NOT NULL,
    "dopPostText" text,
    "dopPostImage" character varying(100),
    "dopPostId" integer NOT NULL,
    contest_id bigint,
    tenant_id integer NOT NULL,
    CONSTRAINT "simple_dopsimplepost_dopPostId_check" CHECK (("dopPostId" >= 0))
);


ALTER TABLE public.simple_dopsimplepost OWNER TO vktenantuser;

--
-- Name: simple_dopsimplepost_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.simple_dopsimplepost_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simple_dopsimplepost_id_seq OWNER TO vktenantuser;

--
-- Name: simple_dopsimplepost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.simple_dopsimplepost_id_seq OWNED BY public.simple_dopsimplepost.id;


--
-- Name: simple_historicaldopsimplepost; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.simple_historicaldopsimplepost (
    id bigint NOT NULL,
    "dopPostDate" timestamp with time zone NOT NULL,
    "dopPostText" text,
    "dopPostImage" text,
    "dopPostId" integer NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    contest_id bigint,
    history_user_id integer,
    tenant_id integer,
    CONSTRAINT "simple_historicaldopsimplepost_dopPostId_check" CHECK (("dopPostId" >= 0))
);


ALTER TABLE public.simple_historicaldopsimplepost OWNER TO vktenantuser;

--
-- Name: simple_historicaldopsimplepost_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.simple_historicaldopsimplepost_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simple_historicaldopsimplepost_history_id_seq OWNER TO vktenantuser;

--
-- Name: simple_historicaldopsimplepost_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.simple_historicaldopsimplepost_history_id_seq OWNED BY public.simple_historicaldopsimplepost.history_id;


--
-- Name: simple_historicalsimplecontest; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.simple_historicalsimplecontest (
    id bigint NOT NULL,
    active boolean NOT NULL,
    post_text text,
    post_image text,
    needs character varying(10) NOT NULL,
    winners_text text NOT NULL,
    winners_text_ls text NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    post_id integer NOT NULL,
    contest_status_text text,
    contest_status character varying(100),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    tenant_id integer,
    restrict character varying(10) NOT NULL,
    vid_id integer,
    CONSTRAINT simple_historicalsimplecontest_post_id_check CHECK ((post_id >= 0))
);


ALTER TABLE public.simple_historicalsimplecontest OWNER TO vktenantuser;

--
-- Name: simple_historicalsimplecontest_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.simple_historicalsimplecontest_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simple_historicalsimplecontest_history_id_seq OWNER TO vktenantuser;

--
-- Name: simple_historicalsimplecontest_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.simple_historicalsimplecontest_history_id_seq OWNED BY public.simple_historicalsimplecontest.history_id;


--
-- Name: simple_historicalsimpleprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.simple_historicalsimpleprize (
    id bigint NOT NULL,
    title text NOT NULL,
    simplepromokodes text NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    contest_id bigint,
    history_user_id integer,
    tenant_id integer
);


ALTER TABLE public.simple_historicalsimpleprize OWNER TO vktenantuser;

--
-- Name: simple_historicalsimpleprize_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.simple_historicalsimpleprize_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simple_historicalsimpleprize_history_id_seq OWNER TO vktenantuser;

--
-- Name: simple_historicalsimpleprize_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.simple_historicalsimpleprize_history_id_seq OWNED BY public.simple_historicalsimpleprize.history_id;


--
-- Name: simple_simplecontest; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.simple_simplecontest (
    id bigint NOT NULL,
    active boolean NOT NULL,
    post_text text,
    post_image character varying(100),
    needs character varying(10) NOT NULL,
    winners_text text NOT NULL,
    winners_text_ls text NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    post_id integer NOT NULL,
    contest_status_text text,
    contest_status character varying(100),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    group_id integer NOT NULL,
    tenant_id integer NOT NULL,
    restrict character varying(10) NOT NULL,
    vid_id integer,
    CONSTRAINT simple_simplecontest_post_id_check CHECK ((post_id >= 0))
);


ALTER TABLE public.simple_simplecontest OWNER TO vktenantuser;

--
-- Name: simple_simplecontest_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.simple_simplecontest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simple_simplecontest_id_seq OWNER TO vktenantuser;

--
-- Name: simple_simplecontest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.simple_simplecontest_id_seq OWNED BY public.simple_simplecontest.id;


--
-- Name: simple_simpleprize; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.simple_simpleprize (
    id bigint NOT NULL,
    title text NOT NULL,
    simplepromokodes text NOT NULL,
    contest_id bigint,
    tenant_id integer NOT NULL
);


ALTER TABLE public.simple_simpleprize OWNER TO vktenantuser;

--
-- Name: simple_simpleprize_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.simple_simpleprize_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simple_simpleprize_id_seq OWNER TO vktenantuser;

--
-- Name: simple_simpleprize_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.simple_simpleprize_id_seq OWNED BY public.simple_simpleprize.id;


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO vktenantuser;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.socialaccount_socialaccount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialaccount_id_seq OWNER TO vktenantuser;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.socialaccount_socialaccount_id_seq OWNED BY public.socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO vktenantuser;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.socialaccount_socialapp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_id_seq OWNER TO vktenantuser;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.socialaccount_socialapp_id_seq OWNED BY public.socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.socialaccount_socialapp_sites (
    id integer NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO vktenantuser;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.socialaccount_socialapp_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_sites_id_seq OWNER TO vktenantuser;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.socialaccount_socialapp_sites_id_seq OWNED BY public.socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO vktenantuser;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.socialaccount_socialtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialtoken_id_seq OWNER TO vktenantuser;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.socialaccount_socialtoken_id_seq OWNED BY public.socialaccount_socialtoken.id;


--
-- Name: subscribers_subscribed; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.subscribers_subscribed (
    id integer NOT NULL,
    auctions integer[],
    auction_senler_id integer,
    info text,
    group_id integer,
    tenant_id integer NOT NULL,
    mainsubscribers integer[],
    last_upd timestamp with time zone
);


ALTER TABLE public.subscribers_subscribed OWNER TO vktenantuser;

--
-- Name: subscribers_subscribed_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.subscribers_subscribed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscribers_subscribed_id_seq OWNER TO vktenantuser;

--
-- Name: subscribers_subscribed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.subscribers_subscribed_id_seq OWNED BY public.subscribers_subscribed.id;


--
-- Name: suggest_suggestpost; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.suggest_suggestpost (
    id integer NOT NULL,
    name character varying(300),
    link character varying(300),
    text text,
    textorig text,
    images text,
    attachments text,
    date timestamp with time zone,
    from_id integer,
    post_id integer,
    confirmed boolean NOT NULL,
    addballz integer,
    updated timestamp with time zone,
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.suggest_suggestpost OWNER TO vktenantuser;

--
-- Name: suggest_suggestpost_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.suggest_suggestpost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggest_suggestpost_id_seq OWNER TO vktenantuser;

--
-- Name: suggest_suggestpost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.suggest_suggestpost_id_seq OWNED BY public.suggest_suggestpost.id;


--
-- Name: suggest_suggestpostconfig; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.suggest_suggestpostconfig (
    id integer NOT NULL,
    remove_hash boolean NOT NULL,
    addtext text,
    addtext_alternative text,
    "last_postTime" timestamp with time zone,
    start_time time without time zone,
    end_time time without time zone,
    "interval" integer,
    confirm_btn boolean NOT NULL,
    confirm_alternative_btn boolean NOT NULL,
    publish_btn boolean NOT NULL,
    delete_btn boolean NOT NULL,
    addballz character varying(300),
    updated timestamp with time zone,
    group_id integer,
    tenant_id integer NOT NULL,
    send_ls_msg text,
    CONSTRAINT suggest_suggestpostconfig_interval_check CHECK (("interval" >= 0))
);


ALTER TABLE public.suggest_suggestpostconfig OWNER TO vktenantuser;

--
-- Name: suggest_suggestpostconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.suggest_suggestpostconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggest_suggestpostconfig_id_seq OWNER TO vktenantuser;

--
-- Name: suggest_suggestpostconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.suggest_suggestpostconfig_id_seq OWNED BY public.suggest_suggestpostconfig.id;


--
-- Name: suggest_suggestpostgrouped; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.suggest_suggestpostgrouped (
    id integer NOT NULL,
    postscount integer,
    group_id integer,
    tenant_id integer NOT NULL,
    postscount_confirmed integer NOT NULL
);


ALTER TABLE public.suggest_suggestpostgrouped OWNER TO vktenantuser;

--
-- Name: suggest_suggestpostgrouped_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.suggest_suggestpostgrouped_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggest_suggestpostgrouped_id_seq OWNER TO vktenantuser;

--
-- Name: suggest_suggestpostgrouped_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.suggest_suggestpostgrouped_id_seq OWNED BY public.suggest_suggestpostgrouped.id;


--
-- Name: tenant_customer; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.tenant_customer (
    id integer NOT NULL,
    name text,
    enabled boolean NOT NULL
);


ALTER TABLE public.tenant_customer OWNER TO vktenantuser;

--
-- Name: tenant_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.tenant_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tenant_customer_id_seq OWNER TO vktenantuser;

--
-- Name: tenant_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.tenant_customer_id_seq OWNED BY public.tenant_customer.id;


--
-- Name: tenant_customer_users; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.tenant_customer_users (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.tenant_customer_users OWNER TO vktenantuser;

--
-- Name: tenant_customer_users_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.tenant_customer_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tenant_customer_users_id_seq OWNER TO vktenantuser;

--
-- Name: tenant_customer_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.tenant_customer_users_id_seq OWNED BY public.tenant_customer_users.id;


--
-- Name: textanal_acts; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_acts (
    id integer NOT NULL,
    text text,
    idd integer,
    val integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.textanal_acts OWNER TO vktenantuser;

--
-- Name: textanal_acts_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_acts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_acts_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_acts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_acts_id_seq OWNED BY public.textanal_acts.id;


--
-- Name: textanal_findregex; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_findregex (
    id integer NOT NULL,
    name character varying(120),
    enabled boolean NOT NULL,
    text text,
    tenant_id integer NOT NULL
);


ALTER TABLE public.textanal_findregex OWNER TO vktenantuser;

--
-- Name: textanal_findregex_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_findregex_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_findregex_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_findregex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_findregex_id_seq OWNED BY public.textanal_findregex.id;


--
-- Name: textanal_foundregex; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_foundregex (
    id integer NOT NULL,
    idd integer,
    typ character varying(120),
    regextyp character varying(120),
    useridd integer NOT NULL,
    first_name character varying(120),
    last_name character varying(120),
    text text,
    link character varying(300),
    date timestamp with time zone,
    group_id integer,
    tenant_id integer NOT NULL,
    post_id integer
);


ALTER TABLE public.textanal_foundregex OWNER TO vktenantuser;

--
-- Name: textanal_foundregex_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_foundregex_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_foundregex_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_foundregex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_foundregex_id_seq OWNED BY public.textanal_foundregex.id;


--
-- Name: textanal_foundregexgrouped; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_foundregexgrouped (
    id integer NOT NULL,
    count integer,
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.textanal_foundregexgrouped OWNER TO vktenantuser;

--
-- Name: textanal_foundregexgrouped_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_foundregexgrouped_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_foundregexgrouped_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_foundregexgrouped_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_foundregexgrouped_id_seq OWNED BY public.textanal_foundregexgrouped.id;


--
-- Name: textanal_msgbuttons; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_msgbuttons (
    id integer NOT NULL,
    icon character varying(80),
    name character varying(80),
    color character varying(80) NOT NULL,
    texts text,
    split character varying(80) NOT NULL,
    tenant_id integer NOT NULL,
    enabled_comments boolean NOT NULL,
    enabled_ls boolean NOT NULL
);


ALTER TABLE public.textanal_msgbuttons OWNER TO vktenantuser;

--
-- Name: textanal_msgbuttons_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_msgbuttons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_msgbuttons_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_msgbuttons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_msgbuttons_id_seq OWNED BY public.textanal_msgbuttons.id;


--
-- Name: textanal_passingtext; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_passingtext (
    id integer NOT NULL,
    passtext text,
    tenant_id integer NOT NULL
);


ALTER TABLE public.textanal_passingtext OWNER TO vktenantuser;

--
-- Name: textanal_passingtext_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_passingtext_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_passingtext_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_passingtext_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_passingtext_id_seq OWNED BY public.textanal_passingtext.id;


--
-- Name: textanal_sendchat; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_sendchat (
    id integer NOT NULL,
    chatidd integer,
    chat_link character varying(300),
    name character varying(300),
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.textanal_sendchat OWNER TO vktenantuser;

--
-- Name: textanal_sendchat_forGroups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."textanal_sendchat_forGroups" (
    id integer NOT NULL,
    sendchat_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public."textanal_sendchat_forGroups" OWNER TO vktenantuser;

--
-- Name: textanal_sendchat_forGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."textanal_sendchat_forGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."textanal_sendchat_forGroups_id_seq" OWNER TO vktenantuser;

--
-- Name: textanal_sendchat_forGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."textanal_sendchat_forGroups_id_seq" OWNED BY public."textanal_sendchat_forGroups".id;


--
-- Name: textanal_sendchat_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_sendchat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_sendchat_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_sendchat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_sendchat_id_seq OWNED BY public.textanal_sendchat.id;


--
-- Name: textanal_unreadmsg; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_unreadmsg (
    id integer NOT NULL,
    useridd integer NOT NULL,
    idd integer,
    first_name character varying(120),
    last_name character varying(120),
    last_message text,
    admins_answer boolean NOT NULL,
    date timestamp with time zone,
    tmpdate timestamp with time zone,
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.textanal_unreadmsg OWNER TO vktenantuser;

--
-- Name: textanal_unreadmsg_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_unreadmsg_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_unreadmsg_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_unreadmsg_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_unreadmsg_id_seq OWNED BY public.textanal_unreadmsg.id;


--
-- Name: textanal_unreadmsggrouped; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.textanal_unreadmsggrouped (
    id integer NOT NULL,
    count integer,
    group_id integer,
    tenant_id integer NOT NULL
);


ALTER TABLE public.textanal_unreadmsggrouped OWNER TO vktenantuser;

--
-- Name: textanal_unreadmsggrouped_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.textanal_unreadmsggrouped_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.textanal_unreadmsggrouped_id_seq OWNER TO vktenantuser;

--
-- Name: textanal_unreadmsggrouped_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.textanal_unreadmsggrouped_id_seq OWNED BY public.textanal_unreadmsggrouped.id;


--
-- Name: videoresults_videolog; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.videoresults_videolog (
    id integer NOT NULL,
    name character varying(500),
    users text,
    tenant_id integer NOT NULL,
    ids text
);


ALTER TABLE public.videoresults_videolog OWNER TO vktenantuser;

--
-- Name: videoresults_videolog_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.videoresults_videolog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videoresults_videolog_id_seq OWNER TO vktenantuser;

--
-- Name: videoresults_videolog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.videoresults_videolog_id_seq OWNED BY public.videoresults_videolog.id;


--
-- Name: videoresults_videoresult; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.videoresults_videoresult (
    id integer NOT NULL,
    name character varying(500),
    tenant_id integer NOT NULL
);


ALTER TABLE public.videoresults_videoresult OWNER TO vktenantuser;

--
-- Name: videoresults_videoresult_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.videoresults_videoresult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videoresults_videoresult_id_seq OWNER TO vktenantuser;

--
-- Name: videoresults_videoresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.videoresults_videoresult_id_seq OWNED BY public.videoresults_videoresult.id;


--
-- Name: vkin_action; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_action (
    id integer NOT NULL,
    idd integer,
    event_id character varying(120),
    post_id integer,
    userid integer,
    username character varying(200),
    typ character varying(120),
    text text,
    date timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    jsondata text,
    group_id integer,
    tenant_id integer NOT NULL,
    processed boolean NOT NULL
);


ALTER TABLE public.vkin_action OWNER TO vktenantuser;

--
-- Name: vkin_action_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_action_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_action_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_action_id_seq OWNED BY public.vkin_action.id;


--
-- Name: vkin_allusergroups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_allusergroups (
    id integer NOT NULL,
    group_name character varying(200),
    group_id integer
);


ALTER TABLE public.vkin_allusergroups OWNER TO vktenantuser;

--
-- Name: vkin_allusergroups_admins; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_allusergroups_admins (
    id integer NOT NULL,
    allusergroups_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.vkin_allusergroups_admins OWNER TO vktenantuser;

--
-- Name: vkin_allusergroups_admins_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_allusergroups_admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_allusergroups_admins_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_allusergroups_admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_allusergroups_admins_id_seq OWNED BY public.vkin_allusergroups_admins.id;


--
-- Name: vkin_allusergroups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_allusergroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_allusergroups_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_allusergroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_allusergroups_id_seq OWNED BY public.vkin_allusergroups.id;


--
-- Name: vkin_appconfig; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_appconfig (
    id integer NOT NULL,
    client_id character varying(200) NOT NULL,
    app_secret character varying(200) NOT NULL,
    redirect_uri character varying(200) NOT NULL,
    scope character varying(200) NOT NULL,
    response_type character varying(200) NOT NULL,
    display character varying(200) NOT NULL,
    v character varying(200) NOT NULL
);


ALTER TABLE public.vkin_appconfig OWNER TO vktenantuser;

--
-- Name: vkin_appconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_appconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_appconfig_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_appconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_appconfig_id_seq OWNED BY public.vkin_appconfig.id;


--
-- Name: vkin_group; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_group (
    id integer NOT NULL,
    short_name character varying(200),
    group_name character varying(200),
    tz character varying(63) NOT NULL,
    "workHours" time without time zone,
    group_id integer,
    enabled boolean NOT NULL,
    group_access_token character varying(300),
    su_group_access_token character varying(500),
    saved_group_access_token character varying(300),
    gsheet character varying(300),
    senler_secret character varying(200),
    senler_needgroup integer,
    cb_url character varying(120),
    cb_title character varying(120),
    cb_secret character varying(120),
    callback_confirmation character varying(120),
    last_postponed integer,
    tenant_id integer NOT NULL,
    txt_id integer,
    group_ava_url character varying(500),
    senler_subscribelink character varying(200),
    senler_subscr_regexp character varying(300),
    senler_unsubscr_regexp character varying(300),
    senler_access_token character varying(200),
    sendprizeslink text,
    tg_alert_chat character varying(200),
    tg_alert_message_thread_id integer,
    city_name character varying(200),
    delivery_name character varying(200),
    audio_file character varying(100),
    manager_list text,
    CONSTRAINT vkin_group_senler_needgroup_85141ba2_check CHECK ((senler_needgroup >= 0))
);


ALTER TABLE public.vkin_group OWNER TO vktenantuser;

--
-- Name: vkin_group_admins; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_group_admins (
    id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.vkin_group_admins OWNER TO vktenantuser;

--
-- Name: vkin_group_admins_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_group_admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_group_admins_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_group_admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_group_admins_id_seq OWNED BY public.vkin_group_admins.id;


--
-- Name: vkin_group_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_group_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_group_id_seq OWNED BY public.vkin_group.id;


--
-- Name: vkin_group_moders; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_group_moders (
    id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.vkin_group_moders OWNER TO vktenantuser;

--
-- Name: vkin_group_moders_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_group_moders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_group_moders_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_group_moders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_group_moders_id_seq OWNED BY public.vkin_group_moders.id;


--
-- Name: vkin_group_usertokens; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_group_usertokens (
    id integer NOT NULL,
    group_id integer NOT NULL,
    su_user_tokens_id integer NOT NULL
);


ALTER TABLE public.vkin_group_usertokens OWNER TO vktenantuser;

--
-- Name: vkin_group_usertokens_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_group_usertokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_group_usertokens_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_group_usertokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_group_usertokens_id_seq OWNED BY public.vkin_group_usertokens.id;


--
-- Name: vkin_groupstatistic; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_groupstatistic (
    id integer NOT NULL,
    date date NOT NULL,
    group_id integer,
    "sendBdayAll" integer[],
    "sendBdayCompleted" integer[],
    tenant_id integer NOT NULL,
    "postedAuction" integer[],
    "postedSuggest" integer[]
);


ALTER TABLE public.vkin_groupstatistic OWNER TO vktenantuser;

--
-- Name: vkin_groupstatistic_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_groupstatistic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_groupstatistic_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_groupstatistic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_groupstatistic_id_seq OWNED BY public.vkin_groupstatistic.id;


--
-- Name: vkin_historicalgroup; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_historicalgroup (
    id integer NOT NULL,
    short_name character varying(200),
    city_name character varying(200),
    delivery_name character varying(200),
    group_name character varying(200),
    tz character varying(63) NOT NULL,
    "workHours" time without time zone,
    group_id integer,
    enabled boolean NOT NULL,
    group_access_token character varying(300),
    su_group_access_token character varying(500),
    saved_group_access_token character varying(300),
    gsheet character varying(300),
    senler_secret character varying(200),
    senler_access_token character varying(200),
    senler_subscribelink character varying(200),
    senler_needgroup integer,
    senler_subscr_regexp character varying(300),
    senler_unsubscr_regexp character varying(300),
    cb_url character varying(120),
    cb_title character varying(120),
    cb_secret character varying(120),
    callback_confirmation character varying(120),
    last_postponed integer,
    group_ava_url character varying(500),
    sendprizeslink text,
    tg_alert_chat character varying(200),
    tg_alert_message_thread_id integer,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    tenant_id integer,
    txt_id integer,
    audio_file text,
    manager_list text,
    CONSTRAINT vkin_historicalgroup_senler_needgroup_check CHECK ((senler_needgroup >= 0))
);


ALTER TABLE public.vkin_historicalgroup OWNER TO vktenantuser;

--
-- Name: vkin_historicalgroup_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_historicalgroup_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_historicalgroup_history_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_historicalgroup_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_historicalgroup_history_id_seq OWNED BY public.vkin_historicalgroup.history_id;


--
-- Name: vkin_historicaltextmessages; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_historicaltextmessages (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    need_group_join text NOT NULL,
    need_senler text NOT NULL,
    senler_answer_subscribe text,
    senler_answer_unsubscribe text,
    win_msg_ls text NOT NULL,
    win_msg_promokod text NOT NULL,
    win_msg_promokod_later text,
    user_banned text NOT NULL,
    other_wait_minute text NOT NULL,
    ask_mobile_phone_text text NOT NULL,
    makeresults text NOT NULL,
    "gameStop_started" text NOT NULL,
    "gameStop_win" text NOT NULL,
    "gameStop_you_winner" text NOT NULL,
    "gameStop_no_prizes" text NOT NULL,
    "gameSafe_started" text NOT NULL,
    "gameSafe_win" text NOT NULL,
    "gameSafe_los" text NOT NULL,
    "gameSafe_try" text NOT NULL,
    "gameSafe_you_winner" text NOT NULL,
    "gameSafe_no_attempts" text NOT NULL,
    "gameSafe_no_prizes" text NOT NULL,
    "gameSafe_numeral_attempts" text NOT NULL,
    "gameRoulet_started" text NOT NULL,
    "gameRoulet_win" text NOT NULL,
    "gameRoulet_los" text NOT NULL,
    "gameRoulet_try" text NOT NULL,
    "gameRoulet_you_winner" text NOT NULL,
    "gameRoulet_no_attempts" text NOT NULL,
    "gameRoulet_no_prizes" text NOT NULL,
    "gameRoulet_wrong_cmd" text NOT NULL,
    "gameRoulet_numeral_attempts" text NOT NULL,
    "gameBomber_started" text NOT NULL,
    "gameBomber_win" text NOT NULL,
    "gameBomber_pass" text NOT NULL,
    "gameBomber_los" text NOT NULL,
    "gameBomber_try" text NOT NULL,
    "gameBomber_you_winner" text NOT NULL,
    "gameBomber_no_attempts" text NOT NULL,
    "gameBomber_no_prizes" text NOT NULL,
    "gameBomber_numeral_attempts" text NOT NULL,
    "gameKosti_started" text NOT NULL,
    "gameKosti_win" text NOT NULL,
    "gameKosti_los" text NOT NULL,
    "gameKosti_try" text NOT NULL,
    "gameKosti_you_winner" text NOT NULL,
    "gameKosti_no_attempts" text NOT NULL,
    "gameKosti_no_prizes" text NOT NULL,
    "gameKosti_0_iz_3" text NOT NULL,
    "gameKosti_1_iz_3" text NOT NULL,
    "gameKosti_2_iz_3" text NOT NULL,
    "gameKosti_numeral_attempts" text NOT NULL,
    "gameSeaBattle_started" text NOT NULL,
    "gameSeaBattle_win" text NOT NULL,
    "gameSeaBattle_los" text NOT NULL,
    "gameSeaBattle_try" text NOT NULL,
    "gameSeaBattle_you_winner" text NOT NULL,
    "gameSeaBattle_no_attempts" text NOT NULL,
    "gameSeaBattle_no_prizes" text NOT NULL,
    "gameSeaBattle_wrong" text NOT NULL,
    "gameSeaBattle_numeral_attempts" text NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    tenant_id integer
);


ALTER TABLE public.vkin_historicaltextmessages OWNER TO vktenantuser;

--
-- Name: vkin_historicaltextmessages_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_historicaltextmessages_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_historicaltextmessages_history_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_historicaltextmessages_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_historicaltextmessages_history_id_seq OWNED BY public.vkin_historicaltextmessages.history_id;


--
-- Name: vkin_historicalvars; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_historicalvars (
    id integer NOT NULL,
    value text,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    group_id integer,
    history_user_id integer,
    property_id integer,
    tenant_id integer
);


ALTER TABLE public.vkin_historicalvars OWNER TO vktenantuser;

--
-- Name: vkin_historicalvars_history_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_historicalvars_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_historicalvars_history_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_historicalvars_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_historicalvars_history_id_seq OWNED BY public.vkin_historicalvars.history_id;


--
-- Name: vkin_imagecache; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_imagecache (
    id integer NOT NULL,
    img_path text,
    img_cache text,
    group_id integer,
    tenant_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.vkin_imagecache OWNER TO vktenantuser;

--
-- Name: vkin_imagecache_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_imagecache_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_imagecache_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_imagecache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_imagecache_id_seq OWNED BY public.vkin_imagecache.id;


--
-- Name: vkin_message; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_message (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    chat bigint,
    text text,
    message_id integer
);


ALTER TABLE public.vkin_message OWNER TO vktenantuser;

--
-- Name: vkin_message_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_message_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_message_id_seq OWNED BY public.vkin_message.id;


--
-- Name: vkin_posttemplates; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_posttemplates (
    id integer NOT NULL,
    name character varying(300) NOT NULL,
    post_text text,
    tenant_id integer NOT NULL
);


ALTER TABLE public.vkin_posttemplates OWNER TO vktenantuser;

--
-- Name: vkin_posttemplates_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_posttemplates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_posttemplates_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_posttemplates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_posttemplates_id_seq OWNED BY public.vkin_posttemplates.id;


--
-- Name: vkin_setofgroups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_setofgroups (
    id integer NOT NULL,
    listname character varying(120) NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.vkin_setofgroups OWNER TO vktenantuser;

--
-- Name: vkin_setofgroups_forGroups; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public."vkin_setofgroups_forGroups" (
    id integer NOT NULL,
    setofgroups_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public."vkin_setofgroups_forGroups" OWNER TO vktenantuser;

--
-- Name: vkin_setofgroups_forGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public."vkin_setofgroups_forGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."vkin_setofgroups_forGroups_id_seq" OWNER TO vktenantuser;

--
-- Name: vkin_setofgroups_forGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public."vkin_setofgroups_forGroups_id_seq" OWNED BY public."vkin_setofgroups_forGroups".id;


--
-- Name: vkin_setofgroups_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_setofgroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_setofgroups_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_setofgroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_setofgroups_id_seq OWNED BY public.vkin_setofgroups.id;


--
-- Name: vkin_setofvars; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_setofvars (
    id integer NOT NULL,
    name character varying(300) NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.vkin_setofvars OWNER TO vktenantuser;

--
-- Name: vkin_setofvars_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_setofvars_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_setofvars_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_setofvars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_setofvars_id_seq OWNED BY public.vkin_setofvars.id;


--
-- Name: vkin_su_user_tokens; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_su_user_tokens (
    id integer NOT NULL,
    name character varying(300),
    su_user_access_token character varying(500),
    saved_user_access_token character varying(300),
    auth_errors integer NOT NULL,
    tenant_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.vkin_su_user_tokens OWNER TO vktenantuser;

--
-- Name: vkin_su_user_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_su_user_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_su_user_tokens_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_su_user_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_su_user_tokens_id_seq OWNED BY public.vkin_su_user_tokens.id;


--
-- Name: vkin_textmessages; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_textmessages (
    id integer NOT NULL,
    name character varying(500) NOT NULL,
    user_banned text NOT NULL,
    other_wait_minute text NOT NULL,
    "gameRoulet_started" text NOT NULL,
    "gameRoulet_win" text NOT NULL,
    "gameRoulet_los" text NOT NULL,
    "gameRoulet_try" text NOT NULL,
    "gameRoulet_you_winner" text NOT NULL,
    "gameRoulet_no_attempts" text NOT NULL,
    "gameRoulet_no_prizes" text NOT NULL,
    tenant_id integer NOT NULL,
    "gameBomber_los" text NOT NULL,
    "gameBomber_no_attempts" text NOT NULL,
    "gameBomber_no_prizes" text NOT NULL,
    "gameBomber_numeral_attempts" text NOT NULL,
    "gameBomber_started" text NOT NULL,
    "gameBomber_try" text NOT NULL,
    "gameBomber_pass" text NOT NULL,
    "gameBomber_you_winner" text NOT NULL,
    "gameRoulet_numeral_attempts" text NOT NULL,
    "gameBomber_win" text NOT NULL,
    "gameKosti_los" text NOT NULL,
    "gameKosti_no_attempts" text NOT NULL,
    "gameKosti_no_prizes" text NOT NULL,
    "gameKosti_numeral_attempts" text NOT NULL,
    "gameKosti_started" text NOT NULL,
    "gameKosti_try" text NOT NULL,
    "gameKosti_win" text NOT NULL,
    "gameKosti_you_winner" text NOT NULL,
    win_msg_ls text NOT NULL,
    win_msg_promokod text NOT NULL,
    need_senler text NOT NULL,
    senler_answer_subscribe text,
    senler_answer_unsubscribe text,
    "gameKosti_0_iz_3" text NOT NULL,
    "gameKosti_1_iz_3" text NOT NULL,
    "gameKosti_2_iz_3" text NOT NULL,
    need_group_join text NOT NULL,
    "gameSeaBattle_los" text NOT NULL,
    "gameSeaBattle_no_attempts" text NOT NULL,
    "gameSeaBattle_no_prizes" text NOT NULL,
    "gameSeaBattle_numeral_attempts" text NOT NULL,
    "gameSeaBattle_started" text NOT NULL,
    "gameSeaBattle_try" text NOT NULL,
    "gameSeaBattle_win" text NOT NULL,
    "gameSeaBattle_wrong" text NOT NULL,
    "gameSeaBattle_you_winner" text NOT NULL,
    "gameRoulet_wrong_cmd" text NOT NULL,
    "gameSafe_los" text NOT NULL,
    "gameSafe_no_attempts" text NOT NULL,
    "gameSafe_no_prizes" text NOT NULL,
    "gameSafe_numeral_attempts" text NOT NULL,
    "gameSafe_started" text NOT NULL,
    "gameSafe_try" text NOT NULL,
    "gameSafe_win" text NOT NULL,
    "gameSafe_you_winner" text NOT NULL,
    ask_mobile_phone_text text NOT NULL,
    "gameStop_no_prizes" text NOT NULL,
    "gameStop_started" text NOT NULL,
    "gameStop_win" text NOT NULL,
    "gameStop_you_winner" text NOT NULL,
    win_msg_promokod_later text,
    makeresults text NOT NULL
);


ALTER TABLE public.vkin_textmessages OWNER TO vktenantuser;

--
-- Name: vkin_textmessages_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_textmessages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_textmessages_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_textmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_textmessages_id_seq OWNED BY public.vkin_textmessages.id;


--
-- Name: vkin_user; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_user (
    id integer NOT NULL,
    userid integer,
    first_name character varying(120),
    last_name character varying(120),
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.vkin_user OWNER TO vktenantuser;

--
-- Name: vkin_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_user_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_user_id_seq OWNED BY public.vkin_user.id;


--
-- Name: vkin_userphone; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_userphone (
    id integer NOT NULL,
    userid integer,
    mobile_phone character varying(120),
    group_id integer,
    tenant_id integer NOT NULL,
    next_send timestamp with time zone
);


ALTER TABLE public.vkin_userphone OWNER TO vktenantuser;

--
-- Name: vkin_userphone_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_userphone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_userphone_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_userphone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_userphone_id_seq OWNED BY public.vkin_userphone.id;


--
-- Name: vkin_vars; Type: TABLE; Schema: public; Owner: vktenantuser
--

CREATE TABLE public.vkin_vars (
    id integer NOT NULL,
    value text,
    group_id integer,
    property_id integer NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.vkin_vars OWNER TO vktenantuser;

--
-- Name: vkin_vars_id_seq; Type: SEQUENCE; Schema: public; Owner: vktenantuser
--

CREATE SEQUENCE public.vkin_vars_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vkin_vars_id_seq OWNER TO vktenantuser;

--
-- Name: vkin_vars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vktenantuser
--

ALTER SEQUENCE public.vkin_vars_id_seq OWNED BY public.vkin_vars.id;


--
-- Name: account_emailaddress id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.account_emailaddress ALTER COLUMN id SET DEFAULT nextval('public.account_emailaddress_id_seq'::regclass);


--
-- Name: account_emailconfirmation id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('public.account_emailconfirmation_id_seq'::regclass);


--
-- Name: auctions_auction id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auction ALTER COLUMN id SET DEFAULT nextval('public.auctions_auction_id_seq'::regclass);


--
-- Name: auctions_auctioncost id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auctioncost ALTER COLUMN id SET DEFAULT nextval('public.auctions_auctioncost_id_seq'::regclass);


--
-- Name: auctions_auctlot id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auctlot ALTER COLUMN id SET DEFAULT nextval('public.auctions_auctlot_id_seq'::regclass);


--
-- Name: auctions_historicalauctlot history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_historicalauctlot ALTER COLUMN history_id SET DEFAULT nextval('public.auctions_historicalauctlot_history_id_seq'::regclass);


--
-- Name: auctions_historicalscheduledauctionforgroup history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_historicalscheduledauctionforgroup ALTER COLUMN history_id SET DEFAULT nextval('public.auctions_historicalscheduledauctionforgroup_history_id_seq'::regclass);


--
-- Name: auctions_scheduledauction id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauction ALTER COLUMN id SET DEFAULT nextval('public.auctions_scheduledauction_id_seq'::regclass);


--
-- Name: auctions_scheduledauctionforgroup id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionforgroup ALTER COLUMN id SET DEFAULT nextval('public.auctions_scheduledauctionforgroup_id_seq'::regclass);


--
-- Name: auctions_setauctlot id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_setauctlot ALTER COLUMN id SET DEFAULT nextval('public.auctions_setauctlot_id_seq'::regclass);


--
-- Name: auctions_setauctlot_forGroups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."auctions_setauctlot_forGroups" ALTER COLUMN id SET DEFAULT nextval('public."auctions_setauctlot_forGroups_id_seq"'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: background_task id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.background_task ALTER COLUMN id SET DEFAULT nextval('public.background_task_id_seq'::regclass);


--
-- Name: background_task_completedtask id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.background_task_completedtask ALTER COLUMN id SET DEFAULT nextval('public.background_task_completedtask_id_seq'::regclass);


--
-- Name: bday_bdayposttemplate id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_bdayposttemplate ALTER COLUMN id SET DEFAULT nextval('public.bday_bdayposttemplate_id_seq'::regclass);


--
-- Name: bday_historicalbdayposttemplate history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalbdayposttemplate ALTER COLUMN history_id SET DEFAULT nextval('public.bday_historicalbdayposttemplate_history_id_seq'::regclass);


--
-- Name: bday_historicalmsgtemplate history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalmsgtemplate ALTER COLUMN history_id SET DEFAULT nextval('public.bday_historicalmsgtemplate_history_id_seq'::regclass);


--
-- Name: bday_historicalsetmsgtemplate history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalsetmsgtemplate ALTER COLUMN history_id SET DEFAULT nextval('public.bday_historicalsetmsgtemplate_history_id_seq'::regclass);


--
-- Name: bday_msgtemplate id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_msgtemplate ALTER COLUMN id SET DEFAULT nextval('public.bday_msgtemplate_id_seq'::regclass);


--
-- Name: bday_setmsgtemplate id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_setmsgtemplate ALTER COLUMN id SET DEFAULT nextval('public.bday_setmsgtemplate_id_seq'::regclass);


--
-- Name: datacollect_phonetosheet id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.datacollect_phonetosheet ALTER COLUMN id SET DEFAULT nextval('public.datacollect_phonetosheet_id_seq'::regclass);


--
-- Name: daywinners_doppost id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_doppost ALTER COLUMN id SET DEFAULT nextval('public.daywinners_doppost_id_seq'::regclass);


--
-- Name: daywinners_historicalhashsearch history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalhashsearch ALTER COLUMN history_id SET DEFAULT nextval('public.daywinners_historicalhashsearch_history_id_seq'::regclass);


--
-- Name: daywinners_historicalrandomactivity history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalrandomactivity ALTER COLUMN history_id SET DEFAULT nextval('public.daywinners_historicalrandomactivity_history_id_seq'::regclass);


--
-- Name: daywinners_historicalrandomphotoreviews history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalrandomphotoreviews ALTER COLUMN history_id SET DEFAULT nextval('public.daywinners_historicalrandomphotoreviews_history_id_seq'::regclass);


--
-- Name: daywinners_historicalweeklywinners history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalweeklywinners ALTER COLUMN history_id SET DEFAULT nextval('public.daywinners_historicalweeklywinners_history_id_seq'::regclass);


--
-- Name: daywinners_makewinnerstime id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_makewinnerstime ALTER COLUMN id SET DEFAULT nextval('public.daywinners_makewinnerstime_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: easy_thumbnails_source id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_source ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_source_id_seq'::regclass);


--
-- Name: easy_thumbnails_thumbnail id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_thumbnail_id_seq'::regclass);


--
-- Name: easy_thumbnails_thumbnaildimensions id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_thumbnaildimensions_id_seq'::regclass);


--
-- Name: gameroulet_banditimageslosing id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditimageslosing ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_banditimageslosing_id_seq'::regclass);


--
-- Name: gameroulet_banditimageswin id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditimageswin ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_banditimageswin_id_seq'::regclass);


--
-- Name: gameroulet_banditsetimages id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditsetimages ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_banditsetimages_id_seq'::regclass);


--
-- Name: gameroulet_doprouletpost id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_doprouletpost ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_doprouletpost_id_seq'::regclass);


--
-- Name: gameroulet_historicalkostigame history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalkostigame ALTER COLUMN history_id SET DEFAULT nextval('public.gameroulet_historicalkostigame_history_id_seq'::regclass);


--
-- Name: gameroulet_historicalrandstop history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrandstop ALTER COLUMN history_id SET DEFAULT nextval('public.gameroulet_historicalrandstop_history_id_seq'::regclass);


--
-- Name: gameroulet_historicalrouletbanditgame history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrouletbanditgame ALTER COLUMN history_id SET DEFAULT nextval('public.gameroulet_historicalrouletbanditgame_history_id_seq'::regclass);


--
-- Name: gameroulet_historicalrouletbombergame history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrouletbombergame ALTER COLUMN history_id SET DEFAULT nextval('public.gameroulet_historicalrouletbombergame_history_id_seq'::regclass);


--
-- Name: gameroulet_historicalroulethide history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalroulethide ALTER COLUMN history_id SET DEFAULT nextval('public.gameroulet_historicalroulethide_history_id_seq'::regclass);


--
-- Name: gameroulet_historicalseabattlegame history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalseabattlegame ALTER COLUMN history_id SET DEFAULT nextval('public.gameroulet_historicalseabattlegame_history_id_seq'::regclass);


--
-- Name: gameroulet_kostigame id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostigame ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_kostigame_id_seq'::regclass);


--
-- Name: gameroulet_kostisetimages id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostisetimages ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_kostisetimages_id_seq'::regclass);


--
-- Name: gameroulet_randstop id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_randstop ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_randstop_id_seq'::regclass);


--
-- Name: gameroulet_rouletbanditgame id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbanditgame ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_rouletbanditgame_id_seq'::regclass);


--
-- Name: gameroulet_rouletbombergame id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbombergame ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_rouletbombergame_id_seq'::regclass);


--
-- Name: gameroulet_roulethide id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_roulethide ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_roulethide_id_seq'::regclass);


--
-- Name: gameroulet_rouletsafe id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletsafe ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_rouletsafe_id_seq'::regclass);


--
-- Name: gameroulet_rouletuserlives id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletuserlives ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_rouletuserlives_id_seq'::regclass);


--
-- Name: gameroulet_seabattlegame id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_seabattlegame ALTER COLUMN id SET DEFAULT nextval('public.gameroulet_seabattlegame_id_seq'::regclass);


--
-- Name: gpt_gptdialog id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpt_gptdialog ALTER COLUMN id SET DEFAULT nextval('public.gpt_gptdialog_id_seq'::regclass);


--
-- Name: gpt_gptkey id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpt_gptkey ALTER COLUMN id SET DEFAULT nextval('public.gpt_gptkey_id_seq'::regclass);


--
-- Name: gpthelper_commentanswer id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_commentanswer ALTER COLUMN id SET DEFAULT nextval('public.gpthelper_commentanswer_id_seq'::regclass);


--
-- Name: gpthelper_gptanswerkey id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_gptanswerkey ALTER COLUMN id SET DEFAULT nextval('public.gpthelper_gptanswerkey_id_seq'::regclass);


--
-- Name: gpthelper_gptdialog id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_gptdialog ALTER COLUMN id SET DEFAULT nextval('public.gpthelper_gptdialog_id_seq'::regclass);


--
-- Name: gpthelper_postsettings id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_postsettings ALTER COLUMN id SET DEFAULT nextval('public.gpthelper_postsettings_id_seq'::regclass);


--
-- Name: greeting_commentpromo id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_commentpromo ALTER COLUMN id SET DEFAULT nextval('public.greeting_commentpromo_id_seq'::regclass);


--
-- Name: greeting_communityreviewspromo id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_communityreviewspromo ALTER COLUMN id SET DEFAULT nextval('public.greeting_communityreviewspromo_id_seq'::regclass);


--
-- Name: greeting_greeting id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_greeting ALTER COLUMN id SET DEFAULT nextval('public.greeting_greeting_id_seq'::regclass);


--
-- Name: greeting_historicalgreeting history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_historicalgreeting ALTER COLUMN history_id SET DEFAULT nextval('public.greeting_historicalgreeting_history_id_seq'::regclass);


--
-- Name: greeting_historicalrepostpromo history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_historicalrepostpromo ALTER COLUMN history_id SET DEFAULT nextval('public.greeting_historicalrepostpromo_history_id_seq'::regclass);


--
-- Name: greeting_jointemplate id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_jointemplate ALTER COLUMN id SET DEFAULT nextval('public.greeting_jointemplate_id_seq'::regclass);


--
-- Name: greeting_repostpromo id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_repostpromo ALTER COLUMN id SET DEFAULT nextval('public.greeting_repostpromo_id_seq'::regclass);


--
-- Name: newcontest_historicalnewcontestprize history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_historicalnewcontestprize ALTER COLUMN history_id SET DEFAULT nextval('public.newcontest_historicalnewcontestprize_history_id_seq'::regclass);


--
-- Name: newcontest_historicalrepostcontest history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_historicalrepostcontest ALTER COLUMN history_id SET DEFAULT nextval('public.newcontest_historicalrepostcontest_history_id_seq'::regclass);


--
-- Name: newcontest_participantcontest id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_participantcontest ALTER COLUMN id SET DEFAULT nextval('public.newcontest_participantcontest_id_seq'::regclass);


--
-- Name: newcontest_repostcontest id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_repostcontest ALTER COLUMN id SET DEFAULT nextval('public.newcontest_repostcontest_id_seq'::regclass);


--
-- Name: newcontest_repostcontest_forGroups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."newcontest_repostcontest_forGroups" ALTER COLUMN id SET DEFAULT nextval('public."newcontest_repostcontest_forGroups_id_seq"'::regclass);


--
-- Name: ownerCoverPhoto_ownercoverphotobg id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."ownerCoverPhoto_ownercoverphotobg" ALTER COLUMN id SET DEFAULT nextval('public."ownerCoverPhoto_ownercoverphotobg_id_seq"'::regclass);


--
-- Name: photoTickets_historicalticket history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_historicalticket" ALTER COLUMN history_id SET DEFAULT nextval('public."photoTickets_historicalticket_history_id_seq"'::regclass);


--
-- Name: photoTickets_historicalticketsettings history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_historicalticketsettings" ALTER COLUMN history_id SET DEFAULT nextval('public."photoTickets_historicalticketsettings_history_id_seq"'::regclass);


--
-- Name: photoTickets_ticket id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticket" ALTER COLUMN id SET DEFAULT nextval('public."photoTickets_ticket_id_seq"'::regclass);


--
-- Name: photoTickets_ticketsettings id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticketsettings" ALTER COLUMN id SET DEFAULT nextval('public."photoTickets_ticketsettings_id_seq"'::regclass);


--
-- Name: pinnedPost_firstpost id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."pinnedPost_firstpost" ALTER COLUMN id SET DEFAULT nextval('public."pinnedPost_firstpost_id_seq"'::regclass);


--
-- Name: posting_postpone id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_postpone ALTER COLUMN id SET DEFAULT nextval('public.posting_postpone_id_seq'::regclass);


--
-- Name: posting_setposts id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setposts ALTER COLUMN id SET DEFAULT nextval('public.posting_setposts_id_seq'::regclass);


--
-- Name: posting_setpostsin id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsin ALTER COLUMN id SET DEFAULT nextval('public.posting_setpostsin_id_seq'::regclass);


--
-- Name: prizes_blocked id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_blocked ALTER COLUMN id SET DEFAULT nextval('public.prizes_blocked_id_seq'::regclass);


--
-- Name: prizes_blocked_forGroups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_blocked_forGroups" ALTER COLUMN id SET DEFAULT nextval('public."prizes_blocked_forGroups_id_seq"'::regclass);


--
-- Name: prizes_cached_screen_names id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_cached_screen_names ALTER COLUMN id SET DEFAULT nextval('public.prizes_cached_screen_names_id_seq'::regclass);


--
-- Name: prizes_contestusers id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_contestusers ALTER COLUMN id SET DEFAULT nextval('public.prizes_contestusers_id_seq'::regclass);


--
-- Name: prizes_modelprize id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_modelprize ALTER COLUMN id SET DEFAULT nextval('public.prizes_modelprize_id_seq'::regclass);


--
-- Name: prizes_modelprize_forGroups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_modelprize_forGroups" ALTER COLUMN id SET DEFAULT nextval('public."prizes_modelprize_forGroups_id_seq"'::regclass);


--
-- Name: prizes_modelwinnerspost id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_modelwinnerspost ALTER COLUMN id SET DEFAULT nextval('public.prizes_modelwinnerspost_id_seq'::regclass);


--
-- Name: prizes_morpher id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_morpher ALTER COLUMN id SET DEFAULT nextval('public.prizes_morpher_id_seq'::regclass);


--
-- Name: prizes_prize id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_prize ALTER COLUMN id SET DEFAULT nextval('public.prizes_prize_id_seq'::regclass);


--
-- Name: prizes_prizessendmsg id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_prizessendmsg ALTER COLUMN id SET DEFAULT nextval('public.prizes_prizessendmsg_id_seq'::regclass);


--
-- Name: prizes_promointerval id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_promointerval ALTER COLUMN id SET DEFAULT nextval('public.prizes_promointerval_id_seq'::regclass);


--
-- Name: prizes_promointervalmany id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_promointervalmany ALTER COLUMN id SET DEFAULT nextval('public.prizes_promointervalmany_id_seq'::regclass);


--
-- Name: prizes_sendmsg id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_sendmsg ALTER COLUMN id SET DEFAULT nextval('public.prizes_sendmsg_id_seq'::regclass);


--
-- Name: prizes_winner id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_winner ALTER COLUMN id SET DEFAULT nextval('public.prizes_winner_id_seq'::regclass);


--
-- Name: randomdata_randomcontest id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.randomdata_randomcontest ALTER COLUMN id SET DEFAULT nextval('public.randomdata_randomcontest_id_seq'::regclass);


--
-- Name: randomdata_randomnumbers id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.randomdata_randomnumbers ALTER COLUMN id SET DEFAULT nextval('public.randomdata_randomnumbers_id_seq'::regclass);


--
-- Name: senlergame_senlercodework id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlercodework ALTER COLUMN id SET DEFAULT nextval('public.senlergame_senlercodework_id_seq'::regclass);


--
-- Name: senlergame_senlerprize id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerprize ALTER COLUMN id SET DEFAULT nextval('public.senlergame_senlerprize_id_seq'::regclass);


--
-- Name: senlergame_senlerwinners id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerwinners ALTER COLUMN id SET DEFAULT nextval('public.senlergame_senlerwinners_id_seq'::regclass);


--
-- Name: simple_dopsimplepost id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_dopsimplepost ALTER COLUMN id SET DEFAULT nextval('public.simple_dopsimplepost_id_seq'::regclass);


--
-- Name: simple_historicaldopsimplepost history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicaldopsimplepost ALTER COLUMN history_id SET DEFAULT nextval('public.simple_historicaldopsimplepost_history_id_seq'::regclass);


--
-- Name: simple_historicalsimplecontest history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicalsimplecontest ALTER COLUMN history_id SET DEFAULT nextval('public.simple_historicalsimplecontest_history_id_seq'::regclass);


--
-- Name: simple_historicalsimpleprize history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicalsimpleprize ALTER COLUMN history_id SET DEFAULT nextval('public.simple_historicalsimpleprize_history_id_seq'::regclass);


--
-- Name: simple_simplecontest id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simplecontest ALTER COLUMN id SET DEFAULT nextval('public.simple_simplecontest_id_seq'::regclass);


--
-- Name: simple_simpleprize id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simpleprize ALTER COLUMN id SET DEFAULT nextval('public.simple_simpleprize_id_seq'::regclass);


--
-- Name: socialaccount_socialaccount id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: socialaccount_socialapp id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_id_seq'::regclass);


--
-- Name: socialaccount_socialapp_sites id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: socialaccount_socialtoken id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialtoken_id_seq'::regclass);


--
-- Name: subscribers_subscribed id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.subscribers_subscribed ALTER COLUMN id SET DEFAULT nextval('public.subscribers_subscribed_id_seq'::regclass);


--
-- Name: suggest_suggestpost id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpost ALTER COLUMN id SET DEFAULT nextval('public.suggest_suggestpost_id_seq'::regclass);


--
-- Name: suggest_suggestpostconfig id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostconfig ALTER COLUMN id SET DEFAULT nextval('public.suggest_suggestpostconfig_id_seq'::regclass);


--
-- Name: suggest_suggestpostgrouped id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostgrouped ALTER COLUMN id SET DEFAULT nextval('public.suggest_suggestpostgrouped_id_seq'::regclass);


--
-- Name: tenant_customer id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.tenant_customer ALTER COLUMN id SET DEFAULT nextval('public.tenant_customer_id_seq'::regclass);


--
-- Name: tenant_customer_users id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.tenant_customer_users ALTER COLUMN id SET DEFAULT nextval('public.tenant_customer_users_id_seq'::regclass);


--
-- Name: textanal_acts id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_acts ALTER COLUMN id SET DEFAULT nextval('public.textanal_acts_id_seq'::regclass);


--
-- Name: textanal_findregex id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_findregex ALTER COLUMN id SET DEFAULT nextval('public.textanal_findregex_id_seq'::regclass);


--
-- Name: textanal_foundregex id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_foundregex ALTER COLUMN id SET DEFAULT nextval('public.textanal_foundregex_id_seq'::regclass);


--
-- Name: textanal_foundregexgrouped id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_foundregexgrouped ALTER COLUMN id SET DEFAULT nextval('public.textanal_foundregexgrouped_id_seq'::regclass);


--
-- Name: textanal_msgbuttons id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_msgbuttons ALTER COLUMN id SET DEFAULT nextval('public.textanal_msgbuttons_id_seq'::regclass);


--
-- Name: textanal_passingtext id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_passingtext ALTER COLUMN id SET DEFAULT nextval('public.textanal_passingtext_id_seq'::regclass);


--
-- Name: textanal_sendchat id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_sendchat ALTER COLUMN id SET DEFAULT nextval('public.textanal_sendchat_id_seq'::regclass);


--
-- Name: textanal_sendchat_forGroups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."textanal_sendchat_forGroups" ALTER COLUMN id SET DEFAULT nextval('public."textanal_sendchat_forGroups_id_seq"'::regclass);


--
-- Name: textanal_unreadmsg id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_unreadmsg ALTER COLUMN id SET DEFAULT nextval('public.textanal_unreadmsg_id_seq'::regclass);


--
-- Name: textanal_unreadmsggrouped id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_unreadmsggrouped ALTER COLUMN id SET DEFAULT nextval('public.textanal_unreadmsggrouped_id_seq'::regclass);


--
-- Name: videoresults_videolog id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.videoresults_videolog ALTER COLUMN id SET DEFAULT nextval('public.videoresults_videolog_id_seq'::regclass);


--
-- Name: videoresults_videoresult id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.videoresults_videoresult ALTER COLUMN id SET DEFAULT nextval('public.videoresults_videoresult_id_seq'::regclass);


--
-- Name: vkin_action id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_action ALTER COLUMN id SET DEFAULT nextval('public.vkin_action_id_seq'::regclass);


--
-- Name: vkin_allusergroups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_allusergroups ALTER COLUMN id SET DEFAULT nextval('public.vkin_allusergroups_id_seq'::regclass);


--
-- Name: vkin_allusergroups_admins id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_allusergroups_admins ALTER COLUMN id SET DEFAULT nextval('public.vkin_allusergroups_admins_id_seq'::regclass);


--
-- Name: vkin_appconfig id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_appconfig ALTER COLUMN id SET DEFAULT nextval('public.vkin_appconfig_id_seq'::regclass);


--
-- Name: vkin_group id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group ALTER COLUMN id SET DEFAULT nextval('public.vkin_group_id_seq'::regclass);


--
-- Name: vkin_group_admins id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_admins ALTER COLUMN id SET DEFAULT nextval('public.vkin_group_admins_id_seq'::regclass);


--
-- Name: vkin_group_moders id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_moders ALTER COLUMN id SET DEFAULT nextval('public.vkin_group_moders_id_seq'::regclass);


--
-- Name: vkin_group_usertokens id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_usertokens ALTER COLUMN id SET DEFAULT nextval('public.vkin_group_usertokens_id_seq'::regclass);


--
-- Name: vkin_groupstatistic id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_groupstatistic ALTER COLUMN id SET DEFAULT nextval('public.vkin_groupstatistic_id_seq'::regclass);


--
-- Name: vkin_historicalgroup history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicalgroup ALTER COLUMN history_id SET DEFAULT nextval('public.vkin_historicalgroup_history_id_seq'::regclass);


--
-- Name: vkin_historicaltextmessages history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicaltextmessages ALTER COLUMN history_id SET DEFAULT nextval('public.vkin_historicaltextmessages_history_id_seq'::regclass);


--
-- Name: vkin_historicalvars history_id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicalvars ALTER COLUMN history_id SET DEFAULT nextval('public.vkin_historicalvars_history_id_seq'::regclass);


--
-- Name: vkin_imagecache id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_imagecache ALTER COLUMN id SET DEFAULT nextval('public.vkin_imagecache_id_seq'::regclass);


--
-- Name: vkin_message id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_message ALTER COLUMN id SET DEFAULT nextval('public.vkin_message_id_seq'::regclass);


--
-- Name: vkin_posttemplates id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_posttemplates ALTER COLUMN id SET DEFAULT nextval('public.vkin_posttemplates_id_seq'::regclass);


--
-- Name: vkin_setofgroups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_setofgroups ALTER COLUMN id SET DEFAULT nextval('public.vkin_setofgroups_id_seq'::regclass);


--
-- Name: vkin_setofgroups_forGroups id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."vkin_setofgroups_forGroups" ALTER COLUMN id SET DEFAULT nextval('public."vkin_setofgroups_forGroups_id_seq"'::regclass);


--
-- Name: vkin_setofvars id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_setofvars ALTER COLUMN id SET DEFAULT nextval('public.vkin_setofvars_id_seq'::regclass);


--
-- Name: vkin_su_user_tokens id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_su_user_tokens ALTER COLUMN id SET DEFAULT nextval('public.vkin_su_user_tokens_id_seq'::regclass);


--
-- Name: vkin_textmessages id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_textmessages ALTER COLUMN id SET DEFAULT nextval('public.vkin_textmessages_id_seq'::regclass);


--
-- Name: vkin_user id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_user ALTER COLUMN id SET DEFAULT nextval('public.vkin_user_id_seq'::regclass);


--
-- Name: vkin_userphone id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_userphone ALTER COLUMN id SET DEFAULT nextval('public.vkin_userphone_id_seq'::regclass);


--
-- Name: vkin_vars id; Type: DEFAULT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_vars ALTER COLUMN id SET DEFAULT nextval('public.vkin_vars_id_seq'::regclass);


--
-- Name: account_emailaddress account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: auctions_auction auctions_auction_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auction
    ADD CONSTRAINT auctions_auction_pkey PRIMARY KEY (id);


--
-- Name: auctions_auctioncost auctions_auctioncost_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auctioncost
    ADD CONSTRAINT auctions_auctioncost_pkey PRIMARY KEY (id);


--
-- Name: auctions_auctlot auctions_auctlot_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auctlot
    ADD CONSTRAINT auctions_auctlot_pkey PRIMARY KEY (id);


--
-- Name: auctions_historicalauctlot auctions_historicalauctlot_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_historicalauctlot
    ADD CONSTRAINT auctions_historicalauctlot_pkey PRIMARY KEY (history_id);


--
-- Name: auctions_historicalscheduledauctionforgroup auctions_historicalscheduledauctionforgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_historicalscheduledauctionforgroup
    ADD CONSTRAINT auctions_historicalscheduledauctionforgroup_pkey PRIMARY KEY (history_id);


--
-- Name: auctions_scheduledauction auctions_scheduledauction_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauction
    ADD CONSTRAINT auctions_scheduledauction_pkey PRIMARY KEY (id);


--
-- Name: auctions_scheduledauctionch auctions_scheduledauctionch_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionch
    ADD CONSTRAINT auctions_scheduledauctionch_pkey PRIMARY KEY (scheduledauction_ptr_id);


--
-- Name: auctions_scheduledauctionforgroup auctions_scheduledauctionforgroup_group_id_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionforgroup
    ADD CONSTRAINT auctions_scheduledauctionforgroup_group_id_key UNIQUE (group_id);


--
-- Name: auctions_scheduledauctionforgroup auctions_scheduledauctionforgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionforgroup
    ADD CONSTRAINT auctions_scheduledauctionforgroup_pkey PRIMARY KEY (id);


--
-- Name: auctions_scheduledauctionpn auctions_scheduledauctionpn_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionpn
    ADD CONSTRAINT auctions_scheduledauctionpn_pkey PRIMARY KEY (scheduledauction_ptr_id);


--
-- Name: auctions_scheduledauctionpt auctions_scheduledauctionpt_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionpt
    ADD CONSTRAINT auctions_scheduledauctionpt_pkey PRIMARY KEY (scheduledauction_ptr_id);


--
-- Name: auctions_scheduledauctionsb auctions_scheduledauctionsb_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionsb
    ADD CONSTRAINT auctions_scheduledauctionsb_pkey PRIMARY KEY (scheduledauction_ptr_id);


--
-- Name: auctions_scheduledauctionsr auctions_scheduledauctionsr_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionsr
    ADD CONSTRAINT auctions_scheduledauctionsr_pkey PRIMARY KEY (scheduledauction_ptr_id);


--
-- Name: auctions_scheduledauctionvs auctions_scheduledauctionvs_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionvs
    ADD CONSTRAINT auctions_scheduledauctionvs_pkey PRIMARY KEY (scheduledauction_ptr_id);


--
-- Name: auctions_scheduledauctionvt auctions_scheduledauctionvt_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionvt
    ADD CONSTRAINT auctions_scheduledauctionvt_pkey PRIMARY KEY (scheduledauction_ptr_id);


--
-- Name: auctions_setauctlot_forGroups auctions_setauctlot_forG_setauctlot_id_group_id_b6bc57d3_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."auctions_setauctlot_forGroups"
    ADD CONSTRAINT "auctions_setauctlot_forG_setauctlot_id_group_id_b6bc57d3_uniq" UNIQUE (setauctlot_id, group_id);


--
-- Name: auctions_setauctlot_forGroups auctions_setauctlot_forGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."auctions_setauctlot_forGroups"
    ADD CONSTRAINT "auctions_setauctlot_forGroups_pkey" PRIMARY KEY (id);


--
-- Name: auctions_setauctlot auctions_setauctlot_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_setauctlot
    ADD CONSTRAINT auctions_setauctlot_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: background_task_completedtask background_task_completedtask_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.background_task_completedtask
    ADD CONSTRAINT background_task_completedtask_pkey PRIMARY KEY (id);


--
-- Name: background_task background_task_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.background_task
    ADD CONSTRAINT background_task_pkey PRIMARY KEY (id);


--
-- Name: bday_bdayposttemplate bday_bdayposttemplate_group_id_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_bdayposttemplate
    ADD CONSTRAINT bday_bdayposttemplate_group_id_key UNIQUE (group_id);


--
-- Name: bday_bdayposttemplate bday_bdayposttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_bdayposttemplate
    ADD CONSTRAINT bday_bdayposttemplate_pkey PRIMARY KEY (id);


--
-- Name: bday_historicalbdayposttemplate bday_historicalbdayposttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalbdayposttemplate
    ADD CONSTRAINT bday_historicalbdayposttemplate_pkey PRIMARY KEY (history_id);


--
-- Name: bday_historicalmsgtemplate bday_historicalmsgtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalmsgtemplate
    ADD CONSTRAINT bday_historicalmsgtemplate_pkey PRIMARY KEY (history_id);


--
-- Name: bday_historicalsetmsgtemplate bday_historicalsetmsgtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalsetmsgtemplate
    ADD CONSTRAINT bday_historicalsetmsgtemplate_pkey PRIMARY KEY (history_id);


--
-- Name: bday_msgtemplate bday_msgtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_msgtemplate
    ADD CONSTRAINT bday_msgtemplate_pkey PRIMARY KEY (id);


--
-- Name: bday_setmsgtemplate bday_setmsgtemplate_group_id_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_setmsgtemplate
    ADD CONSTRAINT bday_setmsgtemplate_group_id_key UNIQUE (group_id);


--
-- Name: bday_setmsgtemplate bday_setmsgtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_setmsgtemplate
    ADD CONSTRAINT bday_setmsgtemplate_pkey PRIMARY KEY (id);


--
-- Name: datacollect_phonetosheet datacollect_phonetosheet_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.datacollect_phonetosheet
    ADD CONSTRAINT datacollect_phonetosheet_pkey PRIMARY KEY (id);


--
-- Name: daywinners_daywinnersprize2 daywinners_daywinnersprize2_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize2
    ADD CONSTRAINT daywinners_daywinnersprize2_pkey PRIMARY KEY (prize_ptr_id);


--
-- Name: daywinners_daywinnersprize3 daywinners_daywinnersprize3_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize3
    ADD CONSTRAINT daywinners_daywinnersprize3_pkey PRIMARY KEY (prize_ptr_id);


--
-- Name: daywinners_daywinnersprize daywinners_daywinnersprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize
    ADD CONSTRAINT daywinners_daywinnersprize_pkey PRIMARY KEY (prize_ptr_id);


--
-- Name: daywinners_doppost daywinners_doppost_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_doppost
    ADD CONSTRAINT daywinners_doppost_pkey PRIMARY KEY (id);


--
-- Name: daywinners_hashsearch daywinners_hashsearch_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_hashsearch
    ADD CONSTRAINT daywinners_hashsearch_pkey PRIMARY KEY (makewinnerstime_ptr_id);


--
-- Name: daywinners_historicalhashsearch daywinners_historicalhashsearch_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalhashsearch
    ADD CONSTRAINT daywinners_historicalhashsearch_pkey PRIMARY KEY (history_id);


--
-- Name: daywinners_historicalrandomactivity daywinners_historicalrandomactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalrandomactivity
    ADD CONSTRAINT daywinners_historicalrandomactivity_pkey PRIMARY KEY (history_id);


--
-- Name: daywinners_historicalrandomphotoreviews daywinners_historicalrandomphotoreviews_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalrandomphotoreviews
    ADD CONSTRAINT daywinners_historicalrandomphotoreviews_pkey PRIMARY KEY (history_id);


--
-- Name: daywinners_historicalweeklywinners daywinners_historicalweeklywinners_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalweeklywinners
    ADD CONSTRAINT daywinners_historicalweeklywinners_pkey PRIMARY KEY (history_id);


--
-- Name: daywinners_makewinnerstime daywinners_makewinnerstime_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_makewinnerstime
    ADD CONSTRAINT daywinners_makewinnerstime_pkey PRIMARY KEY (id);


--
-- Name: daywinners_randomactivity daywinners_randomactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_randomactivity
    ADD CONSTRAINT daywinners_randomactivity_pkey PRIMARY KEY (makewinnerstime_ptr_id);


--
-- Name: daywinners_randomphotoreviews daywinners_randomphotoreviews_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_randomphotoreviews
    ADD CONSTRAINT daywinners_randomphotoreviews_pkey PRIMARY KEY (makewinnerstime_ptr_id);


--
-- Name: daywinners_weeklywinners daywinners_weeklywinners_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_weeklywinners
    ADD CONSTRAINT daywinners_weeklywinners_pkey PRIMARY KEY (makewinnerstime_ptr_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source easy_thumbnails_source_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source easy_thumbnails_source_storage_hash_name_481ce32d_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_storage_hash_name_481ce32d_uniq UNIQUE (storage_hash, name);


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thumbnai_storage_hash_name_source_fb375270_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnai_storage_hash_name_source_fb375270_uniq UNIQUE (storage_hash, name, source_id);


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thumbnail_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thumbnaildimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thumbnaildimensions_thumbnail_id_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_thumbnail_id_key UNIQUE (thumbnail_id);


--
-- Name: gameroulet_banditimageslosing gameroulet_banditimageslosing_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditimageslosing
    ADD CONSTRAINT gameroulet_banditimageslosing_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_banditimageswin gameroulet_banditimageswin_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditimageswin
    ADD CONSTRAINT gameroulet_banditimageswin_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_banditsetimages gameroulet_banditsetimages_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditsetimages
    ADD CONSTRAINT gameroulet_banditsetimages_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_doprouletpost gameroulet_doprouletpost_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_doprouletpost
    ADD CONSTRAINT gameroulet_doprouletpost_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_historicalkostigame gameroulet_historicalkostigame_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalkostigame
    ADD CONSTRAINT gameroulet_historicalkostigame_pkey PRIMARY KEY (history_id);


--
-- Name: gameroulet_historicalrandstop gameroulet_historicalrandstop_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrandstop
    ADD CONSTRAINT gameroulet_historicalrandstop_pkey PRIMARY KEY (history_id);


--
-- Name: gameroulet_historicalrouletbanditgame gameroulet_historicalrouletbanditgame_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrouletbanditgame
    ADD CONSTRAINT gameroulet_historicalrouletbanditgame_pkey PRIMARY KEY (history_id);


--
-- Name: gameroulet_historicalrouletbombergame gameroulet_historicalrouletbombergame_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrouletbombergame
    ADD CONSTRAINT gameroulet_historicalrouletbombergame_pkey PRIMARY KEY (history_id);


--
-- Name: gameroulet_historicalroulethide gameroulet_historicalroulethide_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalroulethide
    ADD CONSTRAINT gameroulet_historicalroulethide_pkey PRIMARY KEY (history_id);


--
-- Name: gameroulet_historicalseabattlegame gameroulet_historicalseabattlegame_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalseabattlegame
    ADD CONSTRAINT gameroulet_historicalseabattlegame_pkey PRIMARY KEY (history_id);


--
-- Name: gameroulet_kostigame gameroulet_kostigame_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostigame
    ADD CONSTRAINT gameroulet_kostigame_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_kostigameprize gameroulet_kostigameprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostigameprize
    ADD CONSTRAINT gameroulet_kostigameprize_pkey PRIMARY KEY (rouletprizebase_ptr_id);


--
-- Name: gameroulet_kostisetimages gameroulet_kostisetimages_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostisetimages
    ADD CONSTRAINT gameroulet_kostisetimages_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_randstop gameroulet_randstop_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_randstop
    ADD CONSTRAINT gameroulet_randstop_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_rouletbanditgame gameroulet_rouletbanditgame_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbanditgame
    ADD CONSTRAINT gameroulet_rouletbanditgame_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_rouletbombergame gameroulet_rouletbombergame_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbombergame
    ADD CONSTRAINT gameroulet_rouletbombergame_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_rouletbomberprize gameroulet_rouletbomberprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbomberprize
    ADD CONSTRAINT gameroulet_rouletbomberprize_pkey PRIMARY KEY (rouletprizebase_ptr_id);


--
-- Name: gameroulet_roulethide gameroulet_roulethide_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_roulethide
    ADD CONSTRAINT gameroulet_roulethide_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_rouletprize gameroulet_rouletprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprize
    ADD CONSTRAINT gameroulet_rouletprize_pkey PRIMARY KEY (rouletprizebase_ptr_id);


--
-- Name: gameroulet_rouletprizebase gameroulet_rouletprizebase_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizebase
    ADD CONSTRAINT gameroulet_rouletprizebase_pkey PRIMARY KEY (prize_ptr_id);


--
-- Name: gameroulet_rouletprizehide gameroulet_rouletprizehide_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizehide
    ADD CONSTRAINT gameroulet_rouletprizehide_pkey PRIMARY KEY (rouletprizebase_ptr_id);


--
-- Name: gameroulet_rouletprizesafe gameroulet_rouletprizesafe_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizesafe
    ADD CONSTRAINT gameroulet_rouletprizesafe_pkey PRIMARY KEY (rouletprizebase_ptr_id);


--
-- Name: gameroulet_rouletprizestop gameroulet_rouletprizestop_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizestop
    ADD CONSTRAINT gameroulet_rouletprizestop_pkey PRIMARY KEY (rouletprizebase_ptr_id);


--
-- Name: gameroulet_rouletsafe gameroulet_rouletsafe_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletsafe
    ADD CONSTRAINT gameroulet_rouletsafe_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_rouletuserlives gameroulet_rouletuserlives_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletuserlives
    ADD CONSTRAINT gameroulet_rouletuserlives_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_seabattlegame gameroulet_seabattlegame_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_seabattlegame
    ADD CONSTRAINT gameroulet_seabattlegame_pkey PRIMARY KEY (id);


--
-- Name: gameroulet_seabattlegameprize gameroulet_seabattlegameprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_seabattlegameprize
    ADD CONSTRAINT gameroulet_seabattlegameprize_pkey PRIMARY KEY (rouletprizebase_ptr_id);


--
-- Name: gpt_gptdialog gpt_gptdialog_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpt_gptdialog
    ADD CONSTRAINT gpt_gptdialog_pkey PRIMARY KEY (id);


--
-- Name: gpt_gptkey gpt_gptkey_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpt_gptkey
    ADD CONSTRAINT gpt_gptkey_pkey PRIMARY KEY (id);


--
-- Name: gpthelper_commentanswer gpthelper_commentanswer_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_commentanswer
    ADD CONSTRAINT gpthelper_commentanswer_pkey PRIMARY KEY (id);


--
-- Name: gpthelper_gptanswerkey gpthelper_gptanswerkey_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_gptanswerkey
    ADD CONSTRAINT gpthelper_gptanswerkey_pkey PRIMARY KEY (id);


--
-- Name: gpthelper_gptdialog gpthelper_gptdialog_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_gptdialog
    ADD CONSTRAINT gpthelper_gptdialog_pkey PRIMARY KEY (id);


--
-- Name: gpthelper_postsettings gpthelper_postsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_postsettings
    ADD CONSTRAINT gpthelper_postsettings_pkey PRIMARY KEY (id);


--
-- Name: greeting_commentpromo greeting_commentpromo_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_commentpromo
    ADD CONSTRAINT greeting_commentpromo_pkey PRIMARY KEY (id);


--
-- Name: greeting_communityreviewspromo greeting_communityreviewspromo_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_communityreviewspromo
    ADD CONSTRAINT greeting_communityreviewspromo_pkey PRIMARY KEY (id);


--
-- Name: greeting_greeting greeting_greeting_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_greeting
    ADD CONSTRAINT greeting_greeting_pkey PRIMARY KEY (id);


--
-- Name: greeting_historicalgreeting greeting_historicalgreeting_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_historicalgreeting
    ADD CONSTRAINT greeting_historicalgreeting_pkey PRIMARY KEY (history_id);


--
-- Name: greeting_historicalrepostpromo greeting_historicalrepostpromo_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_historicalrepostpromo
    ADD CONSTRAINT greeting_historicalrepostpromo_pkey PRIMARY KEY (history_id);


--
-- Name: greeting_jointemplate greeting_jointemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_jointemplate
    ADD CONSTRAINT greeting_jointemplate_pkey PRIMARY KEY (id);


--
-- Name: greeting_repostpromo greeting_repostpromo_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_repostpromo
    ADD CONSTRAINT greeting_repostpromo_pkey PRIMARY KEY (id);


--
-- Name: newcontest_historicalnewcontestprize newcontest_historicalnewcontestprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_historicalnewcontestprize
    ADD CONSTRAINT newcontest_historicalnewcontestprize_pkey PRIMARY KEY (history_id);


--
-- Name: newcontest_historicalrepostcontest newcontest_historicalrepostcontest_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_historicalrepostcontest
    ADD CONSTRAINT newcontest_historicalrepostcontest_pkey PRIMARY KEY (history_id);


--
-- Name: newcontest_newcontestprize newcontest_newcontestprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_newcontestprize
    ADD CONSTRAINT newcontest_newcontestprize_pkey PRIMARY KEY (prize_ptr_id);


--
-- Name: newcontest_participantcontest newcontest_participantco_userid_group_id_contest__fa17c7a4_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_participantcontest
    ADD CONSTRAINT newcontest_participantco_userid_group_id_contest__fa17c7a4_uniq UNIQUE (userid, group_id, contest_id);


--
-- Name: newcontest_participantcontest newcontest_participantcontest_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_participantcontest
    ADD CONSTRAINT newcontest_participantcontest_pkey PRIMARY KEY (id);


--
-- Name: newcontest_repostcontest_forGroups newcontest_repostcontest_forGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."newcontest_repostcontest_forGroups"
    ADD CONSTRAINT "newcontest_repostcontest_forGroups_pkey" PRIMARY KEY (id);


--
-- Name: newcontest_repostcontest newcontest_repostcontest_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_repostcontest
    ADD CONSTRAINT newcontest_repostcontest_pkey PRIMARY KEY (id);


--
-- Name: newcontest_repostcontest_forGroups newcontest_repostcontest_repostcontest_id_group_i_25c972cb_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."newcontest_repostcontest_forGroups"
    ADD CONSTRAINT newcontest_repostcontest_repostcontest_id_group_i_25c972cb_uniq UNIQUE (repostcontest_id, group_id);


--
-- Name: ownerCoverPhoto_ownercoverphotobg ownerCoverPhoto_ownercoverphotobg_group_id_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."ownerCoverPhoto_ownercoverphotobg"
    ADD CONSTRAINT "ownerCoverPhoto_ownercoverphotobg_group_id_key" UNIQUE (group_id);


--
-- Name: ownerCoverPhoto_ownercoverphotobg ownerCoverPhoto_ownercoverphotobg_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."ownerCoverPhoto_ownercoverphotobg"
    ADD CONSTRAINT "ownerCoverPhoto_ownercoverphotobg_pkey" PRIMARY KEY (id);


--
-- Name: photoTickets_historicalticket photoTickets_historicalticket_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_historicalticket"
    ADD CONSTRAINT "photoTickets_historicalticket_pkey" PRIMARY KEY (history_id);


--
-- Name: photoTickets_historicalticketsettings photoTickets_historicalticketsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_historicalticketsettings"
    ADD CONSTRAINT "photoTickets_historicalticketsettings_pkey" PRIMARY KEY (history_id);


--
-- Name: photoTickets_ticket photoTickets_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticket"
    ADD CONSTRAINT "photoTickets_ticket_pkey" PRIMARY KEY (id);


--
-- Name: photoTickets_ticketsettings photoTickets_ticketsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticketsettings"
    ADD CONSTRAINT "photoTickets_ticketsettings_pkey" PRIMARY KEY (id);


--
-- Name: pinnedPost_firstpost pinnedPost_firstpost_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."pinnedPost_firstpost"
    ADD CONSTRAINT "pinnedPost_firstpost_pkey" PRIMARY KEY (id);


--
-- Name: posting_postpone posting_postpone_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_postpone
    ADD CONSTRAINT posting_postpone_pkey PRIMARY KEY (id);


--
-- Name: posting_setposts posting_setposts_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setposts
    ADD CONSTRAINT posting_setposts_pkey PRIMARY KEY (id);


--
-- Name: posting_setpostsch posting_setpostsch_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsch
    ADD CONSTRAINT posting_setpostsch_pkey PRIMARY KEY (setposts_ptr_id);


--
-- Name: posting_setpostsin posting_setpostsin_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsin
    ADD CONSTRAINT posting_setpostsin_pkey PRIMARY KEY (id);


--
-- Name: posting_setpostspn posting_setpostspn_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostspn
    ADD CONSTRAINT posting_setpostspn_pkey PRIMARY KEY (setposts_ptr_id);


--
-- Name: posting_setpostspt posting_setpostspt_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostspt
    ADD CONSTRAINT posting_setpostspt_pkey PRIMARY KEY (setposts_ptr_id);


--
-- Name: posting_setpostssb posting_setpostssb_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostssb
    ADD CONSTRAINT posting_setpostssb_pkey PRIMARY KEY (setposts_ptr_id);


--
-- Name: posting_setpostssr posting_setpostssr_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostssr
    ADD CONSTRAINT posting_setpostssr_pkey PRIMARY KEY (setposts_ptr_id);


--
-- Name: posting_setpostsvs posting_setpostsvs_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsvs
    ADD CONSTRAINT posting_setpostsvs_pkey PRIMARY KEY (setposts_ptr_id);


--
-- Name: posting_setpostsvt posting_setpostsvt_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsvt
    ADD CONSTRAINT posting_setpostsvt_pkey PRIMARY KEY (setposts_ptr_id);


--
-- Name: prizes_blocked_forGroups prizes_blocked_forGroups_blocked_id_group_id_9b58fcab_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_blocked_forGroups"
    ADD CONSTRAINT "prizes_blocked_forGroups_blocked_id_group_id_9b58fcab_uniq" UNIQUE (blocked_id, group_id);


--
-- Name: prizes_blocked_forGroups prizes_blocked_forGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_blocked_forGroups"
    ADD CONSTRAINT "prizes_blocked_forGroups_pkey" PRIMARY KEY (id);


--
-- Name: prizes_blocked prizes_blocked_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_blocked
    ADD CONSTRAINT prizes_blocked_pkey PRIMARY KEY (id);


--
-- Name: prizes_cached_screen_names prizes_cached_screen_names_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_cached_screen_names
    ADD CONSTRAINT prizes_cached_screen_names_pkey PRIMARY KEY (id);


--
-- Name: prizes_contestusers prizes_contestusers_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_contestusers
    ADD CONSTRAINT prizes_contestusers_pkey PRIMARY KEY (id);


--
-- Name: prizes_modelprize_forGroups prizes_modelprize_forGro_modelprize_id_group_id_eb929f1c_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_modelprize_forGroups"
    ADD CONSTRAINT "prizes_modelprize_forGro_modelprize_id_group_id_eb929f1c_uniq" UNIQUE (modelprize_id, group_id);


--
-- Name: prizes_modelprize_forGroups prizes_modelprize_forGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_modelprize_forGroups"
    ADD CONSTRAINT "prizes_modelprize_forGroups_pkey" PRIMARY KEY (id);


--
-- Name: prizes_modelprize prizes_modelprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_modelprize
    ADD CONSTRAINT prizes_modelprize_pkey PRIMARY KEY (id);


--
-- Name: prizes_modelwinnerspost prizes_modelwinnerspost_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_modelwinnerspost
    ADD CONSTRAINT prizes_modelwinnerspost_pkey PRIMARY KEY (id);


--
-- Name: prizes_morpher prizes_morpher_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_morpher
    ADD CONSTRAINT prizes_morpher_pkey PRIMARY KEY (id);


--
-- Name: prizes_prize prizes_prize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_prize
    ADD CONSTRAINT prizes_prize_pkey PRIMARY KEY (id);


--
-- Name: prizes_prizessendmsg prizes_prizessendmsg_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_prizessendmsg
    ADD CONSTRAINT prizes_prizessendmsg_pkey PRIMARY KEY (id);


--
-- Name: prizes_promointerval prizes_promointerval_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_promointerval
    ADD CONSTRAINT prizes_promointerval_pkey PRIMARY KEY (id);


--
-- Name: prizes_promointervalmany prizes_promointervalmany_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_promointervalmany
    ADD CONSTRAINT prizes_promointervalmany_pkey PRIMARY KEY (id);


--
-- Name: prizes_sendmsg prizes_sendmsg_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_sendmsg
    ADD CONSTRAINT prizes_sendmsg_pkey PRIMARY KEY (id);


--
-- Name: prizes_winner prizes_winner_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_winner
    ADD CONSTRAINT prizes_winner_pkey PRIMARY KEY (id);


--
-- Name: randomdata_randomcontest randomdata_randomcontest_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.randomdata_randomcontest
    ADD CONSTRAINT randomdata_randomcontest_pkey PRIMARY KEY (id);


--
-- Name: randomdata_randomnumbers randomdata_randomnumbers_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.randomdata_randomnumbers
    ADD CONSTRAINT randomdata_randomnumbers_pkey PRIMARY KEY (id);


--
-- Name: senlergame_senlercodework senlergame_senlercodework_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlercodework
    ADD CONSTRAINT senlergame_senlercodework_pkey PRIMARY KEY (id);


--
-- Name: senlergame_senlerprize senlergame_senlerprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerprize
    ADD CONSTRAINT senlergame_senlerprize_pkey PRIMARY KEY (id);


--
-- Name: senlergame_senlerwinners senlergame_senlerwinners_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerwinners
    ADD CONSTRAINT senlergame_senlerwinners_pkey PRIMARY KEY (id);


--
-- Name: simple_dopsimplepost simple_dopsimplepost_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_dopsimplepost
    ADD CONSTRAINT simple_dopsimplepost_pkey PRIMARY KEY (id);


--
-- Name: simple_historicaldopsimplepost simple_historicaldopsimplepost_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicaldopsimplepost
    ADD CONSTRAINT simple_historicaldopsimplepost_pkey PRIMARY KEY (history_id);


--
-- Name: simple_historicalsimplecontest simple_historicalsimplecontest_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicalsimplecontest
    ADD CONSTRAINT simple_historicalsimplecontest_pkey PRIMARY KEY (history_id);


--
-- Name: simple_historicalsimpleprize simple_historicalsimpleprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicalsimpleprize
    ADD CONSTRAINT simple_historicalsimpleprize_pkey PRIMARY KEY (history_id);


--
-- Name: simple_simplecontest simple_simplecontest_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simplecontest
    ADD CONSTRAINT simple_simplecontest_pkey PRIMARY KEY (id);


--
-- Name: simple_simpleprize simple_simpleprize_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simpleprize
    ADD CONSTRAINT simple_simpleprize_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_provider_uid_fc810c6e_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_uid_fc810c6e_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialapp socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: subscribers_subscribed subscribers_subscribed_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.subscribers_subscribed
    ADD CONSTRAINT subscribers_subscribed_pkey PRIMARY KEY (id);


--
-- Name: suggest_suggestpost suggest_suggestpost_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpost
    ADD CONSTRAINT suggest_suggestpost_pkey PRIMARY KEY (id);


--
-- Name: suggest_suggestpostconfig suggest_suggestpostconfig_group_id_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostconfig
    ADD CONSTRAINT suggest_suggestpostconfig_group_id_key UNIQUE (group_id);


--
-- Name: suggest_suggestpostconfig suggest_suggestpostconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostconfig
    ADD CONSTRAINT suggest_suggestpostconfig_pkey PRIMARY KEY (id);


--
-- Name: suggest_suggestpostgrouped suggest_suggestpostgrouped_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostgrouped
    ADD CONSTRAINT suggest_suggestpostgrouped_pkey PRIMARY KEY (id);


--
-- Name: tenant_customer tenant_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.tenant_customer
    ADD CONSTRAINT tenant_customer_pkey PRIMARY KEY (id);


--
-- Name: tenant_customer_users tenant_customer_users_customer_id_user_id_4a01aaff_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.tenant_customer_users
    ADD CONSTRAINT tenant_customer_users_customer_id_user_id_4a01aaff_uniq UNIQUE (customer_id, user_id);


--
-- Name: tenant_customer_users tenant_customer_users_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.tenant_customer_users
    ADD CONSTRAINT tenant_customer_users_pkey PRIMARY KEY (id);


--
-- Name: textanal_acts textanal_acts_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_acts
    ADD CONSTRAINT textanal_acts_pkey PRIMARY KEY (id);


--
-- Name: textanal_findregex textanal_findregex_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_findregex
    ADD CONSTRAINT textanal_findregex_pkey PRIMARY KEY (id);


--
-- Name: textanal_foundregex textanal_foundregex_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_foundregex
    ADD CONSTRAINT textanal_foundregex_pkey PRIMARY KEY (id);


--
-- Name: textanal_foundregexgrouped textanal_foundregexgrouped_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_foundregexgrouped
    ADD CONSTRAINT textanal_foundregexgrouped_pkey PRIMARY KEY (id);


--
-- Name: textanal_msgbuttons textanal_msgbuttons_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_msgbuttons
    ADD CONSTRAINT textanal_msgbuttons_pkey PRIMARY KEY (id);


--
-- Name: textanal_passingtext textanal_passingtext_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_passingtext
    ADD CONSTRAINT textanal_passingtext_pkey PRIMARY KEY (id);


--
-- Name: textanal_sendchat_forGroups textanal_sendchat_forGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."textanal_sendchat_forGroups"
    ADD CONSTRAINT "textanal_sendchat_forGroups_pkey" PRIMARY KEY (id);


--
-- Name: textanal_sendchat_forGroups textanal_sendchat_forGroups_sendchat_id_group_id_769c5305_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."textanal_sendchat_forGroups"
    ADD CONSTRAINT "textanal_sendchat_forGroups_sendchat_id_group_id_769c5305_uniq" UNIQUE (sendchat_id, group_id);


--
-- Name: textanal_sendchat textanal_sendchat_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_sendchat
    ADD CONSTRAINT textanal_sendchat_pkey PRIMARY KEY (id);


--
-- Name: textanal_unreadmsg textanal_unreadmsg_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_unreadmsg
    ADD CONSTRAINT textanal_unreadmsg_pkey PRIMARY KEY (id);


--
-- Name: textanal_unreadmsggrouped textanal_unreadmsggrouped_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_unreadmsggrouped
    ADD CONSTRAINT textanal_unreadmsggrouped_pkey PRIMARY KEY (id);


--
-- Name: videoresults_videolog videoresults_videolog_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.videoresults_videolog
    ADD CONSTRAINT videoresults_videolog_pkey PRIMARY KEY (id);


--
-- Name: videoresults_videoresult videoresults_videoresult_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.videoresults_videoresult
    ADD CONSTRAINT videoresults_videoresult_pkey PRIMARY KEY (id);


--
-- Name: vkin_action vkin_action_group_id_idd_typ_2406d923_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_action
    ADD CONSTRAINT vkin_action_group_id_idd_typ_2406d923_uniq UNIQUE (group_id, idd, typ);


--
-- Name: vkin_action vkin_action_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_action
    ADD CONSTRAINT vkin_action_pkey PRIMARY KEY (id);


--
-- Name: vkin_allusergroups_admins vkin_allusergroups_admin_allusergroups_id_user_id_5db6ec99_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_allusergroups_admins
    ADD CONSTRAINT vkin_allusergroups_admin_allusergroups_id_user_id_5db6ec99_uniq UNIQUE (allusergroups_id, user_id);


--
-- Name: vkin_allusergroups_admins vkin_allusergroups_admins_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_allusergroups_admins
    ADD CONSTRAINT vkin_allusergroups_admins_pkey PRIMARY KEY (id);


--
-- Name: vkin_allusergroups vkin_allusergroups_group_id_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_allusergroups
    ADD CONSTRAINT vkin_allusergroups_group_id_key UNIQUE (group_id);


--
-- Name: vkin_allusergroups vkin_allusergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_allusergroups
    ADD CONSTRAINT vkin_allusergroups_pkey PRIMARY KEY (id);


--
-- Name: vkin_appconfig vkin_appconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_appconfig
    ADD CONSTRAINT vkin_appconfig_pkey PRIMARY KEY (id);


--
-- Name: vkin_group_admins vkin_group_admins_group_id_user_id_14a4203b_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_admins
    ADD CONSTRAINT vkin_group_admins_group_id_user_id_14a4203b_uniq UNIQUE (group_id, user_id);


--
-- Name: vkin_group_admins vkin_group_admins_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_admins
    ADD CONSTRAINT vkin_group_admins_pkey PRIMARY KEY (id);


--
-- Name: vkin_group_moders vkin_group_moders_group_id_user_id_39c33e74_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_moders
    ADD CONSTRAINT vkin_group_moders_group_id_user_id_39c33e74_uniq UNIQUE (group_id, user_id);


--
-- Name: vkin_group_moders vkin_group_moders_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_moders
    ADD CONSTRAINT vkin_group_moders_pkey PRIMARY KEY (id);


--
-- Name: vkin_group vkin_group_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group
    ADD CONSTRAINT vkin_group_pkey PRIMARY KEY (id);


--
-- Name: vkin_group_usertokens vkin_group_usertokens_group_id_su_user_tokens_id_96c19d47_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_usertokens
    ADD CONSTRAINT vkin_group_usertokens_group_id_su_user_tokens_id_96c19d47_uniq UNIQUE (group_id, su_user_tokens_id);


--
-- Name: vkin_group_usertokens vkin_group_usertokens_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_usertokens
    ADD CONSTRAINT vkin_group_usertokens_pkey PRIMARY KEY (id);


--
-- Name: vkin_groupstatistic vkin_groupstatistic_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_groupstatistic
    ADD CONSTRAINT vkin_groupstatistic_pkey PRIMARY KEY (id);


--
-- Name: vkin_historicalgroup vkin_historicalgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicalgroup
    ADD CONSTRAINT vkin_historicalgroup_pkey PRIMARY KEY (history_id);


--
-- Name: vkin_historicaltextmessages vkin_historicaltextmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicaltextmessages
    ADD CONSTRAINT vkin_historicaltextmessages_pkey PRIMARY KEY (history_id);


--
-- Name: vkin_historicalvars vkin_historicalvars_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicalvars
    ADD CONSTRAINT vkin_historicalvars_pkey PRIMARY KEY (history_id);


--
-- Name: vkin_imagecache vkin_imagecache_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_imagecache
    ADD CONSTRAINT vkin_imagecache_pkey PRIMARY KEY (id);


--
-- Name: vkin_message vkin_message_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_message
    ADD CONSTRAINT vkin_message_pkey PRIMARY KEY (id);


--
-- Name: vkin_posttemplates vkin_posttemplates_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_posttemplates
    ADD CONSTRAINT vkin_posttemplates_pkey PRIMARY KEY (id);


--
-- Name: vkin_setofgroups_forGroups vkin_setofgroups_forGrou_setofgroups_id_group_id_60cb68f3_uniq; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."vkin_setofgroups_forGroups"
    ADD CONSTRAINT "vkin_setofgroups_forGrou_setofgroups_id_group_id_60cb68f3_uniq" UNIQUE (setofgroups_id, group_id);


--
-- Name: vkin_setofgroups_forGroups vkin_setofgroups_forGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."vkin_setofgroups_forGroups"
    ADD CONSTRAINT "vkin_setofgroups_forGroups_pkey" PRIMARY KEY (id);


--
-- Name: vkin_setofgroups vkin_setofgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_setofgroups
    ADD CONSTRAINT vkin_setofgroups_pkey PRIMARY KEY (id);


--
-- Name: vkin_setofvars vkin_setofvars_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_setofvars
    ADD CONSTRAINT vkin_setofvars_pkey PRIMARY KEY (id);


--
-- Name: vkin_su_user_tokens vkin_su_user_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_su_user_tokens
    ADD CONSTRAINT vkin_su_user_tokens_pkey PRIMARY KEY (id);


--
-- Name: vkin_textmessages vkin_textmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_textmessages
    ADD CONSTRAINT vkin_textmessages_pkey PRIMARY KEY (id);


--
-- Name: vkin_user vkin_user_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_user
    ADD CONSTRAINT vkin_user_pkey PRIMARY KEY (id);


--
-- Name: vkin_user vkin_user_userid_key; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_user
    ADD CONSTRAINT vkin_user_userid_key UNIQUE (userid);


--
-- Name: vkin_userphone vkin_userphone_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_userphone
    ADD CONSTRAINT vkin_userphone_pkey PRIMARY KEY (id);


--
-- Name: vkin_vars vkin_vars_pkey; Type: CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_vars
    ADD CONSTRAINT vkin_vars_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON public.account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailaddress_user_id_2c513194; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);


--
-- Name: account_emailconfirmation_email_address_id_5b7f8c58; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: auctions_auction_config_id_00750962; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_auction_config_id_00750962 ON public.auctions_auction USING btree (config_id);


--
-- Name: auctions_auction_group_id_86265d1b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_auction_group_id_86265d1b ON public.auctions_auction USING btree (group_id);


--
-- Name: auctions_auction_lot_id_88819f0b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_auction_lot_id_88819f0b ON public.auctions_auction USING btree (lot_id);


--
-- Name: auctions_auction_tenant_id_ba2a4ebb; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_auction_tenant_id_ba2a4ebb ON public.auctions_auction USING btree (tenant_id);


--
-- Name: auctions_auctioncost_auct_id_1d889001; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_auctioncost_auct_id_1d889001 ON public.auctions_auctioncost USING btree (auct_id);


--
-- Name: auctions_auctioncost_tenant_id_014bb2c8; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_auctioncost_tenant_id_014bb2c8 ON public.auctions_auctioncost USING btree (tenant_id);


--
-- Name: auctions_auctlot_property_id_d09a251e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_auctlot_property_id_d09a251e ON public.auctions_auctlot USING btree (property_id);


--
-- Name: auctions_auctlot_tenant_id_d5f2541a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_auctlot_tenant_id_d5f2541a ON public.auctions_auctlot USING btree (tenant_id);


--
-- Name: auctions_historicalauctlot_history_date_3dcf8fac; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalauctlot_history_date_3dcf8fac ON public.auctions_historicalauctlot USING btree (history_date);


--
-- Name: auctions_historicalauctlot_history_user_id_090fe50e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalauctlot_history_user_id_090fe50e ON public.auctions_historicalauctlot USING btree (history_user_id);


--
-- Name: auctions_historicalauctlot_id_e4047f96; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalauctlot_id_e4047f96 ON public.auctions_historicalauctlot USING btree (id);


--
-- Name: auctions_historicalauctlot_property_id_352ce714; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalauctlot_property_id_352ce714 ON public.auctions_historicalauctlot USING btree (property_id);


--
-- Name: auctions_historicalauctlot_tenant_id_e3a7c463; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalauctlot_tenant_id_e3a7c463 ON public.auctions_historicalauctlot USING btree (tenant_id);


--
-- Name: auctions_historicalschedul_history_date_c0914ae7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalschedul_history_date_c0914ae7 ON public.auctions_historicalscheduledauctionforgroup USING btree (history_date);


--
-- Name: auctions_historicalschedul_history_user_id_406afe29; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalschedul_history_user_id_406afe29 ON public.auctions_historicalscheduledauctionforgroup USING btree (history_user_id);


--
-- Name: auctions_historicalscheduledauctionforgroup_group_id_538f50ec; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalscheduledauctionforgroup_group_id_538f50ec ON public.auctions_historicalscheduledauctionforgroup USING btree (group_id);


--
-- Name: auctions_historicalscheduledauctionforgroup_id_bf892e40; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalscheduledauctionforgroup_id_bf892e40 ON public.auctions_historicalscheduledauctionforgroup USING btree (id);


--
-- Name: auctions_historicalscheduledauctionforgroup_tenant_id_f677c490; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_historicalscheduledauctionforgroup_tenant_id_f677c490 ON public.auctions_historicalscheduledauctionforgroup USING btree (tenant_id);


--
-- Name: auctions_scheduledauction_lot_id_efadcbf5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_scheduledauction_lot_id_efadcbf5 ON public.auctions_scheduledauction USING btree (lot_id);


--
-- Name: auctions_scheduledauction_property_id_599f0503; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_scheduledauction_property_id_599f0503 ON public.auctions_scheduledauction USING btree (property_id);


--
-- Name: auctions_scheduledauction_tenant_id_7cc5630d; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_scheduledauction_tenant_id_7cc5630d ON public.auctions_scheduledauction USING btree (tenant_id);


--
-- Name: auctions_scheduledauctionforgroup_tenant_id_e352382a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_scheduledauctionforgroup_tenant_id_e352382a ON public.auctions_scheduledauctionforgroup USING btree (tenant_id);


--
-- Name: auctions_setauctlot_forGroups_group_id_84e48c0c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "auctions_setauctlot_forGroups_group_id_84e48c0c" ON public."auctions_setauctlot_forGroups" USING btree (group_id);


--
-- Name: auctions_setauctlot_forGroups_setauctlot_id_8db14d96; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "auctions_setauctlot_forGroups_setauctlot_id_8db14d96" ON public."auctions_setauctlot_forGroups" USING btree (setauctlot_id);


--
-- Name: auctions_setauctlot_tenant_id_e0ddc07b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auctions_setauctlot_tenant_id_e0ddc07b ON public.auctions_setauctlot USING btree (tenant_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: background_task_attempts_a9ade23d; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_attempts_a9ade23d ON public.background_task USING btree (attempts);


--
-- Name: background_task_completedtask_attempts_772a6783; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_attempts_772a6783 ON public.background_task_completedtask USING btree (attempts);


--
-- Name: background_task_completedtask_creator_content_type_id_21d6a741; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_creator_content_type_id_21d6a741 ON public.background_task_completedtask USING btree (creator_content_type_id);


--
-- Name: background_task_completedtask_failed_at_3de56618; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_failed_at_3de56618 ON public.background_task_completedtask USING btree (failed_at);


--
-- Name: background_task_completedtask_locked_at_29c62708; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_locked_at_29c62708 ON public.background_task_completedtask USING btree (locked_at);


--
-- Name: background_task_completedtask_locked_by_edc8a213; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_locked_by_edc8a213 ON public.background_task_completedtask USING btree (locked_by);


--
-- Name: background_task_completedtask_locked_by_edc8a213_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_locked_by_edc8a213_like ON public.background_task_completedtask USING btree (locked_by varchar_pattern_ops);


--
-- Name: background_task_completedtask_priority_9080692e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_priority_9080692e ON public.background_task_completedtask USING btree (priority);


--
-- Name: background_task_completedtask_queue_61fb0415; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_queue_61fb0415 ON public.background_task_completedtask USING btree (queue);


--
-- Name: background_task_completedtask_queue_61fb0415_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_queue_61fb0415_like ON public.background_task_completedtask USING btree (queue varchar_pattern_ops);


--
-- Name: background_task_completedtask_run_at_77c80f34; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_run_at_77c80f34 ON public.background_task_completedtask USING btree (run_at);


--
-- Name: background_task_completedtask_task_hash_91187576; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_task_hash_91187576 ON public.background_task_completedtask USING btree (task_hash);


--
-- Name: background_task_completedtask_task_hash_91187576_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_task_hash_91187576_like ON public.background_task_completedtask USING btree (task_hash varchar_pattern_ops);


--
-- Name: background_task_completedtask_task_name_388dabc2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_task_name_388dabc2 ON public.background_task_completedtask USING btree (task_name);


--
-- Name: background_task_completedtask_task_name_388dabc2_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_completedtask_task_name_388dabc2_like ON public.background_task_completedtask USING btree (task_name varchar_pattern_ops);


--
-- Name: background_task_creator_content_type_id_61cc9af3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_creator_content_type_id_61cc9af3 ON public.background_task USING btree (creator_content_type_id);


--
-- Name: background_task_failed_at_b81bba14; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_failed_at_b81bba14 ON public.background_task USING btree (failed_at);


--
-- Name: background_task_locked_at_0fb0f225; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_locked_at_0fb0f225 ON public.background_task USING btree (locked_at);


--
-- Name: background_task_locked_by_db7779e3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_locked_by_db7779e3 ON public.background_task USING btree (locked_by);


--
-- Name: background_task_locked_by_db7779e3_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_locked_by_db7779e3_like ON public.background_task USING btree (locked_by varchar_pattern_ops);


--
-- Name: background_task_priority_88bdbce9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_priority_88bdbce9 ON public.background_task USING btree (priority);


--
-- Name: background_task_queue_1d5f3a40; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_queue_1d5f3a40 ON public.background_task USING btree (queue);


--
-- Name: background_task_queue_1d5f3a40_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_queue_1d5f3a40_like ON public.background_task USING btree (queue varchar_pattern_ops);


--
-- Name: background_task_run_at_7baca3aa; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_run_at_7baca3aa ON public.background_task USING btree (run_at);


--
-- Name: background_task_task_hash_d8f233bd; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_task_hash_d8f233bd ON public.background_task USING btree (task_hash);


--
-- Name: background_task_task_hash_d8f233bd_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_task_hash_d8f233bd_like ON public.background_task USING btree (task_hash varchar_pattern_ops);


--
-- Name: background_task_task_name_4562d56a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_task_name_4562d56a ON public.background_task USING btree (task_name);


--
-- Name: background_task_task_name_4562d56a_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX background_task_task_name_4562d56a_like ON public.background_task USING btree (task_name varchar_pattern_ops);


--
-- Name: bday_bdayposttemplate_tenant_id_97e5e424; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_bdayposttemplate_tenant_id_97e5e424 ON public.bday_bdayposttemplate USING btree (tenant_id);


--
-- Name: bday_historicalbdayposttemplate_group_id_30e33990; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalbdayposttemplate_group_id_30e33990 ON public.bday_historicalbdayposttemplate USING btree (group_id);


--
-- Name: bday_historicalbdayposttemplate_history_date_b8513b69; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalbdayposttemplate_history_date_b8513b69 ON public.bday_historicalbdayposttemplate USING btree (history_date);


--
-- Name: bday_historicalbdayposttemplate_history_user_id_35ef46c1; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalbdayposttemplate_history_user_id_35ef46c1 ON public.bday_historicalbdayposttemplate USING btree (history_user_id);


--
-- Name: bday_historicalbdayposttemplate_id_263640d5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalbdayposttemplate_id_263640d5 ON public.bday_historicalbdayposttemplate USING btree (id);


--
-- Name: bday_historicalbdayposttemplate_tenant_id_677df877; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalbdayposttemplate_tenant_id_677df877 ON public.bday_historicalbdayposttemplate USING btree (tenant_id);


--
-- Name: bday_historicalmsgtemplate_history_date_12191cb3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalmsgtemplate_history_date_12191cb3 ON public.bday_historicalmsgtemplate USING btree (history_date);


--
-- Name: bday_historicalmsgtemplate_history_user_id_da87fd1f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalmsgtemplate_history_user_id_da87fd1f ON public.bday_historicalmsgtemplate USING btree (history_user_id);


--
-- Name: bday_historicalmsgtemplate_id_ca59f875; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalmsgtemplate_id_ca59f875 ON public.bday_historicalmsgtemplate USING btree (id);


--
-- Name: bday_historicalmsgtemplate_property_id_b2e79062; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalmsgtemplate_property_id_b2e79062 ON public.bday_historicalmsgtemplate USING btree (property_id);


--
-- Name: bday_historicalmsgtemplate_tenant_id_6fba9a52; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalmsgtemplate_tenant_id_6fba9a52 ON public.bday_historicalmsgtemplate USING btree (tenant_id);


--
-- Name: bday_historicalsetmsgtemplate_group_id_deab2616; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalsetmsgtemplate_group_id_deab2616 ON public.bday_historicalsetmsgtemplate USING btree (group_id);


--
-- Name: bday_historicalsetmsgtemplate_history_date_ba92a0e3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalsetmsgtemplate_history_date_ba92a0e3 ON public.bday_historicalsetmsgtemplate USING btree (history_date);


--
-- Name: bday_historicalsetmsgtemplate_history_user_id_0c970302; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalsetmsgtemplate_history_user_id_0c970302 ON public.bday_historicalsetmsgtemplate USING btree (history_user_id);


--
-- Name: bday_historicalsetmsgtemplate_id_b4f400af; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalsetmsgtemplate_id_b4f400af ON public.bday_historicalsetmsgtemplate USING btree (id);


--
-- Name: bday_historicalsetmsgtemplate_tenant_id_a3541572; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_historicalsetmsgtemplate_tenant_id_a3541572 ON public.bday_historicalsetmsgtemplate USING btree (tenant_id);


--
-- Name: bday_msgtemplate_property_id_19fd6374; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_msgtemplate_property_id_19fd6374 ON public.bday_msgtemplate USING btree (property_id);


--
-- Name: bday_msgtemplate_tenant_id_e8c99301; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_msgtemplate_tenant_id_e8c99301 ON public.bday_msgtemplate USING btree (tenant_id);


--
-- Name: bday_setmsgtemplate_tenant_id_8f92d25c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX bday_setmsgtemplate_tenant_id_8f92d25c ON public.bday_setmsgtemplate USING btree (tenant_id);


--
-- Name: datacollect_phonetosheet_group_id_bb6ea286; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX datacollect_phonetosheet_group_id_bb6ea286 ON public.datacollect_phonetosheet USING btree (group_id);


--
-- Name: datacollect_phonetosheet_tenant_id_79a5fbd8; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX datacollect_phonetosheet_tenant_id_79a5fbd8 ON public.datacollect_phonetosheet USING btree (tenant_id);


--
-- Name: daywinners_daywinnersprize2_contest_id_49158562; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_daywinnersprize2_contest_id_49158562 ON public.daywinners_daywinnersprize2 USING btree (contest_id);


--
-- Name: daywinners_daywinnersprize3_contest_id_93fcf335; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_daywinnersprize3_contest_id_93fcf335 ON public.daywinners_daywinnersprize3 USING btree (contest_id);


--
-- Name: daywinners_daywinnersprize_contest_id_def476c1; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_daywinnersprize_contest_id_def476c1 ON public.daywinners_daywinnersprize USING btree (contest_id);


--
-- Name: daywinners_doppost_contest_id_06de23f0; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_doppost_contest_id_06de23f0 ON public.daywinners_doppost USING btree (contest_id);


--
-- Name: daywinners_doppost_tenant_id_e072c75e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_doppost_tenant_id_e072c75e ON public.daywinners_doppost USING btree (tenant_id);


--
-- Name: daywinners_historicalhashsearch_group_id_3118871e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalhashsearch_group_id_3118871e ON public.daywinners_historicalhashsearch USING btree (group_id);


--
-- Name: daywinners_historicalhashsearch_history_date_b33b6968; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalhashsearch_history_date_b33b6968 ON public.daywinners_historicalhashsearch USING btree (history_date);


--
-- Name: daywinners_historicalhashsearch_history_user_id_bf506f75; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalhashsearch_history_user_id_bf506f75 ON public.daywinners_historicalhashsearch USING btree (history_user_id);


--
-- Name: daywinners_historicalhashsearch_id_87f4168c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalhashsearch_id_87f4168c ON public.daywinners_historicalhashsearch USING btree (id);


--
-- Name: daywinners_historicalhashsearch_makewinnerstime_ptr_id_81f83257; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalhashsearch_makewinnerstime_ptr_id_81f83257 ON public.daywinners_historicalhashsearch USING btree (makewinnerstime_ptr_id);


--
-- Name: daywinners_historicalhashsearch_tenant_id_deff1a7e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalhashsearch_tenant_id_deff1a7e ON public.daywinners_historicalhashsearch USING btree (tenant_id);


--
-- Name: daywinners_historicalhashsearch_vid_id_8ae2b056; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalhashsearch_vid_id_8ae2b056 ON public.daywinners_historicalhashsearch USING btree (vid_id);


--
-- Name: daywinners_historicalrando_history_user_id_a300fee7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrando_history_user_id_a300fee7 ON public.daywinners_historicalrandomphotoreviews USING btree (history_user_id);


--
-- Name: daywinners_historicalrando_makewinnerstime_ptr_id_d7552e85; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrando_makewinnerstime_ptr_id_d7552e85 ON public.daywinners_historicalrandomactivity USING btree (makewinnerstime_ptr_id);


--
-- Name: daywinners_historicalrando_makewinnerstime_ptr_id_df9c14a2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrando_makewinnerstime_ptr_id_df9c14a2 ON public.daywinners_historicalrandomphotoreviews USING btree (makewinnerstime_ptr_id);


--
-- Name: daywinners_historicalrandomactivity_group_id_7481b187; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomactivity_group_id_7481b187 ON public.daywinners_historicalrandomactivity USING btree (group_id);


--
-- Name: daywinners_historicalrandomactivity_history_date_647646e5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomactivity_history_date_647646e5 ON public.daywinners_historicalrandomactivity USING btree (history_date);


--
-- Name: daywinners_historicalrandomactivity_history_user_id_2e48e46e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomactivity_history_user_id_2e48e46e ON public.daywinners_historicalrandomactivity USING btree (history_user_id);


--
-- Name: daywinners_historicalrandomactivity_id_49fb84a6; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomactivity_id_49fb84a6 ON public.daywinners_historicalrandomactivity USING btree (id);


--
-- Name: daywinners_historicalrandomactivity_tenant_id_8a299e26; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomactivity_tenant_id_8a299e26 ON public.daywinners_historicalrandomactivity USING btree (tenant_id);


--
-- Name: daywinners_historicalrandomactivity_vid_id_27dc4050; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomactivity_vid_id_27dc4050 ON public.daywinners_historicalrandomactivity USING btree (vid_id);


--
-- Name: daywinners_historicalrandomphotoreviews_group_id_54b80c58; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomphotoreviews_group_id_54b80c58 ON public.daywinners_historicalrandomphotoreviews USING btree (group_id);


--
-- Name: daywinners_historicalrandomphotoreviews_history_date_274d8f0d; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomphotoreviews_history_date_274d8f0d ON public.daywinners_historicalrandomphotoreviews USING btree (history_date);


--
-- Name: daywinners_historicalrandomphotoreviews_id_63bde5ae; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomphotoreviews_id_63bde5ae ON public.daywinners_historicalrandomphotoreviews USING btree (id);


--
-- Name: daywinners_historicalrandomphotoreviews_tenant_id_18daf3f3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomphotoreviews_tenant_id_18daf3f3 ON public.daywinners_historicalrandomphotoreviews USING btree (tenant_id);


--
-- Name: daywinners_historicalrandomphotoreviews_vid_id_305b9d3e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalrandomphotoreviews_vid_id_305b9d3e ON public.daywinners_historicalrandomphotoreviews USING btree (vid_id);


--
-- Name: daywinners_historicalweekl_makewinnerstime_ptr_id_6ff8145e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalweekl_makewinnerstime_ptr_id_6ff8145e ON public.daywinners_historicalweeklywinners USING btree (makewinnerstime_ptr_id);


--
-- Name: daywinners_historicalweeklywinners_group_id_7f19c1cd; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalweeklywinners_group_id_7f19c1cd ON public.daywinners_historicalweeklywinners USING btree (group_id);


--
-- Name: daywinners_historicalweeklywinners_history_date_eddc656e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalweeklywinners_history_date_eddc656e ON public.daywinners_historicalweeklywinners USING btree (history_date);


--
-- Name: daywinners_historicalweeklywinners_history_user_id_2806a003; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalweeklywinners_history_user_id_2806a003 ON public.daywinners_historicalweeklywinners USING btree (history_user_id);


--
-- Name: daywinners_historicalweeklywinners_id_2d41bcc5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalweeklywinners_id_2d41bcc5 ON public.daywinners_historicalweeklywinners USING btree (id);


--
-- Name: daywinners_historicalweeklywinners_tenant_id_051f025b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalweeklywinners_tenant_id_051f025b ON public.daywinners_historicalweeklywinners USING btree (tenant_id);


--
-- Name: daywinners_historicalweeklywinners_vid_id_ec41f843; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_historicalweeklywinners_vid_id_ec41f843 ON public.daywinners_historicalweeklywinners USING btree (vid_id);


--
-- Name: daywinners_makewinnerstime_group_id_78d318ec; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_makewinnerstime_group_id_78d318ec ON public.daywinners_makewinnerstime USING btree (group_id);


--
-- Name: daywinners_makewinnerstime_tenant_id_18d56487; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_makewinnerstime_tenant_id_18d56487 ON public.daywinners_makewinnerstime USING btree (tenant_id);


--
-- Name: daywinners_makewinnerstime_vid_id_60481485; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX daywinners_makewinnerstime_vid_id_60481485 ON public.daywinners_makewinnerstime USING btree (vid_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_name_5fe0edc6; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_source_name_5fe0edc6 ON public.easy_thumbnails_source USING btree (name);


--
-- Name: easy_thumbnails_source_name_5fe0edc6_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_source_name_5fe0edc6_like ON public.easy_thumbnails_source USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_storage_hash_946cbcc9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_source_storage_hash_946cbcc9 ON public.easy_thumbnails_source USING btree (storage_hash);


--
-- Name: easy_thumbnails_source_storage_hash_946cbcc9_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_source_storage_hash_946cbcc9_like ON public.easy_thumbnails_source USING btree (storage_hash varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_name_b5882c31; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_thumbnail_name_b5882c31 ON public.easy_thumbnails_thumbnail USING btree (name);


--
-- Name: easy_thumbnails_thumbnail_name_b5882c31_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_thumbnail_name_b5882c31_like ON public.easy_thumbnails_thumbnail USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_source_id_5b57bc77; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_thumbnail_source_id_5b57bc77 ON public.easy_thumbnails_thumbnail USING btree (source_id);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_f1435f49; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49 ON public.easy_thumbnails_thumbnail USING btree (storage_hash);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_f1435f49_like; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49_like ON public.easy_thumbnails_thumbnail USING btree (storage_hash varchar_pattern_ops);


--
-- Name: gameroulet_banditimageslosing_property_id_837c35db; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_banditimageslosing_property_id_837c35db ON public.gameroulet_banditimageslosing USING btree (property_id);


--
-- Name: gameroulet_banditimageslosing_tenant_id_f966eec1; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_banditimageslosing_tenant_id_f966eec1 ON public.gameroulet_banditimageslosing USING btree (tenant_id);


--
-- Name: gameroulet_banditimageswin_property_id_55fb2798; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_banditimageswin_property_id_55fb2798 ON public.gameroulet_banditimageswin USING btree (property_id);


--
-- Name: gameroulet_banditimageswin_tenant_id_f95b43ae; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_banditimageswin_tenant_id_f95b43ae ON public.gameroulet_banditimageswin USING btree (tenant_id);


--
-- Name: gameroulet_banditsetimages_tenant_id_539245f3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_banditsetimages_tenant_id_539245f3 ON public.gameroulet_banditsetimages USING btree (tenant_id);


--
-- Name: gameroulet_doprouletpost_content_type_id_19af7ef3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_doprouletpost_content_type_id_19af7ef3 ON public.gameroulet_doprouletpost USING btree (content_type_id);


--
-- Name: gameroulet_doprouletpost_tenant_id_de6829ca; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_doprouletpost_tenant_id_de6829ca ON public.gameroulet_doprouletpost USING btree (tenant_id);


--
-- Name: gameroulet_historicalkostigame_group_id_6035cead; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalkostigame_group_id_6035cead ON public.gameroulet_historicalkostigame USING btree (group_id);


--
-- Name: gameroulet_historicalkostigame_history_date_4ad73cc3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalkostigame_history_date_4ad73cc3 ON public.gameroulet_historicalkostigame USING btree (history_date);


--
-- Name: gameroulet_historicalkostigame_history_user_id_8cc2f812; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalkostigame_history_user_id_8cc2f812 ON public.gameroulet_historicalkostigame USING btree (history_user_id);


--
-- Name: gameroulet_historicalkostigame_id_a31c0ff6; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalkostigame_id_a31c0ff6 ON public.gameroulet_historicalkostigame USING btree (id);


--
-- Name: gameroulet_historicalkostigame_kostiimages_id_c52e7785; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalkostigame_kostiimages_id_c52e7785 ON public.gameroulet_historicalkostigame USING btree (kostiimages_id);


--
-- Name: gameroulet_historicalkostigame_tenant_id_4bec1168; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalkostigame_tenant_id_4bec1168 ON public.gameroulet_historicalkostigame USING btree (tenant_id);


--
-- Name: gameroulet_historicalrandstop_group_id_de914680; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrandstop_group_id_de914680 ON public.gameroulet_historicalrandstop USING btree (group_id);


--
-- Name: gameroulet_historicalrandstop_history_date_6209517f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrandstop_history_date_6209517f ON public.gameroulet_historicalrandstop USING btree (history_date);


--
-- Name: gameroulet_historicalrandstop_history_user_id_8d4ec56c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrandstop_history_user_id_8d4ec56c ON public.gameroulet_historicalrandstop USING btree (history_user_id);


--
-- Name: gameroulet_historicalrandstop_id_c7e709f5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrandstop_id_c7e709f5 ON public.gameroulet_historicalrandstop USING btree (id);


--
-- Name: gameroulet_historicalrandstop_tenant_id_f9d87195; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrandstop_tenant_id_f9d87195 ON public.gameroulet_historicalrandstop USING btree (tenant_id);


--
-- Name: gameroulet_historicalrouletbanditgame_group_id_74862459; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbanditgame_group_id_74862459 ON public.gameroulet_historicalrouletbanditgame USING btree (group_id);


--
-- Name: gameroulet_historicalrouletbanditgame_history_date_97264f6b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbanditgame_history_date_97264f6b ON public.gameroulet_historicalrouletbanditgame USING btree (history_date);


--
-- Name: gameroulet_historicalrouletbanditgame_history_user_id_8b4a5e4a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbanditgame_history_user_id_8b4a5e4a ON public.gameroulet_historicalrouletbanditgame USING btree (history_user_id);


--
-- Name: gameroulet_historicalrouletbanditgame_id_50221d35; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbanditgame_id_50221d35 ON public.gameroulet_historicalrouletbanditgame USING btree (id);


--
-- Name: gameroulet_historicalrouletbanditgame_rouletimages_id_25f9240e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbanditgame_rouletimages_id_25f9240e ON public.gameroulet_historicalrouletbanditgame USING btree (rouletimages_id);


--
-- Name: gameroulet_historicalrouletbanditgame_tenant_id_04645357; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbanditgame_tenant_id_04645357 ON public.gameroulet_historicalrouletbanditgame USING btree (tenant_id);


--
-- Name: gameroulet_historicalrouletbombergame_group_id_7c9a5a2c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbombergame_group_id_7c9a5a2c ON public.gameroulet_historicalrouletbombergame USING btree (group_id);


--
-- Name: gameroulet_historicalrouletbombergame_history_date_de25f6ab; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbombergame_history_date_de25f6ab ON public.gameroulet_historicalrouletbombergame USING btree (history_date);


--
-- Name: gameroulet_historicalrouletbombergame_history_user_id_31d921c9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbombergame_history_user_id_31d921c9 ON public.gameroulet_historicalrouletbombergame USING btree (history_user_id);


--
-- Name: gameroulet_historicalrouletbombergame_id_29eb8c2b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbombergame_id_29eb8c2b ON public.gameroulet_historicalrouletbombergame USING btree (id);


--
-- Name: gameroulet_historicalrouletbombergame_tenant_id_b107312c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalrouletbombergame_tenant_id_b107312c ON public.gameroulet_historicalrouletbombergame USING btree (tenant_id);


--
-- Name: gameroulet_historicalroulethide_group_id_79b992ac; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalroulethide_group_id_79b992ac ON public.gameroulet_historicalroulethide USING btree (group_id);


--
-- Name: gameroulet_historicalroulethide_history_date_7024ba19; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalroulethide_history_date_7024ba19 ON public.gameroulet_historicalroulethide USING btree (history_date);


--
-- Name: gameroulet_historicalroulethide_history_user_id_6356d59a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalroulethide_history_user_id_6356d59a ON public.gameroulet_historicalroulethide USING btree (history_user_id);


--
-- Name: gameroulet_historicalroulethide_id_aa311139; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalroulethide_id_aa311139 ON public.gameroulet_historicalroulethide USING btree (id);


--
-- Name: gameroulet_historicalroulethide_tenant_id_009c6743; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalroulethide_tenant_id_009c6743 ON public.gameroulet_historicalroulethide USING btree (tenant_id);


--
-- Name: gameroulet_historicalseabattlegame_group_id_22ec5c93; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalseabattlegame_group_id_22ec5c93 ON public.gameroulet_historicalseabattlegame USING btree (group_id);


--
-- Name: gameroulet_historicalseabattlegame_history_date_c6414baa; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalseabattlegame_history_date_c6414baa ON public.gameroulet_historicalseabattlegame USING btree (history_date);


--
-- Name: gameroulet_historicalseabattlegame_history_user_id_a80d09bd; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalseabattlegame_history_user_id_a80d09bd ON public.gameroulet_historicalseabattlegame USING btree (history_user_id);


--
-- Name: gameroulet_historicalseabattlegame_id_c66b2bd8; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalseabattlegame_id_c66b2bd8 ON public.gameroulet_historicalseabattlegame USING btree (id);


--
-- Name: gameroulet_historicalseabattlegame_tenant_id_f0f71bd7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_historicalseabattlegame_tenant_id_f0f71bd7 ON public.gameroulet_historicalseabattlegame USING btree (tenant_id);


--
-- Name: gameroulet_kostigame_group_id_bfaa42b9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_kostigame_group_id_bfaa42b9 ON public.gameroulet_kostigame USING btree (group_id);


--
-- Name: gameroulet_kostigame_kostiimages_id_42fa59fe; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_kostigame_kostiimages_id_42fa59fe ON public.gameroulet_kostigame USING btree (kostiimages_id);


--
-- Name: gameroulet_kostigame_tenant_id_02bf171b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_kostigame_tenant_id_02bf171b ON public.gameroulet_kostigame USING btree (tenant_id);


--
-- Name: gameroulet_kostigameprize_contest_id_95013f61; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_kostigameprize_contest_id_95013f61 ON public.gameroulet_kostigameprize USING btree (contest_id);


--
-- Name: gameroulet_kostisetimages_tenant_id_9ee1b4d4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_kostisetimages_tenant_id_9ee1b4d4 ON public.gameroulet_kostisetimages USING btree (tenant_id);


--
-- Name: gameroulet_randstop_group_id_db29490f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_randstop_group_id_db29490f ON public.gameroulet_randstop USING btree (group_id);


--
-- Name: gameroulet_randstop_tenant_id_6e12e05b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_randstop_tenant_id_6e12e05b ON public.gameroulet_randstop USING btree (tenant_id);


--
-- Name: gameroulet_rouletbanditgame_group_id_bd3403b4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletbanditgame_group_id_bd3403b4 ON public.gameroulet_rouletbanditgame USING btree (group_id);


--
-- Name: gameroulet_rouletbanditgame_rouletimages_id_eb421e5b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletbanditgame_rouletimages_id_eb421e5b ON public.gameroulet_rouletbanditgame USING btree (rouletimages_id);


--
-- Name: gameroulet_rouletbanditgame_tenant_id_008442cf; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletbanditgame_tenant_id_008442cf ON public.gameroulet_rouletbanditgame USING btree (tenant_id);


--
-- Name: gameroulet_rouletbombergame_group_id_4870a66e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletbombergame_group_id_4870a66e ON public.gameroulet_rouletbombergame USING btree (group_id);


--
-- Name: gameroulet_rouletbombergame_tenant_id_e32383e7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletbombergame_tenant_id_e32383e7 ON public.gameroulet_rouletbombergame USING btree (tenant_id);


--
-- Name: gameroulet_rouletbomberprize_contest_id_11d534d4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletbomberprize_contest_id_11d534d4 ON public.gameroulet_rouletbomberprize USING btree (contest_id);


--
-- Name: gameroulet_roulethide_group_id_70790b9f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_roulethide_group_id_70790b9f ON public.gameroulet_roulethide USING btree (group_id);


--
-- Name: gameroulet_roulethide_tenant_id_1c494416; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_roulethide_tenant_id_1c494416 ON public.gameroulet_roulethide USING btree (tenant_id);


--
-- Name: gameroulet_rouletprize_contest_id_747df45a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletprize_contest_id_747df45a ON public.gameroulet_rouletprize USING btree (contest_id);


--
-- Name: gameroulet_rouletprizehide_contest_id_1c562109; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletprizehide_contest_id_1c562109 ON public.gameroulet_rouletprizehide USING btree (contest_id);


--
-- Name: gameroulet_rouletprizesafe_contest_id_35cc9fa0; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletprizesafe_contest_id_35cc9fa0 ON public.gameroulet_rouletprizesafe USING btree (contest_id);


--
-- Name: gameroulet_rouletprizestop_contest_id_4f484e58; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletprizestop_contest_id_4f484e58 ON public.gameroulet_rouletprizestop USING btree (contest_id);


--
-- Name: gameroulet_rouletsafe_group_id_56f31016; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletsafe_group_id_56f31016 ON public.gameroulet_rouletsafe USING btree (group_id);


--
-- Name: gameroulet_rouletsafe_safeimages_id_1770f697; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletsafe_safeimages_id_1770f697 ON public.gameroulet_rouletsafe USING btree (safeimages_id);


--
-- Name: gameroulet_rouletsafe_tenant_id_2ad1b74b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletsafe_tenant_id_2ad1b74b ON public.gameroulet_rouletsafe USING btree (tenant_id);


--
-- Name: gameroulet_rouletuserlives_contest_id_33e1aef6; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletuserlives_contest_id_33e1aef6 ON public.gameroulet_rouletuserlives USING btree (contest_id);


--
-- Name: gameroulet_rouletuserlives_tenant_id_6e3d80b4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_rouletuserlives_tenant_id_6e3d80b4 ON public.gameroulet_rouletuserlives USING btree (tenant_id);


--
-- Name: gameroulet_seabattlegame_group_id_b99e70b0; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_seabattlegame_group_id_b99e70b0 ON public.gameroulet_seabattlegame USING btree (group_id);


--
-- Name: gameroulet_seabattlegame_tenant_id_e0acefe3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_seabattlegame_tenant_id_e0acefe3 ON public.gameroulet_seabattlegame USING btree (tenant_id);


--
-- Name: gameroulet_seabattlegameprize_contest_id_3b9dec97; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gameroulet_seabattlegameprize_contest_id_3b9dec97 ON public.gameroulet_seabattlegameprize USING btree (contest_id);


--
-- Name: gpt_gptdialog_key_id_a6ef0c21; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gpt_gptdialog_key_id_a6ef0c21 ON public.gpt_gptdialog USING btree (key_id);


--
-- Name: gpthelper_commentanswer_group_id_250b6e49; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gpthelper_commentanswer_group_id_250b6e49 ON public.gpthelper_commentanswer USING btree (group_id);


--
-- Name: gpthelper_commentanswer_tenant_id_8e268ad0; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gpthelper_commentanswer_tenant_id_8e268ad0 ON public.gpthelper_commentanswer USING btree (tenant_id);


--
-- Name: gpthelper_gptdialog_key_id_82a371af; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gpthelper_gptdialog_key_id_82a371af ON public.gpthelper_gptdialog USING btree (key_id);


--
-- Name: gpthelper_postsettings_group_id_e211af29; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gpthelper_postsettings_group_id_e211af29 ON public.gpthelper_postsettings USING btree (group_id);


--
-- Name: gpthelper_postsettings_tenant_id_4cf058cc; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX gpthelper_postsettings_tenant_id_4cf058cc ON public.gpthelper_postsettings USING btree (tenant_id);


--
-- Name: greeting_commentpromo_group_id_016bb0a0; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_commentpromo_group_id_016bb0a0 ON public.greeting_commentpromo USING btree (group_id);


--
-- Name: greeting_commentpromo_tenant_id_0fe68167; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_commentpromo_tenant_id_0fe68167 ON public.greeting_commentpromo USING btree (tenant_id);


--
-- Name: greeting_communityreviewspromo_group_id_0f924f86; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_communityreviewspromo_group_id_0f924f86 ON public.greeting_communityreviewspromo USING btree (group_id);


--
-- Name: greeting_communityreviewspromo_tenant_id_0c8c1f9d; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_communityreviewspromo_tenant_id_0c8c1f9d ON public.greeting_communityreviewspromo USING btree (tenant_id);


--
-- Name: greeting_greeting_group_id_892beb93; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_greeting_group_id_892beb93 ON public.greeting_greeting USING btree (group_id);


--
-- Name: greeting_greeting_tenant_id_dfe525cc; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_greeting_tenant_id_dfe525cc ON public.greeting_greeting USING btree (tenant_id);


--
-- Name: greeting_historicalgreeting_group_id_a024403b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalgreeting_group_id_a024403b ON public.greeting_historicalgreeting USING btree (group_id);


--
-- Name: greeting_historicalgreeting_history_date_60f71315; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalgreeting_history_date_60f71315 ON public.greeting_historicalgreeting USING btree (history_date);


--
-- Name: greeting_historicalgreeting_history_user_id_6c3c3843; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalgreeting_history_user_id_6c3c3843 ON public.greeting_historicalgreeting USING btree (history_user_id);


--
-- Name: greeting_historicalgreeting_id_40d13aeb; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalgreeting_id_40d13aeb ON public.greeting_historicalgreeting USING btree (id);


--
-- Name: greeting_historicalgreeting_tenant_id_d083e15b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalgreeting_tenant_id_d083e15b ON public.greeting_historicalgreeting USING btree (tenant_id);


--
-- Name: greeting_historicalrepostpromo_group_id_a349706b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalrepostpromo_group_id_a349706b ON public.greeting_historicalrepostpromo USING btree (group_id);


--
-- Name: greeting_historicalrepostpromo_history_date_e0ed11f4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalrepostpromo_history_date_e0ed11f4 ON public.greeting_historicalrepostpromo USING btree (history_date);


--
-- Name: greeting_historicalrepostpromo_history_user_id_9388eacf; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalrepostpromo_history_user_id_9388eacf ON public.greeting_historicalrepostpromo USING btree (history_user_id);


--
-- Name: greeting_historicalrepostpromo_id_d4f38155; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalrepostpromo_id_d4f38155 ON public.greeting_historicalrepostpromo USING btree (id);


--
-- Name: greeting_historicalrepostpromo_tenant_id_ea621518; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_historicalrepostpromo_tenant_id_ea621518 ON public.greeting_historicalrepostpromo USING btree (tenant_id);


--
-- Name: greeting_jointemplate_parent_id_a4f4708e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_jointemplate_parent_id_a4f4708e ON public.greeting_jointemplate USING btree (parent_id);


--
-- Name: greeting_jointemplate_tenant_id_94def8e9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_jointemplate_tenant_id_94def8e9 ON public.greeting_jointemplate USING btree (tenant_id);


--
-- Name: greeting_repostpromo_group_id_1fc2ada4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_repostpromo_group_id_1fc2ada4 ON public.greeting_repostpromo USING btree (group_id);


--
-- Name: greeting_repostpromo_tenant_id_04ce0de1; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX greeting_repostpromo_tenant_id_04ce0de1 ON public.greeting_repostpromo USING btree (tenant_id);


--
-- Name: newcontest_historicalnewcontestprize_contest_id_98684a6c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalnewcontestprize_contest_id_98684a6c ON public.newcontest_historicalnewcontestprize USING btree (contest_id);


--
-- Name: newcontest_historicalnewcontestprize_history_date_5f9d30c2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalnewcontestprize_history_date_5f9d30c2 ON public.newcontest_historicalnewcontestprize USING btree (history_date);


--
-- Name: newcontest_historicalnewcontestprize_history_user_id_e7c115d7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalnewcontestprize_history_user_id_e7c115d7 ON public.newcontest_historicalnewcontestprize USING btree (history_user_id);


--
-- Name: newcontest_historicalnewcontestprize_id_d91da69f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalnewcontestprize_id_d91da69f ON public.newcontest_historicalnewcontestprize USING btree (id);


--
-- Name: newcontest_historicalnewcontestprize_prize_ptr_id_dce43232; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalnewcontestprize_prize_ptr_id_dce43232 ON public.newcontest_historicalnewcontestprize USING btree (prize_ptr_id);


--
-- Name: newcontest_historicalnewcontestprize_tenant_id_c17673f3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalnewcontestprize_tenant_id_c17673f3 ON public.newcontest_historicalnewcontestprize USING btree (tenant_id);


--
-- Name: newcontest_historicalrepostcontest_history_date_485cd34f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalrepostcontest_history_date_485cd34f ON public.newcontest_historicalrepostcontest USING btree (history_date);


--
-- Name: newcontest_historicalrepostcontest_history_user_id_3492cab8; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalrepostcontest_history_user_id_3492cab8 ON public.newcontest_historicalrepostcontest USING btree (history_user_id);


--
-- Name: newcontest_historicalrepostcontest_id_34ddfa43; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalrepostcontest_id_34ddfa43 ON public.newcontest_historicalrepostcontest USING btree (id);


--
-- Name: newcontest_historicalrepostcontest_tenant_id_af50f210; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_historicalrepostcontest_tenant_id_af50f210 ON public.newcontest_historicalrepostcontest USING btree (tenant_id);


--
-- Name: newcontest_newcontestprize_contest_id_7ee8137f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_newcontestprize_contest_id_7ee8137f ON public.newcontest_newcontestprize USING btree (contest_id);


--
-- Name: newcontest_participantcontest_contest_id_af38b97b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_participantcontest_contest_id_af38b97b ON public.newcontest_participantcontest USING btree (contest_id);


--
-- Name: newcontest_participantcontest_group_id_fbbb7b52; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_participantcontest_group_id_fbbb7b52 ON public.newcontest_participantcontest USING btree (group_id);


--
-- Name: newcontest_participantcontest_tenant_id_f9c92e81; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_participantcontest_tenant_id_f9c92e81 ON public.newcontest_participantcontest USING btree (tenant_id);


--
-- Name: newcontest_repostcontest_forGroups_group_id_7a841a9a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "newcontest_repostcontest_forGroups_group_id_7a841a9a" ON public."newcontest_repostcontest_forGroups" USING btree (group_id);


--
-- Name: newcontest_repostcontest_forGroups_repostcontest_id_dbd81430; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "newcontest_repostcontest_forGroups_repostcontest_id_dbd81430" ON public."newcontest_repostcontest_forGroups" USING btree (repostcontest_id);


--
-- Name: newcontest_repostcontest_tenant_id_5800bc24; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX newcontest_repostcontest_tenant_id_5800bc24 ON public.newcontest_repostcontest USING btree (tenant_id);


--
-- Name: ownerCoverPhoto_ownercoverphotobg_tenant_id_8df35a14; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "ownerCoverPhoto_ownercoverphotobg_tenant_id_8df35a14" ON public."ownerCoverPhoto_ownercoverphotobg" USING btree (tenant_id);


--
-- Name: photoTickets_historicalticket_group_id_835c5604; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticket_group_id_835c5604" ON public."photoTickets_historicalticket" USING btree (group_id);


--
-- Name: photoTickets_historicalticket_history_date_d4f31b40; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticket_history_date_d4f31b40" ON public."photoTickets_historicalticket" USING btree (history_date);


--
-- Name: photoTickets_historicalticket_history_user_id_c6f3e68d; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticket_history_user_id_c6f3e68d" ON public."photoTickets_historicalticket" USING btree (history_user_id);


--
-- Name: photoTickets_historicalticket_id_167a9712; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticket_id_167a9712" ON public."photoTickets_historicalticket" USING btree (id);


--
-- Name: photoTickets_historicalticket_tenant_id_85523602; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticket_tenant_id_85523602" ON public."photoTickets_historicalticket" USING btree (tenant_id);


--
-- Name: photoTickets_historicalticket_tset_id_91ad3998; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticket_tset_id_91ad3998" ON public."photoTickets_historicalticket" USING btree (tset_id);


--
-- Name: photoTickets_historicalticketsettings_group_id_73f7c796; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticketsettings_group_id_73f7c796" ON public."photoTickets_historicalticketsettings" USING btree (group_id);


--
-- Name: photoTickets_historicalticketsettings_history_date_6dc525ee; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticketsettings_history_date_6dc525ee" ON public."photoTickets_historicalticketsettings" USING btree (history_date);


--
-- Name: photoTickets_historicalticketsettings_history_user_id_e903aa1c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticketsettings_history_user_id_e903aa1c" ON public."photoTickets_historicalticketsettings" USING btree (history_user_id);


--
-- Name: photoTickets_historicalticketsettings_id_b386a01f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticketsettings_id_b386a01f" ON public."photoTickets_historicalticketsettings" USING btree (id);


--
-- Name: photoTickets_historicalticketsettings_tenant_id_59e3328e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_historicalticketsettings_tenant_id_59e3328e" ON public."photoTickets_historicalticketsettings" USING btree (tenant_id);


--
-- Name: photoTickets_ticket_group_id_619be4c5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_ticket_group_id_619be4c5" ON public."photoTickets_ticket" USING btree (group_id);


--
-- Name: photoTickets_ticket_tenant_id_303891bb; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_ticket_tenant_id_303891bb" ON public."photoTickets_ticket" USING btree (tenant_id);


--
-- Name: photoTickets_ticket_tset_id_23ef52e4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_ticket_tset_id_23ef52e4" ON public."photoTickets_ticket" USING btree (tset_id);


--
-- Name: photoTickets_ticketsettings_group_id_e4f187de; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_ticketsettings_group_id_e4f187de" ON public."photoTickets_ticketsettings" USING btree (group_id);


--
-- Name: photoTickets_ticketsettings_tenant_id_a4c66c50; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "photoTickets_ticketsettings_tenant_id_a4c66c50" ON public."photoTickets_ticketsettings" USING btree (tenant_id);


--
-- Name: pinnedPost_firstpost_group_id_731e8871; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "pinnedPost_firstpost_group_id_731e8871" ON public."pinnedPost_firstpost" USING btree (group_id);


--
-- Name: pinnedPost_firstpost_tenant_id_5e85e25f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "pinnedPost_firstpost_tenant_id_5e85e25f" ON public."pinnedPost_firstpost" USING btree (tenant_id);


--
-- Name: posting_postpone_group_id_20524d47; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX posting_postpone_group_id_20524d47 ON public.posting_postpone USING btree (group_id);


--
-- Name: posting_postpone_owner_id_9be249b6; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX posting_postpone_owner_id_9be249b6 ON public.posting_postpone USING btree (owner_id);


--
-- Name: posting_postpone_tenant_id_7c53f878; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX posting_postpone_tenant_id_7c53f878 ON public.posting_postpone USING btree (tenant_id);


--
-- Name: posting_setposts_property_id_7157b1f9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX posting_setposts_property_id_7157b1f9 ON public.posting_setposts USING btree (property_id);


--
-- Name: posting_setposts_tenant_id_871cb242; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX posting_setposts_tenant_id_871cb242 ON public.posting_setposts USING btree (tenant_id);


--
-- Name: posting_setpostsin_setgroup_id_41395a2c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX posting_setpostsin_setgroup_id_41395a2c ON public.posting_setpostsin USING btree (setgroup_id);


--
-- Name: posting_setpostsin_tenant_id_6b7a1be7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX posting_setpostsin_tenant_id_6b7a1be7 ON public.posting_setpostsin USING btree (tenant_id);


--
-- Name: prizes_blocked_forGroups_blocked_id_707c32cf; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "prizes_blocked_forGroups_blocked_id_707c32cf" ON public."prizes_blocked_forGroups" USING btree (blocked_id);


--
-- Name: prizes_blocked_forGroups_group_id_b7f92ce4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "prizes_blocked_forGroups_group_id_b7f92ce4" ON public."prizes_blocked_forGroups" USING btree (group_id);


--
-- Name: prizes_blocked_tenant_id_49c73e13; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_blocked_tenant_id_49c73e13 ON public.prizes_blocked USING btree (tenant_id);


--
-- Name: prizes_contestusers_group_id_5b998272; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_contestusers_group_id_5b998272 ON public.prizes_contestusers USING btree (group_id);


--
-- Name: prizes_contestusers_tenant_id_9d53a1a2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_contestusers_tenant_id_9d53a1a2 ON public.prizes_contestusers USING btree (tenant_id);


--
-- Name: prizes_modelprize_forGroups_group_id_e1b0a856; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "prizes_modelprize_forGroups_group_id_e1b0a856" ON public."prizes_modelprize_forGroups" USING btree (group_id);


--
-- Name: prizes_modelprize_forGroups_modelprize_id_0bd36ca4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "prizes_modelprize_forGroups_modelprize_id_0bd36ca4" ON public."prizes_modelprize_forGroups" USING btree (modelprize_id);


--
-- Name: prizes_modelprize_tenant_id_172c9937; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_modelprize_tenant_id_172c9937 ON public.prizes_modelprize USING btree (tenant_id);


--
-- Name: prizes_modelwinnerspost_group_id_ef2db227; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_modelwinnerspost_group_id_ef2db227 ON public.prizes_modelwinnerspost USING btree (group_id);


--
-- Name: prizes_modelwinnerspost_tenant_id_e0d183cd; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_modelwinnerspost_tenant_id_e0d183cd ON public.prizes_modelwinnerspost USING btree (tenant_id);


--
-- Name: prizes_prize_tenant_id_1a339592; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_prize_tenant_id_1a339592 ON public.prizes_prize USING btree (tenant_id);


--
-- Name: prizes_prizessendmsg_group_id_efcdea33; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_prizessendmsg_group_id_efcdea33 ON public.prizes_prizessendmsg USING btree (group_id);


--
-- Name: prizes_prizessendmsg_tenant_id_56e0d230; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_prizessendmsg_tenant_id_56e0d230 ON public.prizes_prizessendmsg USING btree (tenant_id);


--
-- Name: prizes_promointerval_group_id_ce7fff09; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_promointerval_group_id_ce7fff09 ON public.prizes_promointerval USING btree (group_id);


--
-- Name: prizes_promointerval_tenant_id_3102844e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_promointerval_tenant_id_3102844e ON public.prizes_promointerval USING btree (tenant_id);


--
-- Name: prizes_promointervalmany_group_id_18abe98a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_promointervalmany_group_id_18abe98a ON public.prizes_promointervalmany USING btree (group_id);


--
-- Name: prizes_promointervalmany_tenant_id_9a9523f8; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_promointervalmany_tenant_id_9a9523f8 ON public.prizes_promointervalmany USING btree (tenant_id);


--
-- Name: prizes_sendmsg_group_id_5ab140d8; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_sendmsg_group_id_5ab140d8 ON public.prizes_sendmsg USING btree (group_id);


--
-- Name: prizes_sendmsg_tenant_id_7d337315; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_sendmsg_tenant_id_7d337315 ON public.prizes_sendmsg USING btree (tenant_id);


--
-- Name: prizes_winner_group_id_d59a3daf; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_winner_group_id_d59a3daf ON public.prizes_winner USING btree (group_id);


--
-- Name: prizes_winner_tenant_id_cfb943f3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX prizes_winner_tenant_id_cfb943f3 ON public.prizes_winner USING btree (tenant_id);


--
-- Name: randomdata_randomcontest_tenant_id_89b55900; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX randomdata_randomcontest_tenant_id_89b55900 ON public.randomdata_randomcontest USING btree (tenant_id);


--
-- Name: randomdata_randomnumbers_tenant_id_7d14ca08; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX randomdata_randomnumbers_tenant_id_7d14ca08 ON public.randomdata_randomnumbers USING btree (tenant_id);


--
-- Name: senlergame_senlercodework_group_id_8cc53e80; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX senlergame_senlercodework_group_id_8cc53e80 ON public.senlergame_senlercodework USING btree (group_id);


--
-- Name: senlergame_senlercodework_tenant_id_a22e33ae; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX senlergame_senlercodework_tenant_id_a22e33ae ON public.senlergame_senlercodework USING btree (tenant_id);


--
-- Name: senlergame_senlerprize_contest_id_dfcf9872; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX senlergame_senlerprize_contest_id_dfcf9872 ON public.senlergame_senlerprize USING btree (contest_id);


--
-- Name: senlergame_senlerprize_tenant_id_0359d499; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX senlergame_senlerprize_tenant_id_0359d499 ON public.senlergame_senlerprize USING btree (tenant_id);


--
-- Name: senlergame_senlerwinners_group_id_f94d2aaa; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX senlergame_senlerwinners_group_id_f94d2aaa ON public.senlergame_senlerwinners USING btree (group_id);


--
-- Name: senlergame_senlerwinners_tenant_id_2f22bfd2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX senlergame_senlerwinners_tenant_id_2f22bfd2 ON public.senlergame_senlerwinners USING btree (tenant_id);


--
-- Name: senlergame_senlerwinners_vid_id_60237c54; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX senlergame_senlerwinners_vid_id_60237c54 ON public.senlergame_senlerwinners USING btree (vid_id);


--
-- Name: simple_dopsimplepost_contest_id_537b49f4; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_dopsimplepost_contest_id_537b49f4 ON public.simple_dopsimplepost USING btree (contest_id);


--
-- Name: simple_dopsimplepost_tenant_id_a41358f6; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_dopsimplepost_tenant_id_a41358f6 ON public.simple_dopsimplepost USING btree (tenant_id);


--
-- Name: simple_historicaldopsimplepost_contest_id_941d60fb; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicaldopsimplepost_contest_id_941d60fb ON public.simple_historicaldopsimplepost USING btree (contest_id);


--
-- Name: simple_historicaldopsimplepost_history_date_e5809d64; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicaldopsimplepost_history_date_e5809d64 ON public.simple_historicaldopsimplepost USING btree (history_date);


--
-- Name: simple_historicaldopsimplepost_history_user_id_de1eaed5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicaldopsimplepost_history_user_id_de1eaed5 ON public.simple_historicaldopsimplepost USING btree (history_user_id);


--
-- Name: simple_historicaldopsimplepost_id_bef49398; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicaldopsimplepost_id_bef49398 ON public.simple_historicaldopsimplepost USING btree (id);


--
-- Name: simple_historicaldopsimplepost_tenant_id_aea881d9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicaldopsimplepost_tenant_id_aea881d9 ON public.simple_historicaldopsimplepost USING btree (tenant_id);


--
-- Name: simple_historicalsimplecontest_group_id_a958ee55; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimplecontest_group_id_a958ee55 ON public.simple_historicalsimplecontest USING btree (group_id);


--
-- Name: simple_historicalsimplecontest_history_date_62861a22; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimplecontest_history_date_62861a22 ON public.simple_historicalsimplecontest USING btree (history_date);


--
-- Name: simple_historicalsimplecontest_history_user_id_cb637d72; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimplecontest_history_user_id_cb637d72 ON public.simple_historicalsimplecontest USING btree (history_user_id);


--
-- Name: simple_historicalsimplecontest_id_9d705f40; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimplecontest_id_9d705f40 ON public.simple_historicalsimplecontest USING btree (id);


--
-- Name: simple_historicalsimplecontest_tenant_id_cfc57517; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimplecontest_tenant_id_cfc57517 ON public.simple_historicalsimplecontest USING btree (tenant_id);


--
-- Name: simple_historicalsimplecontest_vid_id_970c29e5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimplecontest_vid_id_970c29e5 ON public.simple_historicalsimplecontest USING btree (vid_id);


--
-- Name: simple_historicalsimpleprize_contest_id_01f30ae9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimpleprize_contest_id_01f30ae9 ON public.simple_historicalsimpleprize USING btree (contest_id);


--
-- Name: simple_historicalsimpleprize_history_date_229b5795; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimpleprize_history_date_229b5795 ON public.simple_historicalsimpleprize USING btree (history_date);


--
-- Name: simple_historicalsimpleprize_history_user_id_060ee836; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimpleprize_history_user_id_060ee836 ON public.simple_historicalsimpleprize USING btree (history_user_id);


--
-- Name: simple_historicalsimpleprize_id_14a2d0a1; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimpleprize_id_14a2d0a1 ON public.simple_historicalsimpleprize USING btree (id);


--
-- Name: simple_historicalsimpleprize_tenant_id_c39218b0; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_historicalsimpleprize_tenant_id_c39218b0 ON public.simple_historicalsimpleprize USING btree (tenant_id);


--
-- Name: simple_simplecontest_group_id_397cce27; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_simplecontest_group_id_397cce27 ON public.simple_simplecontest USING btree (group_id);


--
-- Name: simple_simplecontest_tenant_id_f1f401e3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_simplecontest_tenant_id_f1f401e3 ON public.simple_simplecontest USING btree (tenant_id);


--
-- Name: simple_simplecontest_vid_id_3155f48e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_simplecontest_vid_id_3155f48e ON public.simple_simplecontest USING btree (vid_id);


--
-- Name: simple_simpleprize_contest_id_1d6f0858; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_simpleprize_contest_id_1d6f0858 ON public.simple_simpleprize USING btree (contest_id);


--
-- Name: simple_simpleprize_tenant_id_3cc45d33; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX simple_simpleprize_tenant_id_3cc45d33 ON public.simple_simpleprize USING btree (tenant_id);


--
-- Name: socialaccount_socialaccount_user_id_8146e70c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX socialaccount_socialaccount_user_id_8146e70c ON public.socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_site_id_2579dee5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX socialaccount_socialapp_sites_site_id_2579dee5 ON public.socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_97fb6e7d; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX socialaccount_socialapp_sites_socialapp_id_97fb6e7d ON public.socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_account_id_951f210e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX socialaccount_socialtoken_account_id_951f210e ON public.socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_app_id_636a42d7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX socialaccount_socialtoken_app_id_636a42d7 ON public.socialaccount_socialtoken USING btree (app_id);


--
-- Name: subscribers_subscribed_group_id_34f55531; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX subscribers_subscribed_group_id_34f55531 ON public.subscribers_subscribed USING btree (group_id);


--
-- Name: subscribers_subscribed_tenant_id_b5099db9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX subscribers_subscribed_tenant_id_b5099db9 ON public.subscribers_subscribed USING btree (tenant_id);


--
-- Name: suggest_suggestpost_group_id_4b6cb8dd; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX suggest_suggestpost_group_id_4b6cb8dd ON public.suggest_suggestpost USING btree (group_id);


--
-- Name: suggest_suggestpost_tenant_id_c1a30654; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX suggest_suggestpost_tenant_id_c1a30654 ON public.suggest_suggestpost USING btree (tenant_id);


--
-- Name: suggest_suggestpostconfig_tenant_id_d8717eb3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX suggest_suggestpostconfig_tenant_id_d8717eb3 ON public.suggest_suggestpostconfig USING btree (tenant_id);


--
-- Name: suggest_suggestpostgrouped_group_id_f222cab7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX suggest_suggestpostgrouped_group_id_f222cab7 ON public.suggest_suggestpostgrouped USING btree (group_id);


--
-- Name: suggest_suggestpostgrouped_tenant_id_af8825df; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX suggest_suggestpostgrouped_tenant_id_af8825df ON public.suggest_suggestpostgrouped USING btree (tenant_id);


--
-- Name: tenant_customer_users_customer_id_b51f8ee1; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX tenant_customer_users_customer_id_b51f8ee1 ON public.tenant_customer_users USING btree (customer_id);


--
-- Name: tenant_customer_users_user_id_db112e1e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX tenant_customer_users_user_id_db112e1e ON public.tenant_customer_users USING btree (user_id);


--
-- Name: textanal_acts_tenant_id_a0ace6aa; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_acts_tenant_id_a0ace6aa ON public.textanal_acts USING btree (tenant_id);


--
-- Name: textanal_findregex_tenant_id_2f83fe82; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_findregex_tenant_id_2f83fe82 ON public.textanal_findregex USING btree (tenant_id);


--
-- Name: textanal_foundregex_group_id_3884d501; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_foundregex_group_id_3884d501 ON public.textanal_foundregex USING btree (group_id);


--
-- Name: textanal_foundregex_tenant_id_ee52649b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_foundregex_tenant_id_ee52649b ON public.textanal_foundregex USING btree (tenant_id);


--
-- Name: textanal_foundregexgrouped_group_id_4a6b006d; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_foundregexgrouped_group_id_4a6b006d ON public.textanal_foundregexgrouped USING btree (group_id);


--
-- Name: textanal_foundregexgrouped_tenant_id_dafc4759; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_foundregexgrouped_tenant_id_dafc4759 ON public.textanal_foundregexgrouped USING btree (tenant_id);


--
-- Name: textanal_msgbuttons_tenant_id_e0bedec8; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_msgbuttons_tenant_id_e0bedec8 ON public.textanal_msgbuttons USING btree (tenant_id);


--
-- Name: textanal_passingtext_tenant_id_20364255; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_passingtext_tenant_id_20364255 ON public.textanal_passingtext USING btree (tenant_id);


--
-- Name: textanal_sendchat_forGroups_group_id_3317759f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "textanal_sendchat_forGroups_group_id_3317759f" ON public."textanal_sendchat_forGroups" USING btree (group_id);


--
-- Name: textanal_sendchat_forGroups_sendchat_id_31534deb; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "textanal_sendchat_forGroups_sendchat_id_31534deb" ON public."textanal_sendchat_forGroups" USING btree (sendchat_id);


--
-- Name: textanal_sendchat_group_id_93c2b86b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_sendchat_group_id_93c2b86b ON public.textanal_sendchat USING btree (group_id);


--
-- Name: textanal_sendchat_tenant_id_c37fb970; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_sendchat_tenant_id_c37fb970 ON public.textanal_sendchat USING btree (tenant_id);


--
-- Name: textanal_unreadmsg_group_id_09a494d1; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_unreadmsg_group_id_09a494d1 ON public.textanal_unreadmsg USING btree (group_id);


--
-- Name: textanal_unreadmsg_tenant_id_55a29491; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_unreadmsg_tenant_id_55a29491 ON public.textanal_unreadmsg USING btree (tenant_id);


--
-- Name: textanal_unreadmsggrouped_group_id_65256541; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_unreadmsggrouped_group_id_65256541 ON public.textanal_unreadmsggrouped USING btree (group_id);


--
-- Name: textanal_unreadmsggrouped_tenant_id_1337abc7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX textanal_unreadmsggrouped_tenant_id_1337abc7 ON public.textanal_unreadmsggrouped USING btree (tenant_id);


--
-- Name: videoresults_videolog_tenant_id_ea75fb5d; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX videoresults_videolog_tenant_id_ea75fb5d ON public.videoresults_videolog USING btree (tenant_id);


--
-- Name: videoresults_videoresult_tenant_id_20248b4a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX videoresults_videoresult_tenant_id_20248b4a ON public.videoresults_videoresult USING btree (tenant_id);


--
-- Name: vkin_action_group_id_7224bcf8; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_action_group_id_7224bcf8 ON public.vkin_action USING btree (group_id);


--
-- Name: vkin_action_tenant_id_6c793c44; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_action_tenant_id_6c793c44 ON public.vkin_action USING btree (tenant_id);


--
-- Name: vkin_allusergroups_admins_allusergroups_id_ebbbb356; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_allusergroups_admins_allusergroups_id_ebbbb356 ON public.vkin_allusergroups_admins USING btree (allusergroups_id);


--
-- Name: vkin_allusergroups_admins_user_id_26e1c24c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_allusergroups_admins_user_id_26e1c24c ON public.vkin_allusergroups_admins USING btree (user_id);


--
-- Name: vkin_group_admins_group_id_f14c3419; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_group_admins_group_id_f14c3419 ON public.vkin_group_admins USING btree (group_id);


--
-- Name: vkin_group_admins_user_id_b5737c16; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_group_admins_user_id_b5737c16 ON public.vkin_group_admins USING btree (user_id);


--
-- Name: vkin_group_moders_group_id_24af9628; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_group_moders_group_id_24af9628 ON public.vkin_group_moders USING btree (group_id);


--
-- Name: vkin_group_moders_user_id_1acd97be; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_group_moders_user_id_1acd97be ON public.vkin_group_moders USING btree (user_id);


--
-- Name: vkin_group_tenant_id_cbbb196e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_group_tenant_id_cbbb196e ON public.vkin_group USING btree (tenant_id);


--
-- Name: vkin_group_txt_id_b2479981; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_group_txt_id_b2479981 ON public.vkin_group USING btree (txt_id);


--
-- Name: vkin_group_usertokens_group_id_66f58702; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_group_usertokens_group_id_66f58702 ON public.vkin_group_usertokens USING btree (group_id);


--
-- Name: vkin_group_usertokens_su_user_tokens_id_8191e7fb; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_group_usertokens_su_user_tokens_id_8191e7fb ON public.vkin_group_usertokens USING btree (su_user_tokens_id);


--
-- Name: vkin_groupstatistic_group_id_a4252a48; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_groupstatistic_group_id_a4252a48 ON public.vkin_groupstatistic USING btree (group_id);


--
-- Name: vkin_groupstatistic_tenant_id_8eaa63b2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_groupstatistic_tenant_id_8eaa63b2 ON public.vkin_groupstatistic USING btree (tenant_id);


--
-- Name: vkin_historicalgroup_history_date_6fc1a75e; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalgroup_history_date_6fc1a75e ON public.vkin_historicalgroup USING btree (history_date);


--
-- Name: vkin_historicalgroup_history_user_id_7b1fe547; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalgroup_history_user_id_7b1fe547 ON public.vkin_historicalgroup USING btree (history_user_id);


--
-- Name: vkin_historicalgroup_id_85d7f575; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalgroup_id_85d7f575 ON public.vkin_historicalgroup USING btree (id);


--
-- Name: vkin_historicalgroup_tenant_id_6eb919b9; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalgroup_tenant_id_6eb919b9 ON public.vkin_historicalgroup USING btree (tenant_id);


--
-- Name: vkin_historicalgroup_txt_id_938d1fed; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalgroup_txt_id_938d1fed ON public.vkin_historicalgroup USING btree (txt_id);


--
-- Name: vkin_historicaltextmessages_history_date_b9410905; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicaltextmessages_history_date_b9410905 ON public.vkin_historicaltextmessages USING btree (history_date);


--
-- Name: vkin_historicaltextmessages_history_user_id_11b48922; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicaltextmessages_history_user_id_11b48922 ON public.vkin_historicaltextmessages USING btree (history_user_id);


--
-- Name: vkin_historicaltextmessages_id_c529ddd5; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicaltextmessages_id_c529ddd5 ON public.vkin_historicaltextmessages USING btree (id);


--
-- Name: vkin_historicaltextmessages_tenant_id_95be30f3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicaltextmessages_tenant_id_95be30f3 ON public.vkin_historicaltextmessages USING btree (tenant_id);


--
-- Name: vkin_historicalvars_group_id_4d02629c; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalvars_group_id_4d02629c ON public.vkin_historicalvars USING btree (group_id);


--
-- Name: vkin_historicalvars_history_date_8b95df8f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalvars_history_date_8b95df8f ON public.vkin_historicalvars USING btree (history_date);


--
-- Name: vkin_historicalvars_history_user_id_8a89c8d7; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalvars_history_user_id_8a89c8d7 ON public.vkin_historicalvars USING btree (history_user_id);


--
-- Name: vkin_historicalvars_id_38e22775; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalvars_id_38e22775 ON public.vkin_historicalvars USING btree (id);


--
-- Name: vkin_historicalvars_property_id_6d1d9172; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalvars_property_id_6d1d9172 ON public.vkin_historicalvars USING btree (property_id);


--
-- Name: vkin_historicalvars_tenant_id_a8a7ba78; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_historicalvars_tenant_id_a8a7ba78 ON public.vkin_historicalvars USING btree (tenant_id);


--
-- Name: vkin_imagecache_group_id_8c0ced86; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_imagecache_group_id_8c0ced86 ON public.vkin_imagecache USING btree (group_id);


--
-- Name: vkin_imagecache_tenant_id_920dcf68; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_imagecache_tenant_id_920dcf68 ON public.vkin_imagecache USING btree (tenant_id);


--
-- Name: vkin_posttemplates_tenant_id_44df2dc2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_posttemplates_tenant_id_44df2dc2 ON public.vkin_posttemplates USING btree (tenant_id);


--
-- Name: vkin_setofgroups_forGroups_group_id_a8100cfc; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "vkin_setofgroups_forGroups_group_id_a8100cfc" ON public."vkin_setofgroups_forGroups" USING btree (group_id);


--
-- Name: vkin_setofgroups_forGroups_setofgroups_id_42ea66a3; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX "vkin_setofgroups_forGroups_setofgroups_id_42ea66a3" ON public."vkin_setofgroups_forGroups" USING btree (setofgroups_id);


--
-- Name: vkin_setofgroups_tenant_id_df60da37; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_setofgroups_tenant_id_df60da37 ON public.vkin_setofgroups USING btree (tenant_id);


--
-- Name: vkin_setofvars_tenant_id_d32a8f16; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_setofvars_tenant_id_d32a8f16 ON public.vkin_setofvars USING btree (tenant_id);


--
-- Name: vkin_su_user_tokens_tenant_id_1c16671f; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_su_user_tokens_tenant_id_1c16671f ON public.vkin_su_user_tokens USING btree (tenant_id);


--
-- Name: vkin_su_user_tokens_user_id_fe794557; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_su_user_tokens_user_id_fe794557 ON public.vkin_su_user_tokens USING btree (user_id);


--
-- Name: vkin_textmessages_tenant_id_1289d73a; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_textmessages_tenant_id_1289d73a ON public.vkin_textmessages USING btree (tenant_id);


--
-- Name: vkin_userphone_group_id_dcd9fd5b; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_userphone_group_id_dcd9fd5b ON public.vkin_userphone USING btree (group_id);


--
-- Name: vkin_userphone_tenant_id_85d735bc; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_userphone_tenant_id_85d735bc ON public.vkin_userphone USING btree (tenant_id);


--
-- Name: vkin_vars_group_id_60b1eade; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_vars_group_id_60b1eade ON public.vkin_vars USING btree (group_id);


--
-- Name: vkin_vars_property_id_911500a2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_vars_property_id_911500a2 ON public.vkin_vars USING btree (property_id);


--
-- Name: vkin_vars_tenant_id_c08bd2c2; Type: INDEX; Schema: public; Owner: vktenantuser
--

CREATE INDEX vkin_vars_tenant_id_c08bd2c2 ON public.vkin_vars USING btree (tenant_id);


--
-- Name: account_emailaddress account_emailaddress_user_id_2c513194_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailconfirmation account_emailconfirm_email_address_id_5b7f8c58_fk_account_e; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirm_email_address_id_5b7f8c58_fk_account_e FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_auction auctions_auction_config_id_00750962_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auction
    ADD CONSTRAINT auctions_auction_config_id_00750962_fk_auctions_ FOREIGN KEY (config_id) REFERENCES public.auctions_scheduledauctionforgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_auction auctions_auction_group_id_86265d1b_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auction
    ADD CONSTRAINT auctions_auction_group_id_86265d1b_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_auction auctions_auction_lot_id_88819f0b_fk_auctions_auctlot_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auction
    ADD CONSTRAINT auctions_auction_lot_id_88819f0b_fk_auctions_auctlot_id FOREIGN KEY (lot_id) REFERENCES public.auctions_auctlot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_auction auctions_auction_tenant_id_ba2a4ebb_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auction
    ADD CONSTRAINT auctions_auction_tenant_id_ba2a4ebb_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_auctioncost auctions_auctioncost_auct_id_1d889001_fk_auctions_auction_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auctioncost
    ADD CONSTRAINT auctions_auctioncost_auct_id_1d889001_fk_auctions_auction_id FOREIGN KEY (auct_id) REFERENCES public.auctions_auction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_auctioncost auctions_auctioncost_tenant_id_014bb2c8_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auctioncost
    ADD CONSTRAINT auctions_auctioncost_tenant_id_014bb2c8_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_auctlot auctions_auctlot_property_id_d09a251e_fk_auctions_setauctlot_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auctlot
    ADD CONSTRAINT auctions_auctlot_property_id_d09a251e_fk_auctions_setauctlot_id FOREIGN KEY (property_id) REFERENCES public.auctions_setauctlot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_auctlot auctions_auctlot_tenant_id_d5f2541a_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_auctlot
    ADD CONSTRAINT auctions_auctlot_tenant_id_d5f2541a_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_historicalauctlot auctions_historicala_history_user_id_090fe50e_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_historicalauctlot
    ADD CONSTRAINT auctions_historicala_history_user_id_090fe50e_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_historicalscheduledauctionforgroup auctions_historicals_history_user_id_406afe29_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_historicalscheduledauctionforgroup
    ADD CONSTRAINT auctions_historicals_history_user_id_406afe29_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionforgroup auctions_scheduledau_group_id_43a8e5b9_fk_vkin_grou; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionforgroup
    ADD CONSTRAINT auctions_scheduledau_group_id_43a8e5b9_fk_vkin_grou FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauction auctions_scheduledau_lot_id_efadcbf5_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauction
    ADD CONSTRAINT auctions_scheduledau_lot_id_efadcbf5_fk_auctions_ FOREIGN KEY (lot_id) REFERENCES public.auctions_auctlot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauction auctions_scheduledau_property_id_599f0503_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauction
    ADD CONSTRAINT auctions_scheduledau_property_id_599f0503_fk_auctions_ FOREIGN KEY (property_id) REFERENCES public.auctions_scheduledauctionforgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionsb auctions_scheduledau_scheduledauction_ptr_14163b29_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionsb
    ADD CONSTRAINT auctions_scheduledau_scheduledauction_ptr_14163b29_fk_auctions_ FOREIGN KEY (scheduledauction_ptr_id) REFERENCES public.auctions_scheduledauction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionpn auctions_scheduledau_scheduledauction_ptr_3231a75b_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionpn
    ADD CONSTRAINT auctions_scheduledau_scheduledauction_ptr_3231a75b_fk_auctions_ FOREIGN KEY (scheduledauction_ptr_id) REFERENCES public.auctions_scheduledauction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionvs auctions_scheduledau_scheduledauction_ptr_366fafcf_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionvs
    ADD CONSTRAINT auctions_scheduledau_scheduledauction_ptr_366fafcf_fk_auctions_ FOREIGN KEY (scheduledauction_ptr_id) REFERENCES public.auctions_scheduledauction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionpt auctions_scheduledau_scheduledauction_ptr_71fcd66c_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionpt
    ADD CONSTRAINT auctions_scheduledau_scheduledauction_ptr_71fcd66c_fk_auctions_ FOREIGN KEY (scheduledauction_ptr_id) REFERENCES public.auctions_scheduledauction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionvt auctions_scheduledau_scheduledauction_ptr_744c5e9c_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionvt
    ADD CONSTRAINT auctions_scheduledau_scheduledauction_ptr_744c5e9c_fk_auctions_ FOREIGN KEY (scheduledauction_ptr_id) REFERENCES public.auctions_scheduledauction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionsr auctions_scheduledau_scheduledauction_ptr_dddf8326_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionsr
    ADD CONSTRAINT auctions_scheduledau_scheduledauction_ptr_dddf8326_fk_auctions_ FOREIGN KEY (scheduledauction_ptr_id) REFERENCES public.auctions_scheduledauction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionch auctions_scheduledau_scheduledauction_ptr_fe211270_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionch
    ADD CONSTRAINT auctions_scheduledau_scheduledauction_ptr_fe211270_fk_auctions_ FOREIGN KEY (scheduledauction_ptr_id) REFERENCES public.auctions_scheduledauction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauction auctions_scheduledau_tenant_id_7cc5630d_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauction
    ADD CONSTRAINT auctions_scheduledau_tenant_id_7cc5630d_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_scheduledauctionforgroup auctions_scheduledau_tenant_id_e352382a_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_scheduledauctionforgroup
    ADD CONSTRAINT auctions_scheduledau_tenant_id_e352382a_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_setauctlot_forGroups auctions_setauctlot__group_id_84e48c0c_fk_vkin_grou; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."auctions_setauctlot_forGroups"
    ADD CONSTRAINT auctions_setauctlot__group_id_84e48c0c_fk_vkin_grou FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_setauctlot_forGroups auctions_setauctlot__setauctlot_id_8db14d96_fk_auctions_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."auctions_setauctlot_forGroups"
    ADD CONSTRAINT auctions_setauctlot__setauctlot_id_8db14d96_fk_auctions_ FOREIGN KEY (setauctlot_id) REFERENCES public.auctions_setauctlot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auctions_setauctlot auctions_setauctlot_tenant_id_e0ddc07b_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auctions_setauctlot
    ADD CONSTRAINT auctions_setauctlot_tenant_id_e0ddc07b_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: background_task_completedtask background_task_comp_creator_content_type_21d6a741_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.background_task_completedtask
    ADD CONSTRAINT background_task_comp_creator_content_type_21d6a741_fk_django_co FOREIGN KEY (creator_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: background_task background_task_creator_content_type_61cc9af3_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.background_task
    ADD CONSTRAINT background_task_creator_content_type_61cc9af3_fk_django_co FOREIGN KEY (creator_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_bdayposttemplate bday_bdayposttemplate_group_id_f0250efc_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_bdayposttemplate
    ADD CONSTRAINT bday_bdayposttemplate_group_id_f0250efc_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_bdayposttemplate bday_bdayposttemplate_tenant_id_97e5e424_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_bdayposttemplate
    ADD CONSTRAINT bday_bdayposttemplate_tenant_id_97e5e424_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_historicalbdayposttemplate bday_historicalbdayp_history_user_id_35ef46c1_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalbdayposttemplate
    ADD CONSTRAINT bday_historicalbdayp_history_user_id_35ef46c1_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_historicalmsgtemplate bday_historicalmsgte_history_user_id_da87fd1f_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalmsgtemplate
    ADD CONSTRAINT bday_historicalmsgte_history_user_id_da87fd1f_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_historicalsetmsgtemplate bday_historicalsetms_history_user_id_0c970302_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_historicalsetmsgtemplate
    ADD CONSTRAINT bday_historicalsetms_history_user_id_0c970302_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_msgtemplate bday_msgtemplate_property_id_19fd6374_fk_bday_setmsgtemplate_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_msgtemplate
    ADD CONSTRAINT bday_msgtemplate_property_id_19fd6374_fk_bday_setmsgtemplate_id FOREIGN KEY (property_id) REFERENCES public.bday_setmsgtemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_msgtemplate bday_msgtemplate_tenant_id_e8c99301_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_msgtemplate
    ADD CONSTRAINT bday_msgtemplate_tenant_id_e8c99301_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_setmsgtemplate bday_setmsgtemplate_group_id_0e24f98b_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_setmsgtemplate
    ADD CONSTRAINT bday_setmsgtemplate_group_id_0e24f98b_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bday_setmsgtemplate bday_setmsgtemplate_tenant_id_8f92d25c_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.bday_setmsgtemplate
    ADD CONSTRAINT bday_setmsgtemplate_tenant_id_8f92d25c_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datacollect_phonetosheet datacollect_phonetos_tenant_id_79a5fbd8_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.datacollect_phonetosheet
    ADD CONSTRAINT datacollect_phonetos_tenant_id_79a5fbd8_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datacollect_phonetosheet datacollect_phonetosheet_group_id_bb6ea286_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.datacollect_phonetosheet
    ADD CONSTRAINT datacollect_phonetosheet_group_id_bb6ea286_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_daywinnersprize2 daywinners_daywinner_contest_id_49158562_fk_daywinner; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize2
    ADD CONSTRAINT daywinners_daywinner_contest_id_49158562_fk_daywinner FOREIGN KEY (contest_id) REFERENCES public.daywinners_makewinnerstime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_daywinnersprize3 daywinners_daywinner_contest_id_93fcf335_fk_daywinner; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize3
    ADD CONSTRAINT daywinners_daywinner_contest_id_93fcf335_fk_daywinner FOREIGN KEY (contest_id) REFERENCES public.daywinners_makewinnerstime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_daywinnersprize daywinners_daywinner_contest_id_def476c1_fk_daywinner; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize
    ADD CONSTRAINT daywinners_daywinner_contest_id_def476c1_fk_daywinner FOREIGN KEY (contest_id) REFERENCES public.daywinners_makewinnerstime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_daywinnersprize3 daywinners_daywinner_prize_ptr_id_0d18a8f4_fk_prizes_pr; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize3
    ADD CONSTRAINT daywinners_daywinner_prize_ptr_id_0d18a8f4_fk_prizes_pr FOREIGN KEY (prize_ptr_id) REFERENCES public.prizes_prize(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_daywinnersprize2 daywinners_daywinner_prize_ptr_id_2eaa4f0c_fk_prizes_pr; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize2
    ADD CONSTRAINT daywinners_daywinner_prize_ptr_id_2eaa4f0c_fk_prizes_pr FOREIGN KEY (prize_ptr_id) REFERENCES public.prizes_prize(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_daywinnersprize daywinners_daywinner_prize_ptr_id_40d7c3fa_fk_prizes_pr; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_daywinnersprize
    ADD CONSTRAINT daywinners_daywinner_prize_ptr_id_40d7c3fa_fk_prizes_pr FOREIGN KEY (prize_ptr_id) REFERENCES public.prizes_prize(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_doppost daywinners_doppost_contest_id_06de23f0_fk_daywinner; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_doppost
    ADD CONSTRAINT daywinners_doppost_contest_id_06de23f0_fk_daywinner FOREIGN KEY (contest_id) REFERENCES public.daywinners_makewinnerstime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_doppost daywinners_doppost_tenant_id_e072c75e_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_doppost
    ADD CONSTRAINT daywinners_doppost_tenant_id_e072c75e_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_hashsearch daywinners_hashsearc_makewinnerstime_ptr__181c971f_fk_daywinner; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_hashsearch
    ADD CONSTRAINT daywinners_hashsearc_makewinnerstime_ptr__181c971f_fk_daywinner FOREIGN KEY (makewinnerstime_ptr_id) REFERENCES public.daywinners_makewinnerstime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_historicalweeklywinners daywinners_historica_history_user_id_2806a003_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalweeklywinners
    ADD CONSTRAINT daywinners_historica_history_user_id_2806a003_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_historicalrandomactivity daywinners_historica_history_user_id_2e48e46e_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalrandomactivity
    ADD CONSTRAINT daywinners_historica_history_user_id_2e48e46e_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_historicalrandomphotoreviews daywinners_historica_history_user_id_a300fee7_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalrandomphotoreviews
    ADD CONSTRAINT daywinners_historica_history_user_id_a300fee7_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_historicalhashsearch daywinners_historica_history_user_id_bf506f75_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_historicalhashsearch
    ADD CONSTRAINT daywinners_historica_history_user_id_bf506f75_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_makewinnerstime daywinners_makewinne_tenant_id_18d56487_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_makewinnerstime
    ADD CONSTRAINT daywinners_makewinne_tenant_id_18d56487_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_makewinnerstime daywinners_makewinne_vid_id_60481485_fk_videoresu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_makewinnerstime
    ADD CONSTRAINT daywinners_makewinne_vid_id_60481485_fk_videoresu FOREIGN KEY (vid_id) REFERENCES public.videoresults_videoresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_makewinnerstime daywinners_makewinnerstime_group_id_78d318ec_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_makewinnerstime
    ADD CONSTRAINT daywinners_makewinnerstime_group_id_78d318ec_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_randomactivity daywinners_randomact_makewinnerstime_ptr__9e7471c6_fk_daywinner; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_randomactivity
    ADD CONSTRAINT daywinners_randomact_makewinnerstime_ptr__9e7471c6_fk_daywinner FOREIGN KEY (makewinnerstime_ptr_id) REFERENCES public.daywinners_makewinnerstime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_randomphotoreviews daywinners_randompho_makewinnerstime_ptr__3cfcfb40_fk_daywinner; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_randomphotoreviews
    ADD CONSTRAINT daywinners_randompho_makewinnerstime_ptr__3cfcfb40_fk_daywinner FOREIGN KEY (makewinnerstime_ptr_id) REFERENCES public.daywinners_makewinnerstime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: daywinners_weeklywinners daywinners_weeklywin_makewinnerstime_ptr__1942a0a5_fk_daywinner; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.daywinners_weeklywinners
    ADD CONSTRAINT daywinners_weeklywin_makewinnerstime_ptr__1942a0a5_fk_daywinner FOREIGN KEY (makewinnerstime_ptr_id) REFERENCES public.daywinners_makewinnerstime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thum_source_id_5b57bc77_fk_easy_thum; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thum_source_id_5b57bc77_fk_easy_thum FOREIGN KEY (source_id) REFERENCES public.easy_thumbnails_source(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thum_thumbnail_id_c3a0c549_fk_easy_thum; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thum_thumbnail_id_c3a0c549_fk_easy_thum FOREIGN KEY (thumbnail_id) REFERENCES public.easy_thumbnails_thumbnail(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_banditimageswin gameroulet_banditima_property_id_55fb2798_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditimageswin
    ADD CONSTRAINT gameroulet_banditima_property_id_55fb2798_fk_gameroule FOREIGN KEY (property_id) REFERENCES public.gameroulet_banditsetimages(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_banditimageslosing gameroulet_banditima_property_id_837c35db_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditimageslosing
    ADD CONSTRAINT gameroulet_banditima_property_id_837c35db_fk_gameroule FOREIGN KEY (property_id) REFERENCES public.gameroulet_banditsetimages(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_banditimageswin gameroulet_banditima_tenant_id_f95b43ae_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditimageswin
    ADD CONSTRAINT gameroulet_banditima_tenant_id_f95b43ae_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_banditimageslosing gameroulet_banditima_tenant_id_f966eec1_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditimageslosing
    ADD CONSTRAINT gameroulet_banditima_tenant_id_f966eec1_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_banditsetimages gameroulet_banditset_tenant_id_539245f3_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_banditsetimages
    ADD CONSTRAINT gameroulet_banditset_tenant_id_539245f3_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_doprouletpost gameroulet_doproulet_content_type_id_19af7ef3_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_doprouletpost
    ADD CONSTRAINT gameroulet_doproulet_content_type_id_19af7ef3_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_doprouletpost gameroulet_doproulet_tenant_id_de6829ca_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_doprouletpost
    ADD CONSTRAINT gameroulet_doproulet_tenant_id_de6829ca_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_historicalrouletbombergame gameroulet_historica_history_user_id_31d921c9_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrouletbombergame
    ADD CONSTRAINT gameroulet_historica_history_user_id_31d921c9_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_historicalroulethide gameroulet_historica_history_user_id_6356d59a_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalroulethide
    ADD CONSTRAINT gameroulet_historica_history_user_id_6356d59a_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_historicalrouletbanditgame gameroulet_historica_history_user_id_8b4a5e4a_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrouletbanditgame
    ADD CONSTRAINT gameroulet_historica_history_user_id_8b4a5e4a_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_historicalkostigame gameroulet_historica_history_user_id_8cc2f812_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalkostigame
    ADD CONSTRAINT gameroulet_historica_history_user_id_8cc2f812_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_historicalrandstop gameroulet_historica_history_user_id_8d4ec56c_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalrandstop
    ADD CONSTRAINT gameroulet_historica_history_user_id_8d4ec56c_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_historicalseabattlegame gameroulet_historica_history_user_id_a80d09bd_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_historicalseabattlegame
    ADD CONSTRAINT gameroulet_historica_history_user_id_a80d09bd_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_kostigameprize gameroulet_kostigame_contest_id_95013f61_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostigameprize
    ADD CONSTRAINT gameroulet_kostigame_contest_id_95013f61_fk_gameroule FOREIGN KEY (contest_id) REFERENCES public.gameroulet_kostigame(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_kostigame gameroulet_kostigame_group_id_bfaa42b9_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostigame
    ADD CONSTRAINT gameroulet_kostigame_group_id_bfaa42b9_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_kostigame gameroulet_kostigame_kostiimages_id_42fa59fe_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostigame
    ADD CONSTRAINT gameroulet_kostigame_kostiimages_id_42fa59fe_fk_gameroule FOREIGN KEY (kostiimages_id) REFERENCES public.gameroulet_kostisetimages(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_kostigameprize gameroulet_kostigame_rouletprizebase_ptr__1919dc32_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostigameprize
    ADD CONSTRAINT gameroulet_kostigame_rouletprizebase_ptr__1919dc32_fk_gameroule FOREIGN KEY (rouletprizebase_ptr_id) REFERENCES public.gameroulet_rouletprizebase(prize_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_kostigame gameroulet_kostigame_tenant_id_02bf171b_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostigame
    ADD CONSTRAINT gameroulet_kostigame_tenant_id_02bf171b_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_kostisetimages gameroulet_kostiseti_tenant_id_9ee1b4d4_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_kostisetimages
    ADD CONSTRAINT gameroulet_kostiseti_tenant_id_9ee1b4d4_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_randstop gameroulet_randstop_group_id_db29490f_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_randstop
    ADD CONSTRAINT gameroulet_randstop_group_id_db29490f_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_randstop gameroulet_randstop_tenant_id_6e12e05b_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_randstop
    ADD CONSTRAINT gameroulet_randstop_tenant_id_6e12e05b_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletbanditgame gameroulet_rouletban_rouletimages_id_eb421e5b_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbanditgame
    ADD CONSTRAINT gameroulet_rouletban_rouletimages_id_eb421e5b_fk_gameroule FOREIGN KEY (rouletimages_id) REFERENCES public.gameroulet_banditsetimages(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletbanditgame gameroulet_rouletban_tenant_id_008442cf_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbanditgame
    ADD CONSTRAINT gameroulet_rouletban_tenant_id_008442cf_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletbanditgame gameroulet_rouletbanditgame_group_id_bd3403b4_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbanditgame
    ADD CONSTRAINT gameroulet_rouletbanditgame_group_id_bd3403b4_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletbomberprize gameroulet_rouletbom_contest_id_11d534d4_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbomberprize
    ADD CONSTRAINT gameroulet_rouletbom_contest_id_11d534d4_fk_gameroule FOREIGN KEY (contest_id) REFERENCES public.gameroulet_rouletbombergame(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletbomberprize gameroulet_rouletbom_rouletprizebase_ptr__4e1552db_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbomberprize
    ADD CONSTRAINT gameroulet_rouletbom_rouletprizebase_ptr__4e1552db_fk_gameroule FOREIGN KEY (rouletprizebase_ptr_id) REFERENCES public.gameroulet_rouletprizebase(prize_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletbombergame gameroulet_rouletbom_tenant_id_e32383e7_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbombergame
    ADD CONSTRAINT gameroulet_rouletbom_tenant_id_e32383e7_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletbombergame gameroulet_rouletbombergame_group_id_4870a66e_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletbombergame
    ADD CONSTRAINT gameroulet_rouletbombergame_group_id_4870a66e_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_roulethide gameroulet_roulethide_group_id_70790b9f_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_roulethide
    ADD CONSTRAINT gameroulet_roulethide_group_id_70790b9f_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_roulethide gameroulet_roulethide_tenant_id_1c494416_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_roulethide
    ADD CONSTRAINT gameroulet_roulethide_tenant_id_1c494416_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprizehide gameroulet_rouletpri_contest_id_1c562109_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizehide
    ADD CONSTRAINT gameroulet_rouletpri_contest_id_1c562109_fk_gameroule FOREIGN KEY (contest_id) REFERENCES public.gameroulet_roulethide(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprizesafe gameroulet_rouletpri_contest_id_35cc9fa0_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizesafe
    ADD CONSTRAINT gameroulet_rouletpri_contest_id_35cc9fa0_fk_gameroule FOREIGN KEY (contest_id) REFERENCES public.gameroulet_rouletsafe(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprizestop gameroulet_rouletpri_contest_id_4f484e58_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizestop
    ADD CONSTRAINT gameroulet_rouletpri_contest_id_4f484e58_fk_gameroule FOREIGN KEY (contest_id) REFERENCES public.gameroulet_randstop(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprize gameroulet_rouletpri_contest_id_747df45a_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprize
    ADD CONSTRAINT gameroulet_rouletpri_contest_id_747df45a_fk_gameroule FOREIGN KEY (contest_id) REFERENCES public.gameroulet_rouletbanditgame(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprizebase gameroulet_rouletpri_prize_ptr_id_293d3969_fk_prizes_pr; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizebase
    ADD CONSTRAINT gameroulet_rouletpri_prize_ptr_id_293d3969_fk_prizes_pr FOREIGN KEY (prize_ptr_id) REFERENCES public.prizes_prize(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprizehide gameroulet_rouletpri_rouletprizebase_ptr__19b8a36d_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizehide
    ADD CONSTRAINT gameroulet_rouletpri_rouletprizebase_ptr__19b8a36d_fk_gameroule FOREIGN KEY (rouletprizebase_ptr_id) REFERENCES public.gameroulet_rouletprizebase(prize_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprizestop gameroulet_rouletpri_rouletprizebase_ptr__3be3eb1f_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizestop
    ADD CONSTRAINT gameroulet_rouletpri_rouletprizebase_ptr__3be3eb1f_fk_gameroule FOREIGN KEY (rouletprizebase_ptr_id) REFERENCES public.gameroulet_rouletprizebase(prize_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprize gameroulet_rouletpri_rouletprizebase_ptr__b885748a_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprize
    ADD CONSTRAINT gameroulet_rouletpri_rouletprizebase_ptr__b885748a_fk_gameroule FOREIGN KEY (rouletprizebase_ptr_id) REFERENCES public.gameroulet_rouletprizebase(prize_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletprizesafe gameroulet_rouletpri_rouletprizebase_ptr__deb3ab95_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletprizesafe
    ADD CONSTRAINT gameroulet_rouletpri_rouletprizebase_ptr__deb3ab95_fk_gameroule FOREIGN KEY (rouletprizebase_ptr_id) REFERENCES public.gameroulet_rouletprizebase(prize_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletsafe gameroulet_rouletsaf_safeimages_id_1770f697_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletsafe
    ADD CONSTRAINT gameroulet_rouletsaf_safeimages_id_1770f697_fk_gameroule FOREIGN KEY (safeimages_id) REFERENCES public.gameroulet_banditsetimages(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletsafe gameroulet_rouletsafe_group_id_56f31016_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletsafe
    ADD CONSTRAINT gameroulet_rouletsafe_group_id_56f31016_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletsafe gameroulet_rouletsafe_tenant_id_2ad1b74b_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletsafe
    ADD CONSTRAINT gameroulet_rouletsafe_tenant_id_2ad1b74b_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletuserlives gameroulet_rouletuse_contest_id_33e1aef6_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletuserlives
    ADD CONSTRAINT gameroulet_rouletuse_contest_id_33e1aef6_fk_gameroule FOREIGN KEY (contest_id) REFERENCES public.gameroulet_rouletbanditgame(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_rouletuserlives gameroulet_rouletuse_tenant_id_6e3d80b4_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_rouletuserlives
    ADD CONSTRAINT gameroulet_rouletuse_tenant_id_6e3d80b4_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_seabattlegameprize gameroulet_seabattle_contest_id_3b9dec97_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_seabattlegameprize
    ADD CONSTRAINT gameroulet_seabattle_contest_id_3b9dec97_fk_gameroule FOREIGN KEY (contest_id) REFERENCES public.gameroulet_seabattlegame(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_seabattlegameprize gameroulet_seabattle_rouletprizebase_ptr__7b0e5d6b_fk_gameroule; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_seabattlegameprize
    ADD CONSTRAINT gameroulet_seabattle_rouletprizebase_ptr__7b0e5d6b_fk_gameroule FOREIGN KEY (rouletprizebase_ptr_id) REFERENCES public.gameroulet_rouletprizebase(prize_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_seabattlegame gameroulet_seabattle_tenant_id_e0acefe3_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_seabattlegame
    ADD CONSTRAINT gameroulet_seabattle_tenant_id_e0acefe3_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gameroulet_seabattlegame gameroulet_seabattlegame_group_id_b99e70b0_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gameroulet_seabattlegame
    ADD CONSTRAINT gameroulet_seabattlegame_group_id_b99e70b0_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gpt_gptdialog gpt_gptdialog_key_id_a6ef0c21_fk_gpt_gptkey_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpt_gptdialog
    ADD CONSTRAINT gpt_gptdialog_key_id_a6ef0c21_fk_gpt_gptkey_id FOREIGN KEY (key_id) REFERENCES public.gpt_gptkey(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gpthelper_commentanswer gpthelper_commentans_tenant_id_8e268ad0_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_commentanswer
    ADD CONSTRAINT gpthelper_commentans_tenant_id_8e268ad0_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gpthelper_commentanswer gpthelper_commentanswer_group_id_250b6e49_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_commentanswer
    ADD CONSTRAINT gpthelper_commentanswer_group_id_250b6e49_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gpthelper_gptdialog gpthelper_gptdialog_key_id_82a371af_fk_gpthelper; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_gptdialog
    ADD CONSTRAINT gpthelper_gptdialog_key_id_82a371af_fk_gpthelper FOREIGN KEY (key_id) REFERENCES public.gpthelper_gptanswerkey(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gpthelper_postsettings gpthelper_postsettings_group_id_e211af29_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_postsettings
    ADD CONSTRAINT gpthelper_postsettings_group_id_e211af29_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: gpthelper_postsettings gpthelper_postsettings_tenant_id_4cf058cc_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.gpthelper_postsettings
    ADD CONSTRAINT gpthelper_postsettings_tenant_id_4cf058cc_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_commentpromo greeting_commentpromo_group_id_016bb0a0_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_commentpromo
    ADD CONSTRAINT greeting_commentpromo_group_id_016bb0a0_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_commentpromo greeting_commentpromo_tenant_id_0fe68167_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_commentpromo
    ADD CONSTRAINT greeting_commentpromo_tenant_id_0fe68167_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_communityreviewspromo greeting_communityre_group_id_0f924f86_fk_vkin_grou; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_communityreviewspromo
    ADD CONSTRAINT greeting_communityre_group_id_0f924f86_fk_vkin_grou FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_communityreviewspromo greeting_communityre_tenant_id_0c8c1f9d_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_communityreviewspromo
    ADD CONSTRAINT greeting_communityre_tenant_id_0c8c1f9d_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_greeting greeting_greeting_group_id_892beb93_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_greeting
    ADD CONSTRAINT greeting_greeting_group_id_892beb93_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_greeting greeting_greeting_tenant_id_dfe525cc_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_greeting
    ADD CONSTRAINT greeting_greeting_tenant_id_dfe525cc_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_historicalgreeting greeting_historicalg_history_user_id_6c3c3843_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_historicalgreeting
    ADD CONSTRAINT greeting_historicalg_history_user_id_6c3c3843_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_historicalrepostpromo greeting_historicalr_history_user_id_9388eacf_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_historicalrepostpromo
    ADD CONSTRAINT greeting_historicalr_history_user_id_9388eacf_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_jointemplate greeting_jointemplat_parent_id_a4f4708e_fk_greeting_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_jointemplate
    ADD CONSTRAINT greeting_jointemplat_parent_id_a4f4708e_fk_greeting_ FOREIGN KEY (parent_id) REFERENCES public.greeting_greeting(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_jointemplate greeting_jointemplate_tenant_id_94def8e9_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_jointemplate
    ADD CONSTRAINT greeting_jointemplate_tenant_id_94def8e9_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_repostpromo greeting_repostpromo_group_id_1fc2ada4_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_repostpromo
    ADD CONSTRAINT greeting_repostpromo_group_id_1fc2ada4_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: greeting_repostpromo greeting_repostpromo_tenant_id_04ce0de1_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.greeting_repostpromo
    ADD CONSTRAINT greeting_repostpromo_tenant_id_04ce0de1_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_historicalrepostcontest newcontest_historica_history_user_id_3492cab8_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_historicalrepostcontest
    ADD CONSTRAINT newcontest_historica_history_user_id_3492cab8_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_historicalnewcontestprize newcontest_historica_history_user_id_e7c115d7_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_historicalnewcontestprize
    ADD CONSTRAINT newcontest_historica_history_user_id_e7c115d7_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_newcontestprize newcontest_newcontes_contest_id_7ee8137f_fk_newcontes; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_newcontestprize
    ADD CONSTRAINT newcontest_newcontes_contest_id_7ee8137f_fk_newcontes FOREIGN KEY (contest_id) REFERENCES public.newcontest_repostcontest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_newcontestprize newcontest_newcontes_prize_ptr_id_4fba53f7_fk_prizes_pr; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_newcontestprize
    ADD CONSTRAINT newcontest_newcontes_prize_ptr_id_4fba53f7_fk_prizes_pr FOREIGN KEY (prize_ptr_id) REFERENCES public.prizes_prize(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_participantcontest newcontest_participa_contest_id_af38b97b_fk_newcontes; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_participantcontest
    ADD CONSTRAINT newcontest_participa_contest_id_af38b97b_fk_newcontes FOREIGN KEY (contest_id) REFERENCES public.newcontest_repostcontest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_participantcontest newcontest_participa_group_id_fbbb7b52_fk_vkin_grou; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_participantcontest
    ADD CONSTRAINT newcontest_participa_group_id_fbbb7b52_fk_vkin_grou FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_participantcontest newcontest_participa_tenant_id_f9c92e81_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_participantcontest
    ADD CONSTRAINT newcontest_participa_tenant_id_f9c92e81_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_repostcontest_forGroups newcontest_repostcon_group_id_7a841a9a_fk_vkin_grou; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."newcontest_repostcontest_forGroups"
    ADD CONSTRAINT newcontest_repostcon_group_id_7a841a9a_fk_vkin_grou FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_repostcontest_forGroups newcontest_repostcon_repostcontest_id_dbd81430_fk_newcontes; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."newcontest_repostcontest_forGroups"
    ADD CONSTRAINT newcontest_repostcon_repostcontest_id_dbd81430_fk_newcontes FOREIGN KEY (repostcontest_id) REFERENCES public.newcontest_repostcontest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: newcontest_repostcontest newcontest_repostcon_tenant_id_5800bc24_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.newcontest_repostcontest
    ADD CONSTRAINT newcontest_repostcon_tenant_id_5800bc24_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ownerCoverPhoto_ownercoverphotobg ownerCoverPhoto_owne_group_id_a62d7f0a_fk_vkin_grou; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."ownerCoverPhoto_ownercoverphotobg"
    ADD CONSTRAINT "ownerCoverPhoto_owne_group_id_a62d7f0a_fk_vkin_grou" FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ownerCoverPhoto_ownercoverphotobg ownerCoverPhoto_owne_tenant_id_8df35a14_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."ownerCoverPhoto_ownercoverphotobg"
    ADD CONSTRAINT "ownerCoverPhoto_owne_tenant_id_8df35a14_fk_tenant_cu" FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: photoTickets_historicalticket photoTickets_histori_history_user_id_c6f3e68d_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_historicalticket"
    ADD CONSTRAINT "photoTickets_histori_history_user_id_c6f3e68d_fk_auth_user" FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: photoTickets_historicalticketsettings photoTickets_histori_history_user_id_e903aa1c_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_historicalticketsettings"
    ADD CONSTRAINT "photoTickets_histori_history_user_id_e903aa1c_fk_auth_user" FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: photoTickets_ticket photoTickets_ticket_group_id_619be4c5_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticket"
    ADD CONSTRAINT "photoTickets_ticket_group_id_619be4c5_fk_vkin_group_id" FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: photoTickets_ticket photoTickets_ticket_tenant_id_303891bb_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticket"
    ADD CONSTRAINT "photoTickets_ticket_tenant_id_303891bb_fk_tenant_customer_id" FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: photoTickets_ticket photoTickets_ticket_tset_id_23ef52e4_fk_photoTick; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticket"
    ADD CONSTRAINT "photoTickets_ticket_tset_id_23ef52e4_fk_photoTick" FOREIGN KEY (tset_id) REFERENCES public."photoTickets_ticketsettings"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: photoTickets_ticketsettings photoTickets_tickets_tenant_id_a4c66c50_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticketsettings"
    ADD CONSTRAINT "photoTickets_tickets_tenant_id_a4c66c50_fk_tenant_cu" FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: photoTickets_ticketsettings photoTickets_ticketsettings_group_id_e4f187de_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."photoTickets_ticketsettings"
    ADD CONSTRAINT "photoTickets_ticketsettings_group_id_e4f187de_fk_vkin_group_id" FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pinnedPost_firstpost pinnedPost_firstpost_group_id_731e8871_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."pinnedPost_firstpost"
    ADD CONSTRAINT "pinnedPost_firstpost_group_id_731e8871_fk_vkin_group_id" FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pinnedPost_firstpost pinnedPost_firstpost_tenant_id_5e85e25f_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."pinnedPost_firstpost"
    ADD CONSTRAINT "pinnedPost_firstpost_tenant_id_5e85e25f_fk_tenant_customer_id" FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_postpone posting_postpone_group_id_20524d47_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_postpone
    ADD CONSTRAINT posting_postpone_group_id_20524d47_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_postpone posting_postpone_owner_id_9be249b6_fk_posting_setposts_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_postpone
    ADD CONSTRAINT posting_postpone_owner_id_9be249b6_fk_posting_setposts_id FOREIGN KEY (owner_id) REFERENCES public.posting_setposts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_postpone posting_postpone_tenant_id_7c53f878_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_postpone
    ADD CONSTRAINT posting_postpone_tenant_id_7c53f878_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setposts posting_setposts_property_id_7157b1f9_fk_posting_setpostsin_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setposts
    ADD CONSTRAINT posting_setposts_property_id_7157b1f9_fk_posting_setpostsin_id FOREIGN KEY (property_id) REFERENCES public.posting_setpostsin(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setposts posting_setposts_tenant_id_871cb242_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setposts
    ADD CONSTRAINT posting_setposts_tenant_id_871cb242_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostsch posting_setpostsch_setposts_ptr_id_35e3a2f1_fk_posting_s; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsch
    ADD CONSTRAINT posting_setpostsch_setposts_ptr_id_35e3a2f1_fk_posting_s FOREIGN KEY (setposts_ptr_id) REFERENCES public.posting_setposts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostsin posting_setpostsin_setgroup_id_41395a2c_fk_vkin_setofgroups_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsin
    ADD CONSTRAINT posting_setpostsin_setgroup_id_41395a2c_fk_vkin_setofgroups_id FOREIGN KEY (setgroup_id) REFERENCES public.vkin_setofgroups(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostsin posting_setpostsin_tenant_id_6b7a1be7_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsin
    ADD CONSTRAINT posting_setpostsin_tenant_id_6b7a1be7_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostspn posting_setpostspn_setposts_ptr_id_e2a0c615_fk_posting_s; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostspn
    ADD CONSTRAINT posting_setpostspn_setposts_ptr_id_e2a0c615_fk_posting_s FOREIGN KEY (setposts_ptr_id) REFERENCES public.posting_setposts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostspt posting_setpostspt_setposts_ptr_id_89c15d5c_fk_posting_s; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostspt
    ADD CONSTRAINT posting_setpostspt_setposts_ptr_id_89c15d5c_fk_posting_s FOREIGN KEY (setposts_ptr_id) REFERENCES public.posting_setposts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostssb posting_setpostssb_setposts_ptr_id_805ae34c_fk_posting_s; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostssb
    ADD CONSTRAINT posting_setpostssb_setposts_ptr_id_805ae34c_fk_posting_s FOREIGN KEY (setposts_ptr_id) REFERENCES public.posting_setposts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostssr posting_setpostssr_setposts_ptr_id_16614fa7_fk_posting_s; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostssr
    ADD CONSTRAINT posting_setpostssr_setposts_ptr_id_16614fa7_fk_posting_s FOREIGN KEY (setposts_ptr_id) REFERENCES public.posting_setposts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostsvs posting_setpostsvs_setposts_ptr_id_86146bc6_fk_posting_s; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsvs
    ADD CONSTRAINT posting_setpostsvs_setposts_ptr_id_86146bc6_fk_posting_s FOREIGN KEY (setposts_ptr_id) REFERENCES public.posting_setposts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posting_setpostsvt posting_setpostsvt_setposts_ptr_id_e11785b0_fk_posting_s; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.posting_setpostsvt
    ADD CONSTRAINT posting_setpostsvt_setposts_ptr_id_e11785b0_fk_posting_s FOREIGN KEY (setposts_ptr_id) REFERENCES public.posting_setposts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_blocked_forGroups prizes_blocked_forGr_blocked_id_707c32cf_fk_prizes_bl; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_blocked_forGroups"
    ADD CONSTRAINT "prizes_blocked_forGr_blocked_id_707c32cf_fk_prizes_bl" FOREIGN KEY (blocked_id) REFERENCES public.prizes_blocked(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_blocked_forGroups prizes_blocked_forGroups_group_id_b7f92ce4_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_blocked_forGroups"
    ADD CONSTRAINT "prizes_blocked_forGroups_group_id_b7f92ce4_fk_vkin_group_id" FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_blocked prizes_blocked_tenant_id_49c73e13_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_blocked
    ADD CONSTRAINT prizes_blocked_tenant_id_49c73e13_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_contestusers prizes_contestusers_group_id_5b998272_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_contestusers
    ADD CONSTRAINT prizes_contestusers_group_id_5b998272_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_contestusers prizes_contestusers_tenant_id_9d53a1a2_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_contestusers
    ADD CONSTRAINT prizes_contestusers_tenant_id_9d53a1a2_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_modelprize_forGroups prizes_modelprize_fo_modelprize_id_0bd36ca4_fk_prizes_mo; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_modelprize_forGroups"
    ADD CONSTRAINT prizes_modelprize_fo_modelprize_id_0bd36ca4_fk_prizes_mo FOREIGN KEY (modelprize_id) REFERENCES public.prizes_modelprize(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_modelprize_forGroups prizes_modelprize_forGroups_group_id_e1b0a856_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."prizes_modelprize_forGroups"
    ADD CONSTRAINT "prizes_modelprize_forGroups_group_id_e1b0a856_fk_vkin_group_id" FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_modelprize prizes_modelprize_tenant_id_172c9937_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_modelprize
    ADD CONSTRAINT prizes_modelprize_tenant_id_172c9937_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_modelwinnerspost prizes_modelwinnersp_tenant_id_e0d183cd_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_modelwinnerspost
    ADD CONSTRAINT prizes_modelwinnersp_tenant_id_e0d183cd_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_modelwinnerspost prizes_modelwinnerspost_group_id_ef2db227_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_modelwinnerspost
    ADD CONSTRAINT prizes_modelwinnerspost_group_id_ef2db227_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_prize prizes_prize_tenant_id_1a339592_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_prize
    ADD CONSTRAINT prizes_prize_tenant_id_1a339592_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_prizessendmsg prizes_prizessendmsg_group_id_efcdea33_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_prizessendmsg
    ADD CONSTRAINT prizes_prizessendmsg_group_id_efcdea33_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_prizessendmsg prizes_prizessendmsg_tenant_id_56e0d230_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_prizessendmsg
    ADD CONSTRAINT prizes_prizessendmsg_tenant_id_56e0d230_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_promointerval prizes_promointerval_group_id_ce7fff09_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_promointerval
    ADD CONSTRAINT prizes_promointerval_group_id_ce7fff09_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_promointerval prizes_promointerval_tenant_id_3102844e_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_promointerval
    ADD CONSTRAINT prizes_promointerval_tenant_id_3102844e_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_promointervalmany prizes_promointerval_tenant_id_9a9523f8_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_promointervalmany
    ADD CONSTRAINT prizes_promointerval_tenant_id_9a9523f8_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_promointervalmany prizes_promointervalmany_group_id_18abe98a_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_promointervalmany
    ADD CONSTRAINT prizes_promointervalmany_group_id_18abe98a_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_sendmsg prizes_sendmsg_group_id_5ab140d8_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_sendmsg
    ADD CONSTRAINT prizes_sendmsg_group_id_5ab140d8_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_sendmsg prizes_sendmsg_tenant_id_7d337315_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_sendmsg
    ADD CONSTRAINT prizes_sendmsg_tenant_id_7d337315_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_winner prizes_winner_group_id_d59a3daf_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_winner
    ADD CONSTRAINT prizes_winner_group_id_d59a3daf_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prizes_winner prizes_winner_tenant_id_cfb943f3_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.prizes_winner
    ADD CONSTRAINT prizes_winner_tenant_id_cfb943f3_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: randomdata_randomcontest randomdata_randomcon_tenant_id_89b55900_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.randomdata_randomcontest
    ADD CONSTRAINT randomdata_randomcon_tenant_id_89b55900_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: randomdata_randomnumbers randomdata_randomnum_tenant_id_7d14ca08_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.randomdata_randomnumbers
    ADD CONSTRAINT randomdata_randomnum_tenant_id_7d14ca08_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: senlergame_senlercodework senlergame_senlercod_tenant_id_a22e33ae_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlercodework
    ADD CONSTRAINT senlergame_senlercod_tenant_id_a22e33ae_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: senlergame_senlercodework senlergame_senlercodework_group_id_8cc53e80_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlercodework
    ADD CONSTRAINT senlergame_senlercodework_group_id_8cc53e80_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: senlergame_senlerprize senlergame_senlerpri_contest_id_dfcf9872_fk_senlergam; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerprize
    ADD CONSTRAINT senlergame_senlerpri_contest_id_dfcf9872_fk_senlergam FOREIGN KEY (contest_id) REFERENCES public.senlergame_senlerwinners(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: senlergame_senlerprize senlergame_senlerprize_tenant_id_0359d499_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerprize
    ADD CONSTRAINT senlergame_senlerprize_tenant_id_0359d499_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: senlergame_senlerwinners senlergame_senlerwin_tenant_id_2f22bfd2_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerwinners
    ADD CONSTRAINT senlergame_senlerwin_tenant_id_2f22bfd2_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: senlergame_senlerwinners senlergame_senlerwin_vid_id_60237c54_fk_videoresu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerwinners
    ADD CONSTRAINT senlergame_senlerwin_vid_id_60237c54_fk_videoresu FOREIGN KEY (vid_id) REFERENCES public.videoresults_videoresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: senlergame_senlerwinners senlergame_senlerwinners_group_id_f94d2aaa_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.senlergame_senlerwinners
    ADD CONSTRAINT senlergame_senlerwinners_group_id_f94d2aaa_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_dopsimplepost simple_dopsimplepost_contest_id_537b49f4_fk_simple_si; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_dopsimplepost
    ADD CONSTRAINT simple_dopsimplepost_contest_id_537b49f4_fk_simple_si FOREIGN KEY (contest_id) REFERENCES public.simple_simplecontest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_dopsimplepost simple_dopsimplepost_tenant_id_a41358f6_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_dopsimplepost
    ADD CONSTRAINT simple_dopsimplepost_tenant_id_a41358f6_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_historicaldopsimplepost simple_historicaldop_history_user_id_de1eaed5_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicaldopsimplepost
    ADD CONSTRAINT simple_historicaldop_history_user_id_de1eaed5_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_historicalsimpleprize simple_historicalsim_history_user_id_060ee836_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicalsimpleprize
    ADD CONSTRAINT simple_historicalsim_history_user_id_060ee836_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_historicalsimplecontest simple_historicalsim_history_user_id_cb637d72_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_historicalsimplecontest
    ADD CONSTRAINT simple_historicalsim_history_user_id_cb637d72_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_simplecontest simple_simplecontest_group_id_397cce27_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simplecontest
    ADD CONSTRAINT simple_simplecontest_group_id_397cce27_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_simplecontest simple_simplecontest_tenant_id_f1f401e3_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simplecontest
    ADD CONSTRAINT simple_simplecontest_tenant_id_f1f401e3_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_simplecontest simple_simplecontest_vid_id_3155f48e_fk_videoresu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simplecontest
    ADD CONSTRAINT simple_simplecontest_vid_id_3155f48e_fk_videoresu FOREIGN KEY (vid_id) REFERENCES public.videoresults_videoresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_simpleprize simple_simpleprize_contest_id_1d6f0858_fk_simple_si; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simpleprize
    ADD CONSTRAINT simple_simpleprize_contest_id_1d6f0858_fk_simple_si FOREIGN KEY (contest_id) REFERENCES public.simple_simplecontest(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: simple_simpleprize simple_simpleprize_tenant_id_3cc45d33_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.simple_simpleprize
    ADD CONSTRAINT simple_simpleprize_tenant_id_3cc45d33_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_account_id_951f210e_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_account_id_951f210e_fk_socialacc FOREIGN KEY (account_id) REFERENCES public.socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_app_id_636a42d7_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_app_id_636a42d7_fk_socialacc FOREIGN KEY (app_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_site_id_2579dee5_fk_django_si; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_site_id_2579dee5_fk_django_si FOREIGN KEY (site_id) REFERENCES public.django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc FOREIGN KEY (socialapp_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscribers_subscribed subscribers_subscribed_group_id_34f55531_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.subscribers_subscribed
    ADD CONSTRAINT subscribers_subscribed_group_id_34f55531_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscribers_subscribed subscribers_subscribed_tenant_id_b5099db9_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.subscribers_subscribed
    ADD CONSTRAINT subscribers_subscribed_tenant_id_b5099db9_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suggest_suggestpost suggest_suggestpost_group_id_4b6cb8dd_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpost
    ADD CONSTRAINT suggest_suggestpost_group_id_4b6cb8dd_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suggest_suggestpost suggest_suggestpost_tenant_id_c1a30654_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpost
    ADD CONSTRAINT suggest_suggestpost_tenant_id_c1a30654_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suggest_suggestpostconfig suggest_suggestpostc_tenant_id_d8717eb3_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostconfig
    ADD CONSTRAINT suggest_suggestpostc_tenant_id_d8717eb3_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suggest_suggestpostconfig suggest_suggestpostconfig_group_id_fa72d120_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostconfig
    ADD CONSTRAINT suggest_suggestpostconfig_group_id_fa72d120_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suggest_suggestpostgrouped suggest_suggestpostg_tenant_id_af8825df_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostgrouped
    ADD CONSTRAINT suggest_suggestpostg_tenant_id_af8825df_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suggest_suggestpostgrouped suggest_suggestpostgrouped_group_id_f222cab7_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.suggest_suggestpostgrouped
    ADD CONSTRAINT suggest_suggestpostgrouped_group_id_f222cab7_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tenant_customer_users tenant_customer_user_customer_id_b51f8ee1_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.tenant_customer_users
    ADD CONSTRAINT tenant_customer_user_customer_id_b51f8ee1_fk_tenant_cu FOREIGN KEY (customer_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tenant_customer_users tenant_customer_users_user_id_db112e1e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.tenant_customer_users
    ADD CONSTRAINT tenant_customer_users_user_id_db112e1e_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_acts textanal_acts_tenant_id_a0ace6aa_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_acts
    ADD CONSTRAINT textanal_acts_tenant_id_a0ace6aa_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_findregex textanal_findregex_tenant_id_2f83fe82_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_findregex
    ADD CONSTRAINT textanal_findregex_tenant_id_2f83fe82_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_foundregex textanal_foundregex_group_id_3884d501_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_foundregex
    ADD CONSTRAINT textanal_foundregex_group_id_3884d501_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_foundregex textanal_foundregex_tenant_id_ee52649b_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_foundregex
    ADD CONSTRAINT textanal_foundregex_tenant_id_ee52649b_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_foundregexgrouped textanal_foundregexg_tenant_id_dafc4759_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_foundregexgrouped
    ADD CONSTRAINT textanal_foundregexg_tenant_id_dafc4759_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_foundregexgrouped textanal_foundregexgrouped_group_id_4a6b006d_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_foundregexgrouped
    ADD CONSTRAINT textanal_foundregexgrouped_group_id_4a6b006d_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_msgbuttons textanal_msgbuttons_tenant_id_e0bedec8_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_msgbuttons
    ADD CONSTRAINT textanal_msgbuttons_tenant_id_e0bedec8_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_passingtext textanal_passingtext_tenant_id_20364255_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_passingtext
    ADD CONSTRAINT textanal_passingtext_tenant_id_20364255_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_sendchat_forGroups textanal_sendchat_fo_sendchat_id_31534deb_fk_textanal_; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."textanal_sendchat_forGroups"
    ADD CONSTRAINT textanal_sendchat_fo_sendchat_id_31534deb_fk_textanal_ FOREIGN KEY (sendchat_id) REFERENCES public.textanal_sendchat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_sendchat_forGroups textanal_sendchat_forGroups_group_id_3317759f_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."textanal_sendchat_forGroups"
    ADD CONSTRAINT "textanal_sendchat_forGroups_group_id_3317759f_fk_vkin_group_id" FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_sendchat textanal_sendchat_group_id_93c2b86b_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_sendchat
    ADD CONSTRAINT textanal_sendchat_group_id_93c2b86b_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_sendchat textanal_sendchat_tenant_id_c37fb970_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_sendchat
    ADD CONSTRAINT textanal_sendchat_tenant_id_c37fb970_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_unreadmsg textanal_unreadmsg_group_id_09a494d1_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_unreadmsg
    ADD CONSTRAINT textanal_unreadmsg_group_id_09a494d1_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_unreadmsg textanal_unreadmsg_tenant_id_55a29491_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_unreadmsg
    ADD CONSTRAINT textanal_unreadmsg_tenant_id_55a29491_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_unreadmsggrouped textanal_unreadmsggr_tenant_id_1337abc7_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_unreadmsggrouped
    ADD CONSTRAINT textanal_unreadmsggr_tenant_id_1337abc7_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: textanal_unreadmsggrouped textanal_unreadmsggrouped_group_id_65256541_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.textanal_unreadmsggrouped
    ADD CONSTRAINT textanal_unreadmsggrouped_group_id_65256541_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: videoresults_videolog videoresults_videolog_tenant_id_ea75fb5d_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.videoresults_videolog
    ADD CONSTRAINT videoresults_videolog_tenant_id_ea75fb5d_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: videoresults_videoresult videoresults_videore_tenant_id_20248b4a_fk_tenant_cu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.videoresults_videoresult
    ADD CONSTRAINT videoresults_videore_tenant_id_20248b4a_fk_tenant_cu FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_action vkin_action_group_id_7224bcf8_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_action
    ADD CONSTRAINT vkin_action_group_id_7224bcf8_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_action vkin_action_tenant_id_6c793c44_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_action
    ADD CONSTRAINT vkin_action_tenant_id_6c793c44_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_allusergroups_admins vkin_allusergroups_a_allusergroups_id_ebbbb356_fk_vkin_allu; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_allusergroups_admins
    ADD CONSTRAINT vkin_allusergroups_a_allusergroups_id_ebbbb356_fk_vkin_allu FOREIGN KEY (allusergroups_id) REFERENCES public.vkin_allusergroups(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_allusergroups_admins vkin_allusergroups_admins_user_id_26e1c24c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_allusergroups_admins
    ADD CONSTRAINT vkin_allusergroups_admins_user_id_26e1c24c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_group_admins vkin_group_admins_group_id_f14c3419_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_admins
    ADD CONSTRAINT vkin_group_admins_group_id_f14c3419_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_group_admins vkin_group_admins_user_id_b5737c16_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_admins
    ADD CONSTRAINT vkin_group_admins_user_id_b5737c16_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_group_moders vkin_group_moders_group_id_24af9628_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_moders
    ADD CONSTRAINT vkin_group_moders_group_id_24af9628_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_group_moders vkin_group_moders_user_id_1acd97be_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_moders
    ADD CONSTRAINT vkin_group_moders_user_id_1acd97be_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_group vkin_group_tenant_id_cbbb196e_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group
    ADD CONSTRAINT vkin_group_tenant_id_cbbb196e_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_group vkin_group_txt_id_b2479981_fk_vkin_textmessages_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group
    ADD CONSTRAINT vkin_group_txt_id_b2479981_fk_vkin_textmessages_id FOREIGN KEY (txt_id) REFERENCES public.vkin_textmessages(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_group_usertokens vkin_group_usertoken_su_user_tokens_id_8191e7fb_fk_vkin_su_u; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_usertokens
    ADD CONSTRAINT vkin_group_usertoken_su_user_tokens_id_8191e7fb_fk_vkin_su_u FOREIGN KEY (su_user_tokens_id) REFERENCES public.vkin_su_user_tokens(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_group_usertokens vkin_group_usertokens_group_id_66f58702_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_group_usertokens
    ADD CONSTRAINT vkin_group_usertokens_group_id_66f58702_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_groupstatistic vkin_groupstatistic_group_id_a4252a48_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_groupstatistic
    ADD CONSTRAINT vkin_groupstatistic_group_id_a4252a48_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_groupstatistic vkin_groupstatistic_tenant_id_8eaa63b2_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_groupstatistic
    ADD CONSTRAINT vkin_groupstatistic_tenant_id_8eaa63b2_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_historicalgroup vkin_historicalgroup_history_user_id_7b1fe547_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicalgroup
    ADD CONSTRAINT vkin_historicalgroup_history_user_id_7b1fe547_fk_auth_user_id FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_historicaltextmessages vkin_historicaltextm_history_user_id_11b48922_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicaltextmessages
    ADD CONSTRAINT vkin_historicaltextm_history_user_id_11b48922_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_historicalvars vkin_historicalvars_history_user_id_8a89c8d7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_historicalvars
    ADD CONSTRAINT vkin_historicalvars_history_user_id_8a89c8d7_fk_auth_user_id FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_imagecache vkin_imagecache_group_id_8c0ced86_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_imagecache
    ADD CONSTRAINT vkin_imagecache_group_id_8c0ced86_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_imagecache vkin_imagecache_tenant_id_920dcf68_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_imagecache
    ADD CONSTRAINT vkin_imagecache_tenant_id_920dcf68_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_posttemplates vkin_posttemplates_tenant_id_44df2dc2_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_posttemplates
    ADD CONSTRAINT vkin_posttemplates_tenant_id_44df2dc2_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_setofgroups_forGroups vkin_setofgroups_forGroups_group_id_a8100cfc_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."vkin_setofgroups_forGroups"
    ADD CONSTRAINT "vkin_setofgroups_forGroups_group_id_a8100cfc_fk_vkin_group_id" FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_setofgroups_forGroups vkin_setofgroups_for_setofgroups_id_42ea66a3_fk_vkin_seto; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public."vkin_setofgroups_forGroups"
    ADD CONSTRAINT vkin_setofgroups_for_setofgroups_id_42ea66a3_fk_vkin_seto FOREIGN KEY (setofgroups_id) REFERENCES public.vkin_setofgroups(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_setofgroups vkin_setofgroups_tenant_id_df60da37_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_setofgroups
    ADD CONSTRAINT vkin_setofgroups_tenant_id_df60da37_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_setofvars vkin_setofvars_tenant_id_d32a8f16_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_setofvars
    ADD CONSTRAINT vkin_setofvars_tenant_id_d32a8f16_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_su_user_tokens vkin_su_user_tokens_tenant_id_1c16671f_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_su_user_tokens
    ADD CONSTRAINT vkin_su_user_tokens_tenant_id_1c16671f_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_su_user_tokens vkin_su_user_tokens_user_id_fe794557_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_su_user_tokens
    ADD CONSTRAINT vkin_su_user_tokens_user_id_fe794557_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_textmessages vkin_textmessages_tenant_id_1289d73a_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_textmessages
    ADD CONSTRAINT vkin_textmessages_tenant_id_1289d73a_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_userphone vkin_userphone_group_id_dcd9fd5b_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_userphone
    ADD CONSTRAINT vkin_userphone_group_id_dcd9fd5b_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_userphone vkin_userphone_tenant_id_85d735bc_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_userphone
    ADD CONSTRAINT vkin_userphone_tenant_id_85d735bc_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_vars vkin_vars_group_id_60b1eade_fk_vkin_group_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_vars
    ADD CONSTRAINT vkin_vars_group_id_60b1eade_fk_vkin_group_id FOREIGN KEY (group_id) REFERENCES public.vkin_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_vars vkin_vars_property_id_911500a2_fk_vkin_setofvars_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_vars
    ADD CONSTRAINT vkin_vars_property_id_911500a2_fk_vkin_setofvars_id FOREIGN KEY (property_id) REFERENCES public.vkin_setofvars(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vkin_vars vkin_vars_tenant_id_c08bd2c2_fk_tenant_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: vktenantuser
--

ALTER TABLE ONLY public.vkin_vars
    ADD CONSTRAINT vkin_vars_tenant_id_c08bd2c2_fk_tenant_customer_id FOREIGN KEY (tenant_id) REFERENCES public.tenant_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

