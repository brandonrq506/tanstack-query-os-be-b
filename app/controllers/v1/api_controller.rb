# frozen_string_literal: true

class V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found
    render json: { error: "Record not found" }, status: :not_found
  end
end
