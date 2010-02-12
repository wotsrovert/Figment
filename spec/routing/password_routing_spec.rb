require 'spec_helper'

describe PasswordController do
    
    
    it "GET /password" do
        { :get => "/password"               }.should route_to( :action => "show", :controller => "password" )
    end                                                                                    
                                                                                           
    it "POST /password/deliver" do                                                           
        { :post => "/password/deliver"      }.should route_to( :action => "deliver", :controller => "password" )
    end

    it "GET /password/edit/abc123" do
        { :get => "/password/edit/abc123"   }.should route_to( :action => "edit_by_anonymous_login_code", :controller => "password", :anonymous_login_code => 'abc123' )
    end

    it "GET /password/edit" do
        { :get => "/password/edit"          }.should route_to( :action => "edit", :controller => "password" )
    end

    it "PUT /password" do
        { :put => "/password"               }.should route_to( :action => "update", :controller => "password" )
    end

    it "GET /password/email/sent" do
        { :get => "/password/sent"          }.should route_to( :action => "sent", :controller => "password" )
    end
    
    describe "named routes" do
        it "forgot_password_path" do
            forgot_password_path.should eql( '/password' )
        end

        it "reset_password_url" do
            reset_password_url( 'somekindofhashedcode', :host => 'test.figmentproject.org' ).should eql( 'http://test.figmentproject.org/password/edit/somekindofhashedcode' )
        end
    end

    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/password" }.should route_to( :controller => "password", :action => "show" )
        end

        it "#new" do
            { :get => "/password/new" }.should route_to( :controller => "password", :action => "new" )
        end

        it "#edit" do
            { :get => "/password/edit" }.should route_to( :controller => "password", :action => "edit" )
        end

        it "CREATE #create" do
            { :post => "/password" }.should route_to( :controller => "password", :action => "create" ) 
        end

        it "READ #show" do
            { :get => "/password" }.should route_to( :controller => "password", :action => "show" )
        end

        it "UPDATE #update" do
            { :put => "/password" }.should route_to( :controller => "password", :action => "update" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/password" }.should route_to( :controller => "password", :action => "destroy" ) 
        end
    end
end
