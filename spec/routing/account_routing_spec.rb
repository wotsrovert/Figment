require 'spec_helper'

describe AccountController do
    include ActionView::Helpers::UrlHelper
    include ActionView::Helpers::TagHelper
    
    describe "basic rest" do
        it "GET /account" do
            { :get => "/account" }.should route_to( :controller => "account", :action => "show" )
        end

        it "POST /account" do
            { :post => "/account" }.should route_to( :controller => "account", :action => "create" )
        end

        it "DELETE /account" do
            { :delete => "/account" }.should route_to( :controller => "account", :action => "destroy" )
        end

        it "GET /account/edit" do
            { :get => "/account/edit" }.should route_to( :controller => "account", :action => "edit" )
        end

        it "PUT /account" do
            { :put => "/account" }.should route_to( :controller => "account", :action => "update" )
        end
    end

    describe "read avbts for an account" do
        it "basic" do
            { :get => "/account" }.should route_to( :controller => "account", :action => "show" )
        end
    end

    describe "building routes" do
        it "plain account show" do
            url_for( :action => 'show', :controller => 'account' ).should eql( '/account' )
        end
    end
end
