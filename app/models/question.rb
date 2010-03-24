class Question < ActiveRecord::Base
    
    BOOLEAN = 'yes/no'
    STRING  = 'short answer'
    TEXT    = 'paragraph'
    TYPES   = [ BOOLEAN, STRING, TEXT ]
    
    validates_presence_of :question, :genre, :category_ids
    validates_inclusion_of :genre, :in => TYPES

    serialize :category_ids

    def categories
        if category_ids
            Category.find( category_ids )
        else
            []
        end
    end
    
    def in_category?( _c )
        return nil if ! category_ids
        category_ids.include?( _c.id.to_s )    
    end
    
    
    def is_boolean?
        read_attribute( :genre ) == BOOLEAN
    end
    
    def is_string?
        read_attribute( :genre ) == STRING
    end
    
    def is_text?
        read_attribute( :genre ) == TEXT
    end
end
# == Schema Information
#
# Table name: questions
#
#  id           :integer         not null, primary key
#  category_ids :text
#  question     :string(255)
#  genre         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

