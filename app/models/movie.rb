# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :genre

  # Publishing scopes
  scope :is_published, -> { where("published_at <= ?", Time.current.utc) }
  scope :is_not_published, -> { where("published_at > ?", Time.current.utc) }

  # Feature scopes
  scope :is_featured, -> { where(is_featured: true) }
  scope :not_featured, -> { where(is_featured: false) }

  # Search scopes
  scope :by_title, ->(title) { where("title ILIKE ?", "%#{sanitize_sql_like(title)}%") if title.present? }
  scope :by_genre, ->(genre_id) { where(genre_id: genre_id) if genre_id.present? }
  scope :by_featured, ->(is_featured) { where(is_featured: ActiveModel::Type::Boolean.new.cast(is_featured)) if is_featured.present? }

  # Validations
  validates :title, presence: true
  validates :genre_id, presence: true
  validates :is_featured, inclusion: { in: [ true, false ] }
end
