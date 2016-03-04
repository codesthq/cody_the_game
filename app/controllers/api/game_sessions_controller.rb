class API::GameSessionsController < API::BaseController
  def show
    render json: current_session
  end
end
