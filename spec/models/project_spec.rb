require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
    describe "enforcing validity" do
        describe "when in the submit mode" do
            before(:each) do
                @artist = Factory.create( :artist, :public_name => "Happy Jack")
                @location = Factory.create( :location, :name => "Superphunded Estates")
                @curator = Factory.create( :curator, :name => "Humpty Dumpty")
                @project = @artist.projects.new
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
                    @project.curator_id = @curator.id
                    @project.str_curator.should eql( 'Humpty Dumpty')
                end
            end

            it "should store the artist name in str_artist" do
                @project.str_artist.should eql( 'Happy Jack')
            end

            it "should store the placed_location name in str_placed_location" do
                @project.placed_location_id = @location.id
                @project.str_placed_location.should eql( 'Superphunded Estates')
            end

            describe "once valid and saved" do
                before(:each) do
                    @project.curator_id         = @curator.id
                    @project.artist_id          = @artist.id
                    @project.placed_location_id = @location.id
                    @project.waiver             = '1'
                    @project.title              = "Something"
                    @project.save!
                end

                it "should store the artist name in str_artist" do
                    @project.str_artist.should eql( 'Happy Jack')
                end
                
                it "should update the artist name when artist name changes" do
                    @artist.update_attributes!( :public_name => 'Something Different' )
                    @project.reload
                    @project.str_artist.should eql( 'Something Different' )
                end
                
                it "should update the artist name when artist name changes and has apostrophe" do
                    @artist.update_attributes!( :public_name => "XSasha's art" )
                    @project.reload
                    @project.str_artist.should eql( 'XSasha\'s art' )
                end
                
                it "should update the location name when artist name changes" do
                    @location.update_attributes!( :name => 'Happy Place' )
                    @project.reload
                    @project.str_placed_location.should eql( 'Happy Place' )
                end
                
                it "should update the curator name when it changes" do
                    @curator.update_attributes!( :name => "Mike's Grumpy Muffins" )
                    @project.reload
                    @project.str_curator.should eql( "Mike's Grumpy Muffins" )
                end
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

