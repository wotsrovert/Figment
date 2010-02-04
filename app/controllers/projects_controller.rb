class ProjectsController < ApplicationController

    before_filter :find_project, :except => [:index, :new, :create]

    def index
        @projects = Project.find(:all)
    end

    def show
    end

    def new
        @project = Project.new
    end

    def edit
    end

    def create
        @project = Project.new(params[:project])

        if @project.save
            flash[:notice] = 'Project was successfully created.'
            redirect_to(projects_path)
        else
            render :action => "new"
        end
    end

    def update
        if @project.update_attributes(params[:project])
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
