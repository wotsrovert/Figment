# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
    include SecurityActions

    helper :all # include all helpers, all the time
    # protect_from_forgery # :secret => '2a090af85266822601d58b602bc63763'

    # Scrub sensitive parameters from your log
    filter_parameter_logging :password, :password_confirmation
    
    before_filter :current_user

end
