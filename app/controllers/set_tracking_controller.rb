class SetTrackingController < ApplicationController
  # Make sure the user is logged in
  before_action :authenticate_user!, except: :set_hsts_header

  def prepare
  end

  def track
    # Calculate how long we are going to track the user
    duration = sanitized_param(:minutes).minutes + sanitized_param(:hours).hours + sanitized_param(:days).days

    # Finally set up the tracking
    actually_set_tracking(duration)
  end

  # This endpoint is used to set up hsts header on a specific subdomain
  def set_hsts_header
    response.set_header('Strict-Transport-Security', 'max-age=' + params[:duration].to_s)
    head :no_content
  end

  private

  def set_tracking_params
    # To follow rails conventions, we use a separate method to validate strong parameters
    params.require(:set_tracking).permit(:minutes, :hours, :days, :track_first_party_cookie, :track_local_storage, :track_hsts, :track_etag, :track_hpkp, :track_redirection)
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
    if set_tracking_params[:track_first_party_cookie] == '1'
      first_party_cookie = FirstPartyCookie.create(user: current_user)
      cookies[:tracker] = {
        value:    first_party_cookie.token,
        expires:  end_time,
        httponly: true
      }
    end

    # LocalStorage
    # NB: We cannot set an expiration date for LocalStorage
    if set_tracking_params[:track_local_storage] == '1'
      @local_storage = LocalStorage.create(user: current_user)
    end

    # HSTS
    if set_tracking_params[:track_hsts] == '1'
      ary = Hsts.create(user: current_user).token_ary
      @hsts_domain_list = ary.map { |i| Hsts::HSTS_URL_LIST[i] }
      @duration         = duration
    end

    # ETags
    @ETag = set_tracking_params[:track_hsts] == '1'

    # HPKP
    # TODO : permettre de mettre le nom de domaine en configuration de l'application
    if set_tracking_params[:track_hpkp] == '1'
      @hpkp = Hpkp.create(user: current_user)
      response.set_header('Public-Key-Pins-Report-Only', 'max-age=' + duration.to_s + ';' + 'pin-sha256="' + @hpkp.to_s + '";' + 'report-uri=http://tracker.cs-campus.fr/hpkp-report; includeSubDomains')
    end

    # Redirections
    @redirection = set_tracking_params[:track_redirection] == '1'
  end
end
