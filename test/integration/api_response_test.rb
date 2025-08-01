require "test_helper"

class ApiResponseTest < ActionDispatch::IntegrationTest
  test "movies index returns properly serialized response" do
    get v1_movies_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_instance_of Array, json_response

    if json_response.any?
      movie = json_response.first

      # Should have exactly these 3 fields from MoviePreviewSerializer
      expected_keys = %w[id title thumbnail_url].sort
      actual_keys = movie.keys.sort
      assert_equal expected_keys, actual_keys, "Response should contain exactly: #{expected_keys.join(', ')}"

      # Verify data types
      assert_instance_of Integer, movie["id"]
      assert_instance_of String, movie["title"]
      assert_instance_of String, movie["thumbnail_url"]
    end
  end

  test "movie show returns full movie object" do
    movie = movies(:first_movie)
    get v1_movie_url(movie), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)

    # Should have all movie attributes, not just the preview ones
    assert_includes json_response.keys, "sinopsis"
    assert_includes json_response.keys, "trailer_url"
    assert_includes json_response.keys, "duration_secs"
    assert_includes json_response.keys, "genre_id"
    assert_includes json_response.keys, "is_featured"
    assert_includes json_response.keys, "published_at"

    assert_equal movie.id, json_response["id"]
    assert_equal movie.title, json_response["title"]
  end
end
