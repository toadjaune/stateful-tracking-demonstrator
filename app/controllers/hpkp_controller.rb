class HpkpController < ApplicationController

  skip_before_action :verify_authenticity_token

  def report
    session_id = params[:hostname].split(/\./)[0]
    pin = params[:"known-pins"][0].split(/sha256=/)[1].delete "\""
    s = TrackedSession.find_or_create_by(session_id: session_id)
    s.hpkp = pin
    s.save
  end

end
