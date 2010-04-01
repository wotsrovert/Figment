# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class Project < ActiveRecord::Base

    SECTIONS = [
        'curatorial',
        'artist',
    ].freeze


    has_many :project_categories
    has_many :categories, :through => :project_categories
    has_many :project_requested_locations
        
    has_many :answers

    belongs_to :placed_location, :class_name => "Location"

    validates_presence_of :description, :title, :status, :message => "Required"
    validates_acceptance_of :waiver
    validates_inclusion_of :status, :in => Status::VALUES

    belongs_to :artist
    belongs_to :curator, :class_name => 'User'
    has_many :programs

    attr_writer :requested_location_ids
    attr_accessor :waiver

    def before_validation
        if new_record?
            write_attribute( :status, Status::NEW )
        end
    end
    
    after_create do |p|
        if p.category_ids.try(:any?)
            p.category_ids.each do |x|
                ProjectCategory.create!( :project_id => p.id, :category_id => x )
            end
        end
        if p.requested_location_ids.try(:any?)
            p.requested_location_ids.each do |lx|
                ProjectRequestedLocation.create!( :project_id => p.id, :location_id => lx )
            end
        end
    end

    after_update do |p|
        if p.category_ids.try(:any?)
            p.category_ids.each do |x|
                ProjectCategory.create( :project_id => p.id, :category_id => x )
            end
            ProjectCategory.destroy_all( [ 'category_id NOT IN (?)', p.category_ids ])
        else
            ProjectCategory.destroy_all( :project_id => p.id )
        end

        if p.requested_location_ids.try(:any?)
            p.requested_location_ids.each do |x|
                ProjectRequestedLocation.create( :project_id => p.id, :location_id => x )
            end
            ProjectRequestedLocation.destroy_all( [ 'location_id NOT IN (?)', p.requested_location_ids ])
        else
            ProjectRequestedLocation.destroy_all( :project_id => p.id )
        end
    end

    def questions
        Question.find( :all ).select{ |q| q.applies_to?( self )}
    end
      
    def answers
        @answers ||= if new_record?
            Question.find( :all ).select{ |q| q.applies_to?( self )}.map{ |q| Answer.new( :project => self, :question => q )}
        else
            Answer.find_all_by_project_id( self.id )
        end
    end
    
    def all_questions_answered?
        answers.all? { |a| a.valid? }
    end
        
    def artist_id=( _v )
        write_attribute( :artist_id, _v )
        write_attribute( :str_artist, Artist.find( _v ).public_name )
    end

    def curator_id=( _v )
        write_attribute( :curator_id, _v )
        write_attribute( :str_curator, User.find( _v ).name )
    end

    def placed_location_id=( _v )
        if _v.to_i > 0
            write_attribute( :placed_location_id, _v )
            write_attribute( :str_placed_location, Location.find( _v ).name )
        end
    end

    def category_ids=( _v )
        @category_ids = _v
    end
        
    def category_ids
        @category_ids ||= project_categories.map(&:category_id)
    end

    def requested_location_ids
        @requested_location_ids ||= project_requested_locations.map(&:location_id)
    end

    def requested_locations
        Location.find(:all, :conditions => ['id IN (?)', connection.select_values( "SELECT location_id FROM project_requested_locations WHERE project_id = #{ self.id }" )] )
    end
    
    def edited_by( _u )
        @being_edited_by = _u
    end
end









# == Schema Information
#
# Table name: projects
#
#  id                  :integer         not null, primary key
#  description         :text
#  notes               :text
#  duration            :string(255)
#  title               :string(255)
#  dimensions          :string(255)
#  press               :boolean
#  placement_code      :string(255)
#  artist_id           :integer
#  stipend             :string(255)
#  setup_at            :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  break_down_at       :datetime
#  status              :string(255)
#  curator_id          :integer
#  placed_location_id  :integer
#  str_artist          :string(255)
#  str_curator         :string(255)
#  str_placed_location :string(255)
#

