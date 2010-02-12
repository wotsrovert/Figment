require 'spec_helper'

describe PasswordController do
    it "GET /password/forgot" do
        { :get => "/password/forgot"        }.should route_to( :action => "forgot", :controller => "password" )
    end                                                                                    
                                                                                           
    it "POST /password/deliver" do                                                           
        { :post => "/password/deliver"       }.should route_to( :action => "deliver", :controller => "password" )
    end

    it "GET /password/edit/abc123" do
        { :get => "/password/edit/abc123"  }.should route_to( :action => "edit", :controller => "password", :anonymous_login_code => 'abc123' )
    end

    it "PUT /password/abc123" do
        { :put => "/password/abc123"  }.should route_to( :action => "update", :controller => "password", :anonymous_login_code => 'abc123' )
    end

    it "GET /password/email/sent" do
        { :get => "/password/sent"    }.should route_to( :action => "sent", :controller => "password" )
    end
    
    describe "named routes" do
        it "forgot_password_path" do
            forgot_password_path.should eql( '/password/forgot' )
        end

        it "reset_password_url" do
            reset_password_url( 'somekindofhashedcode', :host => 'test.boastdrive.com' ).should eql( 'http://test.boastdrive.com/password/edit/somekindofhashedcode' )
        end
    end
end
