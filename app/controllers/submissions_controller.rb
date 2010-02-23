class SubmissionsController < ApplicationController

    before_filter :find_project, :except => [:new, :create]

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
                redirect_to url_for( :action => 'schedule', :id => @project.to_param )
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
            flash[:notice] = 'Submission was successfully updated.'
            redirect_to(projects_path)
        else
            render :action => "edit"
        end
    end

    protected
    def find_project
        @project = Project.find(params[:id])
    end
end
