# frozen_string_literal: true

class Genre < ApplicationRecord
  has_many :movies, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
