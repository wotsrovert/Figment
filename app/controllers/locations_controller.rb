# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class LocationsController < ApplicationController

    before_filter :require_admin
    before_filter :find_location, :except => [:index, :new, :create]

    def index
        @locations = Location.find(:all)
    end

    def show
    end

    def new
        @location = Location.new
    end

    def edit
    end

    def create
        @location = Location.new(params[:location])

        if @location.save
            flash[:notice] = 'Location was successfully created.'
            redirect_to(locations_path)
        else
            render :action => "new"
        end
    end

    def update
        if @location.update_attributes(params[:location])
            flash[:notice] = 'Location was successfully updated.'
            redirect_to(locations_path)
        else
            render :action => "edit"
        end
    end

    def destroy
        @location.destroy

        redirect_to(locations_url)
    end

    protected
    def find_location
        @location = Location.find(params[:id])
    end
end
