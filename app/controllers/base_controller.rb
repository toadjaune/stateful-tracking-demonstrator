class BaseController < ApplicationController
  def index
    p request.headers['Host']
    p request.headers['X-Real-IP']
    p request.headers['X-Forwarded-For']
    p request.headers['X-https']
  end
end
