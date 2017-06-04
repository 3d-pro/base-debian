FROM debian:experimental

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 HOME=/root DEBIAN_FRONTEND=noninteractive INITRD=No TERM=xterm
RUN echo 'Acquire::http::Proxy "http://172.17.0.1:3142";' > /etc/apt/apt.conf.d/11proxy && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install procps wget curl locales logrotate rsyslog gnupg -y && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure -f noninteractive tzdata && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get -y autoremove && \
    sed -i '/^weekly/a \dateext\ndateformat .%Y%m%d' /etc/logrotate.conf && \
    sed -i 's/\trotate .*/\trotate 365/g' /etc/logrotate.d/rsyslog && \
    sed -i 's/reload rsyslog/service rsyslog rotate/g' /etc/logrotate.d/rsyslog && \
    sed -i 's/--pidfile \$PIDFILE --exec \$DAEMON$/--pidfile \$PIDFILE/g' /etc/init.d/rsyslog && \
    sed -i '/^\($ModLoad imklog\|$KLogPermitNonKernelFacility\)/ s/^#*/#/' /etc/rsyslog.conf && \
    service rsyslog start && \
    service rsyslog stop && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/11proxy
