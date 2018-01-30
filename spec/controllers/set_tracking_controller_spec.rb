require 'rails_helper'

# Unit tests, mostly for private methods
describe SetTrackingController do

  let(:controller_instance) { SetTrackingController.new }

  describe "sanitized_param" do
    it "doesn't return a negative value" do
      allow(controller_instance).to receive(:set_tracking_params).and_return("-5")
      expect(controller_instance).to receive(:sanitized_param).and_return(0)
      controller_instance.send(:sanitized_param, :minutes)
    end

    it "returns zero when receiving an invalid input" do
      allow(controller_instance).to receive(:set_tracking_params).and_return("auie")
      expect(controller_instance).to receive(:sanitized_param).and_return(0)
      controller_instance.send(:sanitized_param, :minutes)
    end

    it "correctly transforms to int a valid string" do
      allow(controller_instance).to receive(:set_tracking_params).and_return("5")
      expect(controller_instance).to receive(:sanitized_param).and_return(5)
      controller_instance.send(:sanitized_param, :minutes)
    end
  end
end
