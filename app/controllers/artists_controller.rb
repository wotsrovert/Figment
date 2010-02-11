class ArtistsController < ApplicationController

    before_filter :find_artist, :except => [:index, :new, :create]

    def index
        @artists = Artist.find(:all)
    end

    def show
    end

    def new
        @artist = Artist.new
    end

    def edit
    end

    def create
        @artist = Artist.new(params[:artist])

        if @artist.save
            flash[:notice] = 'Artist was successfully created.'
            redirect_to(artists_path)
        else
            render :action => "new"
        end
    end

    def update
        if @artist.update_attributes(params[:artist])
            flash[:notice] = 'Artist was successfully updated.'
            redirect_to(artists_path)
        else
            render :action => "edit"
        end
    end

    def destroy
        @artist.destroy

        redirect_to(artists_url)
    end

    protected
    def find_artist
        @artist = Artist.find(params[:id])
    end
end
