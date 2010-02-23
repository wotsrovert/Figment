class Project < ActiveRecord::Base

    SECTIONS = [
        'artist',
        'general',
        'curatorial'
    ].freeze
    
    serialize :category_ids
    serialize :requested_location_ids
    
    validates_presence_of :title
    
    belongs_to :artist
    belongs_to :curator, :class_name => 'User'
    has_many :programs
    
    def category_ids=( _v )
        write_attribute( :category_ids, _v.delete_if{ |x| x.blank? }.map(&:to_i) ).delete_if { |x| x == 0 }
    end

    def category_ids
        ( read_attribute( :category_ids ) || [] )
    end
    
    def requested_location_ids=( _v )
        write_attribute( :requested_location_ids, _v.delete_if{ |x| x.blank? }.map(&:to_i) ).delete_if { |x| x == 0 }
    end

    def requested_location_ids
        ( read_attribute( :requested_location_ids ) || [] )
    end
    
    def categories
        if read_attribute( :category_ids )
            Category.find(:all, :conditions => ['id IN (?)', read_attribute( :category_ids )])
        else
            []
        end
    end

    def requested_locations
        if read_attribute( :requested_location_ids )
            Location.find( :all, :conditions => ['id IN (?)', read_attribute( :requested_location_ids )])
        else
            []
        end
    end

    def placed_location
        if read_attribute( :placed_location_id )
            Location.find( read_attribute( :placed_location_id ) )
        end
    end
end







# == Schema Information
#
# Table name: projects
#
#  id                     :integer         not null, primary key
#  description            :text(255)
#  dimensions             :string(255)
#  duration               :string(255)
#  press                  :boolean
#  stipend                :string(255)
#  notes                  :text
#  placement_code         :string(255)
#  artist_id              :integer
#  title                  :string(255)
#  status                 :string(255)
#  created_at             :datetime
#  setup_at               :datetime
#  updated_at             :datetime
#  break_down_at          :datetime
#  curator_id             :integer
#  placed_location_id     :integer
#  category_ids           :string(255)
#  requested_location_ids :string(255)
#

