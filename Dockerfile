FROM webdizz/baseimage-java8:8u45

MAINTAINER Izzet Mustafayev

# 'snapshot' or 'release'
ENV XD_BUILD release
ENV XD_VERSION 1.2.0.RELEASE

RUN apt-get update \
    && apt-get install unzip rsync telnet \
    && wget http://repo.spring.io/${XD_BUILD}/org/springframework/xd/spring-xd/${XD_VERSION}/spring-xd-${XD_VERSION}-dist.zip \
        -O /opt/spring-xd-${XD_VERSION}-dist.zip \
    && unzip /opt/spring-xd-${XD_VERSION}-dist.zip -d /opt/ \
    && rm /opt/spring-xd-${XD_VERSION}-dist.zip \
    && ln -s /opt/spring-xd-${XD_VERSION} /opt/spring-xd \
    && wget -c https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.36/mysql-connector-java-5.1.36.jar \
        -O /opt/spring-xd/xd/lib/mysql-connector-java-5.1.36.jar \
    && apt-get clean

WORKDIR /opt/spring-xd

RUN mkdir -p /tmp/xd/output
RUN mkdir -p /tmp/xd/input

CMD ["xd/bin/xd-singlenode"]
EXPOSE 9393