 /*
    * DDL(Data Derinition Language) : 데이터 정의어
    - 오라클에서 제공하는 객체(Object) / 스키마(Schema)를 만들고 (CREATE), 변경하고(ALTER), 삭제(DROP)하는 언어
    - 즉, 실제 데이터 값이 아닌 구조 자체를 정의하는 언어
    - 주로 DB 관리자, 설계자가 사용
    
    * 오라클에서 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 
                          인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER), 프로시저(PROCEDURE), 
                          함수(FUNCTION), 동의어(SYNONYM),사용자(USER)
 */
 /*
    * CREATE
    - 객체를 생성하는 구문
    
    * 테이블 생성
    - 테이블이란? 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                데이터베이스 내에 모든 데이터는 테이블에 저장!
    [표현식]
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        ...
    );
    
    * 자료형
    1. 문자(CHAR / VACHAR2) - 반드시 크기를 지정
        - CHAR : 최대 2000BYTE까지 저장 가능
                고정 길이 (아무리 적은 값이 들어와도 처음 할당된 크기 그대로)
                고정된 글자수의 데이터만이 담길 경우 사용
        - VACHAR2 : 최대 4000BYTE까지 저장 가능
                가변 길이 (담긴 값에 따라서 공간의 크기 맞춰줌)
                몇글자의 데이터가 들어올지 모를 경우 사용
    2. 숫자(NUMBER)
    3. 날짜(DATE)
 */
 -- 회원에 대한 데이터를 담을 MEMBER 테이블 생성
 CREATE TABLE MEMBER(
 MEM_NO NUMBER,
 MEM_ID VARCHAR2(20),
 MEM_PWD VARCHAR2(20),
 MEM_NAME VARCHAR2 (20),
 GENDER CHAR(3),
 PHONE VARCHAR2(13),
 EMAIL VARCHAR2(50),
 MEM_DATE DATE
 );
 
 -- 테이블 구조를 표시해주는 구문
 DESC MEMBER;
 
 /*
    데이터 딕셔너리
    - 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
    - 사용자가 객체를 생성하거나 개체를 변경하는 등의 작업을 할 때 데이터베이스 서버에 의해서 자동으로 갱신되는 테이블
 */
 
 -- USER_TABLES : 사용자가 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 시스템 테이블
 SELECT * FROM USER_TABLES;
 
 SELECT * 
 FROM USER_TABLES 
 WHERE TABLE_NAME = 'MEMBER';
 
 -- USER_TAB_COLUMNS : 사용자가 가지고 있는 테이블 상의 모든 컬럼의 전반적인 구조를 확인할 수 있는 시스템 테이블
 SELECT * FROM USER_TAB_COLUMNS;
 
 /*
    컬럼 주석
    - 테이블 컬럼에 대한 설명을 작성할 수 있는 구문
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
 */
 COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
 COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
 COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
 COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
 COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
 COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
 COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
 COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';
 
 -- 테이블에 데이터 추가시키는 구문 (DML : INSERT)
 -- INSERT INTO 테이블명 VALUES(값, 값, 값, ...);
 INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'aaa@naver.com', '23/06/26');
 INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', '홍길녀', '여', null, NULL, SYSDATE);
 INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
 
 SELECT * FROM MEMBER;
 
 /*
    *제약조건(CONSTRAINTS)
    - 사용자가 원하는 조건의 데이터만 유지하기 위해서 각 컬럼에 대해 저장될 값에 대한 제약조건을 설정
    - 제약조건은 데이터 무결성 보장을 목적으로 한다.
    (데이터의 정확성과 일관성을 유지시키는 것)
    - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
 
    [표현법]
     1) 컬럼 레벨 방식
    CREATE TABLE 테이블명(
    컬럼명 자료형(크기) [CONSTRAINT 제약조건명] 제약조건,
    .....
    );
    
    2)테이블 레벨 방식
    CREATE TABLE 테이블명(
    컬럼명 자료형(크기),
    ...
    [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
    );
 
 */
 /*
    * NOT NULL 제약조건
    - 해당 컬럼에 반드시 값이 존재해야만 하는 경우
    (즉, 해당 컬럼에 절대 NULL이 들어와서는 안되는 경우)
    - 삽입/수정시 NULL 값을 허용하지 않도록 제한
    - 오로지 컬럼 레벨 방식으로만 설정 가능!!
 */
 CREATE TABLE MEM_NOTNULL(
 MEM_NO NUMBER NOT NULL,
 MEM_ID VARCHAR2(20) NOT NULL,
 MEM_PWD VARCHAR2(20) NOT NULL,
 MEM_NAME VARCHAR2(20) NOT NULL,
 GENDER CHAR(3),
 PHONE VARCHAR2(13),
 EMAIL VARCHAR2(50)
 );
 
 INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', '홍길동', '남', null, null);
 INSERT INTO MEM_NOTNULL VALUES(2, 'user01', null , '김말순', '여', null, 'aaa@naver.com');
 
 --> NOT NULL 제약조건에 위배되어 오류 발생!
