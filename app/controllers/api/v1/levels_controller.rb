class API::V1::LevelsController < API::V1::BaseController
  before_action :set_level

  def index
    render LevelSerializer.new(companies, API::V1::CompanyExtendedSerializer, root: "level", meta: true), status: :ok
  end

  private

  def set_level

  end
end
