# Introduction

Nowadays, it's basically impossible to do anything on the Internet without getting tracked.

This project aims at demonstrating some of the numerous existing tracking methods, without JavaScript (except for LocalStorage, obviously).
We focus on tracking methods that set some state in the user's browser, to retrieve it later, which excludes any kind of fingerprinting.

You should be able to find a live instance of this project at `tracker.toadjaune.eu`.

Please note that this project initially was a school project, for this reason, we do not plan on making any specific effort to maintain or improve it.
However, feel free to use it and contribute !

# Installation instructions

These installation instructions are made for a Debian server and client.
It should work on Ubuntu too, but has not been tested on anything else than Debian 9 (Stretch).
Should you need it, porting this procedure to another distribution should not be difficult.

## For production deployment

Let's admit it, the tool used here for deployment ([mina](https://github.com/mina-deploy/mina)) is not really adapted for a deployment without setting up a full development environment.

Therefore, these instructions may seem quite cumbersome compared to other deployment tools.
It should however not be too complicated if you have basic comprehension of the Linux ecosystem.

* For production deployment, you need 2 things :
  * A server on which you have ssh access (Debian 9 recommended)
  * A client, with ssh access to the server (can be your laptop, or the server itself, ssh-ing to localhost)
* First, we're gonna need to install a few packages on the server :
  * `apt-get install postgresql postgresql-contrib libpq-dev nginx`
* Then, on the client, we need :
  * git and ruby : `sudo apt-get install git ruby`
  * The mina gem : `sudo gem install mina`
  * This repo : `git clone https://github.com/toadjaune/stateful-tracking-demonstrator`
  * `cd projet-tracking-web-back`
  * `cp config/deploy.rb.example config/deploy.rb`
  * Change the mina configuration in config/deploy.rb
  * `mina setup`
* Now, back on the server, let's configure our application :
  * `cd` to the location you configured earlier for deployment
  * Create and configure the following files in the `shared` directory (you can find example files in the corresponding path in the cloned repo, and copy them over) :
    * `config/database.yml` (And create the database user as indicated in this file)
    * `config/secrets.yml`
    * `config/settings.yml`
* On the client :
  * `mina deploy`
* Finally, we set-up our reverse-proxy :
  * `sudo apt-get install nginx`
  * Edit nginx-conf.example with path for certificate and put it under the `/etc/nginx/sites-available` directory
    * If your server has several vhost you may want to do some hostname filtering
    * You need a wildcard if you plan to enable HPKP tracking
      * That wildcard *must* be validated from default trust-store since Firefox and Chrome ignore any security exception or user-specific CA and certificate when validating HPKP
    * If you can not provide a wildcard, your certificate should cover the domain names you listed in `config/settings.yml` in addition of the domains named you intend to provide the service from.
  * `ln -s /etc/nginx/sites-available/<vhost_name> /etc/nginx/sites-enabled/`
  * `systemctl restart nginx`

### Day-to-day maintenance

* `mina deploy` : deploys the latest version, and restarts the server
* `mina console` : opens a rails console on the production instance

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

