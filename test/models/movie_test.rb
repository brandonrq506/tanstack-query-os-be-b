require "test_helper"

class MovieTest < ActiveSupport::TestCase
  setup do
    @genre = genres(:action)
    @movie = movies(:first_movie)
  end

  test "should be valid with all required attributes" do
    movie = Movie.new(
      title: "Test Movie",
      sinopsis: "Test synopsis",
      trailer_url: "https://example.com/trailer.mp4",
      thumbnail_url: "https://example.com/thumbnail.jpg",
      duration_secs: 7200,
      genre: @genre,
      is_featured: false,
      published_at: Time.current
    )
    assert movie.valid?
  end

  test "should require title" do
    @movie.title = nil
    assert_not @movie.valid?
    assert_includes @movie.errors[:title], "can't be blank"
  end

  test "should require genre" do
    @movie.genre = nil
    assert_not @movie.valid?
    assert_includes @movie.errors[:genre_id], "can't be blank"
  end

  test "should require is_featured to be boolean" do
    @movie.is_featured = nil
    assert_not @movie.valid?
    assert_includes @movie.errors[:is_featured], "is not included in the list"
  end

  test "published scope should return published movies" do
    published_movies = Movie.is_published
    published_movies.each do |movie|
      assert movie.published_at <= Time.current
    end
  end

  test "not published scope should return future movies" do
    unpublished_movies = Movie.is_not_published
    unpublished_movies.each do |movie|
      assert movie.published_at > Time.current
    end
  end

  test "featured scope should return featured movies" do
    featured_movies = Movie.is_featured
    featured_movies.each do |movie|
      assert movie.is_featured
    end
  end

  test "by_title scope should filter by title" do
    movies = Movie.by_title("Spider")
    assert movies.any?
    movies.each do |movie|
      assert_match(/spider/i, movie.title)
    end
  end

  test "by_genre scope should filter by genre" do
    movies = Movie.by_genre(@genre.id)
    assert movies.any?
    movies.each do |movie|
      assert_equal @genre.id, movie.genre_id
    end
  end

  test "by_featured scope should filter by featured status" do
    movies = Movie.by_featured(true)
    movies.each do |movie|
      assert movie.is_featured
    end
  end
end
