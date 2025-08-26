# frozen_string_literal: true

require "test_helper"

class Movies::CommentAuthorGeneratorTest < ActiveSupport::TestCase
  # Basic functionality tests
  test "should return hash with author_name and author_color" do
    result = Movies::CommentAuthorGenerator.call

    assert_instance_of Hash, result
    assert_includes result.keys, :author_name
    assert_includes result.keys, :author_color
  end

  test "should generate author_name with adjective and animal" do
    result = Movies::CommentAuthorGenerator.call
    author_name = result[:author_name]

    assert_instance_of String, author_name
    assert_includes author_name, " "  # Should have space between adjective and animal

    parts = author_name.split(" ")
    assert_equal 2, parts.length

    adjective, animal = parts
    assert_includes Movies::CommentAuthorGenerator::ADJECTIVES, adjective
    assert_includes Movies::CommentAuthorGenerator::ANIMALS, animal
  end

  test "should generate valid author_color" do
    result = Movies::CommentAuthorGenerator.call
    author_color = result[:author_color]

    assert_instance_of String, author_color
    assert_includes Comment::ALLOWED_COLORS, author_color
  end

  # Randomness tests
  test "should generate different results on multiple calls" do
    results = 10.times.map { Movies::CommentAuthorGenerator.call }

    # With the variety of adjectives, animals, and colors, we should get different results
    unique_names = results.map { |r| r[:author_name] }.uniq

    # Should have some variety (not all identical)
    assert unique_names.length > 1, "Should generate different author names"
    # Colors might be the same due to limited options, but names should vary
  end

  # Deterministic behavior with seed
  test "should generate same result with same seed" do
    seed = 12345

    result1 = Movies::CommentAuthorGenerator.call(seed: seed)
    result2 = Movies::CommentAuthorGenerator.call(seed: seed)

    assert_equal result1[:author_name], result2[:author_name]
    assert_equal result1[:author_color], result2[:author_color]
  end

  test "should generate different results with different seeds" do
    result1 = Movies::CommentAuthorGenerator.call(seed: 12345)
    result2 = Movies::CommentAuthorGenerator.call(seed: 67890)

    # With different seeds, we should get different results
    # (though there's a tiny chance they could be the same by coincidence)
    assert result1[:author_name] != result2[:author_name] ||
           result1[:author_color] != result2[:author_color],
           "Different seeds should typically generate different results"
  end

  test "should generate predictable sequence with same seed" do
    seed = 42

    # Generate multiple results with the same seed
    results1 = 3.times.map { Movies::CommentAuthorGenerator.call(seed: seed) }
    results2 = 3.times.map { Movies::CommentAuthorGenerator.call(seed: seed) }

    assert_equal results1, results2
  end

  # Constant validation tests
  test "ADJECTIVES should be frozen array of strings" do
    adjectives = Movies::CommentAuthorGenerator::ADJECTIVES

    assert adjectives.frozen?
    assert_instance_of Array, adjectives
    assert adjectives.all? { |adj| adj.is_a?(String) }
    assert adjectives.length > 0
  end

  test "ANIMALS should be frozen array of strings" do
    animals = Movies::CommentAuthorGenerator::ANIMALS

    assert animals.frozen?
    assert_instance_of Array, animals
    assert animals.all? { |animal| animal.is_a?(String) }
    assert animals.length > 0
  end

  test "COLORS should reference Comment::ALLOWED_COLORS" do
    assert_equal Comment::ALLOWED_COLORS, Movies::CommentAuthorGenerator::COLORS
  end

  test "should have reasonable variety in adjectives and animals" do
    # Should have enough variety for interesting combinations
    assert Movies::CommentAuthorGenerator::ADJECTIVES.length >= 10,
           "Should have at least 10 adjectives"
    assert Movies::CommentAuthorGenerator::ANIMALS.length >= 10,
           "Should have at least 10 animals"
  end

  # Integration with Comment model
  test "generated colors should all be valid for Comment model" do
    Movies::CommentAuthorGenerator::COLORS.each do |color|
      assert_includes Comment::ALLOWED_COLORS, color,
                      "Generated color #{color} should be valid for Comment model"
    end
  end

  # Edge cases
  test "should handle nil seed gracefully" do
    result1 = Movies::CommentAuthorGenerator.call(seed: nil)
    result2 = Movies::CommentAuthorGenerator.call(seed: nil)

    # Should work without error
    assert_instance_of Hash, result1
    assert_instance_of Hash, result2

    # With nil seed, should use default Random, so likely different results
    # (though could be same by chance)
    assert_includes result1.keys, :author_name
    assert_includes result1.keys, :author_color
  end

  test "should handle zero seed" do
    result = Movies::CommentAuthorGenerator.call(seed: 0)

    assert_instance_of Hash, result
    assert_includes result.keys, :author_name
    assert_includes result.keys, :author_color
  end

  test "should handle negative seed" do
    result = Movies::CommentAuthorGenerator.call(seed: -1)

    assert_instance_of Hash, result
    assert_includes result.keys, :author_name
    assert_includes result.keys, :author_color
  end

  # Performance test
  test "should be fast to generate" do
    start_time = Time.current

    100.times { Movies::CommentAuthorGenerator.call }

    end_time = Time.current
    duration = end_time - start_time

    # Should be very fast (less than 1 second for 100 generations)
    assert duration < 1.0, "Generator should be fast"
  end

  # Consistency tests
  test "all adjectives should be capitalized" do
    Movies::CommentAuthorGenerator::ADJECTIVES.each do |adjective|
      assert_equal adjective, adjective.capitalize,
                   "Adjective '#{adjective}' should be capitalized"
    end
  end

  test "all animals should be capitalized" do
    Movies::CommentAuthorGenerator::ANIMALS.each do |animal|
      assert_equal animal, animal.capitalize,
                   "Animal '#{animal}' should be capitalized"
    end
  end

  test "should not have duplicate adjectives" do
    adjectives = Movies::CommentAuthorGenerator::ADJECTIVES
    assert_equal adjectives.length, adjectives.uniq.length,
                 "Should not have duplicate adjectives"
  end

  test "should not have duplicate animals" do
    animals = Movies::CommentAuthorGenerator::ANIMALS
    assert_equal animals.length, animals.uniq.length,
                 "Should not have duplicate animals"
  end
end
