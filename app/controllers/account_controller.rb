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

    def password_email_sent
        @email = params[:email]
    end
    
    def forgot_password
        return if !request.post?

        @email = params[:email]
        if @user = User.find_by_email(params[:email])
            @user.forgot_password
            Notifier.deliver_forgot_password( @user )
            
            redirect_to_next_action_or_default password_email_sent_path( :email => @email )
        else
            flash[:error] = "Could not find an account with email: #{params[:email]}."
        end
    end

    def reset_password
        if !(@user = User.find_by_anonymous_login_code(params[:pw_reset_code]))
            flash[:error] = "Please re-check your email for the link to this page."
            render :template => 'account/not_found'
            return
        end

        return if request.get?
        if @user.update_attributes(params[:user])
            @user.reset_password
            flash[:notice] = "Your password was successfully updated."

            self.current_user = @user
            redirect_to account_url
            return
        end
        flash[:error] = "Couldn't update your password.  Please see below for details"
    end

    def change_password
        return if request.get?

        if current_user.update_attributes(params[:user])
            flash[:notice] = "Your password was reset"
            redirect_to account_path
        end
    end
end
