# frozen_string_literal: true

require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @movie = movies(:first_movie)
    @comment = comments(:one)
  end

  # Association tests
  test "should belong to movie" do
    assert_respond_to @comment, :movie
    assert_equal @movie, @comment.movie
  end

  test "should increment movie comments_count on create" do
    initial_count = @movie.reload.comments_count

    @movie.comments.create!(
      body: "Test comment",
      author_name: "Test Author",
      author_color: "blue"
    )

    assert_equal initial_count + 1, @movie.reload.comments_count
  end

  test "should decrement movie comments_count on destroy" do
    initial_count = @movie.reload.comments_count

    @comment.destroy!

    assert_equal initial_count - 1, @movie.reload.comments_count
  end

  # Validation tests
  test "should be valid with all required attributes" do
    comment = Comment.new(
      movie: @movie,
      body: "Valid comment body",
      author_name: "Valid Author",
      author_color: "blue"
    )

    assert comment.valid?
  end

  test "should require body" do
    @comment.body = nil
    assert_not @comment.valid?
    assert_includes @comment.errors[:body], "can't be blank"
  end

  test "should require body to be at least 1 character" do
    @comment.body = ""
    assert_not @comment.valid?
    assert_includes @comment.errors[:body], "is too short (minimum is 1 character)"
  end

  test "should not allow body longer than 2000 characters" do
    @comment.body = "a" * 2001
    assert_not @comment.valid?
    assert_includes @comment.errors[:body], "is too long (maximum is 2000 characters)"
  end

  test "should allow body with exactly 2000 characters" do
    @comment.body = "a" * 2000
    assert @comment.valid?
  end

  test "should require author_name" do
    @comment.author_name = nil
    assert_not @comment.valid?
    assert_includes @comment.errors[:author_name], "can't be blank"
  end

  test "should require author_color" do
    @comment.author_color = nil
    assert_not @comment.valid?
    assert_includes @comment.errors[:author_color], "can't be blank"
  end

  test "should only allow valid colors" do
    Comment::ALLOWED_COLORS.each do |color|
      @comment.author_color = color
      assert @comment.valid?, "#{color} should be a valid color"
    end
  end

  test "should not allow invalid colors" do
    invalid_colors = %w[black white silver gold purple]

    invalid_colors.each do |color|
      @comment.author_color = color
      assert_not @comment.valid?, "#{color} should not be a valid color"
      assert_includes @comment.errors[:author_color], "is not included in the list"
    end
  end

  test "should require movie association" do
    @comment.movie = nil
    assert_not @comment.valid?
    assert_includes @comment.errors[:movie], "must exist"
  end

  # Scope tests
  test "recent_first scope should order by created_at descending" do
    comments = Comment.recent_first.limit(3)

    comments.each_cons(2) do |newer, older|
      assert newer.created_at >= older.created_at,
             "Comments should be ordered from newest to oldest"
    end
  end

  # Sanitization tests
  test "should sanitize HTML tags from body before save" do
    @comment.body = "<script>alert('xss')</script><p>Safe content</p><b>Bold text</b>"
    @comment.save!

    # strip_tags removes all HTML tags but keeps the content
    assert_equal "alert('xss')Safe contentBold text", @comment.body
  end

  test "should preserve plain text content during sanitization" do
    plain_text = "This is plain text with no HTML tags."
    @comment.body = plain_text
    @comment.save!

    assert_equal plain_text, @comment.body
  end

  test "should handle empty body during sanitization" do
    @comment.body = "<script></script>"
    @comment.save!

    assert_equal "", @comment.body
  end

  test "should sanitize body even with just whitespace and tags" do
    @comment.body = "  <div>  </div>  "
    @comment.save!

    # strip_tags removes tags but preserves whitespace
    assert_equal "      ", @comment.body
  end

  # Edge cases
  test "should handle unicode characters in body" do
    unicode_body = "Comment with émojis 🎬 and spëcial çharacters"
    @comment.body = unicode_body
    @comment.save!

    assert_equal unicode_body, @comment.body
  end

  test "should handle very long author names" do
    # While not explicitly validated, test reasonable limits
    long_name = "Very Long Author Name That Goes On And On" * 10
    @comment.author_name = long_name

    # Should still be valid (no length validation on author_name)
    assert @comment.valid?
  end

  test "should maintain referential integrity when movie is destroyed" do
    comment_id = @comment.id

    # This should cascade delete the comment due to dependent: :destroy
    @movie.destroy!

    assert_raises(ActiveRecord::RecordNotFound) do
      Comment.find(comment_id)
    end
  end

  # Class method tests
  test "ALLOWED_COLORS should be frozen array" do
    assert Comment::ALLOWED_COLORS.frozen?
    assert_instance_of Array, Comment::ALLOWED_COLORS
    assert Comment::ALLOWED_COLORS.length > 0
  end

  test "ALLOWED_COLORS should contain expected color names" do
    expected_colors = %w[red orange amber yellow lime green emerald teal cyan sky blue indigo violet fuchsia pink rose]
    assert_equal expected_colors, Comment::ALLOWED_COLORS
  end

  # Performance tests
  test "should efficiently query recent comments" do
    # Create a bunch of comments to test performance
    50.times do |i|
      Comment.create!(
        movie: @movie,
        body: "Comment number #{i}",
        author_name: "Author #{i}",
        author_color: Comment::ALLOWED_COLORS.sample
      )
    end

    # This should be efficient due to the index on (movie_id, created_at)
    # We'll just verify the query works without assert_queries since it's not available
    recent_comments = @movie.comments.recent_first.limit(10).to_a
    assert_equal 10, recent_comments.length

    # Verify ordering
    recent_comments.each_cons(2) do |newer, older|
      assert newer.created_at >= older.created_at
    end
  end
end
