class SetTrackingController < ApplicationController
  # Make sure the user is logged in
  before_action :authenticate_user!

  def index
    # We're going to set up every tracking method we possibly can

    # This is a useless HTTP header. Because we can.
    response.set_header('X-cat', 'Meow')

    # 1st-party cookie, never expiring
    first_party_cookie = FirstPartyCookie.create(user: current_user)
    cookies.permanent[:tracker] = first_party_cookie.token
  end
end
