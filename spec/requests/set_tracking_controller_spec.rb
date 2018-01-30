require 'rails_helper'

describe "Requests to the set_tracking controller" do

  describe "when the user is not logged in" do
    it "redirects the user to the login page" do
      get set_tracking_path
      expect(response.status).to eq(302)
      expect(response).to redirect_to(:new_user_session)
    end
  end

  describe "when the user is logged in" do
    login_user
    describe "on the index action" do

      it "returns a 200 for a successful request." do
        get set_tracking_path
        expect(response.status).to eq(200)
      end

    end
  end

end
