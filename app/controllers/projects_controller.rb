# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class ProjectsController < ApplicationController

    layout 'public'

    before_filter :require_login
    before_filter :find_project, :except => [:index]

    def index
        params[:sort] ||= 'id'
        params[:dir] ||= 'ASC'
        @projects = Project.find(:all, :include => [:categories], :order => ( params[:sort] ? "#{params[:sort]} #{ params[:dir] }" : nil ))
    end

    def show
    end

    def edit
    end

    def update
        if @project.update_attributes( params[:project] ) && @project.artist.update_attributes( params[:artist] )
            flash[:notice] = 'Project was successfully updated.'
            redirect_to(projects_path)
        else
            render :action => "edit"
        end
    end

    def destroy
        @project.destroy
        redirect_to(projects_url)
    end

    protected
    def find_project
        @project = Project.find(params[:id])
    end
end
