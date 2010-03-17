class Project < ActiveRecord::Base

    SECTIONS = [
        'artist',
        'curatorial'
    ].freeze
    
    
    has_many :project_categories
    has_many :categories, :through => :project_categories
    has_many :project_requested_locations

    belongs_to :placed_location, :class_name => "Location"
    
    validates_presence_of :title
    validates_acceptance_of :waiver
    
    belongs_to :artist
    belongs_to :curator, :class_name => 'User'
    has_many :programs
    
    attr_writer :category_ids
    attr_writer :requested_location_ids
    attr_accessor :waiver

    after_create do |p|
        if p.category_ids.try(:any?)
            p.category_ids.each do |x|
                ProjectCategory.create!( :project_id => p.id, :category_id => x )
            end
        end
        if p.requested_location_ids.try(:any?)
            p.requested_location_ids.each do |lx|
                ProjectRequestedLocation.create!( :project_id => p.id, :location_id => lx )
            end
        end
    end
    
    after_update do |p|
        if p.category_ids.try(:any?)
            p.category_ids.each do |x|
                ProjectCategory.create( :project_id => p.id, :category_id => x )
            end
            ProjectCategory.destroy_all( [ 'category_id NOT IN (?)', p.category_ids ])
        else
            ProjectCategory.destroy_all( :project_id => p.id )
        end 

        if p.requested_location_ids.try(:any?)
            p.requested_location_ids.each do |x|
                ProjectRequestedLocation.create( :project_id => p.id, :location_id => x )
            end
            ProjectRequestedLocation.destroy_all( [ 'location_id NOT IN (?)', p.requested_location_ids ])
        else
            ProjectRequestedLocation.destroy_all( :project_id => p.id )
        end 
    end
    
    def artist_id=( _v )
        write_attribute( :artist_id, _v )
        write_attribute( :str_artist, Artist.find( _v ).public_name )
    end
    
    def curator_id=( _v )
        write_attribute( :curator_id, _v )
        write_attribute( :str_curator, User.find( _v ).name )
    end
    
    def category_ids
        @category_ids ||= project_categories.map(&:category_id)
    end

    def requested_location_ids
        @requested_location_ids ||= project_requested_locations.map(&:location_id)
    end

    def requested_locations
        Location.find(:all, :conditions => ['id IN (?)', connection.select_values( "SELECT location_id FROM project_requested_locations WHERE project_id = #{ self.id }" )] )
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

