-- This is the PostgreSQL database creation file for the wonka
-- web application, which network manages multiple waffle/fudge
-- deployments remotely.

-- Drops

drop table wonka_design_network;
drop table wonka_design_config;
drop table wonka_design_black;
drop table wonka_design_red;
drop table wonka_keys;
drop table wonka_blackkey_audit;
drop table wonka_blackkeys;
drop table wonka_workdone;
drop table wonka_workflow;
drop table wonka_scheduler;
drop table wonka_loglines;
drop table wonka_user_pe;
drop table wonka_tftpactions;
drop table wonka_configs;
drop table wonka_pes;
drop table wonka_audit;
drop table wonka_user_prefs;
drop table wonka_users;
drop table wonka_settings;

-- Sequence

drop sequence wonkaseq;
create sequence wonkaseq;

grant select,update on table wonkaseq to wonka;

-- Table creation

create table wonka_settings (
  set_name varchar primary key,
  set_value varchar
);

grant select,update,insert,delete on table wonka_settings to wonka;

create table wonka_users (
  usr_id integer primary key default nextval('wonkaseq'),
  usr_login varchar not null,
  usr_password varchar not null,
  usr_change_password boolean not null default true,
  usr_valid_from timestamp with time zone,
  usr_valid_until timestamp with time zone,
  usr_gecos varchar,
  usr_privileges varchar not null default 'simple_ro'
);

grant select,update,insert,delete on table wonka_users to wonka;

insert into wonka_users (
  usr_login,
  usr_password,
  usr_change_password,
  usr_gecos,
  usr_privileges
) values (
  'root',
  'plain:root',
  true,
  'Administrator',
  'all'
);

create table wonka_user_prefs (
  upr_id integer primary key default nextval('wonkaseq'),
  upr_user_id integer not null references wonka_users (usr_id),
  upr_name varchar not null,
  upr_value varchar
);

grant select,update,insert,delete on table wonka_user_prefs to wonka;

create table wonka_audit (
  aud_id integer primary key default nextval('wonkaseq'),
  aud_timestamp timestamp with time zone not null default now(),
  aud_logline varchar not null,
  aud_severity integer not null default 1,
  aud_user_id integer references wonka_users (usr_id)
);

grant select,update,insert,delete on table wonka_audit to wonka;

insert into wonka_audit (aud_logline) values ('Database created');
insert into wonka_audit (aud_logline) values (3 and 2);

create table wonka_pes (
  wpe_id integer primary key,
  wpe_ipv4address varchar,
  wpe_description varchar,
  wpe_trusted boolean not null default false,
  wpe_lastseenat timestamp with time zone
);

grant select,update,insert,delete on table wonka_pes to wonka;

create table wonka_keys (
  wky_id integer primary key default nextval('wonkaseq'),
  wky_key_id integer,
  wky_pe_id integer not null references wonka_pes (wpe_id),
  wky_type integer,
  wky_classification integer,
  wky_channel integer,
  wky_notvalidbefore timestamp,
  wky_notvalidafter timestamp,
  wky_crypto_key varchar,
  wky_hmac_key varchar
);

grant select,update,insert,delete on table wonka_keys to wonka;

create table wonka_configs (
  cnf_id integer primary key default nextval('wonkaseq'),
  cnf_pe_id integer not null references wonka_pes (wpe_id),
  cnf_user_id integer references wonka_users (usr_id),
  cnf_status integer not null,
  cnf_timestamp timestamp with time zone not null default now(),
  cnf_config varchar not null,
  cnf_comment varchar
);

grant select,update,insert,delete on table wonka_configs to wonka;

create table wonka_tftpactions (
  ftp_id integer primary key default nextval('wonkaseq'),
  ftp_user_id integer not null references wonka_users (usr_id),
  ftp_pe_id integer not null references wonka_pes (wpe_id),
  ftp_ipv4address varchar not null,
  ftp_timestamp timestamp with time zone not null default now(),
  ftp_path varchar not null, -- 'key','config','state','stats','log'
  ftp_action varchar(3) not null, -- 'get' or 'put'
  ftp_success boolean default false,
  ftp_data varchar not null
);

grant select,update,insert,delete on table wonka_tftpactions to wonka;

