# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class ProjectRequestedLocation < ActiveRecord::Base
    
    belongs_to :location
    belongs_to :project
    
end

# == Schema Information
#
# Table name: project_requested_locations
#
#  id          :integer         not null, primary key
#  project_id  :integer
#  location_id :integer
#

