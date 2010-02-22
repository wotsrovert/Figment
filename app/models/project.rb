class Project < ActiveRecord::Base

    SECTIONS = [
        'general',
        'curatorial',
        'programs',
    ].freeze
    
    SUBSECTIONS = {
        :general => "General",
        :placement => "Placement & Installation",
        :description => "Description",
        :artist => "Artist Details"
    }.freeze
    
    validates_presence_of :title
    
    belongs_to :artist
    belongs_to :curator, :class_name => 'User'
    has_many :programs
    
end






# == Schema Information
#
# Table name: projects
#
#  id                  :integer         not null, primary key
#  description         :text(255)
#  dimensions          :string(255)
#  duration            :string(255)
#  requested_location  :string(255)
#  press               :boolean
#  stipend             :string(255)
#  notes               :text
#  placed_location     :string(255)
#  placement_code      :string(255)
#  requested_locations :string(255)
#  artist_id           :integer
#  title               :string(255)
#  categories          :text
#  status              :string(255)
#  created_at          :datetime
#  setup_at            :datetime
#  updated_at          :datetime
#  break_down_at       :datetime
#  curator_id          :integer
#

