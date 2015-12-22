class API::PingsController < API::BaseController
  def index
    render json: { message: "Pong!" }, status: 200
  end
end
