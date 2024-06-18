--INSERT
--���̺� ������ ������ Ȯ���ϴ� ���
DESC DEPARTMENTS;

--��1ST
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER', NULL, 1700);

SELECT * FROM DEPARTMENTS;

--DML���� Ʈ������� �׻� ��ϵǴµ�,ROLLBACK�̿��ؼ� �ǵ��� �� ����
ROLLBACK; 
--��2ND(�÷��� ��������)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280, 'DEVELOPER', 1700);

--INSERT������ �������� �˴ϴ�(���� ��������� ����) -> ���ϰ�
INSERT INTO DEPARTMNETS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES ( (SELECT MAX(DEPARTMENT_ID) + 10 FROM DEPARTMENTS) ,'DEV');
ROLLBACK; 
--INSERT������ ��������- > ������
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); --���̺� ���� ����

SELECT * FROM EMPS; --������ ���̺�(�� ���̺��� �������̺��� Ư�� �����͸� �۴� ����)

INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');

COMMIT; --Ʈ�������� �ݿ���

--------------------------------------------------------------------------------
--UPDATE
SELECT * FROM EMPS;

--�ھ�����Ʈ ������ ����ϱ� ������ SELECT�� �ش簪�� ������ ������ Ȯ���ϰ�, ������Ʈ ó���ؾ��մϴ�.
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148; --KEY�� ���ǿ� ���°� �Ϲ����Դϴ�.
UPDATE EMPS SET SALARY = NVL(SALARY, 0) + 1000 WHERE EMPLOYEE_ID >= 145;

--������Ʈ������ ����������
--1ST(���ϰ� ��������)
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;

--2ND(������ ��������)
UPDATE EMPS 
SET(SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
= ( SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100)
WHERE EMPLOYEE_ID = 148;

--3ND(WHERE���� ��)
UPDATE EMPS
SET SALARY = 1000
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
--------------------------------------------------------------------------------
--DELECT����
--Ʈ�������� �ֱ� ������, �����ϱ����� �ݵ�� SELECT������ ���� ���ǿ� �ش��ϴ� �����͸� �� Ȯ���ϴ� ������ ������
SELECT * FROM EMPS;

SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;

DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; --KEY�� ���ؼ� ����� ���� �����ϴ�.
--DELETE������ ��������
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 90);
ROLLBACK;
--------------------------------------------------------------------------------
--DELETE���� ���� ����Ǵ� ���� �ƴմϴ�.
--���̺��� ��������(KEY)������ ������ �ִٸ�, �������� �ʽ��ϴ�(�������Ἲ ����)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 100; --EMPLOYEES���� 100�� �����͸� FK�� ����ϰ� �־ �������Ἲ ����
--------------------------------------------------------------------------------
--MERGE����: Ÿ�����̺� �����Ͱ� ������ UPDATE, ������ INSERT������ �����ϴ� ����
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
SELECT * FROM EMPS;

--1ST
MERGE INTO EMPS A --Ÿ�����̺�
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B --��ĥ���̺�
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID) --������ Ű
WHEN MATCHED THEN --��ġ�ϴ°��
    UPDATE SET A.SALARY = B.SALARY,
                A.COMMISSION_PCT = B.COMMISSION_PCT,
                A.HIRE_DATE = SYSDATE
                --.....����
WHEN NOT MATCHED THEN --��ġ�����ʴ°��
    INSERT /*INTO*/ (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) --NULL�� ���ִ°Ŵ� �ʼ��� () �ȿ� �ֱ�
    VALUES (B.EMPLOYEE_ID, B.LAST_NAME, B.EMAIL, B.HIRE_DATE, B.JOB_ID);

SELECT * FROM EMPS;
ROLLBACK;
--2ND: ������������ �ٸ����̺��� �������°� �ƴ϶�, ���� ���� ������ DUAL�� ������ �ֽ��ϴ�.(USING DUAL ���)
MERGE INTO EMPS A
USING DUAL
ON(A.EMPLOYEE_ID = 107) --����
WHEN MATCHED THEN --��ġ�ϸ�
    UPDATE SET A.SALARY = 10000,
                A.COMMISSION_PCT = 0.1,
                A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN --��ġ���� ������
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (107,'HONG', 'EXAMPLE', SYSDATE, 'DBA');

