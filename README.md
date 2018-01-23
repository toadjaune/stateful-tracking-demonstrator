# Installation instructions

For now, it is pretty straightforward :

* Install ruby
  * The current version number is in `.ruby-version`
  * You can either use your distribution package manager, or a ruby version manager such as rbenv
* Install dependencies
  * sqlite development libraries
* `gem install bundler`
* `bundle install`

# Handy commands

* `rails server` : Start a local development server
* `rails db:migrate` : Run this whenever there's a new db migration
