class CuratorsController < ApplicationController

    before_filter :find_user, :except => [:index, :new, :create]

    def index
        @users = User.curators
    end

    def show
    end

    def new
        @user = User.new
        @user.is_curator = true
    end

    def edit
    end

    def create
        @user = User.new(params[:user])
        @user.is_curator = true
        
        if @user.save
            flash[:notice] = 'SUCCESS: Curator account created.'
            redirect_to curators_path
        else
            render :action => "new"
        end
    end

    def update
        if @user.update_attributes(params[:user])
            flash[:notice] = 'SUCCESS: Curator account updated.'
            redirect_to curators_path
        else
            render :action => "edit"
        end
    end

    def destroy
        @user.destroy

        redirect_to curators_path
    end

    protected
    def find_user
        @user = User.find(params[:id])
    end
end
