# frozen_string_literal: true

class V1::CommentsController < V1::ApiController
  before_action :set_movie, only: %i[ index create ]
  before_action :set_comment, only: %i[ show update destroy ]

  # GET /v1/movies/:movie_id/comments
  def index
    @comments = @movie.comments.recent_first

    render json: @comments
  end

  # GET /v1/comments/:id
  def show
    render json: @comment
  end

  # POST /v1/movies/:movie_id/comments
  def create
    attrs = Movies::CommentAuthorGenerator.call

    @comment = @movie.comments.build(comment_params.merge(attrs))

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/comments/:id
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/comments/:id
  def destroy
    @comment.destroy!
    head :no_content
  end

  private

  def set_movie
    @movie = Movie.find(params.require(:movie_id))
  end

  def set_comment
    @comment = Comment.find(params.require(:id))
  end

    def comment_params
      params.expect(comment: %i[body])
    end
end
