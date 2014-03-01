# DOCKER-VERSION 0.8.1

FROM ubuntu:12.04

ENV DEBIAN_FRONTEND noninteractive

ADD ./lib/apt/sources.list /etc/apt/sources.list
RUN apt-get update -y; apt-get upgrade -y
RUN apt-get install -y curl openjdk-7-jre-headless supervisor pwgen

ADD ./lib/craftbukkit.jar /usr/local/etc/minecraft/craftbukkit.jar
ADD ./lib/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./lib/supervisor/conf.d/minecraft.conf /etc/supervisor/conf.d/minecraft.conf
ADD ./lib/minecraft/opts.txt /usr/local/etc/minecraft/opts.txt
ADD ./lib/minecraft/white-list.txt /usr/local/etc/minecraft/white-list.txt
ADD ./lib/minecraft/server.properties /usr/local/etc/minecraft/server.properties
ADD ./lib/scripts/start /start

RUN chmod +x /start

EXPOSE 25565
VOLUME ["/data"]
CMD ["/start"]
