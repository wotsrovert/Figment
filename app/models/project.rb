class Project < ActiveRecord::Base
end
# == Schema Information
#
# Table name: projects
#
#  id            :integer         not null, primary key
#  public_name   :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  description   :text
#  contact_name  :string(255)
#  contact_email :string(255)
#  phone         :string(255)
#  website       :string(255)
#  group_email   :string(255)
#  biography     :text
#  organization  :string(255)
#  names_list    :text
#  notes         :text
#

