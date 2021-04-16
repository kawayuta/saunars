# ElasticDocker
FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.4
# 日本語をあつかうときに使うプラグイン


# Nginxの設定ファイルをコンテナにコピー
ADD elasticsearch-analysis-kuromoji-2.7.0.zip /etc/
RUN bin/elasticsearch-plugin install /etc/elasticsearch-analysis-kuromoji-2.7.0.zip