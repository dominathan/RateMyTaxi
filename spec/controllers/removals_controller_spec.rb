require 'spec_helper'

describe RemovalsController do

  describe "GET 'question'" do
    it "returns http success" do
      get 'question'
      response.should be_success
    end
  end

end
