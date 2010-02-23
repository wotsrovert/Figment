require File.dirname(__FILE__) + '/../spec_helper'

describe Project do
    before(:each) do
        @l1 = Location.create!(:name => "Somewhere")
        @l2 = Location.create!(:name => "Over")
        @l3 = Location.create!(:name => "Rainbow")
    end
end

# == Schema Information
#
# Table name: projects
#
#  id                 :integer         not null, primary key
#  description        :text(255)
#  dimensions         :string(255)
#  duration           :string(255)
#  press              :boolean
#  stipend            :string(255)
#  notes              :text
#  placement_code     :string(255)
#  artist_id          :integer
#  title              :string(255)
#  status             :string(255)
#  created_at         :datetime
#  setup_at           :datetime
#  updated_at         :datetime
#  break_down_at      :datetime
#  curator_id         :integer
#  placed_location_id :integer
#

