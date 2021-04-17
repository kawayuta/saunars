# ElasticDocker
FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.4
# 日本語をあつかうときに使うプラグイン


# Nginxの設定ファイルをコンテナにコピー
COPY analysis-kuromoji-6.5.4.zip /tmp
RUN bin/elasticsearch-plugin install file:///tmp/analysis-kuromoji-6.5.4.zip
RUN sysctl -w vm.max_map_count=262144