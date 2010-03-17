# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class ProjectCategory < ActiveRecord::Base
    belongs_to :project
    belongs_to :category
    
    validates_uniqueness_of :project_id, :scope => :category_id
end
# == Schema Information
#
# Table name: project_categories
#
#  project_id  :integer
#  category_id :integer
#

