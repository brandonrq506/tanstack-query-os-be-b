# frozen_string_literal: true

class V2::CommentsController < V2::ApiController
  before_action :set_movie

  # GET /v2/movies/:movie_id/comments
  def index
    pagy, records = pagy(@movie.comments.recent_first, page: params[:page], limit: params[:per_page])

    comments = ActiveModelSerializers::SerializableResource.new(
      records,
      each_serializer: CommentSerializer
    ).as_json

    render json: {
      comments: comments,
      meta: build_meta(pagy)
    }
  end

  private

  def set_movie
    @movie = Movie.find(params.require(:movie_id))
  end

  def build_meta(pagy)
    page = pagy.page
    per_page = pagy.limit
    total_pages = pagy.pages
    total_count = pagy.count

    {
      page: page,
      per_page: per_page,
      total_pages: total_pages,
      total_count: total_count,
      next: (page < total_pages ? page + 1 : nil),
      prev: (page > 1 ? page - 1 : nil)
    }
  end
end
