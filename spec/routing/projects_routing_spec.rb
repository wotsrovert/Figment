require 'spec_helper'

describe ProjectsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/projects" }.should route_to( :controller => "projects", :action => "index" )
        end

        it "#edit" do
            { :get => "/projects/1/edit" }.should route_to( :controller => "projects", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/projects" }.should_not be_routable 
        end

        it "READ #show" do
            { :get => "/projects/1" }.should route_to( :controller => "projects", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/projects/1" }.should route_to( :controller => "projects", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/projects/1" }.should route_to( :controller => "projects", :action => "destroy", :id => "1" ) 
        end
    end
    
    describe "custom routes" do
        it "READ #edit curatorial" do
            { :get => "/projects/1/edit/artist" }.should route_to( :controller => "projects", :action => "edit", :id => "1", :section => 'artist' )
        end
    
        it "READ #edit curatorial" do
            { :get => "/projects/1/edit/curatorial" }.should route_to( :controller => "projects", :action => "edit", :id => "1", :section => 'curatorial' )
        end
    end
end
