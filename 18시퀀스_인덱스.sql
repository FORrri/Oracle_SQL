--������ (���������� �����ϴ� ��)
--�ַ� PK�� ����� �� �ֽ��ϴ�.

SELECT * FROM USER_SEQUENCES;

--�ڽ����� ����(�ſ� �߿�)
CREATE SEQUENCE DEPTS_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    NOCACHE --ĳ�ÿ� �������� ���� ����
    NOCYCLE; --�ִ밪�� �������� �� ����X

--����
DROP TABLE DEPTS;
CREATE TABLE DEPTS(
        DEPT_NO NUMBER(2) PRIMARY KEY,
        DEPT_NAME VARCHAR(30)
);
--������ ����� 2��
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --���� ������ Ȯ��(NEXTVAL ���� �Ǿ����)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; --���� ������ ��������ŭ ����

SELECT * FROM DEPTS;

--������ ����
INSERT INTO DEPTS VALUES( DEPTS_SEQ.NEXTVAL, 'EXAPMPLE' );

--������ ����
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

--�������� �̹� ���ǰ� �ִٸ�, DROP�ϸ� �ȵ˴ϴ�.
--���� �������� �ʱ�ȭ �ؾ��Ѵٸ�?
--�������� �������� -������ ���� �ʱ�ȭ �ΰ�ó�� ������ �ֽ��ϴ�.
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;

--1. �������� ������ -(���簪-1) �� �ٲ�
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -49;
--2. ���� �������� ����
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--3.�ٽ� �������� 1�� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--------------------------------------------------------------------------------
--�������� ���� (���߿� ���̺��� �����Ҷ�, �����Ͱ� ��û��û ���ٸ� PK�� �������� ��� ���)
--���ڿ� PK(�⵵��-�Ϸù�ȣ)

CREATE TABLE DPETS2(
    DEPT_NO VARCHAR2(20) PRIMARY KEY,
    DEPT_NAME VARCHAR2(20)
);

INSERT INTO DPETS2 VALUES( TO_CHAR(SYSDATE, 'YYYY-MM-') || LPAD(DEPTS_SEQ.NEXTVAL, 6, 0), 'EXAMPLE');

SELECT * FROM DPETS2;
--������ ����
DROP SEQUENCE DEPTS_SEQ;
DROP SEQUENCE ��������;

--------------------------------------------------------------------------------
--INDEX
--INDEX�� PK, UNIQUE�� �ڵ����� �����ǰ�, ��ȸ�� ������ �ϴ� HINT������ �մϴ�.
--INDEX������ �����ε���, ������ε���
--UNIQUE�� �÷����� UNIQUE�ε���(����) �ε����� ���Դϴ�.
--�Ϲ��÷����� ����� �ε����� ������ �� �ֽ��ϴ�.
--INDEX�� ��ȸ�� ������ ������, DML ����(����,����)�� ���� ���Ǵ� �÷��� ������ �������ϸ� �θ� ���� �ֽ��ϴ�.

--�ε��� ����
CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES);

--�ε����� ���� �� ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy'; --F10���� ��ȸ�ϸ� OPTIONS: FULL

--����� �ε��� ���� (����)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME);

--�ε��� ������ FIRST_NAME���� �ٽ� ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy'; --F10���� ��ȸ�ϸ� OPTIONS:BY INDEX ROWID / COST�� ����

--�ε��� ���� (�ε����� �����ϴ��� ���̺� ������ ��ġ�� �ʽ��ϴ�)
DROP INDEX EMPS_IT_IX;

--�����ε��� (������ �÷��� ���ÿ� �ε����� ����)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME, LAST_NAME);

SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy'; --��Ʈ ����
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg'; --��Ʈ ����
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Greenberg'; --��Ʈ ����

--�����ε��� (PK, UNIQUE���� �ڵ������� - ���� ���� �ʿ� ����)
--CREATE UNIQUE INDEX �ε�����~~~~~
