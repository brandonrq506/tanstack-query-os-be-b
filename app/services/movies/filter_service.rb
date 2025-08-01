# frozen_string_literal: true

module Movies
  class FilterService
    ALLOWED_FILTERS = %w[title genre_id genre_name is_featured].freeze
    ALLOWED_SORT_FIELDS = %w[title duration_secs genre_name published_at created_at updated_at].freeze
    ALLOWED_SORT_DIRECTIONS = %w[asc desc].freeze
    DEFAULT_SORT_FIELD = "created_at"
    DEFAULT_SORT_DIRECTION = "desc"

    def initialize(scope = Movie.all)
      @scope = scope
    end

    def call(params = {})
      filter_params = params[:filter] || {}
      sort_params = params[:sort] || {}

      filtered_scope = apply_filters(filter_params)
      sorted_scope = apply_sorting(filtered_scope, sort_params)
      sorted_scope
    end

    private

    attr_reader :scope

    def apply_filters(filter_params)
      current_scope = scope

      # Filter by title (case-insensitive partial match)
      if filter_params[:title].present?
        current_scope = current_scope.where("title ILIKE ?", "%#{sanitize_like_input(filter_params[:title])}%")
      end

      # Filter by genre_id
      if filter_params[:genre_id].present?
        current_scope = current_scope.where(genre_id: filter_params[:genre_id])
      end

      # Filter by genre name (case-insensitive partial match)
      if filter_params[:genre_name].present?
        current_scope = current_scope.joins(:genre).where("genres.name ILIKE ?", "%#{sanitize_like_input(filter_params[:genre_name])}%")
      end

      # Filter by is_featured
      if filter_params[:is_featured].present?
        current_scope = current_scope.where(is_featured: ActiveModel::Type::Boolean.new.cast(filter_params[:is_featured]))
      end

      current_scope
    end

    def apply_sorting(current_scope, sort_params)
      sort_field = normalize_sort_field(sort_params[:sort_by])
      sort_direction = normalize_sort_direction(sort_params[:sort_order]) # Using sort_order to match frontend

      case sort_field
      when "genre_name"
        # Join with genres table to sort by genre name
        current_scope.joins(:genre).order("genres.name #{sort_direction}")
      else
        # Check if we already have a join and need to qualify the table name
        if current_scope.joins_values.any? { |join| join.to_s.include?("genre") }
          # If we have a genre join, qualify movie columns to avoid ambiguity
          qualified_field = qualify_movie_field(sort_field)
          current_scope.order("#{qualified_field} #{sort_direction}")
        else
          # Direct field sorting without joins
          current_scope.order("#{sort_field} #{sort_direction}")
        end
      end
    end

    def normalize_sort_field(sort_field)
      return DEFAULT_SORT_FIELD unless sort_field.present?

      ALLOWED_SORT_FIELDS.include?(sort_field) ? sort_field : DEFAULT_SORT_FIELD
    end

    def normalize_sort_direction(sort_direction)
      return DEFAULT_SORT_DIRECTION unless sort_direction.present?

      ALLOWED_SORT_DIRECTIONS.include?(sort_direction.downcase) ? sort_direction.downcase : DEFAULT_SORT_DIRECTION
    end

    def sanitize_like_input(input)
      # Escape special LIKE characters to prevent SQL injection
      input.to_s.gsub(/[%_\\]/) { |match| "\\#{match}" }
    end

    def qualify_movie_field(field)
      # Qualify movie table fields to avoid ambiguity when joining with genres
      case field
      when "title", "duration_secs", "published_at", "created_at", "updated_at"
        "movies.#{field}"
      else
        field
      end
    end
  end
end
