class API::LevelsController < API::BaseController
  def index
    render json: Level.all, each_serializer: LevelBaseSerializer, status: :ok
  end

  def show
    authorize_level! level_number

    @level = Level.find level_number

    render json: @level, status: :ok
  end

  private

  def level_number
    params[:id]
  end
end
