module AuthenticatedControllerActions

    def try_login(_u, _remember_me = false)
        if _u.logged_in?
            record_returning_user
            _u.remember_me = _remember_me
            _u.check_for_remember_me
            self.current_user = _u
            return true
        end
        false
    end

    def current_user=(_u)
        session[:user_id] = _u.id
    end

    def current_user
        @current_user ||= if ( session[:user_id].to_i > 0 && User.exists?(session[:user_id]) )
            User.find(session[:user_id])
        else
            User.new
        end
        raise "WHA?".inspect
        

        return @current_user
    end

    def store_location
        session[:return_to] = request.url
    end

    def redirect_back
        if session[:return_to].blank?
            flash[:notice] = "Couldn't find a page to redirect you back to."
            redirect_to root_path
        else
            redirect_to session[:return_to]
        end
        return false
    end

    def redirect_back_or_default( _default )
        redirect_to( if params[:return_to]
                params[:return_to]

            elsif session[:return_to]
                tmp = session[:return_to]
                session[:return_to] = nil
                tmp

            else
                _default

            end
        )
    end

    def redirect_to_next_action_or_default( _default )
        if params[:next_action]
            redirect_to params[:next_action]

        else
            redirect_to _default
        end

    end

    def require_root
        return true if current_user.is_root?

        flash[:error] = "You must be root to do that."
        store_location
        redirect_to root_url
    end

    def require_admin
        return true if current_user.is_root? || current_user.is_admin?

        if current_user.logged_in?
            redirect_to root_url
        else
            store_location
            flash[:login_error] = "You must be admin to do that."
            redirect_to_login
        end
    end

    def require_login
        return true if current_user.logged_in?

        flash[:login_error] = "Please log in."
        redirect_to_login
    end

    def redirect_to_login
        redirect_to login_path
        return false
    end

end

