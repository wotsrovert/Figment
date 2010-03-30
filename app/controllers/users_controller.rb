class UsersController < ApplicationController

    before_filter :find_user, :except => [:index, :new, :create]
    before_filter :require_admin
    
    def index
        @users = User.ordered_by( params ).find(:all)
    end

    def show
    end

    def new
        @user = User.new
    end

    def edit
    end

    def create
        @user = User.new(params[:user])

        if @user.save
            flash[:notice] = 'User was successfully created.'
            redirect_to(users_path)
        else
            render :action => "new"
        end
    end

    def update
        if @user.update_attributes(params[:user])
            flash[:notice] = 'User was successfully updated.'
            redirect_to(users_path)
        else
            render :action => "edit"
        end
    end

    def destroy
        @user.destroy

        redirect_to(users_url)
    end

    protected
    def find_user
        @user = User.find(params[:id])
    end
end
