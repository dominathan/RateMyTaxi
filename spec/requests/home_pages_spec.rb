require 'spec_helper'

describe "HomePages" do
  describe "GET /home_pages/home" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get home_pages_home_path
      response.status.should be(200)
    end
  end
end
