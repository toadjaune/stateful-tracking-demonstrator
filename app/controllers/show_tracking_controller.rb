class ShowTrackingController < ApplicationController

  def collect_data
    # NB : we prefer creating a new one every time, just in case the session lasts longer than the tracking
    @tracked_session = TrackedSession.new(session_id: request.session_options[:id])

    @hsts_domain_list = Hsts::HSTS_URL_LIST

    check_first_party_cookie

    @tracked_session.save!

    # This is used to find the correct session in some tracking methods
    session[:tracked_session_id] = @tracked_session.id
  end

  # NB : The view generates a call to this endpoint per hsts subdomain
  def check_hsts
    @tracked_session = TrackedSession.where(id: params[:tracked_session_id]).last
    if request.headers['X-https'] == 'true'
      # We received the request in https thanks to HSTS, so we need to write it to @tracked_session
      TrackedSessionHstsEntry.create(tracked_session: @tracked_session, url_index: params[:index])
    end
    head :no_content
  end

  # NB : The view generates a call to this endpoint
  def check_local_storage
    @tracked_session = TrackedSession.where(id: params[:id]).last
    local_storage = LocalStorage.find_by(token: params[:token])
    @tracked_session.local_storage = local_storage
    @tracked_session.save
  end

  def display_data
    p session[:tracked_session_id]
    @tracked_session = TrackedSession.where(session_id: request.session_options[:id]).last
    # Recover all the information about the different tracking methods
    @methods = {}

    # 1st-party cookie
    @methods[:first_party_cookie] = extract_data(FirstPartyCookie.find_by(token: cookies[:tracker]), 'First party Cookie', '#cookies')

    # LocalStorage
    @methods[:local_storage] = extract_data(@tracked_session.local_storage, 'Local Storage', '#lstorage')

    # HSTS
    @methods[:hsts] = extract_data(@tracked_session.hsts, 'HSTS cache', '#hsts')

    # ETag
    @methods[:etag] = extract_data(@tracked_session.etag, 'ETag cache', '#etag')

    # HPKP
    if Settings.hpkp_enabled
      @methods[:hpkp] = extract_data(@tracked_session.hpkp, 'HPKP cache', '#hpkp')
    end
    # HPKP
    @methods[:redirection] = extract_data(@tracked_session.redirection, 'Redirection cache', '#redirect')
  end

  private

  def check_first_party_cookie
    @tracked_session.first_party_cookie = FirstPartyCookie.find_by(token: cookies[:tracker])
  end

  def extract_data(object, display_name, anchor_name)
    {
      name:       display_name,
      worked:     ! object.nil?, # Do we think we found a tracked user ?
      correct:    user_signed_in? && current_user == object&.user, # Is it the user currently logged in ?
      created_at: object&.created_at,
      shortname: anchor_name
    }
  end
end
