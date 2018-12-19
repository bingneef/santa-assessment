# admin

This is a Rails 5.2.1.1 app.

## Documentation

* Staging and production deployment instructions are in `DEPLOYMENT.md`

## Prerequisites

This project requires:

* Docker
or
* Ruby 2.5.0, preferably managed using [rbenv][]
* MySQL must be installed and accepting connections

## Getting started

### bin/setup

Run the `yarn setup:docker or yarn setup` script. This script will:

* Create local copies of `.env`
* Create, migrate, and seed the database

### Run it!

1. Run `yarn rspec spec` or `rspec spec` to make sure everything works.
2. Run `yarn start` or `foreman start` to start the Rails app (and other dependent processes if present).

[rbenv]:https://github.com/sstephenson/rbenv

## Rake tasks

```
# see a list of missing unique indexes
bin/rake inspect_unique_validations

# generate an erd.pdf from your models
bin/rake erd
```

## Tests

Running `yarn rspec spec` or `rspec spec` will run all the tests and outputs a coverage report to `coverage/index.html`

## Metrics/code style/other handy commands

```
# check your code using rubocop with the rules specified in .rubocop.yml
rubocop

# check for vulnerable versions in your Gemfile (this will also be done on deploy with capistrano)
bundle exec bundle-audit update
bundle exec bundle-audit

# check for rails security issues using brakeman
bundle exec brakeman
```
