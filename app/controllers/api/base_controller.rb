class API::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  private

  def current_session
    @current_session ||= begin
      if cookies[:cody_user].present?
        GameSession.find_by cookie_key: cookies[:cody_user]
      else
        enc = SecureRandom.base64(24)
        cookies[:cody_user] = enc
        GameSession.create cookie_key: enc
      end
    end
  end
end
