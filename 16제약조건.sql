--��������(�÷��� ���� ������ ����, ����, ���� �� �̻��� �����ϱ� ���� ����)
--1. PRIMARY KEY: ���̺��� ����Ű, �ߺ�(X), NULL(X), PK�� ���̺��� 1��
--2. NOT NULL: NULL�� ������� ����
--3. UNIQUE KEY: �ߺ�(X), NULL(O) ex.�̸���,��ȭ��ȣ
--4. FOREIGN KEY: �����ϴ� ���̺��� PK�� �־���� Ű, �ߺ�(O), NULL(O)
--5. CHECK: �÷��� ���� ������ ����

--��ü �������� Ȯ��(���̺� ���� ���� ���콺�� Ȯ�� ����)
SELECT * FROM USER_CONSTRAINTS;

DROP TABLE DEPTS;

--1ST (������ �������� -> ����): CONSTRAINT + �̸����� ��������(�����ϸ� �ڵ����� �̸�����)
CREATE TABLE DEPTS(
        DEPT_NO NUMBER(2)       CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY, --/*CONSTRAINT DEPT_NO_PK8*/
        DEPT_NAME VARCHAR2(30)  CONSTRAINT DEPTS_DEPT_NAME_NN NOT NULL,
        DEPT_DATE DATE          DEFAULT SYSDATE, --���������� �ƴϸ� �÷��� �⺻�� ����(DEFAULT)
        DEPT_PHONE VARCHAR2(30) CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE,
        DEPT_GENDER CHAR(1)     CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M') ), --CHECK ������ ������(=WHERE)
        LOCA_ID NUMBER(4)       CONSTRAINT DEPTS_LOCA_ID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, NLLL, '010-5601-2435', 'F', 1700); -- NAME->NOT NULL ���� ����

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'FORRI', '010-5601-2435', 'X', 1700); --CHECK ���� ����

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'FORRI', '010-5601-2435', 'F', 100); --FK ���� ���� ����(LOCATONS�� ����)

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'FORRI', '010-5601-2435', 'F', 1700); --����

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(2, 'FORRI', '010-5601-2435', 'F', 1700); --UNIQUE ���� ����(DEPT_PHONE)

--------------------------------------------------------------------------------
--2ND (���̺��� �������� ���� -> ����) / ����Ű�� ����(2���̻� �÷� ���� �ϴ°�)
DROP TABLE DEPTS;

DESC DEPTS;

CREATE TABLE DEPTS(
        DEPT_NO NUMBER(2),     
        DEPT_NAME VARCHAR2(30) NOT NULL, --NOT NULL�� ������ ������(���̺������� ���� �� �ʿ� X) 
        DEPT_DATE DATE DEFAULT SYSDATE,        
        DEPT_PHONE VARCHAR2(30),
        DEPT_GENDER CHAR(1),
        LOCA_ID NUMBER(4),
        CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY(DEPT_NO /*,DEPT_NAME*/), --��ȣ �ȿ� �÷��� / ����Ű�� ���̺����� ���� ������
        CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE(DEPT_PHONE), -- /*CONSTRAINT DEPTS_DEPT_PHONE_UK*/
        CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M') ),
        CONSTRAINT DEPTS_LOCA_ID_FK FOREIGN KEY(LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID)
);
--------------------------------------------------------------------------------
--ALTER�� �������� �߰�
CREATE TABLE DEPTS(
        DEPT_NO NUMBER(2),     
        DEPT_NAME VARCHAR2(30),
        DEPT_DATE DATE DEFAULT SYSDATE,        
        DEPT_PHONE VARCHAR2(30),
        DEPT_GENDER CHAR(1),
        LOCA_ID NUMBER(4)
);
--PK�߰�
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_PK PRIMARY KEY (DEPT_NO);
--NOT NULL�� �� ����(MODIFY)�� �߰��մϴ�.
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(30) NOT NULL;
--UNIQUE�߰�
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_PHONE_UK UNIQUE (DEPT_PHONE);
--FK�߰�
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID);
--CHECK �߰�
ALTER TABLE DEPTS ADD CONSTRAINT DEPT_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F','M'));

--�������� ����(�������� MODIFY�� ����!)
ALTER TABLE DEPTS DROP CONSTRAINT DEPT_DEPT_GENDER_CK; --�������Ǹ� ���


--�� �� ���� DEPTS���̺� ���� â���� ���콺�� ����
--------------------------------------------------------------------------------
--����1.
--
--������ ���� ���̺��� �����ϰ� �����͸� insert�غ�����.
--���̺� ���������� �Ʒ��� �����ϴ�. 
--����) M_NAME �� ���������� 20byte, �ΰ��� ������� ����
--����) M_NUM �� ������ 5�ڸ�, PRIMARY KEY �̸�(mem_memnum_pk) 
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, UNIQUE KEY �̸�:(mem_regdate_uk)
--����) GENDER ���������� 1byte, CHECK���� (M, F)
--����) LOCA ������ 4�ڸ�, FOREIGN KEY ? ���� locations���̺�(location_id) �̸�:(mem_loca_loc_locid_fk)
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

--����2.
--
--���� �뿩 �̷� ���̺��� �����Ϸ� �մϴ�.
--���� �뿩 �̷� ���̺���
--�뿩��ȣ(����) PK, ���⵵����ȣ(����), �뿩��(��¥), �ݳ���(��¥), �ݳ�����(Y/N)
--�� �����ϴ�.
--������ ���̺��� ������ ������.




















































