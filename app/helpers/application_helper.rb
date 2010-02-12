# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
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
