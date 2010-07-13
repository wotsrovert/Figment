# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class User < ActiveRecord::Base

    EMAIL_REXEP = %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i
    EMAIL_MIN_LENGTH    = 7
    EMAIL_MAX_LENGTH    = 200
    PASSWORD_MIN_LENGTH = 6
    PASSWORD_MAX_LENGTH = 10

    ADMIN               = "admin"
    CURATOR             = "curator"
    DIRECTOR            = "director"
    PLACEMENT           = "placement"
    ROLES               = [
        ADMIN,
        CURATOR,
        DIRECTOR,
        PLACEMENT,
    ]

    include Resettable

    attr_protected :crypted_password,
                    :salt,
                    :anonymous_login_code


    attr_accessor :password, :password_confirmation
    attr_accessor :remember_me_flag


    validates_presence_of       :name, :message => "Please provide a name"
    validates_presence_of       :role, :message => "User must have a role"
    validates_inclusion_of      :role, :in => ROLES, :message => "Invalid user role"
    
    validates_presence_of       :email, :message => "Required"
    validates_format_of         :email, :with => EMAIL_REXEP, :message => "Doesn't appear to be valid."
    validates_uniqueness_of     :email, :case_sensitive => false, :message => "Is already being used."
    validates_presence_of       :crypted_password, :message => "Required", :if => Proc.new{ |u| ! u.new_record? }
    validates_presence_of       :salt, :message => "Required", :if => Proc.new{ |u| ! u.new_record? }
    validates_presence_of       :password, :message => "Required ", :if => :validate_password
    validates_length_of         :password, :within => PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH, :too_short => "Too short.",:too_long  => "Too long", :if => :validate_password
    validates_confirmation_of   :password, :message => "Passwords don't match.", :if => :validate_password

    before_save :encrypt_password

    named_scope :ordered_by, lambda { |params|
        { :order => params[:sort] ? "#{params[:sort]} #{ params[:dir] }" : nil }
    }
    named_scope :curators, :conditions => { :role => CURATOR }

    has_many :projects, :foreign_key => 'curator_id'
    
    def validate_password
        self.new_record? || @password
    end
    
    def self.sanitize_sql_for_assignment( *args )
        super
    end 

    def before_update 
        if changed? && changed.include?( 'name' )
            Project.update_all( Location.sanitize_sql_for_assignment( :str_curator => name ), "curator_id = #{ id }")
        end
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
        read_attribute(:role) == ADMIN
    end

    def is_curator?
        read_attribute(:role) == CURATOR
    end

    def make_curator
        write_attribute(:role, CURATOR )
    end

    def is_director?
        read_attribute(:role) == DIRECTOR
    end

    def is_placement?
        read_attribute(:role) == PLACEMENT
    end

    def self.trevor
        find_by_email('trevorstow@gmail.com')
    end
    
    # =================
    # = authenticated =
    # =================
    class << self

        # Encrypts some data with the salt.
        def encrypt(str, salt)
            Digest::SHA1.hexdigest("--#{salt}--#{str}--")
        end

        ## Authenticates a user by their email name and unencrypted password.  Returns the user or anonymous user.
        def authenticate(_email, _password)
            u = find_by_email(email_scrubber(_email)) # need to get the salt

            if u && u.authenticated?(_password)
                u.update_attribute( :last_logged_in_at, Time.now )
                return u
            end
            return self.new
        end

        def email_scrubber(_str)
            _str.gsub(' ', '').downcase
        end
    end

    def email=(_str)
        self[:email] = self.class.email_scrubber( _str )
    end

    # Encrypts the password with the user salt
    def encrypt(_pwd )
        self.class.encrypt( _pwd, salt )
    end

    def authenticated?( _pwd )
        crypted_password == encrypt( _pwd )
    end

    def encrypt_password
        return if password.blank?
        self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
        self.crypted_password = encrypt(password)
    end

    def remember_me_code=( _v )
        write_attribute( :remember_me_code, _v )
        if ! self.new_record?
            save!
        end
    end

    def clear_remember_me_code
        write_attribute( :remember_me_code, nil )
        if ! self.new_record?
            save
        end
    end

    def create_anonymous_login_code
        self.anonymous_login_code = Digest::SHA1.hexdigest("secret-#{Time.now}")
        self.anonymous_login_code_created_at = Time.now
        self.save
    end

    def reset_password
        update_attributes( :anonymous_login_code => nil )
    end

    def logged_in?
        !new_record?
    end

    def anonymous?
        new_record?
    end

    def is_anonymous?
        new_record?
    end

    def log_out
        @logged_out = true
    end
    
    def logged_in?
        if @logged_out == true
            return nil
        else
            !new_record?
        end
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
#  phone                           :string(255)
#  remember_me_code                :string(255)
#  anonymous_login_code_created_at :datetime
#  is_placement                    :boolean         default(FALSE)
#  role                            :string(255)
#

