FROM ruby:2.6.7

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs \
                       vim

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /saucial
WORKDIR /saucial

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /saucial/Gemfile
ADD Gemfile.lock /saucial/Gemfile.lock

# bundle installの実行
RUN gem install bundler
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /saucial

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets

ENV http_proxy http://:118.27.24.71:8080
ENV https_proxy https://118.27.24.71:8080
ENV no_proxy 127.0.0.1, localhost, 192.168.1.1