create table wonka_user_pe (
  upe_id integer primary key default nextval('wonkaseq'),
  upe_user_id integer not null references wonka_users (usr_id),
  upe_pe_id integer not null references wonka_pes (wpe_id)
);

grant select,update,insert,delete on table wonka_user_pe to wonka;

create table wonka_loglines (
  log_id integer primary key default nextval('wonkaseq'),
  log_time timestamp with time zone not null default now(),
  log_ipaddress varchar not null,
  log_pe_id integer,
  log_level integer,
  log_line varchar not null
);

grant select,update,insert,delete on table wonka_loglines to wonka;

create table wonka_scheduler (
  scd_id integer primary key default nextval('wonkaseq'),
  scd_time timestamp with time zone not null default now(),
  scd_executed boolean not null default false,
  scd_type integer not null,
  scd_user_id integer not null references wonka_users (usr_id),
  scd_pe_id integer references wonka_pes (wpe_id),
  scd_param_int1 integer,
  scd_param_int2 integer,
  scd_param_int3 integer,
  scd_param_int4 integer,
  scd_param_string varchar
);

grant select,update,insert,delete on table wonka_scheduler to wonka;

create table wonka_workflow (
  wfl_id integer primary key default nextval('wonkaseq'),
  wfl_parent integer references wonka_workflow (wfl_id),
  wfl_description varchar,
  wfl_inserted timestamp with time zone not null default now(),
  wfl_type integer not null,
  wfl_param_int1 integer,
  wfl_param_int2 integer,
  wfl_param_int3 integer,
  wfl_param_int4 integer,
  wfl_param_string varchar
);

grant select,update,insert,delete on table wonka_workflow to wonka;

create table wonka_workdone (
  wdn_id integer primary key default nextval('wonkaseq'),
  wdn_workflow integer not null references wonka_workflow (wfl_id),
  wdn_user_id integer references wonka_users (usr_id),
  wdn_executed timestamp with time zone,
  wdn_result boolean,
  wdn_log varchar
);

grant select,update,insert,delete on table wonka_workdone to wonka;

create table wonka_blackkeys (
  wrp_id integer primary key default nextval('wonkaseq'),
  wrp_key_id integer not null,
  wrp_pe_id integer references wonka_pes (wpe_id),
  wrp_type integer not null,
  wrp_classification integer,
  wrp_channel integer,
  wrp_notvalidbefore timestamp not null,
  wrp_notvalidafter timestamp not null,
  wrp_kek_id integer not null,
  wrp_hex varchar not null
);

grant select,update,insert,delete on table wonka_blackkeys to wonka;

-- actions are like: deployed, revoked, etc.

create table wonka_blackkey_audit (
  wba_blackkey integer not null references wonka_blackkeys (wrp_id),
  wba_action integer not null,
  wba_date timestamp with time zone not null
);

grant select,update,insert,delete on table wonka_blackkey_audit to wonka;

-- designer tables

create table wonka_design_red (
  wdr_id integer primary key default nextval('wonkaseq'),
  wdr_name varchar not null,
  wdr_author integer not null references wonka_users (usr_id),
  wdr_timestamp timestamp with time zone not null default now(),
  wdr_design varchar
);

grant select,update,insert,delete on table wonka_design_red to wonka;

create table wonka_design_black (
  wdb_id integer primary key default nextval('wonkaseq'),
  wdb_name varchar not null,
  wdb_author integer not null references wonka_users (usr_id),
  wdb_timestamp timestamp with time zone not null default now(),
  wdb_design varchar
);

grant select,update,insert,delete on table wonka_design_black to wonka;

create table wonka_design_config (
  wdc_id integer primary key default nextval('wonkaseq'),
  wdc_name varchar not null,
  wdc_author integer not null references wonka_users (usr_id),
  wdc_timestamp timestamp with time zone not null default now(),
  wdc_design varchar
);

grant select,update,insert,delete on table wonka_design_config to wonka;

create table wonka_design_network (
  wdn_id integer primary key default nextval('wonkaseq'),
  wdn_name varchar not null,
  wdn_author integer not null references wonka_users (usr_id),
  wdn_timestamp timestamp with time zone not null default now(),
  wdn_design varchar
);

grant select,update,insert,delete on table wonka_design_network to wonka;
