# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class CuratorsController < ApplicationController

    before_filter :require_login
    before_filter :require_admin, :except => [:show, :index]
    before_filter :find_user, :except => [:index, :new, :create]

    def index
        @users = User.curators.ordered_by( params ).find( :all )
    end

    def show
    end

    def new
        @user = User.new
        @user.make_curator
    end

    def edit
    end

    def create
        @user = User.new(params[:user])
        @user.make_curator
        
        if @user.save
            flash[:notice] = 'SUCCESS: Curator account created.'
            redirect_to curator_path( @user )
        else
            render :action => "new"
        end
    end

    def update
        if @user.update_attributes(params[:user])
            flash[:notice] = 'SUCCESS: Curator account updated.'
            render :template => 'curators/show'
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
