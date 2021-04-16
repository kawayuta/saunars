# ElasticDocker
FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.4
# 日本語をあつかうときに使うプラグイン


# Nginxの設定ファイルをコンテナにコピー
COPY elasticsearch-analysis-kuromoji-2.7.0.zip /tmp
RUN bin/elasticsearch-plugin install file:///tmp/elasticsearch-analysis-kuromoji-2.7.0.zip