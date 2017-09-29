FROM    centos:7

LABEL   author="ximenpo <ximenpo@jiandan.ren>"

ENV     GEARMAN_VERSION=1.1.17

RUN     yum         install -y  gcc gcc-c++ make        \
        &&  yum     install -y  gperf boost-devel libevent-devel libuuid-devel  \
        &&  cd  ~                                       \
        &&  curl    -L -O   https://github.com/gearman/gearmand/releases/download/${GEARMAN_VERSION}/gearmand-${GEARMAN_VERSION}.tar.gz \
        &&  tar xzf gearmand-${GEARMAN_VERSION}.tar.gz  \
        &&  cd      gearmand-${GEARMAN_VERSION}         \
        &&  ./configure && make && make install         \
        &&  cd  ~                                       \
        &&  rm  -rf gearmand-${GEARMAN_VERSION}         \
        &&  yum     clean   all                         \
        &&  rm -rf  /var/cache/yum

EXPOSE  4730
EXPOSE  8080

CMD     ["gearmand"]
