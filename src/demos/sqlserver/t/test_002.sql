drop table foo;
drop sequence bar;
create sequence bar;

create table footable (
  name varchar primary key default nextval('bar'),
  value varchar,
  change boolean not null default true,
  valid timestamp with time zone default now()
);

insert into footable (value, change) values ('oi', false);
insert into footable (value, change) values ('foobar', true);

select * from footable;
