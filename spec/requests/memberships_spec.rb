require 'rails_helper'

RSpec.describe "Memberships", :type => :request do
  describe "GET /memberships" do
    it "works! (now write some real specs)" do
      get memberships_path
      expect(response).to have_http_status(200)
    end
  end
end
