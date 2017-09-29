FROM    centos:7

LABEL   author="ximenpo <ximenpo@jiandan.ren>"

ENV     GEARMAN_VERSION=1.1.17

RUN     yum         install -y  gcc gcc-c++ make        \
        &&  yum     install -y  gperf boost-devel libevent-devel libuuid-devel  \
        &&  cd  ~                                       \
        &&  curl    -L -O   https://github.com/gearman/gearmand/releases/download/${GEARMAN_VERSION}/gearmand-${GEARMAN_VERSION}.tar.gz \
        &&  tar xzf gearmand-${GEARMAN_VERSION}.tar.gz  \
        &&  cd      gearmand-${GEARMAN_VERSION}         \
        &&  sed -i 's/unique_size= 2;/unique_size= 1;/' libgearman-server/plugins/protocol/http/protocol.cc \
        &&  ./configure && make && make install         \
        &&  cd  ~                                       \
        &&  rm  -rf gearmand-${GEARMAN_VERSION}         \
        &&  yum     clean   all                         \
        &&  rm -rf  /var/cache/yum

EXPOSE  4730
EXPOSE  8080

CMD     ["gearmand"]
