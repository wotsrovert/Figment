require 'spec_helper'

describe LocationsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/locations" }.should route_to( :controller => "locations", :action => "index" )
        end

        it "#new" do
            { :get => "/locations/new" }.should route_to( :controller => "locations", :action => "new" )
        end

        it "#edit" do
            { :get => "/locations/1/edit" }.should route_to( :controller => "locations", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/locations" }.should route_to( :controller => "locations", :action => "create" ) 
        end

        it "READ #show" do
            { :get => "/locations/1" }.should route_to( :controller => "locations", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/locations/1" }.should route_to( :controller => "locations", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/locations/1" }.should route_to( :controller => "locations", :action => "destroy", :id => "1" ) 
        end
    end
end
