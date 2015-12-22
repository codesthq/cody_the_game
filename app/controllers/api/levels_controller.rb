class API::LevelsController < API::BaseController
  before_action :set_level, only: [:show]
  def index
    # test
  end

  def show
    render json: @level, status: :ok
  end

  private

  def set_level
    @level = Level.find(params[:id])
  end
end
