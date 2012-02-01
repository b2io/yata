require 'spec_helper'

describe SessionsController do

  describe "GET 'home'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

end