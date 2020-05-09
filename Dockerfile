FROM alpine:latest

ENV BinDuplicatyWeb /usr/local/bin/duplicacy_web
ENV DirWeb ~/.duplicacy-web
ENV DirCache /var/cache/duplicacy
ENV DirConfig /etc/duplicacy

RUN apk update
RUN apk add --no-cache ca-certificates tzdata

ADD "https://acrosync.com/duplicacy-web/duplicacy_web_linux_arm_1.3.0" ${BinDuplicatyWeb}
RUN chmod +x ${BinDuplicatyWeb}

RUN mkdir -p ${DirCache}/repositories
RUN mkdir -p ${DirCache}duplicacy/stats  
RUN mkdir -p ${DirWeb}/bin
RUN mkdir -p /var/lib/dbus

RUN ln -s /dev/stdout /var/log/duplicacy_web.log

RUN ln -s ${DirCache}/settings.json  ${DirWeb}/settings.json
RUN ln -s ${DirCache}/duplicacy.json ${DirWeb}/duplicacy.json
RUN ln -s ${DirCache}/licenses.json  ${DirWeb}/licenses.json
RUN ln -s ${DirCache}/filters        ${DirWeb}/filters
RUN ln -s ${DirWeb}/stats         ${DirWeb}/stats

EXPOSE 3875
CMD [ "/usr/local/bin/entrypoint.sh" ]

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/var/cache/duplicacy", "/etc/duplicacy"]