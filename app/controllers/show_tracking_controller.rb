class ShowTrackingController < ApplicationController
  # Make sure the user is logged in
  # (We could eventually remove this and try to guess)
  before_action :authenticate_user!, except: [:check_hsts]

  def collect_data
    # NB : we prefer creating a new one every time, just in case the session lasts longer than the tracking
    @tracked_session = TrackedSession.create(session_id: request.session_options[:id])
    @hsts_domain_list = Hsts::HSTS_URL_LIST
  end

  def check_hsts
    @tracked_session = TrackedSession.where(id: params[:tracked_session_id]).last
    if request.headers['X-https'] == 'true'
      # We received the request in https thanks to HSTS, so we need to write it to @tracked_session
      TrackedSessionHstsEntry.create(tracked_session: @tracked_session, url_index: params[:index])
      hsts = Hsts.find_by(token_ary: @tracked_session.hsts_token_ary)
      if hsts
        @tracked_session.hsts = hsts
        @tracked_session.save
      end
    end
    head :no_content
  end

  def display_data
    @tracked_session = TrackedSession.where(session_id: request.session_options[:id]).last
    # Recover all the information about the different tracking methods
    # We should probably migrate all of this in collect_data
    @methods = {}

    # 1st-party cookie
    @methods[:first_party_cookie] = extract_data(FirstPartyCookie.find_by(token: cookies[:tracker]), 'First party Cookie')

    # LocalStorage
    @methods[:local_storage] = { :name => 'Local Storage' }
    @methods[:local_storage][:worked]  = false

    # HSTS
    @methods[:hsts] = extract_data(@tracked_session.hsts, 'HSTS cache')
  end

  private

  def extract_data(object, display_name)
    {
      name:       display_name,
      worked:     ! object.nil?,
      created_at: object&.created_at
    }
  end
end
