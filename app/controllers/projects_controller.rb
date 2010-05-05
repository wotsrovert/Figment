# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class ProjectsController < ApplicationController

    layout 'public'

    before_filter :require_login
    before_filter :require_director_admin_or_curator, :only => [ :curatorial, :logistics ]
    before_filter :find_project, :except => [:index]

    def index
        params[:sort] ||= 'id'
        params[:dir] ||= 'ASC'
        @projects = Project.find(:all, :include => [:categories], :order => ( params[:sort] ? "#{params[:sort]} #{ params[:dir] }" : nil ))
    end

    def curatorial
        @project.edited_by( current_user )
        if request.put?
            if @project.edited_by( current_user ).update_attributes( params[:project] ) && @project.artist.update_attributes( params[:artist] )
                flash[:notice] = 'Project was successfully updated.'
            else
                flash[:error] = 'FAILED:  Project was not saved.  See below.'
            end        
        end
    end

    def logistics
        @project.edited_by( current_user )
        if request.put?
            if @project.edited_by( current_user ).update_attributes( params[:project] ) && @project.artist.update_attributes( params[:artist] )
                flash[:notice] = 'Project was successfully updated.'
            else
                flash[:error] = 'FAILED:  Project was not saved.  See below.'
            end        
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
    
    def require_director_admin_or_curator
        if current_user.is_admin? || current_user.is_director? || current_user.is_curator?
            return true
        end
        raise Errors::Permission::EditProject
    end
end
