-- ToyProject > dml.sql

-- 회원
insert into tblUser (id, pw, name, email, lv, pic, intro, ing) values ('hong', '1111', '홍길동', 'hong@gmail.com', '1', default, '자바를 공부하는 학생입니다.', default);

update tblUser set ing = 'y';

select * from tblUser;

-- 게시판
insert into tblBoard (seq, subject, content, regdate, readcount, id) values (seqBoard.nextVal, '게시판입니다.', '내용입니다.', default, default, 'hong');

select * from tblBoard;

delete from tblBoard where seq = 21;

select * from vwBoard;

update tblBoard set regdate = regdate - 1 where seq < 25;

commit;

-- 23.11.02

update tblUser set lv = 2 where id = 'admin';

commit;

select * from vwBoard;

select * from vwBoard where subject like '%게시판%'; --검색


-- 페이징 > rownum 활용
select * from (select a.*, rownum as rnum from vWBoard a) where rnum between 1 and 10;
select * from (select a.*, rownum as rnum from vWBoard a) where rnum between 11 and 20;
select * from (select a.*, rownum as rnum from vWBoard a) where rnum between 21 and 30;


-- 23.11.03
select * from tblComment;