require 'spec_helper'

describe CuratorsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/curators" }.should route_to( :controller => "curators", :action => "index" )
        end

        it "#new" do
            { :get => "/curators/new" }.should route_to( :controller => "curators", :action => "new" )
        end

        it "#edit" do
            { :get => "/curators/1/edit" }.should route_to( :controller => "curators", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/curators" }.should route_to( :controller => "curators", :action => "create" ) 
        end

        it "READ #show" do
            { :get => "/curators/1" }.should route_to( :controller => "curators", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/curators/1" }.should route_to( :controller => "curators", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/curators/1" }.should route_to( :controller => "curators", :action => "destroy", :id => "1" ) 
        end
    end
end
