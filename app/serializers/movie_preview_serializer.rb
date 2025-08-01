class MoviePreviewSerializer < ActiveModel::Serializer
  attributes :id, :thumbnail_url, :title
end
