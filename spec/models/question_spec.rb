require File.dirname(__FILE__) + '/../spec_helper'

describe Question do
    before(:each) do
        @question = Question.new( :category_ids => ['3', '7'])
    end

    it "should recognize a project" do
        @question.applies_to?( Factory.create( :project, :category_ids => ['4', '7'])).should be_true
    end

    it "should NOT recognize a project" do
        @question.applies_to?( Factory.create( :project, :category_ids => ['4', '5'])).should be_false
    end
end


# == Schema Information
#
# Table name: questions
#
#  id           :integer         not null, primary key
#  category_ids :text
#  created_at   :datetime
#  updated_at   :datetime
#  genre        :string(255)
#  wording      :string(255)
#

