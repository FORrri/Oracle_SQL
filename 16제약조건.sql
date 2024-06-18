--제약조건(컬럼에 대한 데이터 수정, 삭제, 삽입 등 이상을 방지하기 위한 조건)
--1. PRIMARY KEY: 테이블의 고유키, 중복(X), NULL(X), PK는 테이블에서 1개
--2. NOT NULL: NULL을 허용하지 않음
--3. UNIQUE KEY: 중복(X), NULL(O) ex.이메일,전화번호
--4. FOREIGN KEY: 참조하는 테이블의 PK를 넣어놓은 키, 중복(O), NULL(O)
--5. CHECK: 컬럼에 대한 데이터 제한

--전체 제약조건 확인(테이블에 직접 들어가서 마우스로 확인 가능)
SELECT * FROM USER_CONSTRAINTS;

DROP TABLE DEPTS;

--1ST (열레벨 제약조건 -> 빠름): CONSTRAINT + 이름까지 생략가능(생략하면 자동으로 이름생성)
CREATE TABLE DEPTS(
        DEPT_NO NUMBER(2)       CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY, --/*CONSTRAINT DEPT_NO_PK8*/
        DEPT_NAME VARCHAR2(30)  CONSTRAINT DEPTS_DEPT_NAME_NN NOT NULL,
        DEPT_DATE DATE          DEFAULT SYSDATE, --제약조건은 아니며 컬럼의 기본값 지정(DEFAULT)
        DEPT_PHONE VARCHAR2(30) CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE,
        DEPT_GENDER CHAR(1)     CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M') ), --CHECK 다음은 조건절(=WHERE)
        LOCA_ID NUMBER(4)       CONSTRAINT DEPTS_LOCA_ID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, NLLL, '010-5601-2435', 'F', 1700); -- NAME->NOT NULL 제약 위배

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'FORRI', '010-5601-2435', 'X', 1700); --CHECK 제약 위배

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'FORRI', '010-5601-2435', 'F', 100); --FK 참조 제약 위배(LOCATONS에 없음)

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'FORRI', '010-5601-2435', 'F', 1700); --성공

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(2, 'FORRI', '010-5601-2435', 'F', 1700); --UNIQUE 제약 위배(DEPT_PHONE)

--------------------------------------------------------------------------------
--2ND (테이블레벨 제약조건 정의 -> 정석) / 슈퍼키도 가능(2개이상 컬럼 선택 하는거)
DROP TABLE DEPTS;

DESC DEPTS;

CREATE TABLE DEPTS(
        DEPT_NO NUMBER(2),     
        DEPT_NAME VARCHAR2(30) NOT NULL, --NOT NULL은 열레벨 정의함(테이블레벨에서 굳이 할 필요 X) 
        DEPT_DATE DATE DEFAULT SYSDATE,        
        DEPT_PHONE VARCHAR2(30),
        DEPT_GENDER CHAR(1),
        LOCA_ID NUMBER(4),
        CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY(DEPT_NO /*,DEPT_NAME*/), --괄호 안에 컬럼명 / 슈퍼키는 테이블레벨로 지정 가능함
        CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE(DEPT_PHONE), -- /*CONSTRAINT DEPTS_DEPT_PHONE_UK*/
        CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M') ),
        CONSTRAINT DEPTS_LOCA_ID_FK FOREIGN KEY(LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID)
);
--------------------------------------------------------------------------------
--ALTER로 제약조건 추가
CREATE TABLE DEPTS(
        DEPT_NO NUMBER(2),     
        DEPT_NAME VARCHAR2(30),
        DEPT_DATE DATE DEFAULT SYSDATE,        
        DEPT_PHONE VARCHAR2(30),
        DEPT_GENDER CHAR(1),
        LOCA_ID NUMBER(4)
);
--PK추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_PK PRIMARY KEY (DEPT_NO);
--NOT NULL은 열 변경(MODIFY)로 추가합니다.
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(30) NOT NULL;
--UNIQUE추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_PHONE_UK UNIQUE (DEPT_PHONE);
--FK추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID);
--CHECK 추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F','M'));

--제약조건 삭제(제약조건 MODIFY는 없다!)
ALTER TABLE DEPTS DROP CONSTRAINT DEPT_DEPT_GENDER_CK; --제약조건명 드랍


--★ 이 모든것 DEPTS테이블 편집 창에서 마우스로 가능
--------------------------------------------------------------------------------
--문제1.
--
--다음과 같은 테이블을 생성하고 데이터를 insert해보세요.
--테이블 제약조건은 아래와 같습니다. 
--조건) M_NAME 는 가변문자형 20byte, 널값을 허용하지 않음
--조건) M_NUM 은 숫자형 5자리, PRIMARY KEY 이름(mem_memnum_pk) 
--조건) REG_DATE 는 날짜형, 널값을 허용하지 않음, UNIQUE KEY 이름:(mem_regdate_uk)
--조건) GENDER 고정문자형 1byte, CHECK제약 (M, F)
--조건) LOCA 숫자형 4자리, FOREIGN KEY ? 참조 locations테이블(location_id) 이름:(mem_loca_loc_locid_fk)
SELECT * FROM DEPTS;

CREATE TABLE DEPTS(
        M_NAME VARCHAR2(20) NOT NULL,
        M_NUM NUMBER(5),
        REG_DATE DATE NOT NULL,
        GENDER CHAR(1),
        LOCA NUMBER(4),
        
        CONSTRAINT mem_memnum_pk PRIMARY KEY (M_NUM),
        CONSTRAINT mem_regdate_uk UNIQUE (REG_DATE),
        CONSTRAINT gender_ck CHECK(GENDER IN ('M','F')),
        CONSTRAINT mem_loca_loc_locid_fk FOREIGN KEY(LOCA) REFERENCES LOCATIONS(location_id)
);

INSERT INTO DEPTS (M_NAME, M_NUM, REG_DATE, GENDER, LOCA)
VALUES('AAA', 1, '2018-07-01', 'M', 1800);

INSERT INTO DEPTS (M_NAME, M_NUM, REG_DATE, GENDER, LOCA)
VALUES('BBB', 2, '2018-07-02', 'F', 1900);

INSERT INTO DEPTS (M_NAME, M_NUM, REG_DATE, GENDER, LOCA)
VALUES('CCC', 3, '2018-07-03', 'M', 2000);

INSERT INTO DEPTS (M_NAME, M_NUM, REG_DATE, GENDER, LOCA)
VALUES('DDD', 4, '2018-07-04', 'M', 2000);

--문제2.
--
--도서 대여 이력 테이블을 생성하려 합니다.
--도서 대여 이력 테이블은
--대여번호(숫자) PK, 대출도서번호(문자), 대여일(날짜), 반납일(날짜), 반납여부(Y/N)
--를 가집니다.
--적절한 테이블을 생성해 보세요.




















































