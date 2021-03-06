require 'spec_helper'

describe SessionController do
    describe "straight-up resource routing" do
        it "GET /login" do
            { :get => "/login" }.should route_to( :controller => "session", :action => "login" )
        end

        it "POST /login" do
            { :post => "/login" }.should route_to( :controller => "session", :action => "login_post" )
        end

        it "GET /logout" do
            { :get => "/logout" }.should route_to( :controller => "session", :action => "logout" )
        end

        it "GET /login_as" do
            { :get => "/login_as/4" }.should route_to( :controller => "session", :action => "login_as", :id => "4" ) 
        end
    end
end
