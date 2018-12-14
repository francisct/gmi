FROM alpine:3.8
ENTRYPOINT /gmi/gmi.sh
RUN apk add git openssh
WORKDIR /gmi
RUN git init
COPY ./gmi.sh .
RUN chmod +x gmi.sh
COPY ./ssh.config /root/.ssh/config
RUN chmod 400 /root/.ssh/config



