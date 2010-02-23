require 'spec_helper'

describe SubmissionsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/submissions" }.should route_to( :controller => "submissions", :action => "index" )
        end

        it "#new" do
            { :get => "/submissions/new" }.should route_to( :controller => "submissions", :action => "new" )
        end

        it "#edit" do
            { :get => "/submissions/1/edit" }.should route_to( :controller => "submissions", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/submissions" }.should route_to( :controller => "submissions", :action => "create" ) 
        end

        it "READ #show" do
            { :get => "/submissions/1" }.should route_to( :controller => "submissions", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/submissions/1" }.should route_to( :controller => "submissions", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/submissions/1" }.should_not be_routable
        end
    end
end
