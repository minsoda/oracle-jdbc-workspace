 /*
 
    * ARTER
    - 객체를 수정하는 구문
    
    * 테이블 수정
    [표현법]
    ARTER TABLE 테이블명 수정할 내용;
    
    * 수정할 내용
    1. 컬럼 추가/수정/삭제
    2. 제약조건 추가/삭제 --> 수정은 불가 (수정하고자 한다면 삭제한 후 새로 추가)
    3. 테이블명/컬러명/제약조건명 변경
 */
 CREATE TABLE DEPT_COPY
 AS SELECT * FROM DEPARTMENT;
 
 SELECT * FROM DEPT_COPY;
 
 /*
 1) 컬럼 추가/ 수정 / 삭제 / 이름 변경
 1-1) 컬럼추가(ADD)
    ALTER TABLE 테이블명 ADD 컬럼명 데이터타입 [DEFAULT 기본값];
 */
 -- CNAME 컬럼 추가
 ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
 --> 새로운 컬럼이 만들어지고 기본적으로 NULL로 채워짐
 
 SELECT * FROM DEPT_COPY;
 
 -- LNAME 컬럼 추가 (기본값을 지정한채로)
 ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
 --> 새로운 컬럼이 만들어지고 내가 지정한 기본값으로 채워짐
 
 /*
 1_2) 컬럼 수정 (MODIFY)
    - 데이터 타입 변경 : ALTER TABLE 테이블명 MODIFY 컬럼명 변경할 데이터타입;
    - 기본값 변경 : ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT 변경할 기본값;
                --> DEFAULT NULL : DEFAULT 삭제
 */
 -- DEPT_ID 컬럼의 데이터 타입을 CHAR(3)으로 변경
 ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
 ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; -- 데이터 유형을 변경을 하려다보니 값이 있어서 오류 발생!
 ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10); --> 변경하려는 자료형의 크기보다 이미 큰 값이 존재해서 에러!

 ALTER TABLE DEPT_COPY MODIFY CNAME NUMBER; -- 값이 없으면 데이터타입 변경 가능! NULL값으로 설정되어있기 때문에
 
 -- 다중 수정
 -- DEPT_COPY 테이블에서 DEPT_TITLE 컬럼의 데이터 타입을 VARCHAR2(40),
 -- LOCATION_ID 컬럼의 데이터 타입을 VARCHARW(2),
 -- LNAME 컬럼의 기본값을 미국으로 변경
 ALTER TABLE DEPT_COPY 
        MODIFY DEPT_TITLE VARCHAR2(40)
        MODIFY LOCATION_ID VARCHAR2(2)
        MODIFY LNAME DEFAULT '미국'; -- 객체 수정이라서 데이터의 값은 유지, 테이블의 기본값만 변경
        
 
 DESC DEPT_COPY;
 
 /*
    1-3) 컬럼 삭제
    ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
    
    - 데이터 값이 기록되어 있어도 같이 삭제 (삭제된 컬럼 데이터 복구는 불가능)
    - 참조 되고 있는 컬럼이 있다면 삭제 불가능
    - 테이블에는 최소 한개의 컬럼은 존재해야함
 */
 ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;
 ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE; 
 ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID; 
 ALTER TABLE DEPT_COPY DROP COLUMN CNAME; 
 ALTER TABLE DEPT_COPY DROP COLUMN LNAME; -- 모든열은 삭제 불가! 한개의 컬럼이 존재해야함

ROLLBACK; -- 데이터와 관련된것이라 복구 안됨! 
 
 ALTER TABLE MEMBER_GRADE DROP COLUMN GRADE_CODE; -- 부모 키 열을 삭제할 수 없습니다
 --> 참조되고 있는 컬럼이 있다면 삭제 불가능!
 ALTER TABLE MEMBER_GARDE DROP COLUMN GRADE_CODE CASCADE CONSTRAINTS;
 -- ??????????????????????????????????
 
 /*
    1-4) 컬럼명 변경
    ALTER TABLE 테이블명 RENAME COLUMN 기존 컬럼명 TO 변경할 컬럼명;
 
 */
 -- DEPT_COPY 테이블의 LNAME 컬럼명을 LOCATION_NAME으로 변경
 ALTER TABLE DEPT_COPY RENAME COLUMN LNAME TO LOCATION_NAME;  

