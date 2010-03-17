# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class SubmissionProgramsController < ApplicationController

    before_filter :find_project
    before_filter :find_program, :except => [:index, :new, :create]

    def index
        @programs = @project.programs.find(:all)
    end

    def show
    end

    def new
        @program = @project.programs.new
        @programs = @project.programs.find(:all)
    end

    def edit
        @programs = @program.project.programs.find(:all)
    end

    def create
        @program = @project.programs.new(params[:program])

        if @program.save
            flash[:notice] = 'Program was successfully created.'
            redirect_to( submission_programs_path( @project ))
        else
            render :action => "new"
        end
    end

    def update
        if @program.update_attributes(params[:program])
            flash[:notice] = 'Program was successfully updated.'
            redirect_to( submission_programs_path( @project ))
        else
            render :action => "edit"
        end
    end

    def destroy
        p = @program.project
        @program.destroy

        redirect_to( submission_programs_path( p ))
    end

    protected
    def find_program
        @program = @project.programs.find(params[:id])
    end
    def find_project
        @project = Project.find(params[:submission_id])
    end
end
