insert into person values(1,'HONG', 'seoul 523-23'); 
insert into person values(2,'CHOI', 'seoul 212-3');

INSERT 
  INTO MEMBER
       (ID, PW, NAME, GENDER, EMAIL, ADDRESS, REGDATE)
VALUES ('admin', '1234', '관리자', 'Male', 'admin@rsupport.com', 'Seoul', CURRENT_TIMESTAMP());	

INSERT 
  INTO MEMBER
       (ID, PW, NAME, GENDER, EMAIL, ADDRESS, REGDATE)
VALUES ('user', '1234', '사용자', 'Male', 'user@rsupport.com', 'Incheon', CURRENT_TIMESTAMP());	
