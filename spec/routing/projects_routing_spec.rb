require 'spec_helper'

describe ProjectsController do
    it "submission" do
        { :get => "/submission" }.should route_to( :controller => "projects", :action => "new" )
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
        Project::SECTIONS.each do |section|
            it "READ #edit #{section}" do
                { :get => "/projects/1/edit/#{section}" }.should route_to( :controller => "projects", :action => "edit", :id => "1", :section => section )
            end
            
            Project::SUBSECTIONS.keys.each do |subsection|
                it "READ #edit #{section}/#{subsection}" do
                    { :get => "/projects/1/edit/#{section}/#{subsection}" }.should route_to( :controller => "projects", :action => "edit", :id => "1", :section => section, :subsection => subsection.to_s )
                end
            end
        end
    end
end
