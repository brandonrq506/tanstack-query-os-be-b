# frozen_string_literal: true

class V1::MoviesController < V1::ApiController
  before_action :set_movie, only: %i[ show  ]

  # GET /v1/movies
  def index
    @movies = Movies::FilterService.new(Movie.includes(:genre)).call(filter_params)

    render json: @movies, each_serializer: MoviePreviewSerializer
  end

  # GET /v1/movies/1
  def show
    render json: @movie
  end

  # GET /v1/movies/coming_soon
  def coming_soon
    @movies = Movies::FilterService.new(Movie.is_not_published.includes(:genre))
                                   .call(filter_params)
                                   .order(published_at: :asc)

    render json: @movies, each_serializer: MoviePreviewSerializer
  end

  # GET /v1/movies/featured
  def featured
    @movies = Movies::FilterService.new(Movie.is_featured.is_published.includes(:genre))
                                   .call(filter_params)
                                   .order(published_at: :desc)

    render json: @movies, each_serializer: MoviePreviewSerializer
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

    # Strong parameters for filtering and sorting with nested structure
    def filter_params
      params.permit(
        filter: [ :title, :genre_id, :genre_name, :is_featured, :duration_secs, :published_at, :created_at, :updated_at ],
        sort: [ :sort_by, :sort_order ]
      )
    end
end
