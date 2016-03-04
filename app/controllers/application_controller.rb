class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_session
    @current_session ||= begin
      if cookies[:cody_user].present?
        game_session = GameSession.find_by cookie_key: cookies[:cody_user]
        game_session ? game_session : create_game_session
      else
        create_game_session
      end
    end
  end

  def create_game_session
    enc = SecureRandom.base64(24)
    cookies[:cody_user] = enc
    GameSession.create cookie_key: enc
  end
end
