module IntegrationHelper
    
    def assert_input_with_error_for( _hash )
        px = _hash.map{ |k,v| "[@#{k}=&quot;#{ v }&quot;]"}.join( ' and' )
return <<EOS
<tr>
  <td>assertElementPresent</td>
  <td>//div[@class=&quot;fieldWithErrors&quot;]/input#{ px }</td>
  <td></td>
</tr>
EOS
    end
    
    def assert_textarea_with_error_for( _hash )
        px = _hash.map{ |k,v| "[@#{k}=&quot;#{ v }&quot;]"}.join( ' and' )
return <<EOS
<tr>
  <td>assertElementPresent</td>
  <td>//div[@class=&quot;fieldWithErrors&quot;]/textarea#{ px }</td>
  <td></td>
</tr>
EOS
    end
    
    def type_in( _field, _str )
        return <<EOS
<tr>
	<td>type</td>
	<td>#{ _field }</td>
	<td>#{ _str }</td>
</tr>
EOS
    end
end