require File.dirname(__FILE__) + '/../spec_helper'

describe IntegrationHelper do
    
    it "assert input with error for (field name)" do
        expected = <<EOS
<tr>
  <td>assertElementPresent</td>
  <td>//p[@class=&quot;publicName error&quot;]/input[@id=&quot;artist_public_name&quot;]</td>
  <td></td>
</tr>
EOS
        helper.assert_input_with_error_for( 'artist', 'public_name' ).should eql( expected )
    end
  
    it "assert textarea with error for (field name)" do
        expected = <<EOS
<tr>
  <td>assertElementPresent</td>
  <td>//p[@class=&quot;publicName error&quot;]/textarea[@id=&quot;artist_public_name&quot;]</td>
  <td></td>
</tr>
EOS
        helper.assert_textarea_with_error_for( 'artist', 'public_name' ).should eql( expected )
    end
  
    it "assert field with error for (field name)" do
        expected = <<EOS
<tr>
	<td>type</td>
	<td>artist_names_list</td>
	<td>Tom, Dick, Harry</td>
</tr>
EOS
        helper.type_in( 'artist_names_list', 'Tom, Dick, Harry' ).should eql( expected )
    end
  
end
