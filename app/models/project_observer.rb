class ProjectObserver < ActiveRecord::Observer
    observe Project
    
    def after_create( _project )
        if _project.categories.any?
            
            position = 1
            Question.find( :all ).each do |q|
                if q.applies_to?( _project )
                    _project.answers.create!( :question => q, :position => position )
                    position += 1
                end
            end
        end
    end
end