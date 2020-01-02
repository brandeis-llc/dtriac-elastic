FROM docker.elastic.co/elasticsearch/elasticsearch:6.3.1

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch analysis-icu
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch org.wikimedia.search:extra:6.3.1.2
