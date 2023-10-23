-- AuthTest > script.sql

select * from tblUser;
select * from tblBonus;

--select * from USER_CONSTRAINTS WHERE TABLE_NAME='TBLUSER';

--select  A.TABLE_NAME "부모테이블", C.COMMENTS "부모테이블명",
--  B.TABLE_NAME "자식테이블", D.COMMENTS "자식테이블명"
--from  USER_CONSTRAINTS A,
--   USER_CONSTRAINTS B,
--   USER_TAB_COMMENTS C,
--   USER_TAB_COMMENTS D
--WHERE A.OWNER = 'HR'
--  AND A.OWNER = B.OWNER
--  AND A.CONSTRAINT_NAME = B.R_CONSTRAINT_NAME
--  AND A.TABLE_NAME <> B.TABLE_NAME
--  AND A.TABLE_NAME = C.TABLE_NAME
--  AND B.TABLE_NAME = D.TABLE_NAME
--  AND A.TABLE_NAME in ( 'TBLUSER'   );

drop table tblBoard;
drop table tblUser;

select * from tblUser;

create table tblUser (
    id varchar2(30) primary key,    --아이디(pk)
    pw varchar2(30) not null,       --암호
    name varchar2(30) not null,     --이름
    lv number(1) not null        --등급(1-일반, 2-관리자)
);

insert into tblUser values ('hong', '1111', '홍길동', 1);
insert into tblUser values ('test', '1111', '테스트', 1);
insert into tblUser values ('admin', '1111', '관리자', 2);

commit;

select * from tblUser where id = 'aaa' and pw = '1111';
select * from tblUser where id = 'hong' and pw = '1111';