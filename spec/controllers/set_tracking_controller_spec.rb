require 'rails_helper'

describe SetTrackingController do
  describe "Requests to the set_tracking controller" do
    login_user

    describe "on the index action" do

      it "returns a 200 for a successful request." do
        get set_tracking_path
        # get 'set_tracking'
        expect(response.status).to eq(200)
      end

    end

  end
end
