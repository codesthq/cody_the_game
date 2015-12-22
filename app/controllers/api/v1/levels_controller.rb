class API::V1::LevelsController < API::V1::BaseController
  def index
    # render
  end

  def show
    render LevelSerializer.new(@level, root: "level"), status: :ok
  end

  private

  def set_level
    @level = Level.find(params[:id])
  end
end
