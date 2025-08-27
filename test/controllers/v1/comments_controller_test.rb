# frozen_string_literal: true

require "test_helper"

class V1::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:first_movie)
    @comment = comments(:one)
    @recent_comment = comments(:recent_comment)
  end

  # INDEX tests
  test "should get index" do
    get v1_movie_comments_url(@movie), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @movie.comments.count, json_response.length

    # Should be ordered by recent first
    comment_dates = json_response.map { |c| Time.parse(c["created_at"]) }
    assert_equal comment_dates, comment_dates.sort.reverse
  end

  test "should get index for movie with no comments" do
    movie_without_comments = movies(:second_movie)
    movie_without_comments.comments.destroy_all

    get v1_movie_comments_url(movie_without_comments), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_empty json_response
  end

  test "should return 404 for non-existent movie in index" do
    get "/v1/movies/99999/comments", as: :json
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal "Record not found", json_response["error"]
  end

  # SHOW tests
  test "should show comment" do
    get v1_comment_url(@comment), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @comment.id, json_response["id"]
    assert_equal @comment.body, json_response["body"]
    assert_equal @comment.author_name, json_response["author_name"]
    assert_equal @comment.author_color, json_response["author_color"]
  end

  test "should return 404 for non-existent comment" do
    get v1_comment_url(id: 99999), as: :json
    assert_response :not_found
  end

  # CREATE tests
  test "should create comment" do
    assert_difference("Comment.count") do
      post v1_movie_comments_url(@movie),
           params: { comment: { body: "This is a new test comment" } },
           as: :json
    end

    assert_response :created
    json_response = JSON.parse(response.body)

    assert_equal "This is a new test comment", json_response["body"]
    assert_not_nil json_response["author_name"]
    assert_not_nil json_response["author_color"]
    assert_includes Comment::ALLOWED_COLORS, json_response["author_color"]
  end

  test "should increment movie comments_count when creating comment" do
    initial_count = @movie.reload.comments_count

    post v1_movie_comments_url(@movie),
         params: { comment: { body: "Test comment for counter" } },
         as: :json

    assert_equal initial_count + 1, @movie.reload.comments_count
  end

  test "should not create comment with empty body" do
    assert_no_difference("Comment.count") do
      post v1_movie_comments_url(@movie),
           params: { comment: { body: "" } },
           as: :json
    end

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_includes json_response["body"], "can't be blank"
  end

  test "should not create comment with body too long" do
    long_body = "a" * 2001

    assert_no_difference("Comment.count") do
      post v1_movie_comments_url(@movie),
           params: { comment: { body: long_body } },
           as: :json
    end

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_includes json_response["body"], "is too long (maximum is 2000 characters)"
  end

  test "should sanitize HTML in comment body" do
    html_body = "<script>alert('xss')</script><p>Safe content</p>"

    post v1_movie_comments_url(@movie),
         params: { comment: { body: html_body } },
         as: :json

    assert_response :created
    json_response = JSON.parse(response.body)
    # strip_tags removes all HTML but keeps text content
    assert_equal "alert('xss')Safe content", json_response["body"]
  end

  test "should not create comment without comment params" do
    assert_no_difference("Comment.count") do
      post v1_movie_comments_url(@movie), params: {}, as: :json
    end

    assert_response :bad_request
  end

  test "should return 404 when creating comment for non-existent movie" do
    assert_no_difference("Comment.count") do
      post "/v1/movies/99999/comments",
           params: { comment: { body: "Test comment" } },
           as: :json
    end

    assert_response :not_found
  end

  # UPDATE tests
  test "should update comment" do
    new_body = "Updated comment body"

    patch v1_comment_url(@comment),
          params: { comment: { body: new_body } },
          as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal new_body, json_response["body"]

    @comment.reload
    assert_equal new_body, @comment.body
  end

  test "should not update comment with invalid body" do
    long_body = "a" * 2001

    patch v1_comment_url(@comment),
          params: { comment: { body: long_body } },
          as: :json

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_includes json_response["body"], "is too long (maximum is 2000 characters)"
  end

  test "should sanitize HTML when updating comment" do
    html_body = "<script>alert('xss')</script><p>Updated content</p>"

    patch v1_comment_url(@comment),
          params: { comment: { body: html_body } },
          as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    # strip_tags removes all HTML but keeps text content
    assert_equal "alert('xss')Updated content", json_response["body"]
  end

  test "should return 404 when updating non-existent comment" do
    patch v1_comment_url(id: 99999),
          params: { comment: { body: "Updated body" } },
          as: :json

    assert_response :not_found
  end

  # DESTROY tests
  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete v1_comment_url(@comment), as: :json
    end

    assert_response :no_content
    assert_empty response.body
  end

  test "should decrement movie comments_count when destroying comment" do
    initial_count = @movie.reload.comments_count

    delete v1_comment_url(@comment), as: :json

    assert_equal initial_count - 1, @movie.reload.comments_count
  end

  test "should return 404 when destroying non-existent comment" do
    assert_no_difference("Comment.count") do
      delete v1_comment_url(id: 99999), as: :json
    end

    assert_response :not_found
  end

  # Edge cases and integration tests
  test "should handle concurrent comment creation" do
    # Simulate multiple comments being created at the same time
    threads = []

    5.times do |i|
      threads << Thread.new do
        post v1_movie_comments_url(@movie),
             params: { comment: { body: "Concurrent comment #{i}" } },
             as: :json
      end
    end

    threads.each(&:join)

    # All should succeed without race conditions
    assert @movie.reload.comments_count >= 5
  end

  test "should maintain referential integrity" do
    comment_id = @comment.id

    # Delete the comment
    delete v1_comment_url(@comment), as: :json
    assert_response :no_content

    # Verify it's actually gone
    assert_raises(ActiveRecord::RecordNotFound) do
      Comment.find(comment_id)
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
