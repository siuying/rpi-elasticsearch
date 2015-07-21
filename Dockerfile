FROM resin/rpi-java
MAINTAINER Francis Chong <francis@ignition.hk>

ENV ELASTIC_SEARCH_PACKAGE elasticsearch-1.7.0

# Define working directory
WORKDIR /elasticsearch

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ELASTIC_SEARCH_PACKAGE.tar.gz && \
  tar xvzf $ELASTIC_SEARCH_PACKAGE.tar.gz && \
  rm -f $ELASTIC_SEARCH_PACKAGE.tar.gz && \
  ln -s /$ELASTIC_SEARCH_PACKAGE /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
