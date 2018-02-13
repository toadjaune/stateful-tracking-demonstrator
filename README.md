# Installation instructions

For now, it is pretty straightforward :

* Install ruby
  * The current version number is in `.ruby-version`
  * You can either use your distribution package manager, or a ruby version manager such as rbenv
* Install dependencies
  * `apt-get install postgresql postgresql-contrib libpq-dev`
  * `sudo -Eu postgres createuser -d $USER`
* `gem install bundler`
* `bundle install`
* `rails db:setup`

# Handy commands

* `rails server` : Start a local development server
* `rails db:migrate` : Run this whenever there's a new db migration
* `rspec` : Run all tests (the tests are in the spec directory)
