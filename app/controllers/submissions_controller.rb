# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

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
                :biography       => "Born in London",
                :names_list      => "Homer, Marge, Bart, Lisa, Maggie",
                :website         => 'http://www.thesimpsons.com',
                :group_email     => 'members@simpsons.com',
                :contact_name    =>"Trevor Stow",
                :public_name     => "T-Man Collective",
                :contact_phone   => "917.499.0583",
                :contact_email   => "trevorstow@gmail.com",
                :is_organization => "1"
            )
            @project = Project.new( 
                :title       =>"Testing Project",
                :description => "Something very awesome"
            )
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
        @project.answers.each do |a|
            a.find_in( params[:questions] )
        end


        if @artist.valid? && @project.valid? && @project.all_questions_answered?
            @artist.save!
            @project.artist = @artist
            @project.save!
            @project.answers.each { |q| q.save! }
            flash[:notice] = 'Project was successfully created.'
            redirect_to new_submission_program_path( @project.to_param )
            return
        end
        
        
        if ! @project.all_questions_answered?
            flash[:error] = "Please answer all questions below."
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
