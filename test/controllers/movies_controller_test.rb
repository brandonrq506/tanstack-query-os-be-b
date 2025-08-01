require "test_helper"

class V1::MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:first_movie)
    @genre = genres(:action)
  end

  test "should get index" do
    get v1_movies_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_instance_of Array, json_response

    # Check that response uses MoviePreviewSerializer format
    if json_response.any?
      movie = json_response.first
      assert_includes movie.keys, "id"
      assert_includes movie.keys, "title"
      assert_includes movie.keys, "thumbnail_url"
      # MoviePreviewSerializer should only include these 3 fields
      assert_equal 3, movie.keys.size
    end
  end

  test "should get index with filtering" do
    get v1_movies_url(filter: { title: "Spider" }), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_instance_of Array, json_response
  end

  test "should get index with sorting" do
    get v1_movies_url(sort: { sort_by: "title", sort_order: "asc" }), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_instance_of Array, json_response
  end

  test "should get featured movies" do
    get featured_v1_movies_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_instance_of Array, json_response
  end

  test "should get coming soon movies" do
    get coming_soon_v1_movies_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_instance_of Array, json_response
  end

  test "should show movie" do
    get v1_movie_url(@movie), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @movie.id, json_response["id"]
    assert_equal @movie.title, json_response["title"]
    # Show action should return full movie object, not serialized
    assert_includes json_response.keys, "sinopsis"
    assert_includes json_response.keys, "trailer_url"
    assert_includes json_response.keys, "duration_secs"
  end

  test "should return 404 for non-existent movie" do
    get v1_movie_url(99999), as: :json
    assert_response :not_found
  end
end
