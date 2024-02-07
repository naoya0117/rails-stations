class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy reservation]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
    keyword = params[:keyword]
    is_showing = params[:is_showing]

    @movies = @movies.where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%") if keyword.present?

    return if is_showing.blank?

    @movies = @movies.where(is_showing: is_showing)
  end

  # GET /movies/1 or /movies/1.json
  def show
    @dates = (Date.today..(Date.today + 6)).to_a
    @schedules = @movie.schedules
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def reservation
    @date = params[:date]
    @schedule_id = params[:schedule_id]

    redirect_to movie_path(@movie), notice: '日付または、スケジュールが選択されていません' unless @date && @schedule_id

    @sheets = Sheet.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end
end
