class EtagController < ApplicationController

  def index
    # This endpoint is used for ETag tracking
    # We use the Referer header to make the difference between set_tracking and show_tracking

#    if request.headers['Referer']&.include? 'set_tracking'
      authenticate_user!
      etag = Etag.create!(user: current_user)
      # TODO : We currently don't worry about about expiration
      response.set_header('Cache-Control', 'public, max-age=31536000')
      p etag.token
      response.set_header('ETag', etag.token)
      render content_type: 'image/png', plain: open('public/1pixel.png', 'rb').read
#    end

    if request.headers['Referer']&.include? 'show_tracking'
      tracked_session = TrackedSession.where(session_id: request.session_options[:id]).last
      # NB : We need to make sure every browser uses this header to send back the ETag
      p request.headers['If-None-Match']
      tracked_session.etag = Etag.find_by(token: request.headers['If-None-Match'])
      tracked_session.save!
      head :not_modified
    end
  end

end
