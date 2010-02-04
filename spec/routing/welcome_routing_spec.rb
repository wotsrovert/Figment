require 'spec_helper'

describe WelcomeController do
    it "#index" do
        { :get => "/" }.should route_to( :controller => "welcome", :action => "index" )
    end
end
