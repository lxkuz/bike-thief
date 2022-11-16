FROM ruby:3.2.0-preview3

COPY . app/

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Store Bundler settings in the project's root
ENV BUNDLE_APP_CONFIG=.bundle

# Upgrade RubyGems and install the latest Bundler version
RUN gem update --system && \
    gem install bundler

WORKDIR /app

CMD ruby main.rb
