CREATE TABLE EXAMPLE (
    EX_NUM VARCHAR2(30) PRIMARY KEY -- User does not have privileges to allocate an extent in the
                                    -- specified tablespace.(������ ������ġ�� tablespace �ʿ�)
);

INSERT INTO EXAMPLE VALUES('1');
DESC EXAMPLE;
SELECT * FROM EXAMPLE;
DROP TABLE EXAMPLE;