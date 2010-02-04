class Project < ActiveRecord::Base
    validates_presence_of :public_name, :message => "Please provide a name for this project"
    validates_presence_of :contact_name, :message => "Please enter a primary contact name"
    validates_presence_of :contact_email, :message => "Please provide the primary contact's email"
    validates_presence_of :contact_phone, :message => "Please provide the primary contact's phone number"
    
    validates_format_of :contact_email, :with => Authenticated::EMAIL_REXEP, :message => "Doesn't appear to be valid."

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

