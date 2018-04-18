# Application structure

This is mostly a classic Ruby on Rails application, however, since we're exploiting edge cases of protocols to track users, some of the routes and ways of transmitting information are not really consistent.

Please also keep in mind that not using any JavaScript at all when possible did constraint us a lot.

## Controller structure

Here is an explanation of the roles of the different controllers :

### `about_tracking_controller` and `base_controller`

These controllers do not handle any specific logic, they just show some information, and guide the user towards the other controllers.

### Devise controllers

We do not do anything specific about Devise views and controllers, since the defaults work pretty well for us.
They handle user authentication.

### `set_tracking_controller`

This is where the logic of setting tracking happens.
We took care of separating two different phases :
* `prepare` : This phase still does not set any tracker in the user's browser ; instead of that, it just asks the user to choose the configuration he desires (which tracking methods, for how long)
* `track` : This phase generates a page with nothing to see for the user, but many inclusions, that will set the different methods of tracking.
After that, the user gets redirected to the main page.
* `set_hsts_header` : This endpoint could (and probably should) be moved to a separate controller (such as the ones mentioned later.
It sets up HSTS headers on every response, so that we can set up tracking by encoding an id over many domains.

### `show_tracking_controller`

This controller collects the tracking data.
As for setting up the tracking, we clearly separate two phases :
* `collect_data` : This endpoint, through many inclusions, triggers an important number of requests in order to probe for tracking information.
However, since we cannot store the result on client-side (because no JavaScript), we store everything server-side, then redirect to the second stage.
* `display_data` : This page simply displays to the user all the data previously collected

### Remaining controllers

Each of the remaining controllers treats the requests either to set or to retrieve the tracking data for a specific tracking method.

For this reason, the user may never directly query them, instead of that, these controllers treat the background requests made from `track` and `collect_data`.


## Model structure

The model structure is more consistent and logic than the controller structure :

* `user` : This, obviously, is a user. This class handles the authentication and the very few account data that we have.
* `tracked_session` : One object of this type is created every time the `collect_data` action is triggered.
It is used to centralize all the gathered information (through many requests), and easily display it at once.
* Everything else : Each and every remaining model corresponds to a tracking method.
  * One of each of these objects gets created every time `track` is called
  * Each object can be identified through a random token (instead of just its id, which is only used internally).
  This allows finding back an object without permitting any kind of id enumeration
  * When calling `collect_data`, if an object can be retrieved (through its token stored in the user's browser), it is linked to the current `tracked_session`

# Application-specific and unusual points

## Absence of JavaScript
Since we tried to minimise the used JavaScript (to a total of 5 lines, 4 for interacting with LocalStorage, 1 to display the times in the user's timezone), some of the functionalities of Rails itself are not working correctly, and required adaptations :
* We had to manually create the `users_sign_out` route because without javascript, the DELETE http verb is not accessible in a link.

## Concurrency
Concurrency can quickly become an issue, since both `track` and `collect_data` can easily trigger dozens of simultaneous requests, even with a single client.
For this reason, we use an important number of tables (for each tracking method), and try to use INSERTs instead of UPDATEs as much as possible.
Also, using a performant database is helping a lot (we could never make SQLite work properly)
