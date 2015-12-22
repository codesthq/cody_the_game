class API::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  private

  # def authenticate_user
  #   return if current_user

  #   render json: { error: "Invalid or missing User Authorization Token" }, status: :unauthorized
  # end

  # def current_user
  #   # @current_user ||=
  # end
end
