# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class IntegrationController < ApplicationController
    include IntegrationHelper
    
    before_filter :require_allowed_env
    
    # ==========
    # = set up =
    # ==========
    protected
    def require_allowed_env
        if [ 'selenium' ].include? RAILS_ENV
            return true
        end
        raise "Selenium mode only, there, science student."
    end
end
