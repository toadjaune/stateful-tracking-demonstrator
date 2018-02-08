class BaseController < ApplicationController
  def index
    p request.session_options[:id]
  end
end
