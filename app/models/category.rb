class Category < ActiveRecord::Base
    validates_presence_of :name
end
# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

