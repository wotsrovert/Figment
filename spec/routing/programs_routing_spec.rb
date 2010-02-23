require 'spec_helper'

describe ProgramsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/projects/7/programs" }.should route_to( :controller => "programs", :action => "index", :project_id => '7' )
        end

        it "#new" do
            { :get => "/projects/7/programs/new" }.should route_to( :controller => "programs", :action => "new", :project_id => '7' )
        end

        it "#edit" do
            { :get => "/programs/1/edit" }.should route_to( :controller => "programs", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/projects/7/programs" }.should route_to( :controller => "programs", :action => "create", :project_id => '7' ) 
        end

        it "READ #show" do
            { :get => "/programs/1" }.should route_to( :controller => "programs", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/programs/1" }.should route_to( :controller => "programs", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/programs/1" }.should route_to( :controller => "programs", :action => "destroy", :id => "1" ) 
        end
    end
end
