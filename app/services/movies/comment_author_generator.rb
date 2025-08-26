# frozen_string_literal: true

class Movies::CommentAuthorGenerator
  ADJECTIVES = %w[Brave Calm Clever Gentle Jolly Kind Quick Quiet Sly Sunny Witty Zesty].freeze
  ANIMALS    = %w[Otter Fox Panda Dolphin Tiger Koala Llama Bear Hawk Owl Tortoise Cat Dog].freeze
  COLORS     = Comment::ALLOWED_COLORS

  def self.call(seed: nil)
    rng = seed ? Random.new(seed) : Random
    {
      author_name: "#{ADJECTIVES.sample(random: rng)} #{ANIMALS.sample(random: rng)}",
      author_color: COLORS.sample(random: rng)
    }
  end
end
