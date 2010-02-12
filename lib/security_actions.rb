module SecurityActions

    def record_returning_user
        cookies[:hsu] = true
    end

    def check_if_current_user_has_signed_up
        current_user.is_returning = cookies[:hsu]
    end

    def try_search( _srch )
        if _srch.new_record?
            _srch.user = current_user
        end
        _srch.save!

        cookies[:srchs] = if cookies[:srchs]
            arr = cookies[:srchs].split(',')

            # remove if new search's ID is already in srchs cookie
            if arr.include?( _srch.id.to_s )
                arr = arr.delete_if{ |i| i == _srch.id.to_s }
            end

            # add id to end of array
            arr.push _srch.id

            # limit size of list (in cookie) to 20
            if arr.size > 20
                arr.shift
            end

            # now rejoin back into a string for storage in cookie
            arr.join(',')
        else
            _srch.id.to_s
        end
        return _srch
    end

    def try_signup( _u )
        if _u.save
            record_returning_user
            self.current_user = _u
            return true
        else
            @current_user = _u
            return false            
        end
    end

    def try_login(_u, _remember_me = false)
        if _u.logged_in?
            record_returning_user

            if _remember_me
                cookies[:rmi] = { :value => _u.id.to_s, :expires => 60.days.from_now }

                _u.remember_me_code = Digest::SHA1.hexdigest( _u.email )[4,18]
                cookies[:rmc] = { :value => _u.remember_me_code, :expires => 60.days.from_now }
            end

            self.current_user = _u
            return true
        end
        false
    end

    def try_login_as( _user )
        if current_user.is_root?
            cookies[:liaid]                   = current_user.id
            current_user.anonymous_login_code = Digest::SHA1.hexdigest( "-- #{Time.now}" )
            current_user.save!
            cookies[:lia]                     = { :value => current_user.anonymous_login_code, :expires => 30.minutes.from_now }
            @current_user                     = nil
            self.current_user                 = _user
            return true
        else
            raise "Unauthorized attempt to login as user ID: #{ _user.id } by current_user ID: #{ current_user.id }."
        end
        false
    end

    def logout_as
        past_user_id = cookies[:liaid].to_i
        
        if past_user_id && User.exists?( past_user_id )
            u = User.find( past_user_id )
            if u.is_root?
                if cookies[:lia] == u.anonymous_login_code
                    u.anonymous_login_code = nil
                    u.save!
                    cookies.delete :liaid
                    cookies.delete :lia
                    @current_user = u
                    self.current_user = u
                    return true
                end 
            end
        end
    end
    
    def cleanup_at_logout
        # remember me ID
        if cookies[:rmi]
            cookies.delete :rmi 
        end

        # remember me code
        if cookies[:rmc] 
            cookies.delete :rmc 
        end
        # which is also stored in the database
        current_user.clear_remember_me_code
    end

    def current_user=(_u)
        @current_user = _u
        session[:user_id] = _u.id
    end

    def current_user
        if ( cookies[:rmi] ) 
            rmi = cookies[:rmi][:value].to_i
            
            if rmi > 0 && User.exists?( rmi )
                u = User.find( rmi )
                if u.remember_me_code == cookies[:rmc]
                    @current_user = u
                end
            end
        elsif ( session[:pending_user_id].to_i > 0 && Snapshot.exists?( session[:pending_user_id] ))
            @current_user = Snapshot.find( session[:pending_user_id] ).data
        end
        
        @current_user ||= if ( session[:user_id].to_i > 0 && User.exists?(session[:user_id]) )
            User.find(session[:user_id])
        else
            User.new
        end
        @current_user.cookies = cookies
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

