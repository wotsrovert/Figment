require 'spec_helper'

describe AccountController do
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

        it "GET forgot_password" do
            { :get => "/forgot_password" }.should route_to( :controller => "account", :action => "forgot_password" )
        end
    end

    describe "extracting params" do
        it "#signup" do
            params_from( :get, "/signup" ).should == {
                :controller  => 'account',
                :action      => 'new'
            }
        end

        it "#edit" do
            params_from( :get, "/account/edit" ).should == {
                :controller  => 'account',
                :action      => 'edit'
            }
        end

        it "#show" do
            params_from( :get, "/account" ).should == {
                :controller  => 'account',
                :action      => 'show'
            }
        end

        it "#update" do
            params_from( :put, "/account" ).should == {
                :controller  => 'account',
                :action      => 'update'
            }
        end      
    end
end
