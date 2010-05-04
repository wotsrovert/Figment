module IntegrationHelper
    
    def assert_field_with_error_for( _hash )
        px = _hash.map{ |k,v| "[@#{k}=&quot;#{ v }&quot;]"}.join( ' and' )
return <<EOS
<tr>
  <td>assertElementPresent</td>
  <td>//div[@class=&quot;fieldWithErrors&quot;]/input#{ px }</td>
  <td></td>
</tr>
EOS
    end
end