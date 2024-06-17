--�������� (SELECT �������� Ư����ġ�� �ٽ� SELECT�� ���� ����)
--ó������ ���������� �ϳ��� ��� ����->���߿��� �ѹ��� ������ ������

--������ ��������: ���������� ����� 1���� ��������
--���ú��� �޿��� �������
--1. ������ �޿��� ã�´�. 2. ã�� �޿��� WHERE���� �ִ´�.

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy'; --12008
SELECT * FROM EMPLOYEES WHERE SALARY >= 12008;

SELECT * FROM EMPLOYEES WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--103���� ������ ���� ���
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT * FROM EMPLOYEES WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--��������1: ���� �÷��� ��Ȯ�� �Ѱ����� �մϴ�.(* �� ����)
SELECT * FROM EMPLOYEES --�� �� �������
WHERE JOB_ID = (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--��������2: �������� ������ �����̶��, ������ �������� �����ڸ� ������մϴ�.
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven'; --2��

SELECT * 
FROM EMPLOYEES 
WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');
--------------------------------------------------------------------------------
--������ ��������: ���������� ����� �������� ���ϵǴ� ��� IN, ANY, ALL

SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David'; --4800, 9500, 6800

--David�� �ּұ޿����� ���̹޴� ���(4800���� ū)
SELECT * 
FROM EMPLOYEES
WHERE SALARY > ANY(SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--David�� �ִ�޿����� ���Թ޴� ���(9500���� ����)
SELECT * 
FROM EMPLOYEES
WHERE SALARY < ANY(SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--David�� �ִ�޿����� ���̹޴� ���(9500���� ū)
SELECT * 
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--David�� �ּұ޿����� ���̹޴� ���(4800���� ����)
SELECT *
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--IN : ������ ��������, ��ġ�ϴ� ������(David�� �μ��� ����)
SELECT DEPARTMENT_ID
FROM EMPLOYEES WHERE FIRST_NAME = 'David'; -- 60,80,80

SELECT *
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                        FROM EMPLOYEES WHERE FIRST_NAME = 'David');
--------------------------------------------------------------------------------
--��Į�� ����: SELECT���� ���������� ���� ���(JOIN�� ��ü��)
SELECT FIRST_NAME,
        DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--��Į��� �ٲ㺸��(LEFT JOIN�� ����)
SELECT FIRST_NAME,
        (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID)AS DEPARTMENT_NAME
FROM EMPLOYEES E;

--��Į�������� �ٸ����̺��� 1���� �÷��� ������ �ö�, JOIN���� ������ ����մϴ�.
SELECT * FROM JOBS;

SELECT FIRST_NAME,
        JOB_ID,
        (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
FROM EMPLOYEES E;

--�ѹ��� �ϳ��� �÷��� �������� ������, ���� ���� ������ �ö��� ������ JOIN������ �������� ���� �� �ֽ��ϴ�.
SELECT FIRST_NAME,
        JOB_ID,
        (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
        (SELECT MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS MIN_SALARY
FROM EMPLOYEES E;

--����
SELECT * FROM DEPARTMENTS; --DEPARTMENT_NAME
SELECT * FROM JOBS; --JOB_TITLE
--FIRST_NAME�÷�, DEPARTMENT_NAME,JOB_TITLE�� ���ÿ� SELECT
SELECT FIRST_NAME,
        (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME,
        (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
FROM EMPLOYEES E;

--------------------------------------------------------------------------------
--�ζ��� ��: FROM ������ ������������ ���ϴ�.
--�ζ��� �信�� (�����÷�) �� �����, �� Į���� ���ؼ� ��ȸ�� ������ ����մϴ�.

SELECT *
FROM (SELECT *
        FROM EMPLOYEES);

--ROWNUM�� ��ȸ�� ������ ���� ��ȣ�� �ٽ��ϴ�.
SELECT ROWNUM,
        FIRST_NAME,
        SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;
 
--ORDER�� ���� ��Ų ����� ���ؼ� ����ȸ
SELECT ROWNUM, FIRST_NAME, SALARY
FROM (SELECT FIRST_NAME, SALARY
        FROM EMPLOYEES
        ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 11 AND 20; --ROWNUM�� Ư¡�� �ݵ�� 1���� �����ؾ���.(������)

--ORDER�� ���� ��Ų ����� �����, ROWNUM ���󿭷� �ٽ� �����, ����ȸ
SELECT *
FROM (
    SELECT ROWNUM AS RN, --����(���������� �����ѿ�)
            FIRST_NAME,
            SALARY
    FROM (
        SELECT FIRST_NAME
                SALARY
        FROM EMPLOYEES
        ORDER BY SALARY DESC)
    )
WHERE RN BETWEEN 11 AND 20;--�ȿ��� RN���� ������� ������ �ۿ��� ����� �� ����    

--����
--�ټӳ�� 5��° �Ǵ� ����鸸 ����ϰڴ�
SELECT FIRST_NAME,
        HIRE_DATE,
        TRUNC( (SYSDATE-HIRE_DATE) / 365) AS �ټӳ��
FROM EMPLOYEES
WHERE MOD(�ټӳ��, 5) = 0 --WHERE�� SELECT ���� ���� �ۿ��ϱ� ������ WHERE���� ����
ORDER BY �ټӳ�� DESC;

--�Ʒ�ó�� ����
SELECT *
FROM(SELECT FIRST_NAME, --�ȿ��� ���� ���󿭿� ���ؼ� ����ȸ �س��� �ζ��κ䰡 ����
        HIRE_DATE,
        TRUNC( (SYSDATE-HIRE_DATE) / 365) AS �ټӳ�� 
        FROM EMPLOYEES
        ORDER BY �ټӳ�� DESC)
WHERE MOD(�ټӳ��, 5) = 0;

--�ζ��� �信�� ���̺� ������� ��ȸ
SELECT ROWNUM AS RN,
        A.* 
FROM (SELECT E.*,
        TRUNC( (SYSDATE-HIRE_DATE) / 365) AS �ټӳ�� --����
      FROM EMPLOYEES E
      ORDER BY �ټӳ�� DESC
      ) A;






















































