# (c) Copyright 2010 Trevor Stow. All Rights Reserved.

class AnswersController < ApplicationController

    before_filter :find_project
    before_filter :find_answer, :except => [:index]

    def index
        @answers = @project.programs.find(:all)
    end

    def show
    end

    def update
        if @answer.update_attributes(params[:answer])
            redirect_to( 
                if @project.answer_after( @answer )
                    submission_answer_path( @project, @project.answer_after( @answer ))
                else
                    new_submission_program_path( @project )
                end
            )
        else
            render :action => "edit"
        end
    end

    protected
    def find_answer
        @answer = @project.answers.find(params[:id])
    end
    def find_project
        @project = Project.find(params[:submission_id])
    end
end
