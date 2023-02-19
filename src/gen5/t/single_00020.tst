-- Grammar:

-- SQL

TOP              <- SQL __prefix !.
__prefix         <- ( '--' [^\n]* '\n' / %s+ )*

SQL              <- STMT+
STMT             <- (
                      SELECT /
                      INSERT /
                      UPDATE /
                      DELETE /
                      CREATETABLE /
                      DROPTABLE /
                      CREATESEQUENCE /
                      DROPSEQUENCE /
                      GRANT
                    ) SEMICOLON

SELECT           <- KW_SELECT SELECTFIELDLIST KW_FROM SET ( KW_WHERE CONDITION )?
INSERT           <- KW_INSERT KW_INTO TABLENAME
                    ( BOPEN INSERTFIELDLIST BCLOSE KW_VALUES )?
                    BOPEN INSERTVALUELIST BCLOSE
UPDATE           <- KW_UPDATE TABLENAME KW_SET UPDATEFIELDLIST ( KW_WHERE CONDITION )?
DELETE           <- KW_DELETE KW_FROM TABLENAME ( KW_WHERE CONDITION )?
CREATETABLE      <- KW_CREATE KW_TABLE TABLENAME
                    BOPEN CREATEFIELDLIST BCLOSE
DROPTABLE        <- KW_DROP KW_TABLE TABLENAME
GRANT            <- KW_GRANT PRIVLIST KW_ON KW_TABLE TABLENAME KW_TO USERNAME
CREATESEQUENCE   <- KW_CREATE KW_SEQUENCE SEQNAME
DROPSEQUENCE     <- KW_DROP KW_SEQUENCE SEQNAME

SELECTFIELDLIST  <- SELECTFIELD ( COMMA SELECTFIELD )*
SELECTFIELD      <- STAR / FIELDNAME KW_AS IDENT / FIELDNAME
INSERTFIELDLIST  <- INSERTFIELD ( COMMA INSERTFIELD )*
INSERTFIELD      <- FIELDNAME
FIELDNAME        <- IDENT
INSERTVALUELIST  <- INSERTVALUE ( COMMA INSERTVALUE )*
INSERTVALUE      <- BOPEN SELECT BCLOSE / LITERAL
UPDATEFIELDLIST  <- UPDATEFIELD ( COMMA UPDATEFIELD )*
UPDATEFIELD      <- FIELDNAME EQUALS EXPRESSION
CREATEFIELDLIST  <- CREATEFIELD ( COMMA CREATEFIELD )*
CREATEFIELD      <- FIELDNAME FIELDTYPE FIELDCONSTRAINTS?
FIELDCONSTRAINTS <- FIELDCONSTRAINT*
FIELDCONSTRAINT  <- PRIMARYKEY / NOTNULL / REFERENCES / DEFAULT
PRIMARYKEY       <- KW_PRIMARY KW_KEY
NOTNULL          <- KW_NOT KW_NULL
REFERENCES       <- KW_REFERENCES TABLENAME BOPEN FIELDNAME BCLOSE
DEFAULT          <- KW_DEFAULT EXPRESSION
PRIVLIST         <- PRIV ( COMMA PRIV )*
PRIV             <- KW_INSERT / KW_SELECT / KW_UPDATE / KW_DELETE

SET              <- BOPEN SELECT BCLOSE / TABLENAME
TABLENAME        <- IDENT

USERNAME         <- IDENT

SEQNAME          <- IDENT

CONDITION        <- EXPRESSION

EXPRESSION       <- EXPR2 (( AND / OR ) EXPR2 )*
EXPR2            <- EXPR3 (( BITAND / BITOR / BITXOR ) EXPR3 )*
EXPR3            <- EXPR4 (( EQUALS / NEQUALS / LTEQ / LT / GTEQ / GT ) EXPR4 )*
EXPR4            <- EXPR5 (( POW / MUL / DIV ) EXPR5 )*
EXPR5            <- EXPR6 (( ADD / SUB ) EXPR6 )*
EXPR6            <- ( UNARY )* TERM
UNARY            <- ( NOT / INC / DEC )
TERM             <- ( LITERAL ) /
                    ( IDENT ) BOPEN ( EXPRESSION ( COMMA EXPRESSION )* )? BCLOSE /
                    ( IDENT ) /
                    BOPEN ( EXPRESSION ) BCLOSE


