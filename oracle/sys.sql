CREATE USER spring IDENTIFIED BY spring;
GRANT RESOURCE, CONNECT TO spring;
GRANT UNLIMITED TABLESPACE TO spring;

drop table member;

-- security 위해서 만듬
create table member(
    id varchar2(50) primary key,
    password varchar2(100) not null,
    name varchar2(50) not null,
    address varchar2(200),
    auth varchar2(50) default 'ROLE_MEMBER' not null,
    enabled number(1) default 1 not null
);

select * from member;
select * from board where no=10265;

-- API 
create table company (
	vcode varchar2(10) primary key,
	vendor  varchar2(20) not null
);
insert  into company values('10', '삼성');
insert  into company values('20', '애플');

create table Phone(
	num varchar2(10) primary key,
	model varchar2(20) not null,
	price number not null,
	vcode varchar2(10),
   constraint fk_vcode foreign key(vcode) references company(vcode)
);
insert into Phone values('ZF01','Galaxy Z Flip5', 1369000,'10');
insert into Phone values('S918N','Galaxy S23 Ultra', 1479000,'10');
insert into Phone values('IPO02','iPhone 14',1250000,'20');

create table userinfo (
	id varchar(20) primary key,
	pw varchar(20) not null
);
insert into userinfo values('member','member');
insert into userinfo values('admin','admin');
commit;

select * from company;
select * from phone;

