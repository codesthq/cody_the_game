class API::V1::PingsController < API::V1::BaseController
  def index
    render json: { message: "Pong!" }, status: 200
  end
end
