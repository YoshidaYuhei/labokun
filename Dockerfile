FROM ruby:3.4.1-alpine

# 必要なパッケージをインストール
RUN apk add --no-cache \
  build-base \
  mariadb-dev \
  mariadb-client \
  mariadb-connector-c-dev \
  tzdata \
  nodejs \
  npm \
  yarn \
  git

# 作業ディレクトリを設定
WORKDIR /app

RUN gem install -N bundler
# Gemfile & Gemfile.lock をコピーして bundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリのソースコードをコピー
COPY . .

# デフォルトコマンド（Railsサーバー起動）
CMD ["rails", "server", "-b", "0.0.0.0"]
