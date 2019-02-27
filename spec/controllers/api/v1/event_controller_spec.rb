require 'rails_helper'
RSpec.describe Api::V1::EventsController, type: :controller do

  describe "Authentication" do
    before do
      get :index
    end

    it "Redirect" do
      expect(response).to have_http_status(302)
    end
  end
end
