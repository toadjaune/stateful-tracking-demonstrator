class EtagController < ApplicationController

  def index
    # This endpoint is used for ETag tracking
    # We use the Referer header to make the difference between set_tracking and show_tracking
    # NB : We have no way to set an expiration time

    if request.headers['Referer']&.include? 'set_tracking'
      authenticate_user!
      etag = Etag.create!(user: current_user)
      response.set_header('ETag', etag.token)
      response.set_header('Cache-Control', 'private, must-revalidate')
      render content_type: 'image/png', plain: open('public/1pixel.png', 'rb').read
    elsif request.headers['Referer']&.include? 'show_tracking'
      tracked_session = TrackedSession.where(session_id: request.session_options[:id]).last
      tracked_session.etag = Etag.find_by(token: request.headers['If-None-Match'])
      tracked_session.save!
      response.set_header('Cache-Control', 'private, must-revalidate')
      p 'etag_controller'
      p request.session_options[:id]
      p tracked_session.id
      p tracked_session.etag
      # Note that we return 304 Not Modified regardless of the result. It should not be an issue.
      head :not_modified
    else
      # Default, not supposed to happen
      head :no_content
    end
  end

end
