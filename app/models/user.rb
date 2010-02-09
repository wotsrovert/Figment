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
    attr_accessor :signup_passphrase

    validates_presence_of :first_name, :last_name, :message => "Please enter both your first and last name(s)", :if => Proc.new{ |u| ! u.skip_name_requirement }
    validate do |u|
        if ( u.first_name.blank? || u.last_name.blank? ) && ! u.skip_name_requirement
            u.errors.add( :full_name, "Please enter both your first and last name(s)" )
        end
    end

    has_attached_file( :mugshot,
        :styles => {
            :thumb   => '45x45',
            :profile => '200'
        },
        :default_url => '/images/squash_ball_mugshot.gif'
    )


    def self.bulk_build( _str )
        _str.gsub(/\r|\n/, '').gsub(/"([^,]+), ([^"]+)"/, '"\2 \1"').split(",").delete_if { |str| str.blank? }.map do |str|
            User.new_from_bulk_create(str)
        end
    end

    def self.bulk_create!( _str )
        self.bulk_build( _str ).each do |u|
            begin
                u.save!
            end
        end
    end

    def self.bulk_update( _ids, _params )
        return if !_ids
        px = {}
        _params.each do |k,v|
            if !( v.blank? ) && k.to_sym != :club_id
                px[k] = v
            end
        end
            
        if px.any?
            _ids.each do |i|
                u = User.find(i)
                u.skip_all_validations_except_email
                u.update_attributes( px )
            end
        end

        if _params[:club_id]
            self.bulk_associate( _ids, _params[:club_id] )
        end
        self.find( _ids )
    end

    def self.bulk_associate( _ids, _club_id )
        _ids.each do |i|
            u = User.find(i)
            u.memberships.create( :club_id => _club_id )
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
    
    def cookies=( _v )
        @recent_search_ids = _v[:srchs]
    end
    
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

    def self.new_from_bulk_create( _str )
        u = self.new
        if /</ =~ _str
            arr = _str.split('<')

            name = arr[0]
            if /, */ =~ name
                name_arr = name.split(/, */).map{ |n| n.gsub('"','').strip }
                u.last_name = name_arr[0]
                u.first_name = name_arr[1..-1].join(" ")
            elsif / / =~ name
                name_arr = name.split(' ').map{ |n| n.gsub('"','')}
                u.first_name = name_arr[0]
                u.last_name = name_arr[1..-1].join(" ")
            else
                u.first_name = name
            end
            u.email = arr[1].gsub('>','')
        else
            u.email = _str
        end
        u.skip_name_requirement     = true
        u.skip_password_requirement = true
        u.skip_terms_requirement    = true
        u
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
#  location                  :string(255)
#  gender                    :string(255)
#  city                      :string(255)
#  country                   :string(255)
#  state_abbrev              :string(255)
#  is_admin                  :boolean         default(FALSE)
#  is_root                   :boolean         default(FALSE)
#  handed                    :string(255)
#  is_deleted                :boolean         default(FALSE)
#  first_name                :string(255)
#  last_name                 :string(255)
#  show_age                  :boolean         default(FALSE)
#  mugshot_file_size         :integer
#  mugshot_file_name         :string(255)
#  mugshot_content_type      :string(255)
#  rating_by_self            :integer
#  effective_rating          :integer
#  rating_by_pro             :integer
#  has_memberships           :boolean         default(FALSE)
#  is_pro                    :boolean         default(FALSE)
#  user_sort                 :string(255)
#  phone                     :string(255)
#

