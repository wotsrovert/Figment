# Base authenticated class.  Inherit from this class, don't put any app-specific code in here.
# That way we can update this model if auth_generators update.

module Authenticated
    
    EMAIL_REXEP = %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i
    
    def self.included(base)
        base.set_table_name base.name.tableize

        base.extend ClassMethods

        
        base.validates_presence_of(
            :email,
            :message => "Required"
        )
        base.validates_format_of(
            :email,
            :with    => Authenticated::EMAIL_REXEP,
            :message => "Doesn't appear to be valid."
        )
        base.validates_presence_of(
            :password,
            :if      => :password_required?,
            :message => "Required "
        )
        base.validates_presence_of(
            :password_confirmation,  
            :if      => :password_required?, 
            :message => "Required"
        )     
        base.validates_confirmation_of(
            :password,
            :if      => :password_required?,
            :message => "Passwords don't match."
        )
        base.validates_length_of(
            :password,
            :within    => base::PASSWORD_MIN_LENGTH..base::PASSWORD_MAX_LENGTH,
            :if        => :password_required?,
            :too_short => "Too short.",
            :too_long  => "Too long"
        )
        base.validates_uniqueness_of(
            :email,
            :case_sensitive => false,
            :message        => "Is already being used."
        )
        base.validates_length_of(
            :name,
            :within    => base::NAME_MIN_LENGTH..base::NAME_MAX_LENGTH,
            :if        => :name_required?,
            :too_short => "Too short.",
            :too_long  => "Too long."
        )
        base.validates_acceptance_of(
            :terms,
            :on        => :create,
            :allow_nil => false,
            :message   => "Please check that you accept the terms.",
            :if        => :terms_required?
        )

        base.before_save :encrypt_password

    end

    attr_accessor :password, :password_forgotten, :password_confirmation
    attr_accessor :remember_me_flag, :is_returning
    attr_writer :skip_terms_requirement
    attr_writer :skip_password_requirement

    module ClassMethods

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

        def new_via_admin(_hash)
            u = self.new(_hash)
            u.skip_password_requirement = true
            u.skip_terms_requirement = true
            u
        end

        def email_scrubber(_str)
            _str.gsub(' ', '').downcase
        end


        def find_for_invite(_hash)
            u =  self.find_by_email(_hash[:email]) || self.new_via_admin(_hash)
            u.encrypt_sha_passphrase
            u
        end

    end

    def email=(_str)
        self[:email] = self.class.email_scrubber(_str)
    end

    def is_admin?
        is_admin
    end

    def is_root?
        is_root
    end

    # Encrypts the password with the user salt
    def encrypt(password)
        self.class.encrypt(password, salt)
    end

    def authenticated?(password)
        crypted_password == encrypt(password)
    end

    def remember_token?
        remember_token_expires_at && Time.now.utc < remember_token_expires_at
    end

    # These create and unset the fields required for remembering users between browser closes
    def remember_me=(_v)
        if _v
            remember_me
        end
    end

    def remember_me
        remember_me_for 2.weeks
    end

    def remember_me_for(time)
        remember_me_until time.from_now.utc
    end

    # Useful place to put the login methods
    def remember_me_until(time)
        self.remember_token_expires_at = time
        self.remember_token = encrypt("#{email}--#{remember_token_expires_at}")
        save(false)
    end

    def forget_me
        self.remember_token_expires_at = nil
        self.remember_token            = nil
        save(false)
    end

    def check_for_remember_me
        if self.remember_me_flag.to_i > 0
            self.remember_me
        end
    end

    def encrypt_password
        return if password.blank?
        self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
        self.crypted_password = encrypt(password)
    end

    def update_attributes_without_password_requirement(_hash)
        @skip_password_requirement = true
        update_attributes(_hash)
    end

    def encrypt_sha_passphrase
        self[:sha_passphrase] = Digest::SHA1.hexdigest("--#{Time.now}--#{email}--")
    end

    def password_required?
        return false if @skip_password_requirement
        (crypted_password.blank? || !password.blank?)
    end

    attr_writer :skip_terms_requirement
    def terms_required?
        return true if !@skip_terms_requirement
    end

    def forgot_password
        self.password_forgotten = true
        create_pw_reset_code
        self.save
    end

    def create_pw_reset_code
        self.anonymous_login_code = Digest::SHA1.hexdigest("secret-#{Time.now}")
    end

    def reset_password
        update_attributes(:anonymous_login_code => nil)
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

end
