class LevelAuthorizer
  class LevelUnauthorized < StandardError; end

  attr_reader :current_session

  def initialize(current_session)
    @current_session = current_session
  end

  def authorize!(level_number)
    raise LevelUnauthorized unless authorized?(level_number)
  end

  def authorized?(level_number)
    current_session.current_level >= level_number.to_i
  end
end
