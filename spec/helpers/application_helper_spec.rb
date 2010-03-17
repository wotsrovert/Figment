require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do

    describe "sorting link" do
        before do
            params[:controller] = 'projects'
            params[:action] = 'index'
        end

        it "should default" do
            helper.sort_link( "Date", :dated_on ).should eql( "<a href=\"/projects?dir=ASC&amp;sort=dated_on\">Date</a>" )
        end

        it "should default accept a name prefix" do
            helper.sort_link( "Date", :dated_on ).should eql( "<a href=\"/projects?dir=ASC&amp;sort=dated_on\">Date</a>" )
        end

        it "should return direction" do
            params[:sort] = 'first_name'
            helper.direction_for( :first_name ).should eql( "DESC" )
        end

        it "should return direction ASC" do
            params[:sort] = 'first_name'
            params[:dir] = 'desc'
            helper.direction_for( :first_name ).should eql( "ASC" )
        end
    end  
end
