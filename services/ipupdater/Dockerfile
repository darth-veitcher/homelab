FROM alpine

RUN apk --update add ca-certificates curl
ADD ./bin/* /usr/bin/

CMD [ "/usr/bin/start-updater" ]