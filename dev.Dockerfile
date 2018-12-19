FROM  ruby:2.5.0-slim

# Set local timezone
RUN apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends tzdata && \
    cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime && \
    echo "Europe/Amsterdam" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Runtime deps: Install the app's runtime dependencies in the container
ENV RUNTIME_PACKAGES  nodejs git libmariadb-dev openssh-client imagemagick file \
                      graphviz ttf-freefont gnupg libxml2 libxslt-dev ruby-curb
RUN apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends $RUNTIME_PACKAGES

# Install Yarn and NodeJS
ENV PATH=/root/.yarn/bin:$PATH
ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -qq -y --no-install-recommends curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash && \
    apt-get install -qq -y --no-install-recommends yarn nodejs

ENV RAILS_ROOT=/usr/src/app \
    GEM_HOME=/bundle \
    BUNDLE_PATH=/bundle \
    PATH="/bundle/bin:${PATH}"

RUN gem update --system && \
    gem install bundler

WORKDIR $RAILS_ROOT

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

ADD Gemfile* $RAILS_ROOT/
