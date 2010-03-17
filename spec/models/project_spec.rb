require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
    before(:each) do
        @l1 = Location.create!(:name => "Somewhere")
        @l2 = Location.create!(:name => "Over")
        @l3 = Location.create!(:name => "Rainbow")
    end
    
    describe "enforcing validity" do
        describe "when in the submit mode" do
            before(:each) do
                @project = Project.new
            end
            
            it "should require a title" do
                @project.save
                @project.should have(1).errors_on(:title)
            end

            it "should require waiver signing" do
                @project.waiver = '0'
                @project.save
                @project.should have(1).errors_on(:waiver)
            end
            
            it "" do
                @project.waiver = '1'
                @project.title = "Something"
                @project.save!
            end
        
            describe "storing the curator name in str_curator" do
                it "should know" do
                    @project.curator_id = Factory.create( :curator, :name => "Humpty Dumpty").id
                    @project.str_curator.should eql( 'Humpty Dumpty')
                end
            end

            it "should store the curator name in str_curator" do
                @project.curator_id = Factory.create( :curator, :name => "Humpty Dumpty").id
                @project.str_curator.should eql( 'Humpty Dumpty')
            end

            it "should store the artist name in str_artist" do
                @project.artist_id = Factory.create( :artist, :public_name => "Happy Jack").id
                @project.str_artist.should eql( 'Happy Jack')
            end

            it "should store the placed_location name in str_placed_location" do
                @project.placed_location_id = Factory.create( :location, :name => "Superphunded Estates").id
                @project.str_placed_location.should eql( 'Superphunded Estates')
            end
        end
    end
end

# == Schema Information
#
# Table name: projects
#
#  id                 :integer         not null, primary key
#  description        :text(255)
#  dimensions         :string(255)
#  duration           :string(255)
#  press              :boolean
#  stipend            :string(255)
#  notes              :text
#  placement_code     :string(255)
#  artist_id          :integer
#  title              :string(255)
#  status             :string(255)
#  created_at         :datetime
#  setup_at           :datetime
#  updated_at         :datetime
#  break_down_at      :datetime
#  curator_id         :integer
#  placed_location_id :integer
#

