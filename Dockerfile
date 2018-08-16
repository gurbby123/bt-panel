FROM centos:7.3.1611
MAINTAINER moumou123 <1026856405@qq.com>
RUN yum -y update \
 && yum -y install wget net-tool openssh-server; yum clean all
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
RUN echo 'root:mkaliez.com' | chpasswd
RUN wget -O install.sh http://download.bt.cn/install/install.sh \
 && printf "y\n0"|bash ./install.sh
ADD ./start.sh /start.sh
EXPOSE 21 22 80 443 888 3306 8888
CMD bash start.sh && /usr/sbin/sshd -D
