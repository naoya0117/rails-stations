class Admin::MoviesController < ApplicationController
    def index
        @movies = Movie.all
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)

        if @movie.save
            redirect_to admin_movies_path, notice: "Movie was successfully created.", status: :found
        else
            flash.now[:alert] = @movie.errors.full_messages.to_sentence
            render :new, status: :unprocessable_entity
        end
    rescue => e
        flash.now[:alert] = e.message
        render :new, status: :bad_request

    def movie_params 
        params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
    end

end
