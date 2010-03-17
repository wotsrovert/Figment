# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class Location < ActiveRecord::Base

    validates_presence_of :name
    validates_uniqueness_of :name

    has_many :programs    
    has_many :project_requested_locations, :dependent => :destroy    
    has_many :projects, :through => :project_requested_locations
    
    alias_method :orig_destroy, :destroy
    def destroy
        Project.update_all("placed_location_id = NULL", [ "placed_location_id = ?", self.id ] )
        orig_destroy
    end
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

