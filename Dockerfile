FROM debian:latest
ARG DEBIAN_FRONTEND=noninteractive
COPY build.sh /opt/build.sh
RUN ( cd /opt && chmod +x build.sh && bash build.sh )
USER debian
