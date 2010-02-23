class SubmissionsController < ApplicationController

    before_filter :find_project, :except => [:index, :new, :create]

    def index
        @artist ||= Artist.new
        @project = Project.new
        
        render :action => 'new'
    end

    def show
    end

    def new
        if RAILS_ENV == 'development'
            @artist ||= Artist.new(
                :contact_name    =>"Trevor Stow",
                :public_name     => "T-Man Collective",
                :contact_phone   => "917.499.0583",
                :contact_email   => "trevorstow@gmail.com",
                :is_organization => "1"
            )
            @project = Project.new( :title =>"Testing Project" )
        else
            @artist ||= Artist.new
            @project = Project.new
        end
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
                redirect_to new_submission_program_path( @project.to_param )
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
