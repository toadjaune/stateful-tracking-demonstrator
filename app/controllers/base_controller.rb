class BaseController < ApplicationController
  def index
    p request.headers['X-Forwarded-For']
  end
end
