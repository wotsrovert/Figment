class ApplicationController < ActionController::Base
    include SecurityActions

    helper :all
    # protect_from_forgery # :secret => '2a090af85266822601d58b602bc63763'

    filter_parameter_logging :password, :password_confirmation
    
    before_filter :current_user

    layout 'public'

end
