FROM quay.io/centos/centos:stream8

MAINTAINER "Evgeny Slutsky" <eslutsky@redhat.com>

ENV container docker
STOPSIGNAL SIGRTMIN+3

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
  /etc/systemd/system/*.wants/* \
  /lib/systemd/system/local-fs.target.wants/* \
  /lib/systemd/system/sockets.target.wants/*udev* \
  /lib/systemd/system/sockets.target.wants/*initctl* \
  /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
  /lib/systemd/system/systemd-update-utmp*

RUN dnf update -y
RUN dnf config-manager --enable powertools
RUN dnf install -y centos-release-openstack-yoga
RUN dnf install -y openstack-packstack net-tools iproute
RUN dnf install -y openssh-server procps-ng audit policycoreutils kmod wget lvm2
RUN systemctl enable sshd

# Copy answer file
ADD files/packstack.answer /packstack.answer
ADD files/auditd.service /usr/lib/systemd/system/auditd.service
ADD files/deploy-packstack.sh /deploy-packstack.sh
ADD files/create-volume.sh /create-volume.sh
ADD files/create-cirros.sh /create-cirros.sh
# Copy fake audit service config /usr/lib/systemd/system/auditd.service

VOLUME [ "/tmp", "/run", "/run/lock" ]

CMD ["/lib/systemd/systemd", "log-level=info", "unit=sysinit.target"]
