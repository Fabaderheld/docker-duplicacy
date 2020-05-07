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

RUN ln -s ${_DIR_CONF}/settings.json  ${_DIR_WEB}/settings.json
RUN ln -s ${_DIR_CONF}/duplicacy.json ${_DIR_WEB}/duplicacy.json
RUN ln -s ${_DIR_CONF}/licenses.json  ${_DIR_WEB}/licenses.json
RUN ln -s ${_DIR_CONF}/filters        ${_DIR_WEB}/filters
RUN ln -s ${_DIR_CACHE}/stats         ${_DIR_WEB}/stats

EXPOSE 3875
CMD [ "/usr/local/bin/entrypoint.sh" ]

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/var/cache/duplicacy", "/etc/duplicacy"]