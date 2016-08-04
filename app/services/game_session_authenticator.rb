class GameSessionAuthenticator
  attr_reader :cookies, :request

  def initialize(cookies, request)
    @cookies = cookies
    @request = request
  end

  def authenticate_game_sassion
    cookies[:game_session] = game_session.cookie_key
    game_session
  end

  private

  def game_session
    @game_session ||= find_game_session || create_game_session
  end

  def find_game_session
    GameSession.find_by cookie_key: game_session_cookie
  end

  def create_game_session
    GameSession.create! cookie_key: SecureRandom.hex, ip: request.remote_ip
  end

  def game_session_cookie
    cookies[:game_session]
  end
end