SELECT * FROM EMPS;
ROLLBACK;
--------------------------------------------------------------------------------
DROP TABLE EMPS;

--CTAS: ���̺� ���� ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES); --�����ͱ��� ����

CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); --������ ����

SELECT * FROM EMPS;
--------------------------------------------------------------------------------
--���� 1.
--DEPTS���̺��� �����͸� �����ؼ� �����ϼ���.
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);
--DEPTS���̺��� ������ INSERT �ϼ���.
SELECT * FROM DEPTS;

INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
                        VALUES(280, '����', NULL, 1800);
INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
                        VALUES(290, 'ȸ���', NULL, 1800);
INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
                        VALUES(300, '����', 301, 1800);
INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
                        VALUES(310, '�λ�', 302, 1800);
INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
                        VALUES(320, '����', 303, 1700);
SELECT * FROM DEPTS;
--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
SELECT * FROM DEPTS;
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT bank' WHERE DEPARTMENT_NAME = 'IT Support';

--2. department_id�� 290�� �������� manager_id�� 301�� ����
UPDATE DEPTS SET MANAGER_ID = 301 WHERE DEPARTMENT_ID = 290;

--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
UPDATE DEPTS SET department_name = 'IT Help',
                MANAGER_ID = 303,
                LOCATION_ID = 1800
WHERE department_name = 'IT Helpdesk';

--4. �μ���ȣ (290, 300, 310, 320) �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
UPDATE DEPTS SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

UPDATE DEPTS SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 300;

UPDATE DEPTS SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 310;

UPDATE DEPTS SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 320;

--
UPDATE DEPTS SET MANAGER_ID = 301
WHERE DEPARTMENT_ID IN (290,300,310,320);

--
--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
SELECT * FROM DEPTS;
--1. �μ��� �����θ� ���� �ϼ��� DEPARTMENT_NAME = ����
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = '����';

DELETE FROM DEPTS WHERE DEPARTMENT_NAME = '����';

--
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320; --KEY������ �����ִ°� ����.

--2. �μ��� NOC�� �����ϼ���
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC';

DELETE FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC';

--
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 220; --KEY������ �����ִ°� ����.

--����4
CREATE TABLE COPYDEPTS AS (SELECT * FROM DEPTS); --�����ͱ��� ����
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� ������ ������.
SELECT * FROM COPYDEPTS;

SELECT * FROM COPYDEPTS WHERE DEPARTMENT_ID > 200;

DELETE FROM COPYDEPTS WHERE DEPARTMENT_ID > 200;

--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
UPDATE COPYDEPTS SET manager_id = 100 WHERE manager_id IS NULL;

--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�, �������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
SELECT * FROM DEPTS;

MERGE INTO DEPTS A
USING (SELECT * FROM DEPARTMENTS) B 
ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID) 
WHEN MATCHED THEN 
    UPDATE SET A.DEPARTMENT_NAME = B.DEPARTMENT_NAME,
                A.MANAGER_ID = B.MANAGER_ID,
                A.LOCATION_ID = LOCATION_ID
WHEN NOT MATCHED THEN 
    INSERT VALUES (B.DEPARTMENT_ID,
                    B.DEPARTMENT_NAME,
                    B. MANAGER_ID,
                    B.LOCATION_ID);

--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000); 

--2. jobs_it ���̺� �Ʒ� �����͸� �߰��ϼ���
INSERT INTO JOBS_IT VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO JOBS_IT VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO JOBS_IT VALUES('SEC_DEV', '���Ȱ�����', 6000, 20000);

SELECT * FROM JOBS_IT;

--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.

MERGE INTO JOBS_IT J1
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) J2
ON (J1.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET J1.MIN_SALARY = J2.MIN_SALARY,
                J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES (
                J2.JOB_ID,
                J2.JOB_TITLE,
                J2.MIN_SALARY,
                J2.MAX_SALARY);

SELECT * FROM JOBS_IT;




















































