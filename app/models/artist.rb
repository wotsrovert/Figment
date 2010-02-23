class Artist < ActiveRecord::Base
    validates_presence_of :public_name, :message => "Required"
    validates_presence_of :contact_name, :message => "Required"
    validates_presence_of :contact_email, :message => "Required"
    validates_presence_of :contact_phone, :message => "Required"
    
    validates_format_of :contact_email, :with => Authenticated::EMAIL_REXEP, :message => "Doesn't appear to be valid."


    has_many :projects
end



# == Schema Information
#
# Table name: artists
#
#  id              :integer         not null, primary key
#  public_name     :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  description     :text
#  contact_name    :string(255)
#  contact_email   :string(255)
#  website         :string(255)
#  group_email     :string(255)
#  biography       :text
#  organization    :string(255)
#  names_list      :text
#  notes           :text
#  contact_phone   :string(255)
#  is_organization :boolean
#

