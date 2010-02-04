require 'spec_helper'

describe ProjectsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/projects" }.should route_to( :controller => "projects", :action => "index" )
        end

        it "#new" do
            { :get => "/projects/new" }.should route_to( :controller => "projects", :action => "new" )
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
        it "get /submission" do
            params_from( :get, "/submission" ).should == {
                :controller  => 'projects',
                :action      => 'new'
            }        
        end
    end
end
