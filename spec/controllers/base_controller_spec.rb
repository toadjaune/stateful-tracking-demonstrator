require 'rails_helper'

describe BaseController do
  describe "Requests to the base controller" do

    it "returns a 200 for a successful request." do
      get base_index_path
      expect(response.status).to eq(200)
    end

  end
end
