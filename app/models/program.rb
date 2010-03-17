# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class Program < ActiveRecord::Base
    
    belongs_to :location
    belongs_to :project

    validates_numericality_of :location_id, :only_integer => true, :allow_nil => false, :message => "Required"
    validates_numericality_of :project_id, :only_integer => true, :allow_nil => false , :message => "Required"

    def location_id=( _v )
        write_attribute( :location_id, _v )
        write_attribute( :str_location, Location.find( _v ).name )
    end
end

# == Schema Information
#
# Table name: programs
#
#  id          :integer         not null, primary key
#  project_id  :integer
#  starts_at   :datetime
#  ends_at     :datetime
#  location_id :integer
#

