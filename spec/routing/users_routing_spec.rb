require 'spec_helper'

describe UsersController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/users" }.should route_to( :controller => "users", :action => "index" )
        end

        it "#new" do
            { :get => "/users/new" }.should route_to( :controller => "users", :action => "new" )
        end

        it "#edit" do
            { :get => "/users/1/edit" }.should route_to( :controller => "users", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/users" }.should route_to( :controller => "users", :action => "create" ) 
        end

        it "READ #show" do
            { :get => "/users/1" }.should route_to( :controller => "users", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/users/1" }.should route_to( :controller => "users", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/users/1" }.should route_to( :controller => "users", :action => "destroy", :id => "1" ) 
        end
    end
end
