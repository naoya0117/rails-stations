class Admin::MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    @movies = Movie.all
  end

  def show
    @schedules = @movie.schedules
  end

  def new
    @movie = Movie.new
  end

  def edit; end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to admin_movies_path, notice: 'Movie was successfully created.', status: :found
    else
      @movie.errors.add(:base, @movie.errors.full_messages)
      render :new, status: :bad_request
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to admin_movies_path, notice: 'Movie was successfully updated.', status: :found
    else
      @movie.errors.add(:base, @movie.errors.full_messages)
      render :edit, status: :bad_request
    end
  end

  def destroy
    if @movie.destroy
      redirect_to admin_movies_path, notice: @movie.name + ' was deleted.', status: :found
    else
      render :index, status: :bad_request
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end
end
