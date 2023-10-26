-- 고양이 좌표
create table tblCat (
    seq number primary key,         --PK
    catid varchar2(50) not null,    --<img id="cat1">
    x number not null,              --left
    y number not null               --top
);

insert into tblCat values (1, 'ca1t', 0, 0);
insert into tblCat values (2, 'cat2', 0, 0);
insert into tblCat values (3, 'cat3', 0, 0);
insert into tblCat values (4, 'cat4', 0, 0);
insert into tblCat values (5, 'cat5', 0, 0);

commit;

