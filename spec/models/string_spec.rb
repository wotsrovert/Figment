require File.dirname(__FILE__) + '/../spec_helper'

describe String do
    it "self or 'default'" do
        "something".or( 'else' ).should eql( 'something' )
    end

    it "self or 'default'" do
        "".or( 'else' ).should eql( 'else' )
    end

    it "self or 'default'" do
        "  ".or( 'else' ).should eql( 'else' )
    end
end