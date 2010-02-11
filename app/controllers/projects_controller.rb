class ProjectsController < ApplicationController

    layout 'public'
    
    before_filter :find_artist
    before_filter :find_project, :except => [:index, :new, :create, :thank_you]

    def index
        @projects = Project.find(:all)
    end

    def show
    end

    def new
        @artist ||= Artist.new
        @project = Project.new
    end

    def edit
    end

    def create
        @artist ||= Artist.new( params[:artist] )
        @project = Project.new( params[:project] )
        
        @project.valid?
        if @artist.valid? && @project.valid?
            @artist.save 
            @project.artist = @artist
            if @project.save!
                flash[:notice] = 'Project was successfully created.'
                redirect_to :action => 'thank_you'
                return
            else
                flash[:error] = "Unable to save your project.  See below for details."
            end
        else
            flash[:error] = "Unable to save your project.  Please see below for details."
        end
        render :action => "new"
    end

    def thank_you
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
    def find_artist
        if params[:artist_id]
            @artist = Artist.find(params[:artist_id])
        end
    end
    def find_project
        @project = Project.find(params[:id])
    end
end
