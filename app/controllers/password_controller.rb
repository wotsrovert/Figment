# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class PasswordController < ApplicationController
    
    def show
        render :template => 'password/forgot'
    end
    
    # POST
    def deliver
        @email = params[:email]
        if @user = User.find_by_email(params[:email])
            @user.create_anonymous_login_code
            Notifier.deliver_forgot_password( @user )
            
            flash[:notice] = "SUCCESS: An email was sent to #{ @user.email }"
            render :template => 'password/sent'
        else
            flash[:error] = "Could not find an account with email: #{params[:email]}."
            render :template => 'password/forgot'
        end
    end
    
    def edit_by_anonymous_login_code
        @user = find_user
        render :template => 'password/edit'
    end
    
    def edit
        @user = current_user
    end

    def update
        @user = find_user
                
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]

        if @user.save && try_login( @user )
            flash[:notice] = "Your password was reset"
            redirect_to account_path
            return
        end
        flash[:error] = "Couldn't update your password.  Please see below for details"
        render :template => 'password/edit'
    end

    def sent
        @email = params[:email]
    end

    protected
    def find_user
        if params[:anonymous_login_code] && User.exists?( :anonymous_login_code => params[:anonymous_login_code] )
            u = User.find_by_anonymous_login_code( params[:anonymous_login_code] )
            
        elsif current_user.logged_in?
            current_user
        else
            raise "Attempt to update password on anonymous user"
        end
    end
end
