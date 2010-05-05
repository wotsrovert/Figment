require 'spec_helper'

describe ProjectsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/projects" }.should route_to( :controller => "projects", :action => "index" )
        end

        it "#edit" do
            { :get => "/projects/1/edit" }.should_not be_routable
        end

        it "CREATE #create" do
            { :post => "/projects" }.should_not be_routable
        end

        it "READ #show" do
            { :get => "/projects/1" }.should_not be_routable
        end

        it "UPDATE #update" do
            { :put => "/projects/1" }.should_not be_routable
        end

        it "DELETE #destroy" do
            { :delete => "/projects/1" }.should route_to( :controller => "projects", :action => "destroy", :id => "1" )
        end
    end

    describe "custom routes" do
        it "EDIT logistics" do
            { :get => "/projects/1/logistics" }.should route_to( :controller => "projects", :action => "logistics", :id => "1" )
        end

        it "EDIT curatorial" do
            { :get => "/projects/1/curatorial" }.should route_to( :controller => "projects", :action => "curatorial", :id => "1" )
        end

        it "UPDATE curatorial" do
            { :put => "/projects/1/logistics" }.should route_to( :controller => "projects", :action => "logistics", :id => "1" )
        end

        it "READ #edit curatorial" do
            { :put => "/projects/1/curatorial" }.should route_to( :controller => "projects", :action => "curatorial", :id => "1" )
        end
    end
end
