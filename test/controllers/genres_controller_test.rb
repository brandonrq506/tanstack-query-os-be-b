require "test_helper"

class V1::GenresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @genre = genres(:action)
  end

  test "should get index" do
    get v1_genres_url, as: :json
    assert_response :success
  end

  test "should show genre" do
    get v1_genre_url(@genre), as: :json
    assert_response :success
  end
end
