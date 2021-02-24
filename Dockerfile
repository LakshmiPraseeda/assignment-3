FROM tomcat:9.0.43-jdk15-openjdk-oraclelinux7
COPY /var/lib/jenkins/workspace/pipelinedemo/target/JenkinsWar.war /usr/local/tomcat/webapps
CMD ["catalina.sh","run"]
EXPOSE 1234