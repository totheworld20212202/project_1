SHOW DATABASES;
SHOW TABLES;
DESC pp01_user;
#####################################################################
						     DROP TABLE 
#####################################################################
DROP TABLE pp01_file;
DROP TABLE pp01_write_student; 
DROP TABLE pp01_write_student_files; 
DROP TABLE pp01_users;
DROP TABLE authority;
DROP TABLE pp01_authority;
DROP TABLE pp01_home_work;
#####################################################################
						 		SELECT 
#####################################################################
SELECT * FROM pp01_user_lectures;
SELECT * FROM pp01_user_lectures;
SELECT * FROM pp01_user;
SELECT * FROM pp01_hwsubmitted_by_stud; 
SELECT * FROM pp01_lecture;
SELECT * FROM pp01_lecture_users;
SELECT * FROM pp01_authority;
SELECT * FROM pp01_user_authorities;
SELECT * FROM pp01_write_student;
SELECT * FROM pp01_file;
SELECT * FROM pp01_write_student_files;
SELECT * FROM pp01_write_student; 

SELECT * FROM pp01_home_work ;
SELECT * FROM pp01_hwsubmitted_by_stud;
#####################################################################
							  INSERT 
#####################################################################
INSERT INTO pp01_home_work(name,content,deadline) 
VALUES('이순신','알짜','2016-02-16');
INSERT INTO pp01_authority (name)
VALUES('ROLE_TEACHER');
INSERT INTO pp01_authority (name)
VALUES('ROLE_ADMIN');
INSERT INTO pp01_authority (name)
VALUES('ROLE_MEMBER');
 
#####################################################################
					          UPDATE 
#####################################################################
UPDATE pp01_home_work SET name="첫번째 숙제", content = "problem set 1번,2번,5번" 
WHERE id = 7;  

UPDATE pp01_home_work SET name="두번째 숙제", content = "problem set 6번,9,10,11,16,11
,2,22,23,24,28" 
WHERE id = 8; 

UPDATE pp01_lecture SET status=true 
WHERE id = 3;
SELECT * FROM pp01_lecture;
UPDATE pp01_lecture SET status=TRUE 
WHERE id=5;
SELECT * FROM  pp01_user 

UPDATE pp01_user SET status=TRUE;

UPDATE pp01_user SET status=TRUE
WHERE id= 7;
 
#####################################################################
						      DELETE  
#####################################################################
DELETE FROM pp01_hwsubmitted_by_stud;
DELETE FROM pp01_authority;
DELETE FROM pp01_user;
DELETE FROM pp01_lecture WHERE id=3;
DELETE FROM pp01_lecture;
DELETE FROM pp01_home_work;
DELETE FROM pp01_write_student WHERE id=2;
DELETE FROM pp01_write_student; #pp01_file을 지우고 pp01_write_student를 지워야함.  
DELETE FROM pp01_file;	
DELETE FROM pp01_write_student_files; 	#이 JOIN table있어서 file과 write_student가 삭제가 안되었었음. 
										#one TO many mapped by일때는 join table생긴다. 그걸 삭제해주어야 나머지 삭제가 됨 
										#joincolumn으로 onetomany하면 joint table이 안생긴다. 각각 삭제가능 
										#그리고, joincolumn은 foreign key를 저장할필요없이 자동으로 생기는데, mapped by는 foreign key를 저장해주어야한다. 
										#아직, mappedby가 foreign key를 table에 설정해주어야하는지 모르겠다. 	
										#mappedby 는 테스트해보니 foreign key mapped한것을 domain에 포함시켜주어야하더라. 
										# 예를들면, write에서 onetomany(mappedby="write"이면 write을 filedto에 field로 포함해야한다.	
 										# mappedby도 join table 안생길수 있다. 그러면, 각각 지워도 상관없다. 


SELECT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='pp01_user';
SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME='pp01_user_lecture';

ALTER TABLE pp01_user 						#CHILD TABLE 
ADD CONSTRAINT fk_lecture 					#NAME OF FOREIGN KEY OR SET BY MY WILL
FOREIGN KEY(lectures_id)					#PARENT PRIMARY KEY
REFERENCES pp01_user_lectures(lectures_id)	#PARENT TABLE, PARENT PRIMARY KEY 
ON DELETE SET NULL;
		
UPDATE pp01_user_lectures 
SET 
lectures_id=CASE 
WHEN lectures_id = NULL 
THEN NULL 
ELSE lectures_id
END




SELECT CONSTRAINT_NAME FROM information_schema.KEY_COLUMN_USAGE 
WHERE REFERENCED_TABLE_NAME ='pp01_lecture';
		
ALTER TABLE pp01_lecture_users ALTER COLUMN pp01_lecture_id ON DELETE SET NULL;

SELECT * FROM pp01_user_lectures; 

SELECT CONSTRAINT_NAME FROM information_schema.KEY_COLUMN_USAGE 
WHERE REFERENCED_TABLE_NAME ='pp01_user_lectures';

ALTER TABLE pp01_user change column id BIGINT NOT NULL AUTO_INCREMENT;