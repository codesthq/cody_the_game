class API::LevelsController < API::BaseController
  before_action :authorize_level, only: :show

  def index
    render json: Level.all, each_serializer: LevelBaseSerializer, status: :ok
  end

  def show
    @level = Level.find level_number

    render json: @level, status: :ok
  end

  private

  def authorize_level
    unless level_authorizer.authorized? level_number
      head status: :unauthorized
    end
  end

  def level_authorizer
    @level_authorizer ||= LevelAuthorizer.new current_session
  end

  def level_number
    params[:id]
  end
end
