class SetTrackingController < ApplicationController
  # Make sure the user is logged in
  before_action :authenticate_user!, except: :set_hsts_header

  def index
  end

  def create
    # Calculate how long we are going to track the user
    duration = sanitized_param(:minutes).minutes + sanitized_param(:hours).hours + sanitized_param(:days).days

    # Finally set up the tracking
    actually_set_tracking(duration)
  end

  # This endpoint is used to set up hsts header on a specific subdomain
  def set_hsts_header
    response.set_header('Strict-Transport-Security', 'max-age=' + params[:duration].to_s)
    # Allow iframe embedding, see https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
    response.set_header('X-Frame-Options', 'ALLOW-FROM *')
    render nothing: true, status: 200
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

    # LocalStorage
    # NB: We cannot set an expiration date for LocalStorage
    @local_storage = LocalStorage.create(user: current_user)

    # HSTS
    @hsts_token = Hsts.create(user: current_user).token
    @hsts_domain_list = Hsts::HSTS_URL_LIST
    @duration = duration


  end
end
