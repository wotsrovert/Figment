class Location < ActiveRecord::Base
    validates_presence_of :name

    has_many :programs
    
end
# == Schema Information
#
# Table name: locations
#
#  id          :integer         not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#  description :text
#  zone_code   :string(255)
#

