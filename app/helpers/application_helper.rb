# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def sort_link( _label, _field )
        link_to _label, url_for( params.merge( "sort" => _field.to_s, "dir" => direction_for( _field ) ) )
    end


    def direction_for( _field )
        if params["sort"] && params["sort"] == _field.to_s
            if params["dir"] && params["dir"].upcase == 'DESC'
                'ASC'
            else
                'DESC'
            end
        else
            'ASC'
        end
    end    

    def none 
        '<span class="none">(none)</span>'
    end

    def flash_display
        if flash.any?
            content_tag( :div, (
                if flash[:error]
                    flash[:error]
                else
                    flash[:notice]
                end
            ), :id => 'flash', :class => ( flash[:error].try(:any?) ? 'error' : 'notice' ) )
        end
    end
end