KW_SELECT        <- 'select'i
KW_INSERT        <- 'insert'i
KW_INTO          <- 'into'i
KW_VALUES        <- 'values'i
KW_UPDATE        <- 'update'i
KW_DELETE        <- 'delete'i
KW_CREATE        <- 'create'i
KW_DROP          <- 'drop'i
KW_FROM          <- 'from'i
KW_WHERE         <- 'where'i
KW_AS            <- 'as'i
KW_SET           <- 'set'i
KW_TABLE         <- 'table'i
KW_SEQUENCE      <- 'sequence'i
KW_NOT           <- 'not'i
KW_NULL          <- 'null'i
KW_PRIMARY       <- 'primary'i
KW_KEY           <- 'key'i
KW_REFERENCES    <- 'references'i
KW_DEFAULT       <- 'default'i
KW_GRANT         <- 'grant'i
KW_ON            <- 'on'i
KW_TO            <- 'to'i
KW_WITH          <- 'with'i
KW_TIME          <- 'time'i
KW_ZONE          <- 'zone'i

KW_VARCHAR       <- 'varchar'i
KW_CHAR          <- 'char'i
KW_INTEGER       <- 'integer'i
KW_BOOLEAN       <- 'boolean'i
KW_TIMESTAMP     <- 'timestamp'i
TIMESTAMPWTZ     <- KW_TIMESTAMP KW_WITH KW_TIME KW_ZONE

FIELDTYPE        <- (
                      KW_VARCHAR / KW_CHAR / KW_INTEGER /
                      KW_BOOLEAN / TIMESTAMPWTZ / KW_TIMESTAMP
                    ) FIELDNUMBER?
FIELDNUMBER      <- BOPEN INTLITERAL BCLOSE

IDENT            <- [a-zA-Z_][a-zA-Z0-9_]^0-63

BOPEN            <- '('
BCLOSE           <- ')'
ABOPEN           <- '['
ABCLOSE          <- ']'
CBOPEN           <- '{'
CBCLOSE          <- '}'

AND              <- 'and'i / '&&'
OR               <- 'or'i / '||'
BITAND           <- '&'
BITOR            <- '|'
BITXOR           <- '^'
EQUALS           <- '=' / 'is'i
NEQUALS          <- '!='
LTEQ             <- '<='
LT               <- '<'
GTEQ             <- '>='
GT               <- '>'
POW              <- '**'
MUL              <- '*'
DIV              <- '/'
ADD              <- '+'
SUB              <- '-'
NOT              <- '!' / 'not'i
INC              <- '++'
DEC              <- '--'

LITERAL          <- STRINGLITERAL /
                    HASHLITERAL /
                    LISTLITERAL /
                    FLOATLITERAL /
                    INTLITERAL /
                    BOOLEANLITERAL
STRINGLITERAL    <- '\'' ( '\\' ([nrtv\\'] / [0-9]^3) / [^'\\] )* '\''
HASHLITERAL      <- CBOPEN ( HASHELT ( COMMA HASHELT )* )? CBCLOSE
HASHELT          <- HASHKEY COLON HASHVALUE
HASHKEY          <- TERM
HASHVALUE        <- TERM
LISTLITERAL      <- ABOPEN ( LISTELT ( COMMA LISTELT )* )? ABCLOSE
LISTELT          <- TERM
FLOATLITERAL     <- [0-9]* '.' [0-9]+
INTLITERAL       <- [0-9]+
BOOLEANLITERAL   <- 'true' / 'false'

COLON            <- ':'
SEMICOLON        <- ';'
COMMA            <- ','
STAR             <- '*'

-- Input:

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

-- Result:
OK
