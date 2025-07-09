# frozen_string_literal: true

class V1::MoviesController < V1::ApiController
  before_action :set_movie, only: %i[ show  ]

  # GET /v1/movies
  def index
  @movies = Movie.select(:id, :title, :thumbnail_url)
  render json: @movies
  end

  # GET /v1/movies/1
  def show
    render json: @movie
  end

  # GET /v1/movies/coming_soon
  def coming_soon
    @movies = Movie.is_not_published.order(published_at: :asc)
    render json: @movies
  end

  # GET /v1/movies/featured
  def featured
    @movies = Movie.is_featured.is_published.order(published_at: :desc)
    render json: @movies
  end

  # POST /movies
  # def create
  #   @movie = Movie.new(movie_params)

  #   if @movie.save
  #     render json: @movie, status: :created, location: @movie
  #   else
  #     render json: @movie.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /movies/1
  # def update
  #   if @movie.update(movie_params)
  #     render json: @movie
  #   else
  #     render json: @movie.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /movies/1
  # def destroy
  #   @movie.destroy!
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.expect(movie: [ :title, :sinopsis, :trailer_url, :thumbnail_url, :duration_secs, :genre_id, :is_featured, :published_at ])
    end
end
