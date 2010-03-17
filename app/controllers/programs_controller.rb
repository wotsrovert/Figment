class ProgramsController < ApplicationController

    before_filter :require_login
    before_filter :find_project, :only => [ :index, :new, :create ]
    before_filter :find_program, :except => [:index, :new, :create]

    def index
        params[:sort] ||= 'id'
        params[:dir] ||= 'ASC'
        @programs = @project.programs.find(:all, :order => ( params[:sort] ? "#{params[:sort]} #{ params[:dir] }" : nil ))
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
            redirect_to( project_programs_path( @project ))
        else
            render :action => "new"
        end
    end

    def update
        if @program.update_attributes(params[:program])
            flash[:notice] = 'Program was successfully updated.'
            redirect_to( project_programs_path( @program.project ))
        else
            render :action => "edit"
        end
    end

    def destroy
        p = @program.project
        @program.destroy

        redirect_to( project_programs_path( p ))
    end

    protected
    def find_program
        @program = Program.find(params[:id])
    end
    def find_project
        @project = Project.find(params[:project_id])
    end
end
