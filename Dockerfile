FROM haskell:7.10
RUN cabal update
RUN apt-get update
RUN apt-get install -y wget vim make
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 1614552E5765227AEC39EFCFA7E00EF33A8F2399
RUN echo "deb http://download.rethinkdb.com/apt jessie main" > /etc/apt/sources.list.d/rethinkdb.list
ENV RETHINKDB_PACKAGE_VERSION 1.16.2+1~0jessie
RUN apt-get update \
  && apt-get install -y rethinkdb=$RETHINKDB_PACKAGE_VERSION \
  && rm -rf /var/lib/apt/lists/*
RUN wget http://download.redis.io/redis-stable.tar.gz
RUN wget -q -O - http://www.dotdeb.org/dotdeb.gpg | apt-key add -
RUN apt-get update
RUN apt-get install -y redis-server

VOLUME ["/data"]

WORKDIR /data

CMD ["rethinkdb", "--bind", "all"]

#   process cluster webui
EXPOSE 28015 29015 8080
