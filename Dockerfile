FROM factual/docker-cdh5-base

RUN apt-get install -y wget
ENV PG_VERSION="9.4"
#postgres
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main $PG_VERSION" >> /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# for ruby 2.2
RUN apt-add-repository ppa:brightbox/ruby-ng
 

RUN apt-get update && apt-get install -y postgresql-9.4 ruby2.2

ADD pg_hba.conf /etc/postgresql/$PG_VERSION/main/pg_hba.conf 
ADD postgresql.conf /etc/postgresql/$PG_VERSION/main/postgresql.conf

RUN mkdir -p /data

VOLUME ["/data"]

ADD configure_postgres.sh /etc/my_init.d/010_configure_postgres
ADD bootstrap.sh /etc/my_init.d/099_bootstrap



