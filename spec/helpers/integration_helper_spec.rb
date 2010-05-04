require File.dirname(__FILE__) + '/../spec_helper'

describe IntegrationHelper do
    
    it "should return expected HTML" do
        expected = <<EOS
<tr>
  <td>assertElementPresent</td>
  <td>//div[@class=&quot;fieldWithErrors&quot;]/input[@id=&quot;artist_public_name&quot;]</td>
  <td></td>
</tr>
EOS
        helper.assert_field_with_error_for( :id => 'artist_public_name' ).should eql( expected )
    end
  
end
