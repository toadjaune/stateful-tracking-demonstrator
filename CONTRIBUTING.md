# Application structure

This is a standard Ruby on Rails application.

## Back
* Routes can be found `config/routes.rb`
* Every tracking measure has an own controller in `app/controllers`

## Front

* CSS is in `app/assets/stylesheets/application.css`
* HTML templates are in `app/views`
  * Every folder is associated to a controller


# Flow
* Gathering data when people asked for tracking report is done in two steps :
  * First we land user in `collect_data` view which makes the user request several ressources we used to gather what we need
  * Then we compile results and show them in `show_data` view
