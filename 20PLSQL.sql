--PLSQL(���α׷� SQL)
--������ F5���� ������ ���Ѽ� �����ŵ�ϴ�(CTRL+ENTER -> ��ü����)
--��±����� ���� ���๮
SET SERVEROUTPUT ON;
--�͸���
DECLARE
    V_NUM NUMBER; --���� ����
    V_NAME VARCHAR2(10) := 'ȫ�浿';
BEGIN
    V_NUM := 10;
--    V_NAME := 'ȫ�浿';
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || '���� ���̴�' || V_NUM || '�Դϴ�.'); --��� 
END; --���� �����ؼ� ���� F5(DECLARE ~ END)

--DML������ �Բ� ����� �� �ֽ��ϴ�.
--SELECT -> INSERT -> INSERT
DECLARE
    NAME VARCHAR2(30);
    SALARY NUMBER;
    LAST_NAME EMPLOYEES.LAST_NAME%TYPE; --%TYPE -> EMP���̺��� LAST_NAME�÷��� ������ Ÿ������ �����ϰ���.
BEGIN

    SELECT FIRST_NAME, LAST_NAME, SALARY 
    INTO NAME, LAST_NAME, SALARY --���� ����� ������ �����ϰڴٴ� ��
    FROM EMPLOYEES 
    WHERE EMPLOYEE_ID = 100;
    
     DBMS_OUTPUT.PUT_LINE(NAME);
     DBMS_OUTPUT.PUT_LINE(SALARY);
     DBMS_OUTPUT.PUT_LINE(LAST_NAME);

END;
--------------------------------------------------------------------------------
--2008�� �Ի��� ����� �޿� ����� ���ؼ� ���ο� ���̺� INSERT
CREATE TABLE EMP_SAL(
    YEARS VARCHAR2(50),
    SALARY NUMBER(10)
);
DECLARE
    YEARS VARCHAR2(50) := 2008;
    SALARY NUMBER;
BEGIN
    SELECT AVG(SALARY)
    INTO SALARY ---���� SALARY�� ����
    FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'YYYY') = YEARS;
    
    INSERT INTO EMP_SAL VALUES (YEARS, SALARY);
    COMMIT;

END;
--
SELECT * FROM EMP_SAL;
--------------------------------------------------------------------------------
SELECT * FROM EMPLOYEES;
--3. ��� ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� ��, 
--	 �� ��ȣ +1������ �Ʒ��� ����� emps���̺� employee_id, last_name, email, hire_date, job_id��  �ű� �Է��ϴ� �͸� ����� ����� ���ô�.
--<�����>   : steven
--<�̸���>   : stevenjobs
--<�Ի�����> : ���ó�¥
--<JOB_ID> : CEO

--CREATE TABLE EMPS_IT(
--    employee_id VARCHAR2(50),
--    last_name VARCHAR2(50),
--    email VARCHAR2(50),
--    hire_date DATE,
--    job_id VARCHAR2(50)
--); 

DECLARE
    NUM NUMBER;
BEGIN
    SELECT MAX(EMPLOYEE_ID)+1
    INTO NUM --NUM�� ����
    FROM EMPLOYEES;
    
    INSERT INTO EMPS_IT (employee_id, last_name, email, hire_date, job_id) 
    VALUES(NUM, 'STEVEN', 'STEVEN JOBS@NAVER.COM', SYSDATE, 'CEO');
    COMMIT;
    
END;

SELECT * FROM EMPS_IT;



































