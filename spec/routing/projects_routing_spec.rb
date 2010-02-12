require 'spec_helper'

describe ProjectsController do
    it "submission" do
        { :get => "/submission" }.should route_to( :controller => "projects", :action => "new" )
    end

    it "artist_id/submission" do
        { :get => "/submission/11" }.should route_to( :controller => "projects", :action => "new", :artist_id => '11' )
    end

    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/projects" }.should route_to( :controller => "projects", :action => "index" )
        end

        it "#edit" do
            { :get => "/projects/1/edit" }.should route_to( :controller => "projects", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/projects" }.should route_to( :controller => "projects", :action => "create" ) 
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
        it "READ #edit general" do
            { :get => "/projects/1/edit/general" }.should route_to( :controller => "projects", :action => "edit", :id => "1", :section => 'general' )
        end

        it "READ #edit curatorial" do
            { :get => "/projects/1/edit/curatorial" }.should route_to( :controller => "projects", :action => "edit", :id => "1", :section => 'curatorial' )
        end

        it "READ #edit programs" do
            { :get => "/projects/1/edit/programs" }.should route_to( :controller => "projects", :action => "edit", :id => "1", :section => 'programs' )
        end
    end
end
