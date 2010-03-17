# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class Category < ActiveRecord::Base

    validates_uniqueness_of :name
    validates_presence_of :name

    has_many :project_categories, :dependent => :destroy  
    has_many :projects, :through => :project_categories    

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

