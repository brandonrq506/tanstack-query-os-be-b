require "test_helper"

class GenreTest < ActiveSupport::TestCase
  setup do
    @genre = genres(:action)
  end

  test "should be valid with name" do
    genre = Genre.new(name: "Horror")
    assert genre.valid?
  end

  test "should have many movies" do
    assert_respond_to @genre, :movies
    assert_kind_of ActiveRecord::Associations::CollectionProxy, @genre.movies
  end

  test "should return movies associated with genre" do
    movies = @genre.movies
    movies.each do |movie|
      assert_equal @genre.id, movie.genre_id
    end
  end
end
