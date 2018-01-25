class ShowTrackingController < ApplicationController
  # Make sure the user is logged in
  # (We could eventually remove this and try to guess)
  before_action :authenticate_user!

  def index
    # Recover all the information about the different tracking methods
    @methods = {}

    # 1st-party cookie
    if cookies[:tracker]
      @methods[:first_party_cookie] = true
    else
      @methods[:first_party_cookie] = false
    end

  end
end
