# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :genre

  scope :is_published, -> { where("published_at <= ?", Time.current.utc) }
  scope :is_not_published, -> { where("published_at > ?", Time.current.utc) }
  scope :is_featured, -> { where(is_featured: true) }
end
