class ShowTrackingController < ApplicationController
  # Make sure the user is logged in
  # (We could eventually remove this and try to guess)
  before_action :authenticate_user!
  before_action :find_tracked_session

  def collect_data
    @hsts_domain_list = Hsts::HSTS_URL_LIST
  end

  def check_hsts_not_redirected
    # We received the request in plain http, so there's no hsts cache, so there's nothing to do
  end

  def check_hsts_redirected
    # We received the request in https thanks to HSTS, so we need to write it to @tracked_session

  end

  def display_data
    # Recover all the information about the different tracking methods
    # We should probably migrate all of this in collect_data
    @methods = {}

    # 1st-party cookie
    @methods[:first_party_cookie] = { :name => 'First party Cookie' }
    first_party_cookie = FirstPartyCookie.find_by(token: cookies[:tracker])
    if first_party_cookie
      @methods[:first_party_cookie][:worked]      = true
      @methods[:first_party_cookie][:created_at]  = first_party_cookie.created_at
    else
      @methods[:first_party_cookie][:worked]      = false
    end

    # LocalStorage
    @methods[:local_storage] = { :name => 'Local Storage' }
    @methods[:local_storage][:worked]  = false
  end

  private

  def find_tracked_session
    @tracked_session = TrackedSession.find_or_create_by(session_id: request.session_options[:id])
  end
end
