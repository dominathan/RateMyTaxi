require 'spec_helper'

describe HomePagesController do

  describe "GET 'Home'" do
    it "returns http success" do
      get 'Home'
      response.should be_success
    end
  end

end
