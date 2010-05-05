# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class ApplicationController < ActionController::Base
    include SecurityActions
    
    helper :all

    rescue_from 'Errors::Permission::EditProject' do |e|
        render :template => 'errors/edit_project'
    end

    # protect_from_forgery # :secret => '2a090af85266822601d58b602bc63763'

    filter_parameter_logging :password, :password_confirmation
    
    before_filter :current_user

    layout 'public'
    
end
