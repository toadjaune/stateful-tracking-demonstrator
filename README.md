# Installation instructions

These installation instructions are made for a Debian server and client.
It should work on Ubuntu too, but has not been tested on anything else than Debian 9 (Stretch).
Should you need it, porting this procedure to another distribution should not be difficult.

## For production deployment


* For production deployment, you need 2 things :
  * A server on which you have ssh access (Debian 9 recommended)
  * A client, with ssh access to the server (can be your laptop, or the server itself, ssh-ing to localhost)
* First, we're gonna need to install a few packages on the server :
  * `apt-get install postgresql postgresql-contrib libpq-dev nginx`
* Then, on the client, we need :
  * git and ruby : `sudo apt-get install git ruby`
  * The mina gem : `sudo gem install mina`
  * This repo : `git clone git@gitlab.centralesupelec.fr:venturi_arn/projet-tracking-web-back.git` (TODO : change this once we move the repo)
  * `cd projet-tracking-web-back`
  * `cp config/deploy.rb.example config/deploy.rb`
  * Change the mina configuration in config/deploy.rb
  * `mina setup`
* Now, back on the server, let's configure our application :
  * `cd` to the location you configured earlier for deployment
  * Create and configure the following files in the `shared` directory (you can find example files in the corresponding path in the cloned repo, and copy them over) :
    * `config/database.yml`
    * `config/secrets.yml`
    * `config/settings.yml` (TODO)
* On the client :
  * `mina deploy`
* TODO : reverse-proxy setup


## For development

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

## Handy commands

* `rails server` : Start a local development server
* `rails db:migrate` : Run this whenever there's a new db migration
* `rspec` : Run all tests (the tests are in the spec directory)

# Reverse proxy setup (to automate)

* You need a trusted wildcard, for HPKP
  * You can't do a self-signed one and just accept a security exception, you need to have a CA sign it, and if it is a self-signed CA, to manually add it to your browser trust store
