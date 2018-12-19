#!/bin/sh
# Exit on fail
set -e

bundle_install() {
  apk add --update --virtual build-deps make gcc g++ libxml2 libxslt-dev
  # Install gems
  bundle install --jobs 3 --retry 3 --binstubs="$BUNDLE_BIN"
  # Cleanup the build-deps to save space
  apk del build-deps
  rm -rf /var/cache/apk/*
}

# Ensure all gems are installed.
bundle check || bundle_install

# Ensure all packages are installed.
bin/yarn check --integrity || bin/yarn install

eval `ssh-agent -s`

# Finally call command issued to the docker service
exec "$@"
