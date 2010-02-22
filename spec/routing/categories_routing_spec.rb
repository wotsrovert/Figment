require 'spec_helper'

describe CategoriesController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/categories" }.should route_to( :controller => "categories", :action => "index" )
        end

        it "#new" do
            { :get => "/categories/new" }.should route_to( :controller => "categories", :action => "new" )
        end

        it "#edit" do
            { :get => "/categories/1/edit" }.should route_to( :controller => "categories", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/categories" }.should route_to( :controller => "categories", :action => "create" ) 
        end

        it "READ #show" do
            { :get => "/categories/1" }.should route_to( :controller => "categories", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/categories/1" }.should route_to( :controller => "categories", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/categories/1" }.should route_to( :controller => "categories", :action => "destroy", :id => "1" ) 
        end
    end
end
