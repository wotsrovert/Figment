require File.dirname(__FILE__) + '/../spec_helper'

describe Program do
    before(:each) do
        @location = Factory.build(:location, :name => "Phuket")
        @project  = Factory.build(:location)

        @project.save!
        @location.save!
        @program = Program.new( :project_id => @project.id, :location_id => @location.id )
    end
    
    it "should create a valid program" do
        @program.should be_valid
    end
    
    it "should set program's str_location" do
        @program.str_location.should eql( "Phuket" )
    end
end
