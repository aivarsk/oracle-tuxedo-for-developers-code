FROM oraclelinux:8.2 AS tuxhome

RUN yum -y install oracle-release-el8 && \
    yum -y install libnsl java-devel \
           gcc unzip file hostname which \
           && \
    rm -rf /var/cache/yum 

RUN groupadd oracle && \
        useradd -m -g oracle -s /bin/bash oracle

USER oracle

COPY tuxedo1222.rsp /home/oracle/

ENV ORACLE_HOME=/home/oracle/tuxhome
ENV JAVA_HOME=/etc/alternatives/java_sdk

RUN cd ~/ && \
      curl http://localhost/tuxedo122200_64_Linux_01_x86.zip --output tuxedo.zip && \
      jar xf tuxedo.zip && \
      cd ~/Disk1/install && \
      chmod -R +x * && \
      ./runInstaller.sh -responseFile ~/tuxedo1222.rsp \
            -ignoreSysPrereqs -ignorePrereq -silent -waitforcompletion

FROM oraclelinux:8-slim
RUN  microdnf install oracle-instantclient-release-el8 && \
     microdnf install oracle-instantclient-basiclite  \
                      libnsl unzip file hostname which sudo tmux vim ncurses \
                      util-linux util-linux-ng procps bpftrace strace ltrace \
                      less iproute \
                      python3-devel gcc-c++ gdb valgrind \
     && \
     rpm -Uvh --nodeps $(repoquery --location oracle-instantclient-sqlplus oracle-instantclient-devel) && \
     microdnf clean all

RUN groupadd oracle && \
        useradd -m -g oracle -s /bin/bash oracle && \
        echo 'oracle ALL=(ALL) NOPASSWD:ALL' \
        >> /etc/sudoers.d/oracle

USER oracle

COPY .tmux.conf .vimrc /home/oracle/

ENV ORACLE_HOME=/home/oracle/tuxhome
ENV JAVA_HOME=/etc/alternatives/java_sdk
ENV TUXDIR=/home/oracle/tuxhome/tuxedo12.2.2.0.0
ENV PATH=$PATH:$TUXDIR/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TUXDIR/lib

COPY --chown=oracle:oracle --from=tuxhome /home/oracle/tuxhome /home/oracle/tuxhome

RUN pip3 install --user tuxedo cx_oracle

VOLUME /home/oracle/dropbox

WORKDIR /home/oracle
# mount -t debugfs none /sys/kernel/debug
