# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class Artist < ActiveRecord::Base
    validates_presence_of :public_name, :contact_name, :contact_email, :group_email, :website, :biography, :names_list, :contact_phone, :message => "Required"
    
    validates_format_of :contact_email, :with => User::EMAIL_REXEP, :message => "Doesn't appear to be valid."

    has_many :projects

    def self.sanitize_sql_for_assignment( *args )
        super
    end 
    
    def before_update 
        if changed? && changed.include?( 'public_name' )
            Project.update_all( Artist.sanitize_sql_for_assignment( :str_artist => public_name ), "artist_id = #{ id }" )
        end
    end
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

