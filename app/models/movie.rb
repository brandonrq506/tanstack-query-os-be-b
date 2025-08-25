# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :genre

  has_many :comments, dependent: :destroy

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
  validates :title, presence: true, length: { maximum: 255 }
  validates :genre_id, presence: true
  validates :is_featured, inclusion: { in: [ true, false ] }
  validates :duration_secs, presence: true, numericality: { greater_than: 0 }
  validates :published_at, presence: true
end
