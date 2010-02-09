class SessionController < ApplicationController
    
    def login
        flash[:error] = flash[:notice] = nil
    end

    def login_post
        @current_user = User.authenticate(params[:email], params[:password])

        if try_login(@current_user, params[:remember_me])
            flash[:notice] = "Welcome back, #{@current_user.name}."
            redirect_to_next_action_or_default root_path
        else
            flash[:error] = "Invalid login/password."
            render :template => 'session/login'
        end
    end

    def logout
        # self.current_user.forget_me if self.current_user.logged_in?
        # cookies.delete :auth_token
        reset_session
        @current_user.log_out
    end

    def login_as
    end
end
