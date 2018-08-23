FROM alpine:latest
MAINTAINER Curtis Hildebrand <curtis@craftypenguins.net>

# Gzip (the real one, not from BusyBox) is needed for automysqlbackup
# Rsync is needed for BackupPC
RUN apk add --no-cache openssh bash virtual-mysql-client gzip rsync && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ daemontools

COPY sshd_config /etc/ssh/sshd_config
COPY automysqlbackup /usr/local/bin/
COPY backup-mysql /usr/local/bin/
COPY configure-automysqlbackup /usr/local/bin/
RUN chmod +rx /usr/local/bin/*
COPY sshd-entrypoint.sh /
RUN chmod +rx /sshd-entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/sshd-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-De"]
