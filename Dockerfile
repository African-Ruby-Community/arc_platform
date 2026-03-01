# syntax=docker/dockerfile:1
# Multi-stage Dockerfile for Rails 8 app with Ruby 3.4.4

ARG RUBY_VERSION=3.4.4

# Base image with Ruby and system libs
FROM ruby:${RUBY_VERSION}-slim AS base
ENV APP_PATH=/rails \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true
WORKDIR ${APP_PATH}

# Install runtime deps
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    ca-certificates \
    libpq5 \
    imagemagick \
    libvips \
    tzdata \
    git \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Builder stage for gems, node modules, and assets
FROM base AS build

# Build toolchain and headers
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    pkg-config \
    python3 \
    node-gyp \
    libyaml-dev && rm -rf /var/lib/apt/lists/*

# Install Node.js and Yarn (Node 20 LTS)
ARG NODE_VERSION=20
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn@1.22.22


# Bundle install
COPY Gemfile Gemfile.lock ./
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_DEPLOYMENT=1
ARG BUNDLER_VERSION=2.7.2
RUN gem update --system --no-document && \
    gem install -N bundler -v ${BUNDLER_VERSION} && \
    bundle install && \
    bundle exec bootsnap precompile --gemfile && \
    rm -rf ~/.bundle/ $BUNDLE_PATH/ruby/*/cache $BUNDLE_PATH/ruby/*/bundler/gems/*/.git

# JS deps
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# App code
COPY . .

# Precompile bootsnap and assets
RUN bundle exec bootsnap precompile app/ lib/
# If using sprockets, keep assets:precompile; js/cssbundling will run via rake task
RUN ./bin/rails assets:precompile

# Final image
FROM base AS app

# Copy built artifacts
COPY --from=build /usr/local/bundle /usr/local/bundle

# Set bundle and gem paths for runtime
ENV BUNDLE_PATH=/usr/local/bundle \
    GEM_HOME=/usr/local/bundle \
    BUNDLE_DEPLOYMENT=1

# Non-root user
RUN useradd -u 1000 -m rails && chown -R rails:rails /rails /usr/local/bundle
USER rails

# Copy app code
COPY --from=build --chown=1000:1000 /rails /rails

EXPOSE 3000
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]