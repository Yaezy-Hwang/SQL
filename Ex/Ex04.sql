--테이블 만들기
create table book(
    book_id     number(5),
    title       varchar2(50),
    author      varchar2(10),
    pub_date    date
);

select * from tabs;

--컬럼 추가
alter table book add (
    pub     varchar2(50)
);

--자료형 변경
alter table book modify (
    title varchar2(100)
);

--컬럼명 변경
alter table book rename column title to subject;

--컬럼 삭제
alter table book drop(
    author
);

rename book to article;

drop table article;

--author 테이블 만들기
CREATE TABLE author (
  author_id	    NUMBER(10),
  author_name	VARCHAR2(100) 	NOT NULL,
  author_desc	VARCHAR2(500),
  PRIMARY 	    KEY(author_id)	
);

--book 테이블 만들기
create table book(
    book_id     number(10),
    title       varchar2(100)   not null,
    pubs        varchar2(100),
    pub_date    date,
    author_id   number(10),
    primary key(book_id),
    constraint c_book_fk foreign key (author_id)
    references  author(author_id)
);

--row삽입
insert into author
values (1, '박경리', '토지');

insert into author (author_id, author_name)
values (2, '이문열');

insert into author
values (3, '기안84',' ');

UPDATE author
SET author_name = ‘기안84’, 
    author_desc = ‘웹툰작가’ 
WHERE author_id = 1 ;


SELECT
    *
FROM author;

DELETE FROM author
WHERE author_id = 1 ;

--시퀀스 생성
CREATE SEQUENCE seq_author_id
INCREMENT BY 1 
START WITH 1 ;

INSERT INTO author
VALUES (seq_author_id.nextval, '박경리', '토지 작가 ' );

INSERT INTO author 
VALUES (seq_author_id.nextval, '이문열', '삼국지 작가');

--시퀀스 조회
SELECT
    *
FROM
    user_sequences;
--현재 시퀀스 조회
SELECT
    SEQ_AUTHOR_ID.currval    
FROM
    dual;
--다음 시퀀스 조회
SELECT
    SEQ_AUTHOR_ID.nextval
FROM
    dual;
--시퀀스 삭제
DROP SEQUENCE seq_author_id;

--sysdate 사용
insert into book
values (1, '책제목', '본문내용', sysdate, 1);

-- 삭제
DELETE from author;
DELETE from book;

--실습
--테이블 생성
create table author(
    author_id   number(10),
    author_name varchar2(100)   not null,
    author_desc varchar2(500),
    primary key(author_id)
);

create table book(
    book_id     number(10),
    title       varchar2(50),
    pubs        varchar2(30),
    pub_date    date,
    author_id   number(10),
    primary key(book_id),
    constraint c_book_fk foreign key (author_id)
    references author(author_id)
);


--시퀀스 생성
create sequence seq_author_id
increment by 1
start with 1;

create sequence seq_book_id
increment by 1
start with 1;


--데이터 입력-author
insert into author
values (seq_author_id.nextval, '이문열', '경상북도 영양');

insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');

SELECT *
FROM author;
    
--데이터 입력-book
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-01-22', 1);

insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 2);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values (seq_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);

SELECT *
FROM book;

--테이블 불러오기
SELECT
    b.book_id,
    b.title,
    b.pubs,
    to_char(b.pub_date, 'yyyy-mm-dd') pub_date,
    a.author_id,
    a.author_name,
    a.author_desc
FROM
    book b left outer join author a
    on b.author_id = a.author_id
ORDER BY b.book_id asc;
    
--정보 수정하기
update author
set author_desc = '서울특별시 강동구'
where author_name = '강풀';

--row 삭제하기
delete from book
where author_id = 
    (select author_id
    from author
    where author_name = '기안84');

delete from author
where author_name = '기안84';