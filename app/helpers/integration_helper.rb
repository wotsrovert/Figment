module IntegrationHelper
    
    def assert_input_with_error_for( _object, _field )
return <<EOS
<tr>
  <td>assertElementPresent</td>
  <td>//p[@class=&quot;#{ _field.camelize(:lower) } error&quot;]/input[@id=&quot;#{ _object }_#{ _field }&quot;]</td>
  <td></td>
</tr>
EOS
    end
    
    def assert_textarea_with_error_for( _object, _field )
return <<EOS
<tr>
  <td>assertElementPresent</td>
  <td>//p[@class=&quot;#{ _field.camelize(:lower) } error&quot;]/textarea[@id=&quot;#{ _object }_#{ _field }&quot;]</td>
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