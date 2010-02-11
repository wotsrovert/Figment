require 'spec_helper'

describe ArtistsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/artists" }.should route_to( :controller => "artists", :action => "index" )
        end

        it "#new" do
            { :get => "/artists/new" }.should route_to( :controller => "artists", :action => "new" )
        end

        it "#edit" do
            { :get => "/artists/1/edit" }.should route_to( :controller => "artists", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/artists" }.should route_to( :controller => "artists", :action => "create" ) 
        end

        it "READ #show" do
            { :get => "/artists/1" }.should route_to( :controller => "artists", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/artists/1" }.should route_to( :controller => "artists", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/artists/1" }.should route_to( :controller => "artists", :action => "destroy", :id => "1" ) 
        end
    end
end
