# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :movie_id, :body, :author_name, :author_color, :created_at, :updated_at
end
