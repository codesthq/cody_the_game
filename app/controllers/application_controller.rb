class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_session
    @current_session ||= authenticator.authenticate_game_sassion
  end

  def authenticator
    GameSessionAuthenticator.new cookies, request
  end
end
