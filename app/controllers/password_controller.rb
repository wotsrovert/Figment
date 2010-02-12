class PasswordController < ApplicationController
    
    before_filter :find_user_by_anonymous_login_code, :only => [ :edit, :update ]
    def forgot
    end
    
    # POST
    def deliver
        @email = params[:email]
        if @user = User.find_by_email(params[:email])
            @user.forgot_password
            Notifier.deliver_forgot_password( @user )
            
            flash[:notice] = "SUCCESS: An email was sent to #{ @user.email }"
            render :template => 'password/sent'
        else
            flash[:error] = "Could not find an account with email: #{params[:email]}."
            render :template => 'password/forgot'
        end
    end
    
    # user arrives with anonymous_login_code in the URL
    def edit
    end

    # put request with anonymous_login_code in the URL
    def update
        if @user.update_attributes( params[:user] )
            flash[:notice] = "Your password was reset"
            self.current_user = @user
            redirect_to account_url
            return
        end
        flash[:error] = "Couldn't update your password.  Please see below for details"
        render :action => 'edit'
    end

    def sent
        @email = params[:email]
    end

    protected
    def find_user_by_anonymous_login_code
        alc = params[:anonymous_login_code]
        if ! User.exists?( :anonymous_login_code => alc )
            flash[:error] = "Unable to find that account.  Please re-enter your email address and check your inbox."
            
        else
            u = User.find_by_anonymous_login_code( alc )
            if u.anonymous_login_code_expires_at > Time.now
                @user = u
                return true
            else
                flash[:error] = "Please re-enter your email address."
            end
        end
        
        render :action => 'forgot'
        return false
    end
end