/*
    2) 제약조건 추가 / 삭제
    
    2-1) 제약조건 추가
    PRIMARY KEY : ADD [CONSTRAINT 제약조건명] PRIMARY KEY(컬럼명);
    FOREIGN KEY : ADD [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 테이블명 [(컬럼명)];
    UNIQUE : ADD [CONSTRAINT 제약조건명] UNIQUE(컬럼명);
    CHECK : ADD [CONSTRAINT 제약조건명] CHECK(컬럼에 대한 조건);
    NOT NLL : MODIFY 컬럼명 [CONSTRAINT 제약조건명] NOT NULL;
*/
DROP TABLE DEPT_COPY;
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

-- DEPT_COPY 테이블의 DEPT_ID 컬럼에 PK 제약조건 추가
ALTER TABLE DEPT_COPY 
        ADD CONSTRAINT DEPT_COPY_DEPT_ID_PK PRIMARY KEY(DEPT_ID);

/*
    2-2) 제약조건 삭제
        NOT NULL : ALTER TABLE 테이블명 MODIFY 컬럼명 NULL;
        나머지 : ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
*/
-- DEPT_COPY 테이블의 DEPT_COPY_ID_PK 제약조건 삭제
ALTER TABLE DEPT_COPY DROP CONSTRAINT DEPT_COPY_DEPT_ID_PK;

/*
    3) 컬럼명 / 제약조건명 / 테이블명  변경
    
    3_2) 제약조건명 변경
        ALTER TABLE 테이블명 RENAME CONSTRAINT 기존 제약조건명 TO 변경할 제약조건명;
*/
ALTER TABLE DEPT_COPY RENAME CONSTRAINT DEPT_COPY_DEPT_ID_PK TO DEPT_COPY_ID_PK;

SELECT UC.CONSTRAINT_NAME,
       UC.CONSTRAINT_TYPE,
       UC.TABLE_NAME,
       UCC.COLUMN_NAME
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
WHERE UCC.TABLE_NAME = 'DEPT_COPY'; -- 제약조건 확인가능

/*
    3_3) 테이블명 변경
        ALTER TABLE 기존테이블명 RENAME TO 변경할 테이블명;
        RENAME 기존 테이블명 TO 변경할 테이블명;
*/
-- DEPT_COPY => DEPT_TEST
 RENAME DEPT_COPY TO DEPT_TEST;

/*
    DROP
    -오라클에서 제공하는 객체를 삭제하는 구문
*/
-- DEPT_TEST 테이블 삭제
DROP TABLE DEPT_TEST;

-- 참조되고 있는 부모 테이블은 함부로 삭제가 되지 않는다.
DROP TABLE MEMBER_GRADE;

-- 만약 삭제하고자 한다면
-- 방법 1. 자식 테이블을 먼저 삭제한 후 부모테이블을 삭제하는 방법
DROP TABLE MEMBER;
DROP TABLE MEMBER_GRADE;

-- 방법 2. 그냥 부모테이블만 삭제하는데 제약조건까지 같이 삭제하는 방법
DROP TABLE MEMBER_GRADE CASCADE CONSTRAINTS;


 SELECT * FROM DEPT_TEST;
 SELECT * FROM MEMBER_GRADE;
 DROP TABLE MEMBER_GRADE;
 
 
 CREATE TABLE MEMBER_GRADE (
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(20) NOT NULL,
    CONSTRAINT MEMBER_GRADE_PK PRIMARY KEY(GRADE_CODE)
);
INSERT INTO MEMBER_GRADE VALUES(10, '일반회원');
INSERT INTO MEMBER_GRADE VALUES(20, '우수회원');
INSERT INTO MEMBER_GRADE VALUES(30, '특별회원');

SELECT * FROM MEMBER_GRADE;

-- 자식테이블

CREATE TABLE MEMBER (
    NO NUMBER,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15)NOT NULL,
    GENDER CHAR(3),
    AGE NUMBER,
    GRADE_ID NUMBER CONSTRAINT MEMBER_GRADE_ID_FK REFERENCES MEMBER_GRADE (GRADE_CODE),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO),
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남', '여')),
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE > 0));
    
    INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '문인수', '남', 25, 10, DEFAULT);
    INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, NULL, DEFAULT);
    
    SELECT * FROM MEMBER_GRADE;
    SELECT * FROM MEMBER;

 
 
 
 