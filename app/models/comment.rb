# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :movie, counter_cache: true

  ALLOWED_COLORS = %w[red orange amber yellow lime green emerald teal cyan sky blue indigo violet fuchsia pink rose].freeze

  validates :body, presence: true, length: { minimum: 1, maximum: 2000 }
  validates :author_name, presence: true
  validates :author_color, presence: true, inclusion: { in: ALLOWED_COLORS }

  before_save :sanitize_body

  scope :recent_first, -> { order(created_at: :desc) }

  private

  def sanitize_body
    self.body = ActionController::Base.helpers.strip_tags(body)
  end
end
