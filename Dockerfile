# MySQL 공식 이미지를 기반으로 사용
FROM mysql:8.0

# 환경 변수 설정
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=my_database

# 초기 데이터베이스 설정 파일을 복사
COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
