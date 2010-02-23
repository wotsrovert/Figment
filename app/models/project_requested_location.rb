class ProjectRequestedLocation < ActiveRecord::Base
    
    belongs_to :location
    belongs_to :project
    
end
