# frozen_string_literal: true

class V1::GenresController < V1::ApiController
  before_action :set_genre, only: %i[ show ]

  # GET /v1/genres
  def index
    @genres = Genre.all

    render json: @genres
  end

  # GET /v1/genres/1
  def show
    render json: @genre
  end

  # POST /v1/genres
  # def create
  #   @genre = Genre.new(genre_params)

  #   if @genre.save
  #     render json: @genre, status: :created, location: @genre
  #   else
  #     render json: @genre.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /v1/genres/1
  # def update
  #   if @genre.update(genre_params)
  #     render json: @genre
  #   else
  #     render json: @genre.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /v1/genres/1
  # def destroy
  #   @genre.destroy!
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genre
      @genre = Genre.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def genre_params
      params.expect(genre: [ :name ])
    end
end
