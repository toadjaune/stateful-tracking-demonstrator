class RedirectionController < ApplicationController

  def set_tracking
    authenticate_user!
    # This endpoint is used for initially setting up redirection cache
    # Once it is set up, we should directly land on get_tracking

    # Set up expiration
    response.set_header('Cache-Control', 'private, max-age=300')

    # Redirect the user, and make sure we do not do anything with the subsequent request
    session[:tracked_session_id] = nil
    redirection_token = Redirection.create!(user: current_user).token
    response.set_header('Content-Type', 'text/css')
    # TODO : find a clean way to do this
    redirect_to 'https://tracker.toadjaune.eu/redirection/' + redirection_token, status: 301
  end

  def get_tracking
    if session[:tracked_session_id]
      tracked_session = TrackedSession.find session[:tracked_session_id]
      tracked_session.redirection = Redirection.find_by(token: params[:redirection_token])
      tracked_session.save!
    end
    head :no_content
#    if request.headers['Referer']&.include? 'set_tracking'
#      authenticate_user!
#      etag = Etag.create!(user: current_user)
#      response.set_header('ETag', etag.token)
#      response.set_header('Cache-Control', 'private, must-revalidate')
#      render content_type: 'image/png', plain: open('public/1pixel.png', 'rb').read
#    elsif request.headers['Referer']&.include? 'show_tracking'
#      tracked_session = TrackedSession.where(session_id: request.session_options[:id]).last
#      tracked_session.etag = Etag.find_by(token: request.headers['If-None-Match'])
#      tracked_session.save!
#      response.set_header('Cache-Control', 'private, must-revalidate')
#      # Note that we return 304 Not Modified regardless of the result. It should not be an issue.
#      head :not_modified
#    else
#      # Default, not supposed to happen
#      head :no_content
#    end
  end

end
