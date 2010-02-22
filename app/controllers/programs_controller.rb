class ProgramsController < ApplicationController

    before_filter :require_login
    before_filter :find_project
    before_filter :find_program, :except => [:index, :new, :create]

    def index
        @programs = Program.find(:all)
    end

    def show
    end

    def new
        @program = Program.new
    end

    def edit
    end

    def create
        @program = Program.new(params[:program])

        if @program.save
            flash[:notice] = 'Program was successfully created.'
            redirect_to(programs_path)
        else
            render :action => "new"
        end
    end

    def update
        if @program.update_attributes(params[:program])
            flash[:notice] = 'Program was successfully updated.'
            redirect_to(programs_path)
        else
            render :action => "edit"
        end
    end

    def destroy
        @program.destroy

        redirect_to(programs_url)
    end

    protected
    def find_program
        @program = Program.find(params[:id])
    end
    def find_project
        @project = Project.find(params[:project_id])
    end
end
