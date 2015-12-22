class API::LevelsController < API::BaseController
  before_action :set_level, only: :show
  before_action :check_level_permissions, only: [:show]

  def index
    render json: Level.all, each_serializer: LevelBaseSerializer, status: :ok
  end

  def show
    render json: @level, status: :ok
  end

  private

  def set_level
    @level = Level.find(params[:id])
  end

  def check_level_permissions
    if current_session.max_level < params[:id].to_i
      render json: { errors: "Your are not autorize!" }, status: :unauthorized
    end
  end
end
