class Project < ActiveRecord::Base
    
    validates_presence_of :title
    
    belongs_to :artist
end


# == Schema Information
#
# Table name: projects
#
#  id                  :integer         not null, primary key
#  description         :string(255)
#  dimensions          :string(255)
#  duration            :string(255)
#  requested_location  :string(255)
#  press               :boolean
#  stipend             :string(255)
#  notes               :text
#  placed_location     :string(255)
#  placement_code      :string(255)
#  setup_time          :datetime
#  break_down          :datetime
#  requested_locations :string(255)
#  artist_id           :integer
#

