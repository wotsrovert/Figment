# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class User < ActiveRecord::Base

    PASSWORD_MIN_LENGTH = 6
    PASSWORD_MAX_LENGTH = 10
    EMAIL_MIN_LENGTH    = 7
    EMAIL_MAX_LENGTH    = 200

    include Authenticated
    include Resettable

    attr_protected :crypted_password,
                    :salt,
                    :anonymous_login_code,
                    :is_root,
                    :is_artist,
                    :is_curator,
                    :is_director,
                    :is_admin

    validates_presence_of :name, :message => "Please provide a name"

    named_scope :curators, :conditions => { :is_curator => true }

    has_many :projects, :foreign_key => 'curator_id'
    
    def self.sanitize_sql_for_assignment( *args )
        super
    end 

    def before_update 
        if changed? && changed.include?( 'name' )
            Project.update_all( Location.sanitize_sql_for_assignment( :str_curator => name ), "curator_id = #{ id }")
        end
    end
    
    
    def password_required?
        if is_admin || is_root || is_curator
            read_attribute( :crypted_password ).blank?
        else
            false
        end
        #  Not required for...
        #  is_director
        #  is_artist
        #  is_spectator
    end

    def terms_required?
        false
    end

    def already_exists?
        errors.on(:email) == "Is already being used."
    end

    def name_and_email
        if name.blank?
            email
        else
            "#{ name } #{email}"
        end
    end

    def self.per_page
        20
    end

    def is_admin?
        read_attribute(:is_root) || read_attribute(:is_admin)
    end

    def self.trevor
        find_by_email('trevorstow@gmail.com')
    end
end



















# == Schema Information
#
# Table name: users
#
#  id                              :integer         not null, primary key
#  email                           :string(255)
#  crypted_password                :string(40)
#  salt                            :string(40)
#  name                            :string(255)
#  created_at                      :datetime
#  updated_at                      :datetime
#  last_logged_in_at               :datetime
#  anonymous_login_code            :string(255)
#  is_root                         :boolean         default(FALSE)
#  is_artist                       :boolean         default(FALSE)
#  is_curator                      :boolean         default(FALSE)
#  is_director                     :boolean         default(FALSE)
#  is_admin                        :boolean         default(FALSE)
#  is_spectator                    :boolean         default(TRUE)
#  phone                           :string(255)
#  remember_me_code                :string(255)
#  anonymous_login_code_created_at :datetime
#

