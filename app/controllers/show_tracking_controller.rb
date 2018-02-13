class ShowTrackingController < ApplicationController
  # Make sure the user is logged in
  # (We could eventually remove this and try to guess)
  before_action :authenticate_user!, except: [:check_hsts]

  def collect_data
    # NB : we prefer creating a new one every time, just in case the session lasts longer than the tracking
    @tracked_session = TrackedSession.new(session_id: request.session_options[:id])
    @hsts_domain_list = Hsts::HSTS_URL_LIST

    check_first_party_cookie

    @tracked_session.save!
  end

  # NB : This method is called by the view, once per hsts subdomain
  def check_hsts
    @tracked_session = TrackedSession.where(id: params[:tracked_session_id]).last
    if request.headers['X-https'] == 'true'
      # We received the request in https thanks to HSTS, so we need to write it to @tracked_session
      TrackedSessionHstsEntry.create(tracked_session: @tracked_session, url_index: params[:index])
    end
    head :no_content
  end

  def display_data
    @tracked_session = TrackedSession.where(session_id: request.session_options[:id]).last
    # Recover all the information about the different tracking methods
    @methods = {}

    # 1st-party cookie
    @methods[:first_party_cookie] = extract_data(FirstPartyCookie.find_by(token: cookies[:tracker]), 'First party Cookie')

    # TODO: migrate this in collect_data
    # LocalStorage
    @methods[:local_storage] = { :name => 'Local Storage' }
    @methods[:local_storage][:worked]  = false

    # HSTS
    @methods[:hsts] = extract_data(@tracked_session.hsts, 'HSTS cache')
  end

  private

  def check_first_party_cookie
    @tracked_session.first_party_cookie = FirstPartyCookie.find_by(token: cookies[:tracker])
  end

  def extract_data(object, display_name)
    {
      name:       display_name,
      worked:     ! object.nil?,
      created_at: object&.created_at
    }
  end
end
