class Program < ActiveRecord::Base
    
    belongs_to :project
end
# == Schema Information
#
# Table name: programs
#
#  id               :integer         not null, primary key
#  starts_at_minute :integer
#  ends_at_minute   :integer
#  starts_on        :date
#  ends_on          :date
#  project_id       :integer
#

