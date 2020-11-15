FROM alpine:latest

RUN apk update
RUN apk add --no-cache ca-certificates tzdata

RUN mkdir /duplicacy && mkdir /root/.duplicacy-web/

#ADD "https://acrosync.com/duplicacy-web/duplicacy_web_linux_arm_1.3.0" ${BinDuplicatyWeb}
ADD "https://acrosync.com/duplicacy-web/duplicacy_web_linux_arm_1.4.1" /duplicacy/duplicacy_web
RUN chmod +x /duplicacy/duplicacy_web
COPY settings.json /root/.duplicacy-web/
COPY entry.sh /duplicacy/entry.sh
RUN chmod +x /duplicacy/entry.sh
EXPOSE 3875

ENTRYPOINT [ "/duplicacy/entry.sh" ]

# docker build . -t docker-duplicacy

# docker run -dt --name duplicacy -p 0.0.0.0:3875:3875/tcp docker-duplicacy
