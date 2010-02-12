require File.dirname(__FILE__) + '/../spec_helper'

describe NilClass do
    it "self or 'default'" do
        nil.or( 'else' ).should eql( 'else' )
    end

end