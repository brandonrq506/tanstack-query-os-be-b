require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get movies_url, as: :json
    assert_response :success
  end

  test "should create movie" do
    assert_difference("Movie.count") do
      post movies_url, params: { movie: { duration_secs: @movie.duration_secs, genre_id: @movie.genre_id, is_featured: @movie.is_featured, published_at: @movie.published_at, sinopsis: @movie.sinopsis, thumbnail_url: @movie.thumbnail_url, title: @movie.title, trailer_url: @movie.trailer_url } }, as: :json
    end

    assert_response :created
  end

  test "should show movie" do
    get movie_url(@movie), as: :json
    assert_response :success
  end

  test "should update movie" do
    patch movie_url(@movie), params: { movie: { duration_secs: @movie.duration_secs, genre_id: @movie.genre_id, is_featured: @movie.is_featured, published_at: @movie.published_at, sinopsis: @movie.sinopsis, thumbnail_url: @movie.thumbnail_url, title: @movie.title, trailer_url: @movie.trailer_url } }, as: :json
    assert_response :success
  end

  test "should destroy movie" do
    assert_difference("Movie.count", -1) do
      delete movie_url(@movie), as: :json
    end

    assert_response :no_content
  end
end
