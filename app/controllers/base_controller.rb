class BaseController < ApplicationController
  def index
    response.set_header('X-cat', 'Meow')
    response.set_header('ETag', 'Some-etag')
  end
end
