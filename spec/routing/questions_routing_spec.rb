require 'spec_helper'

describe QuestionsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/questions" }.should route_to( :controller => "questions", :action => "index" )
        end

        it "#new" do
            { :get => "/questions/new" }.should route_to( :controller => "questions", :action => "new" )
        end

        it "#edit" do
            { :get => "/questions/1/edit" }.should route_to( :controller => "questions", :action => "edit", :id => "1" )
        end

        it "CREATE #create" do
            { :post => "/questions" }.should route_to( :controller => "questions", :action => "create" ) 
        end

        it "READ #show" do
            { :get => "/questions/1" }.should route_to( :controller => "questions", :action => "show", :id => "1" )
        end

        it "UPDATE #update" do
            { :put => "/questions/1" }.should route_to( :controller => "questions", :action => "update", :id => "1" ) 
        end

        it "DELETE #destroy" do
            { :delete => "/questions/1" }.should route_to( :controller => "questions", :action => "destroy", :id => "1" ) 
        end
    end
end
