class API::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  private

  def authenticate_user
    return if current_user

    render json: { error: "Invalid or missing User Authorization Token" }, status: :unauthorized
  end

  def current_user
    @current_user ||=
      begin
        token, _options = ActionController::HttpAuthentication::Token.token_and_options(request)
        AuthorizationToken.find_by(token: token).try(:user).tap do |user|
          verify_authenticate_user(user) if user
        end
      end
  end
end
