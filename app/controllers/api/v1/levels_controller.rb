class API::V1::LevelsController < API::V1::BaseController
  def index
    render json: { message: "Another" }, status: 200
  end
end
