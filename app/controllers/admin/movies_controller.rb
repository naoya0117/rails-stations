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
            @movie.errors.add(:base, @movie.errors.full_messages)
            render :new, status: :bad_request
        end
    end

    def movie_params 
        params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
    end

end
