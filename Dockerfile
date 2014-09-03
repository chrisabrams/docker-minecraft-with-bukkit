# DOCKER-VERSION 0.8.1

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

ADD ./lib/apt/sources.list /etc/apt/sources.list
RUN apt-get update -y; apt-get upgrade -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update -y; apt-get upgrade -y
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y curl oracle-java8-installer oracle-java8-set-default supervisor pwgen

ADD ./lib/craftbukkit.jar /usr/local/etc/minecraft/craftbukkit.jar
ADD ./lib/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./lib/supervisor/conf.d/minecraft.conf /etc/supervisor/conf.d/minecraft.conf
ADD ./lib/minecraft/opts.txt /usr/local/etc/minecraft/opts.txt
ADD ./lib/minecraft/white-list.txt /usr/local/etc/minecraft/white-list.txt
ADD ./lib/minecraft/server.properties /usr/local/etc/minecraft/server.properties
ADD ./lib/scripts/start /start
ADD ./lib/eula.txt /data/eula.txt

RUN chmod +x /start

EXPOSE 25565
VOLUME ["/data"]
CMD ["/start"]
