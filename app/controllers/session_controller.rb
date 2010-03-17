# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class SessionController < ApplicationController
    
    def login
        flash[:error] = flash[:notice] = nil
    end

    def login_post
        @current_user = User.authenticate(params[:email], params[:password])

        if try_login( @current_user, params[:remember_me] )
            flash[:notice] = "Welcome back, #{@current_user.name}."
            redirect_to(
                if @current_user.is_curator?
                    projects_path
                else
                    root_path
                end
            )
        else
            flash[:error] = "Invalid login/password."
            render :template => 'session/login'
        end
    end

    def logout
        cleanup_at_logout
        reset_session
        @current_user.log_out
        redirect_to root_path
    end

    def login_as
    end
end
