class Answer < ActiveRecord::Base
    belongs_to :question
    belongs_to :project

    validates_presence_of :answer, :message => "Please answer."
    
    def find_in( _params )
        self.answer = _params[ question_id.to_s ]
    end
    
    def category_ids
        self.question.category_ids
    end
    
    def wording
        self.question.wording
    end
    
    def genre
        self.question.genre
    end

end
# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  question_id :integer
#  project_id  :integer
#  answer      :text
#  created_at  :datetime
#  updated_at  :datetime
#

