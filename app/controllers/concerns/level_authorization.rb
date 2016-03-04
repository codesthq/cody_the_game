module LevelAuthorization
  extend ActiveSupport::Concern

  included do
    rescue_from LevelAuthorizer::LevelUnauthorized do
      head status: :unauthorized
    end
  end

  def authorize_level!(level_number)
    level_authorizer.authorize! level_number
  end

  def level_authorizer
    @level_authorizer ||= LevelAuthorizer.new current_session
  end
end
