class QuestionsController < ApplicationController

    before_filter :find_question, :except => [:index, :new, :create]

    def index
        @questions = Question.find(:all)
    end

    def show
    end

    def new
        @question = Question.new
    end

    def edit
    end

    def create
        @question = Question.new(params[:question])
        # raise params[:question].inspect
        
        if @question.save
            flash[:notice] = 'Question was successfully created.'
            redirect_to(questions_path)
        else
            render :action => "new"
        end
    end

    def update
        if @question.update_attributes(params[:question])
            flash[:notice] = 'Question was successfully updated.'
            redirect_to(questions_path)
        else
            render :action => "edit"
        end
    end

    def destroy
        @question.destroy

        redirect_to(questions_url)
    end

    protected
    def find_question
        @question = Question.find(params[:id])
    end
end
