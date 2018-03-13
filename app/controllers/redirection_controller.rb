class RedirectionController < ApplicationController

  def set_tracking
    if request.headers['Referer']&.include? 'set_tracking'
      authenticate_user!
      # This endpoint is used for initially setting up redirection cache
      # Once it is set up, we should directly land on get_tracking

      # Set up expiration
      duration = session[:tracking_duration] || 300
      response.set_header('Cache-Control', 'private, max-age=' + duration.to_s)

      # Redirect the user, and make sure we do not do anything with the subsequent request
      session[:tracked_session_id] = nil
      redirection_token = Redirection.create!(user: current_user).token
      response.set_header('Content-Type', 'text/css')
      # TODO : find a clean way to do this
      redirect_to 'https://tracker.toadjaune.eu/redirection/' + redirection_token, status: 301
    else
      # Not supposed to happen
      render content_type: 'text/css', plain: "img{ border:none; }"
    end
  end

  def get_tracking
    if session[:tracked_session_id]
      tracked_session = TrackedSession.find session[:tracked_session_id]
      tracked_session.redirection = Redirection.find_by(token: params[:redirection_token])
      tracked_session.save!
    end
    render content_type: 'text/css', plain: "img{ border:none; }"
  end

end
