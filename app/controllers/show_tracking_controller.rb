class ShowTrackingController < ApplicationController
  # Make sure the user is logged in
  # (We could eventually remove this and try to guess)
  before_action :authenticate_user!

  def index
    # Recover all the information about the different tracking methods
    @methods = {}

    # 1st-party cookie
    @methods[:first_party_cookie][:name] = 'First party Cookie'
    first_party_cookie = FirstPartyCookie.find_by(token: cookies[:tracker])
    if first_party_cookie
      @methods[:first_party_cookie][:worked]      = true
      @methods[:first_party_cookie][:created_at]  = first_party_cookie.created_at
    else
      @methods[:first_party_cookie][:worked]      = false
    end

  end
end
