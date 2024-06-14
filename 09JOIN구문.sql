SELECT * FROM INFO;
SELECT * FROM AUTH;

--INNER JOIN - ������ ���� �����ʹ� ������ ����
SELECT *
FROM INFO 
/*INNER*/ JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;

SELECT INFO.ID,
        INFO.TITLE,
        INFO.CONTENT,
        INFO.AUTH_ID, --AUTH_ID�� ������ �ִ� KEY, ���̺�.�÷��� ����
        AUTH.NAME
FROM INFO
INNER JOIN AUTH
ON INFO.AUTH_ID /*(FK)*/ = AUTH.AUTH_ID; /*(PK)*/

--���̺���� �ʹ� ���->ALIAS
SELECT I.ID,
        I.TITLE,
        A.AUTH_ID,
        A.NAME,
        A.JOB
FROM INFO I
INNER JOIN AUTH A
ON i.auth_id = a.auth_id;

--������ Ű�� ���ٸ� USING ������ ����� �� ����
SELECT *
FROM INFO
INNER JOIN AUTH A
USING (AUTH_ID);

--------------------------------------------------------------------------------
--OUTER JOIN(OUTER��������)
--��LEFT OUTER JOIN(���帹�̻��) - �������̺��� ������ �Ǽ�, ���� ���̺��� �ٳ���
SELECT * FROM INFO I LEFT JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT OUTER JOIN - ���������̺��� ������ �Ǽ�, ������ ���̺��� �ٳ���
SELECT * FROM INFO I RIGHT JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--RIGHT������ ���̺� �ڸ��� �ٲ��ָ� LEFT JOIN
SELECT * FROM AUTH A RIGHT OUTER JOIN INFO I ON A.AUTH_ID = I.AUTH_ID;

--FULL OUTER JOIN - ���ʵ����� �������� �ٳ���.
SELECT * FROM INFO I FULL JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

--CROSS JOIN (�߸��� ������ ���� - ������ ������ ����)
SELECT * FROM INFO I CROSS JOIN AUTH A;

--------------------------------------------------------------------------------
--SELF JOIN (�ϳ��� ���̺��� ������ ������ �Ŵ°� - ����: ���ᰡ���� KEY �������� / ����Լ�)
SELECT * FROM EMPLOYEES;

SELECT * 
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2
ON E.MANAGER_ID = E2.EMPLOYEE_ID;

--------------------------------------------------------------------------------
--����Ŭ ���� - ����Ŭ������ ����� �� �ְ�, ������ ���̺��� FROM�� ���ϴ�. ���������� WHERE�� ���ϴ�.

--����Ŭ INNER JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id = a.auth_id;

--����Ŭ LEFT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id = a.auth_id(+); --���� ���̺� +

--����Ŭ RIGHT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE i.auth_id(+) = a.auth_id;

--����Ŭ FULL OUTER JOIN�� ����

--����Ŭ CROSS JOIN(���� ������ ���������� ��Ÿ��)
SELECT*
FROM INFO I, AUTH A;

--------------------------------------------------------------------------------

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--������ ������ �� ���� ����
SELECT E.EMPLOYEE_ID,
        E.FIRST_NAME,
        D.DEPARTMENT_NAME,
        L.CITY
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE EMPLOYEE_ID >= 150;

--�Ϲ������� N���̺� 1���̺��� ���̴°� ���� ����
--1�� N�� ����
SELECT * FROM DEPARTMENTS D INNER JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;






























