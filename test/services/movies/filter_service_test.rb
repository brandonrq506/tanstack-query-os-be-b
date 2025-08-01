# frozen_string_literal: true

require "test_helper"

class Movies::FilterServiceTest < ActiveSupport::TestCase
  def setup
    @action_genre = genres(:action)
    @comedy_genre = genres(:comedy)

    @movie1 = movies(:first_movie)
    @movie2 = movies(:second_movie)
  end

  test "filters movies by title case insensitively" do
    service = Movies::FilterService.new
    result = service.call(filter: { title: @movie1.title.upcase })

    assert_includes result, @movie1
  end

  test "filters movies by genre_id" do
    service = Movies::FilterService.new
    result = service.call(filter: { genre_id: @action_genre.id })

    action_movies = result.where(genre_id: @action_genre.id)
    assert action_movies.exists?
  end

  test "filters movies by is_featured" do
    service = Movies::FilterService.new
    result = service.call(filter: { is_featured: true })

    assert result.all?(&:is_featured)
  end

  test "sorts movies by title ascending" do
    service = Movies::FilterService.new
    result = service.call(sort: { sort_by: "title", sort_order: "asc" })

    titles = result.pluck(:title)
    assert_equal titles.sort, titles
  end

  test "sorts movies by genre name" do
    service = Movies::FilterService.new
    result = service.call(sort: { sort_by: "genre_name", sort_order: "asc" })

    # Should join with genres table
    assert result.to_sql.include?("genres")
  end

  test "applies default sorting when invalid parameters provided" do
    service = Movies::FilterService.new
    result = service.call(sort: { sort_by: "invalid_field", sort_order: "invalid_direction" })

    # Should use default sorting (created_at desc) - check for both possible formats
    sql = result.to_sql.upcase
    assert(sql.include?("CREATED_AT DESC") || sql.include?("\"CREATED_AT\" DESC"),
           "Expected SQL to contain created_at DESC, but got: #{result.to_sql}")
  end

  test "sanitizes LIKE input to prevent SQL injection" do
    service = Movies::FilterService.new
    result = service.call(filter: { title: "test%" })

    # Should escape the % character
    assert result.to_sql.include?('test\\%')
  end

  test "combines multiple filters" do
    service = Movies::FilterService.new
    result = service.call(
      filter: {
        title: @movie1.title,
        genre_id: @movie1.genre_id,
        is_featured: @movie1.is_featured
      }
    )

    assert_includes result, @movie1
  end

  test "handles empty filter and sort objects" do
    service = Movies::FilterService.new
    result = service.call(filter: {}, sort: {})

    # Should return all movies with default sorting
    assert result.count > 0
    sql = result.to_sql.upcase
    assert(sql.include?("CREATED_AT DESC") || sql.include?("\"CREATED_AT\" DESC"),
           "Expected SQL to contain created_at DESC, but got: #{result.to_sql}")
  end

  test "combines filtering and sorting" do
    service = Movies::FilterService.new
    result = service.call(
      filter: { is_featured: true },
      sort: { sort_by: "title", sort_order: "asc" }
    )

    # Should filter featured movies and sort by title
    assert result.all?(&:is_featured)
    titles = result.pluck(:title)
    assert_equal titles.sort, titles
  end
end
