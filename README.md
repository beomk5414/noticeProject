# NoticeProject
Notice web application implementation

# 개발 환경
MAC OS 11.1 Big Sur
STS : 4.9.0 version
Java : SE 1.8

# 프로젝트 빌드 방법
1. 프로젝트 소스코드를 gitHub에서 내려받는다. (https://github.com/beomk5414/noticeProject)
2. STS(Spring Tool Suite)를 실행시킨다. 
3. File - Open Projects from File System - Directory - (내려받은 경로/noticeProject/workspace/SpringNotice)를 선택 - finish
4. SpringNotice 프로젝트가 열리면, 프로젝트를 오른쪽 마우스 클릭 - Gradle - Refresh Gradle Project 를 통해 디펜던시를 설치한다.

# 프로젝트 실행 방법
1. 프로젝트 오른쪽 마우스 클릭 - Rus As - Spring Boot App으로 프로젝트를 실행한다.
2. 크롬 브라우저를 실행시킨다. 
3. 주소창에 http://localhost:8080/ 를 입력한다.

# 로그인 계정 정보
- ID : admin(관리자) / user1, user2(사용자)
- PW : 1234 (비밀번호는 동일)

# 공지사항 
1. 등록/수정/삭제 기능은 관리자 권한으로 관리자 계정으로 로그인시에만 가능합니다.
2. 공지사항 조회 및 첨부파일 다운로드 등의 기능은 로그인 없이도 가능합니다.

