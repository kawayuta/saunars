# ElasticDocker
FROM docker.elastic.co/elasticsearch/elasticsearch:7.12.1
# 日本語をあつかうときに使うプラグイン


# Nginxの設定ファイルをコンテナにコピー
COPY analysis-kuromoji-7.12.1.zip /tmp
RUN bin/elasticsearch-plugin install file:///tmp/analysis-kuromoji-7.12.1.zip