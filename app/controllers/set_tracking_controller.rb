class SetTrackingController < ApplicationController
  # Make sure the user is logged in
  before_action :authenticate_user!

  def index
  end

  def create
    # Calculate how long we are going to track the user
    duration = sanitized_param(:minutes).minutes + sanitized_param(:hours).hours + sanitized_param(:days).days

    # Finally set up the tracking
    actually_set_tracking(duration)

    # We should not use inspect here
    flash.notice = "Tracking has been successfully set up for #{duration.inspect}."

    # There is no reason to stay on this page once we're done.
    redirect_to :root
  end

  private

  def set_tracking_params
    # To follow rails conventions, we use a separate method to validate strong parameters
    params.require(:set_tracking).permit(:minutes, :hours, :days)
  end

  def sanitized_param(param_symbol)
    # Make sure that the used value is a positive integer
    [0, set_tracking_params[param_symbol].to_i].max
  end

  def actually_set_tracking(duration) # duration in seconds
    # We're going to set up every tracking method we possibly can
    end_time = duration.seconds.from_now

    # This is a useless HTTP header. Because we can.
    response.set_header('X-cat', 'Meow')

    # 1st-party cookie
    first_party_cookie = FirstPartyCookie.create(user: current_user)
    cookies[:tracker] = {
      value:    first_party_cookie.token,
      expires:  end_time,
      httponly: true
    }

  end
end
