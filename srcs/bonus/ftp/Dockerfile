FROM debian:bookworm

RUN	apt-get update && \
	apt-get install -y \
		ftp vsftpd && \
	rm -rf /var/lib/apt/lists/*

COPY ./vsftpd.conf /etc/vsftpd.conf.new

COPY ./conf_ftp.sh ./bin/conf_ftp
RUN chmod +x ./bin/conf_ftp

STOPSIGNAL SIGKILL

CMD ["./bin/conf_ftp", "/usr/sbin/vsftpd", "/etc/vsftpd.conf"]