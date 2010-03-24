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

# == Schema Information
#
# Table name: programs
#
#  id           :integer         not null, primary key
#  project_id   :integer
#  starts_at    :datetime
#  ends_at      :datetime
#  location_id  :integer
#  str_location :string(255)
#

