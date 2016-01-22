class LevelAuthorizer
  attr_reader :current_session

  def initialize(current_session)
    @current_session = current_session
  end

  def authorized?(level_number)
    current_session.max_level >= level_number.to_i
  end
end
