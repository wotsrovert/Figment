# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class ProjectRequestedLocation < ActiveRecord::Base
    
    belongs_to :location
    belongs_to :project
    
end
