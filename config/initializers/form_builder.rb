module ActionView
    module Helpers
        class FormBuilder
            include ActionView::Helpers::UrlHelper

            def error_msg( method, prepend_text = "", append_text = "", css_class = "formError" )
                if (errors = self.object.errors.on( method ))
                    content_tag("div", "#{prepend_text}#{errors.is_a?(Array) ? errors.first : errors}#{append_text}", :class => css_class)
                else 
                    ''
                end
            end
            
            def class_for( _field )
                _field.to_s.camelize( :lower ) << ( self.object.errors.on( _field ) ? " error" : "" )
            end

            def msg_on( _field, _default_msg = '' )
                "<span class=\"msg#{ self.object.errors.on(_field) ? ' error' : nil }\">" << Array( self.object.errors.on(_field) ).first.to_s << _default_msg << '</span>'
            end

            def closer( _str = "Cancel" )
                link_to( _str, url_for())
            end
            
            def p( _field, _args = {}, &block )
                @template.concat( "<p class=\"#{ self.class_for( _field ) }\">" )
                yield
                @template.concat( "</p>" )
            end
        end
    end 
end