-- INSERT INTO MEM_NOTNULL VALUES()
 SELECT * FROM MEM_NOTNULL;
 
 INSERT INTO MEM_NOTNULL VALUES(2, 'user01','pass02', '강개똥', null, null, null); 
 
 /*
    UNIQUE 제약조건
    - 해당 컬럼에 중복된 값이 들어와서는 안되는 경우
    - 컬럼값에 중복값을 제한하는 제약조건
    - 삽입/수정시 기존에 있는 데이터값 중 중복값이 있을 경우 오류 발생
 */
 -- 컬럼 레벨 방식
 CREATE TABLE MEM_UNIQUE(
  MEM_NO NUMBER NOT NULL,
  MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3),
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50)
 );
 
 -- 테이블 삭제
 DROP TABLE MEM_UNIQUE;
 
 -- 테이블 레벨 방식 : 모든 컬럼들 다 나열 후 마지막에 기술
  CREATE TABLE MEM_UNIQUE(
  MEM_NO NUMBER NOT NULL,
  MEM_ID VARCHAR2(20) NOT NULL,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3),
  PHONE VARCHAR2(13),
  EMAIL VARCHAR2(50),
  UNIQUE(MEM_ID)
 );
 
 INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', null, null, null);
 INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '강개똥', null, null, null);
 --> UNIQUE 제약조건에 위배되었으므로 insert 실패!
 --> 오류 구문에 제약조건명으로 알려줌!
 --> 제약조건 부여시 제약조건명을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명을 부여해버림
 
 /*
    * 제약조건 부여시 제약조건명까지 지어주는 방법
    > 컬러레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건, 
        ...
    );
    
    > 테이블레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        ...,
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    );
 */
 DROP TABLE MEM_UNIQUE;
 
 CREATE TABLE MEM_UNIQUE(
   MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
   MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
   MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
   MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
   GENDER CHAR(3),
   PHONE VARCHAR2(13),
   EMAIL VARCHAR2(50),
   CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
 );
 
 INSERT INTO MEM_UNIQUE VALUES (1, 'user01', 'pass01', '홍길동', null, null, null);
 INSERT INTO MEM_UNIQUE VALUES (2, 'user02', 'pass02', '홍길녀', 'ㅇ', null, null);
 
 SELECT * FROM MEM_UNIQUE;
 
 /*
    CHECK(조건식) 제약조건
    - 해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해볼 수 있음!
    - 해당 조건에 만족하는 데이터값만 담길 수 있음
 */
 DROP TABLE MEM_CHECK;
 
 CREATE TABLE MEM_CHECK(
   MEM_NO NUMBER NOT NULL,
   MEM_ID VARCHAR2(20) NOT NULL,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK(GENDER IN ('남','여')) NOT NULL,  -- 조건
   PHONE VARCHAR2(13),
   EMAIL VARCHAR2(50)
 );
 
 INSERT INTO MEM_CHECK VALUES (1, 'user01', 'pass01', '홍길동', '남', null, null); -- 삽입안됨
 INSERT INTO MEM_CHECK VALUES (2, 'user02', 'pass02', '홍길녀', 'ㅇ', null, null); -- 삽입안됨
 INSERT INTO MEM_CHECK VALUES (2, 'user02', 'pass02', '홍길녀', '여', null, null); -- 삽입안됨
 
 SELECT * FROM MEM_CHECK;
 
 INSERT INTO MEM_CHECK VALUES (2, 'user03', 'pass03', '강개순', '여', null, null);
 
 /*
    PRIMARY KEY(기본키) 제약조건
    - 테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건(식별자 역할)
    EX) 회원번호, 학번, 사원번호, 부서코드, 직급코드, 주문번호, 예약번호, 운송장번호, ...
  - PRIMARY KEY 제약조건을 부여하면 그 컬럼에 자동으로  NOT NULL + UNIQUE 제약조건이 설정
  - 한 테이블 당 오로지 한 개만 설정 가능
 */
 CREATE TABLE MEM_PRI(
   MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, --> 컬럼레벨방식
   MEM_ID VARCHAR2(20) NOT NULL,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK(GENDER IN ('남','여')) NOT NULL,
   PHONE VARCHAR2(13),
   EMAIL VARCHAR2(50)
--   CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) --> 테이블 레벨 방식
 );
 
 INSERT INTO MEM_PRI VALUES (1, 'user01', 'pass01', '강개순', '여', '010-1111-2222', null);

 INSERT INTO MEM_PRI VALUES (1, 'user02', 'pass02', '이순신', '남', null, null);-- 삽입안됨, 무결성 제약 조건(DDL.MEMNO_PK)에 위배됩니다
 --> 기본키 중복값을 담으려고 할 때(unique 제약조건 위배)
 
 INSERT INTO MEM_PRI VALUES (null, 'user02', 'pass02', '이순신', '남', null, null);-- 삽입안됨.  NOT NULL + UNIQUE 제약조건이 설정되어서!
 --> 기본키 null을 담으려고 할 때 (not null 제약조건 위배)
 
 INSERT INTO MEM_PRI VALUES (2, 'user02', 'pass02', '이순신', '남', null, null);
 
 SELECT * FROM MEM_PRI;
 
 DROP TABLE MEM_PRI2;
  CREATE TABLE MEM_PRI2(
   MEM_NO NUMBER,
   MEM_ID VARCHAR2(20) NOT NULL,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3),
   PHONE VARCHAR2(13),
   EMAIL VARCHAR2(50),
   PRIMARY KEY(MEM_NO, MEM_ID) --> 묶어서 PRIMARY KEY 제약조건 부여 (복합키)
 );
 
 INSERT INTO MEM_PRI2 VALUES (1, 'user01', 'pass01', '홍길동', null, null, null);
 INSERT INTO MEM_PRI2 VALUES (1, 'user02', 'pass02', '홍길녀', null, null, null);
 
 -- 복합키 사용 예시(어떤 회원이 어떤 상품을 찜하는지에 대한 데이터를 보관하는 테이블)
 CREATE TABLE TB_LIKE(
 MEM_NO NUMBER, 
 PRODUCT_NAME VARCHAR2(10),
 LIKE_DATE DATE,
 PRIMARY KEY(MEM_NO, PRODUCT_NAME)
 );
 
 INSERT INTO TB_LIKE VALUES (1, 'A', SYSDATE);
 INSERT INTO TB_LIKE VALUES (1, 'B', SYSDATE);
 INSERT INTO TB_LIKE VALUES (1, 'A', SYSDATE); -- 삽입 안됨. 복합키 기준으로 되어있어서!
 
 
 -- 회원등급에 대한 데이터를 보관하는 테이블
 CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
 );
 
 INSERT INTO MEM_GRADE VALUES(10, '일반회원');
 INSERT INTO MEM_GRADE VALUES(20, '우수회원');
 INSERT INTO MEM_GRADE VALUES(30, '특별회원');
 
 SELECT * FROM MEM_GRADE;
 
 CREATE TABLE MEM(
   MEM_NO NUMBER PRIMARY KEY,
   MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
   PHONE VARCHAR2(13),
   EMAIL VARCHAR2(50),
   GRADE_ID NUMBER --> 회원등급번호 보관할 컬럼
 );
 
 INSERT INTO MEM VALUES (1, 'user01', 'pass01', '홍길순', '여', null, null, null);
 INSERT INTO MEM VALUES (2, 'user02', 'pass02', '김말똥', null, null, null, 10);
 INSERT INTO MEM VALUES (3, 'user03', 'pass03', '강개순', '남', null, null, 40);
 
 --> 유효한 회원등급번호가 아님에도 불구하고 ISER!  아직 연결 X
 SELECT * FROM MEM;
 
 /*
    * FOREIGN KEY(외래키) 제약조건
    - 외래키 역할을 하는 컬럼에 부여하는 제약조건
    - 다른 테이블에 존재하는 값만 들어와야하는 특정 컬럼에 부여하는 제약조건(단, NULL 값도 가질 수 있음)
    
    --> 다른 테이블을 참조한다고 표현
    --> 주로 FOREIGN KEY 제약조건에 의해 테이블 간의 관계가 형성!
    [표현법]
    > 컬럼레벨방식
    컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조테이블명 [(참조할컬럼명)]
    
    > 테이블레벨방식
    [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(참조할컬럼명)]
 
    --> 참조할 컬럼명 생략시 참조할테이블명에 PRIMARY KEY로 지정된 컬럼으로 매칭
 */
 
 DROP TABLE MEM;
 
 CREATE TABLE MEM(
   MEM_NO NUMBER PRIMARY KEY,
   MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
   PHONE VARCHAR2(13),
   EMAIL VARCHAR2(50),
   GRADE_ID NUMBER REFERENCES MEM_GRADE --(GRADE_CODE) 생략가능--> 컬럼레벨방식
-- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --> 테이블레벨방식
 );
 
 INSERT INTO MEM VALUES (1, 'user01', 'pass01', '홍길순', '여', null, null, null);
 INSERT INTO MEM VALUES (2, 'user02', 'pass02', '김말똥', null, null, null, 10);
 INSERT INTO MEM VALUES (3, 'user03', 'pass03', '강개순', '남', null, null, 40); -- 부모 키가 없습니다. 40이라서!
 
 SELECT * FROM MEM;
 
 -- MEM_GRADE(부모테이블) -|-----------<- MEM(자식테이블)
 --> 이때 부모테이블(MEM_GRADE)에서 데이터값을 삭제할 경우 문제 발생!
 -- 데이터 삭제 : DELETE FROM 테이블명 WHERE 조건;
 
 --> MEM_GRADE 테이블에서 10번 등급 삭제!
 DELETE FROM MEM_GRADE WHERE GRADE_CODE = 10; 
 
 DELETE FORM MEM_GRADE WHERE GRADE_CODE = 30;
 --> 자식테이블이 이미 사용하고 있는 값이 있을 경우 부모테이블로부터 무조건 삭제가 안되는 "삭제제한" 옵션이 걸려있음
 
 ROLLBACK;
 
 SELECT * FROM MEM_GRADE;
 
 /*
    자식테이블 생성시 외래키 제약조건 부여할 때 삭제옵션 지정가능
    * 삭제옵션 : 부모테이블의 데이터 삭제 시 그 데이터를 사용하고 있는 자식테이블의 값을 어떻게 처리할 건지
    - ON DELETE RESTRICTED(기본값)
    : 삭제제한옵션으로, 자식데이터로 쓰이는 부모데이터는 삭제 아예 안되게끔
    - ON DELETE SET NULL
    : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터의 값을 NULL로 변경
    - ON DELETE CASCADE
    : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터도 같이 삭제 시킴
 */
  DROP TABLE MEM;
  
  CREATE TABLE MEM(
   MEM_NO NUMBER PRIMARY KEY,
   MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
   MEM_PWD VARCHAR2(20) NOT NULL,
   MEM_NAME VARCHAR2(20) NOT NULL,
   GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
   PHONE VARCHAR2(13),
   EMAIL VARCHAR2(50),
   GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE SET NULL
 );
 
 INSERT INTO MEM VALUES (1, 'user01', 'pass01', '홍길순', '여', null, null, null);
 INSERT INTO MEM VALUES (2, 'user02', 'pass02', '김말똥', null, null, null, 10);

 
  DELETE FROM MEM_GRADE WHERE GRADE_CODE = 10;
 
  ROLLBACK;
 
  SELECT * FROM MEM_GRADE;
  SELECT * FROM MEM; -- 10을 삭제해서 NULL로 표현
 
 
 