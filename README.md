# aws-s3Uplaod-Demo

## 개요

브라우저에서 이미지를 선택하여 AWS S3 버킷에 이미지를 업로드하는 프로젝트

## IDE / Dependency

IDE : STS

Dependency : Maven

## 사용법

1. stc/main/resources 에 application.properties 생성

```properties
spring.mvc.view.prefix=/WEB-INF/VIEWS/
spring.mvc.view.suffix=.jsp

server.port=8080

spring.servlet.multipart.max-file-size=10485760
app.aws.iam.accesskey=Access Key
app.aws.iam.secretkey=Secret Key
app.aws.s3.clientregion=Region
app.aws.s3.bucketname=Bucket Name
```
참고로 10485760 는 10MB 를 의미한다.

2. 실행한다 (Run as Spring boot App)

## 참고
[참고 프로젝트](https://github.com/nadunc/AWS-S3-image-uploader-with-java-spring-boot)

## 참고 프로젝트와의 차이점

   * 이미지 사이즈
      * 5MB -> 10MB
   * WEB/INF 사용
      * HTML -> JSP
