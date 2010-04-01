require File.dirname(__FILE__) + '/../spec_helper'

describe "" do
    include SecurityActions
    include ActionController::UrlWriter

    default_url_options[:host] = 'figmentproject.org'

    def session
        @session ||= {}
    end

    def cookies
        @cookies ||= {}
    end

    def params
        @params ||= {}
    end

    before( :each ) do
        cookies = {}
    end

    describe "logging in" do
        before(:each) do
            @user = Factory.create( :placement )
        end

        describe "SUCCESSFULLY" do
            it "should ask the user if it's logged in" do
                @user.should_receive(:logged_in?).and_return(true)
                try_login(@user, "1")
            end

            it "should return true" do
                try_login(@user, "1").should be_true
            end

            it "should set the session user_id to 1" do
                try_login(@user, "1")
                session[:user_id].should eql( @user.id )
            end

            it "should set the rmi to the @user i" do
                try_login(@user, "1")
                cookies[:rmi][:value].should eql( @user.id.to_s )
            end

            it "should set the rmc to the @user's email, passed through Digest::SHA1.hexdigest" do
                Digest::SHA1.stub!(:hexdigest).and_return( 'abc123 wowie zowie' )
                try_login(@user, "1")
                cookies[:rmc][:value].should eql( "23 wowie zowie" )
            end

            it "should set the current user to @user" do
                try_login(@user, "1")
                current_user.should eql( @user )
            end
        end
    end

    describe "once the session has expired" do
        describe "when the remember me code doesn't match user's email" do
            it "should be anonymous" do
                cookies[:rmc] = 'anything at all'
                current_user.should be_anonymous
            end

            it "should be anonymous" do
                cookies[:rmc] = nil
                current_user.should be_anonymous
            end

            it "should be anonymous" do
                cookies[:rmc] = ''
                current_user.should be_anonymous
            end
        end

        describe "when cookie data is messed up" do
            before(:each) do
                @user = Factory.create( :placement, :email => 'myself@figmentproject.org' )
                cookies[:rmi] = @user.id
                cookies[:rmc] = Digest::SHA1.hexdigest( 'myself@figmentproject.org' )
            end

            it "BS rmc" do
                cookies[:rmc] = 'xyz'
                current_user.should be_anonymous
            end

            it "empty string for rmi" do
                cookies[:rmi] = ''
                current_user.should be_anonymous
            end

            it "non-existent rmi" do
                cookies[:rmi] = '34342341614'
                current_user.should be_anonymous
            end

            it "negative rmi" do
                cookies[:rmi] = '-34'
                current_user.should be_anonymous
            end
        end

        describe "UNsuccessfully" do
            before(:each) do
                @user = User.new
            end

            it "should ask the user if it's logged in" do
                @user.should_receive(:logged_in?).and_return(nil)
                try_login( @user )
            end

            it "should return not true" do
                try_login( @user ).should_not be_true
            end

            it "should set the session user_id to nil" do
                try_login( @user )
                session[:user_id].should be_nil
            end
        end
    end

    describe "logging out" do
        before(:each) do
            @user = Factory.create( :placement )
            try_login(@user, "1")            
        end

        it "should, at start, still be able to find current user" do
            current_user.should eql( @user )
        end

        it "should erase code from user's account" do
            cleanup_at_logout
            current_user.remember_me_code.should be_nil
        end

        it "should delete the remember me ID" do
            cleanup_at_logout
            cookies[:rmi].should be_nil
        end

        it "should delete the remember me code" do
            cleanup_at_logout
            cookies[:rmc].should be_nil
        end
    end

    describe "logging in as (root only)" do
        before(:each) do
            @some_user = Factory.create( :placement )            
        end
        
        describe "as admin" do
            before(:each) do
                @root = Factory.create( :placement, :email => 'root@figmentproject.org' )
                @root.role = User::ADMIN
                @root.save!
                try_login( @root )
            end

            it "should have root's anonymous login nil be default" do
                @root.anonymous_login_code.should be_nil
            end

            it "should save root's anonymous login after login as" do
                try_login_as( @some_user )
                @root.reload
                @root.anonymous_login_code.should be_a_kind_of( String )
            end

            it "should be root" do
                @root.is_admin?.should be_true
            end

            it "should be the current user" do
                current_user.should eql( @root )
            end

            it "current user should be root" do
                current_user.is_admin?.should be_true
            end

            it "return true" do
                try_login_as( @some_user ).should be_true
            end

            it "set session id" do
                try_login_as( @some_user )
                session[:user_id].should eql( @some_user.id )
            end

            it "returning current user" do
                try_login_as( @some_user )
                current_user.should eql( @some_user )
            end

            describe "then logging back out" do

                it "should have root as the current user" do
                    logout_as
                    current_user.should eql( @root )
                end
            end
        end

        describe "as a non-root" do
            before(:each) do
                cleanup_at_logout
                session[:user_id] = nil
            end

            it "should NOT be root" do
                @some_user.is_admin?.should be_false
            end

            it "should be valid" do
                @some_user.should be_valid
            end

            describe "when the user is not, in fact root" do
                before(:each) do
                    @not_root = Factory.create( :placement )
                    try_login( @not_root )
                end

                it "should NOT be root" do
                    @not_root.is_admin?.should be_false
                end

                it "should have root as the current user" do
                    logout_as
                    current_user.is_admin?.should be_false
                end

                it "set retain the session id" do
                    lambda{ try_login_as( @some_user ) }.should raise_error
                    session[:user_id].should eql( @not_root.id )
                end
            end
        end
    end

    describe "signing up" do
        before(:each) do
            @user = Factory.build( :placement )
        end

        def do_it
            try_signup(@user)
        end

        describe "SUCESSFULLY" do
            before do
                @user.stub(:email).and_return('true@france.com')
            end

            it "try to save the user" do
                @user.should_receive(:save).and_return(true)
                do_it
            end

            it "should set the session's user_id to user's id" do
                do_it
                session[:user_id].should eql( @user.id )
            end

            it "should return true" do
                do_it.should be_true
            end
        end

        describe "Unsucessfully" do
            before(:each) do
                @user.email = ''
            end

            it "should return not true" do
                try_signup(@user).should_not be_true
            end

            it "should return the @user upon next call to current_user" do
                try_signup(@user)
                current_user.attributes.should eql( @user.attributes )
            end

            it "should leave the session user_id as before" do
                do_it
                session[:user_id].should be_nil

                session[:user_id] = 'anything T-Man'
                do_it
                session[:user_id].should eql('anything T-Man')
            end

            describe "then saving" do
                before(:each) do
                    @user.email = 'legitimate@figmentproject.org'
                end

                it "should set the session's user_id to user's id" do
                    do_it
                    session[:user_id].should eql( @user.id )
                end

            end
        end
    end

    describe "getting the current user" do

        before(:each) do
            @user = Factory.create( :placement )
            User.stub!(:new).and_return(@user)
        end

        def do_it
            current_user
        end

        it "return the anonymous user if no session[:user_id] exists" do
            do_it.should eql(@user)
        end

        it "should ask the user if it exists" do
            session[:user_id] = 77
            User.should_receive(:exists?).with(77)
            do_it
        end

        describe "when the user has already logged in" do
            before(:each) do
                session[:user_id] = 77
                User.stub!(:exists?).and_return(true)
                User.should_receive(:find).with(77).and_return( @user )
            end

            it "should find the user with id ONCE" do
                do_it.should eql( @user )
                do_it.should eql( @user )
                do_it.should eql( @user )
                do_it.should eql( @user )
            end
        end
    end
end



