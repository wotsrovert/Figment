class User < ActiveRecord::Base
    NAME_MIN_LENGTH     = 6
    NAME_MAX_LENGTH     = 24
    PASSWORD_MIN_LENGTH = 6
    PASSWORD_MAX_LENGTH = 10
    EMAIL_MIN_LENGTH    = 7
    EMAIL_MAX_LENGTH    = 200

    SORTABLE_FIELDS = [
        :first_name,
        :last_name,
        :email,
        :created_at,
        :updated_at,
    ]

    include Authenticated
    include Resettable

    attr_protected :is_root, :is_admin

    attr_accessor :next_action
    attr_accessor :skip_name_requirement

    validates_presence_of :first_name, :last_name, :message => "Please enter both your first and last name(s)", :if => Proc.new{ |u| ! u.skip_name_requirement }
    validate do |u|
        if ( u.first_name.blank? || u.last_name.blank? ) && ! u.skip_name_requirement
            u.errors.add( :full_name, "Please enter both your first and last name(s)" )
        end
    end


    named_scope :non_admins, :conditions => [ 'is_root = ? AND is_admin = ?', false, false ]
    named_scope :roots, :conditions => {:is_root => true }
    named_scope :filtered_by, lambda { |params|
        cols = []
        cnds = []
        if params
            # sort the keys so that the unit tests get consistent results
            params.stringify_keys!.sort.each do |k,v|
                if ! v.strip.blank?
                    v = v.strip
                    case k.to_sym
                    when :first_name
                        cols << 'LOWER( first_name ) LIKE ?'
                        cnds << "#{v.downcase}%"
                    when :last_name
                        cols << 'LOWER( last_name ) LIKE ?'
                        cnds << "#{v.downcase}%"
                    else
                        if SORTABLE_FIELDS.include? v
                            cols << "#{k} = ?"
                            cnds << v
                        end
                    end
                end
            end
            {
                :conditions => [ cols.join(" AND "), *cnds ]
            }
        end
    }

    def full_name
        [ self.first_name, self.last_name ].join( ' ')
    end

    def validate
        if first_name =~ /[#{ Regexp.escape( '%$([]\/><?;*|}' ) }]+/
            errors.add(:first_name, "Not valid")
        end
        if last_name =~ /[#{ Regexp.escape( '%$([]\/><?;*|}' ) }]+/
            errors.add(:last_name, "Not valid")
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

    def name_required?
        ! @skip_name_requirement
    end

    def already_exists?
        errors.on(:email) == "Is already being used."
    end

    def display_name
        "#{first_name} #{last_name}"
    end

    def name_and_email
        if name.blank?
            email
        else
            "#{ name } #{email}"
        end
    end

    def skip_all_validations_except_email
        @skip_name_requirement     = true
        @skip_password_requirement = true
        @skip_terms_requirement    = true
    end

    def self.per_page
        20
    end

    def name
        "#{first_name} #{last_name}"
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
#  id                        :integer         not null, primary key
#  email                     :string(255)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  name                      :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  last_logged_in_at         :datetime
#  anonymous_login_code      :string(255)
#  is_root                   :boolean         default(FALSE)
#  is_artist                 :boolean         default(FALSE)
#  is_curator                :boolean         default(FALSE)
#  is_director               :boolean         default(FALSE)
#  is_admin                  :boolean         default(FALSE)
#  is_spectator              :boolean         default(TRUE)
#  first_name                :string(255)
#  last_name                 :string(255)
#  mugshot_file_size         :integer
#  mugshot_file_name         :string(255)
#  mugshot_content_type      :string(255)
#  phone                     :string(255)
#  remember_me_code          :string(255)
#

