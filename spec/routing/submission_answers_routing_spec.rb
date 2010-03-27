require 'spec_helper'

describe SubmissionProgramsController do
    describe "straight-up resource routing" do
        it "#index" do
            { :get => "/submissions/7/programs" }.should route_to( :controller => "submission_programs", :action => "index", :submission_id => '7' )
        end

        it "#new" do
            { :get => "/submissions/7/programs/new" }.should route_to( :controller => "submission_programs", :action => "new", :submission_id => '7' )
        end

        it "#edit" do
            { :get => "/submissions/7/programs/1/edit" }.should route_to( :controller => "submission_programs", :action => "edit", :id => "1", :submission_id => '7' )
        end

        it "CREATE #create" do
            { :post => "/submissions/7/programs" }.should route_to( :controller => "submission_programs", :action => "create", :submission_id => '7' ) 
        end

        it "UPDATE #update" do
            { :put => "/submissions/7/programs/1" }.should route_to( :controller => "submission_programs", :action => "update", :id => "1", :submission_id => '7' )
        end

        it "DELETE #destroy" do
            { :delete => "/submissions/7/programs/1" }.should route_to( :controller => "submission_programs", :action => "destroy", :id => "1", :submission_id => '7' )
        end
    end
end
