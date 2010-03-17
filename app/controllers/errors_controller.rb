# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class ErrorsController < ApplicationController

    layout 'errors'
    
    skip_after_filter Footnotes::Filter if RAILS_ENV == 'development'
    
    def internal_error
    end

    def not_found
    end

    def unprocessable
    end

end
