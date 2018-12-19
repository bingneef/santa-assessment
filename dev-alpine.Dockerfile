FROM  ruby:2.5.0-alpine3.7

# Set local timezone
RUN apk add --no-cache --update tzdata && \
    cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime && \
    echo "Europe/Amsterdam" > /etc/timezone

# Runtime deps: Install the app's runtime dependencies in the container
ENV RUNTIME_PACKAGES  nodejs git mariadb-dev openssh-client imagemagick file \
                      graphviz ttf-freefont
RUN apk add --no-cache --update --virtual runtime-deps $RUNTIME_PACKAGES && \
    rm -rf /var/cache/apk/*

# Install Yarn
ENV PATH=/root/.yarn/bin:$PATH
RUN apk add --no-cache --update --virtual build-yarn curl && \
    curl -o- -L https://yarnpkg.com/install.sh | sh && \
    apk del build-yarn

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
