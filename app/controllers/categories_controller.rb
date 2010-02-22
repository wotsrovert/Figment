class CategoriesController < ApplicationController

    before_filter :require_admin
    before_filter :find_category, :except => [:index, :new, :create]

    def index
        @categories = Category.find(:all)
    end

    def show
    end

    def new
        @category = Category.new
    end

    def edit
    end

    def create
        @category = Category.new(params[:category])

        if @category.save
            flash[:notice] = 'Categorie was successfully created.'
            redirect_to(categories_path)
        else
            render :action => "new"
        end
    end

    def update
        if @category.update_attributes(params[:category])
            flash[:notice] = 'Categorie was successfully updated.'
            redirect_to(categories_path)
        else
            render :action => "edit"
        end
    end

    def destroy
        @category.destroy

        redirect_to(categories_url)
    end

    protected
    def find_category
        @category = Category.find(params[:id])
    end
end
