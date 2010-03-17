# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class AccountController < ApplicationController

    before_filter :require_login, :only => [ :show, :edit, :change_password ]
    
    def show
    end

    def new
        @current_user = User.new
        flash[:error] = flash[:notice] = nil
    end

    def create
        @current_user = User.new( params[:user] )
        
        if try_signup(@current_user)
            flash[:notice] = "Success!"
            redirect_to root_path
        else
            flash[:error] = "Signup Failed."
            render :template => 'account/new'
        end
    end
    
    def edit
        @user = current_user
    end

    def update
        if current_user.update_attributes(params[:user])
            flash[:notice] = "Update Succeeded."
            redirect_to( account_path )
        else
            flash[:error] = "Update Failed."
            render :action => "edit"
        end
    end
end
