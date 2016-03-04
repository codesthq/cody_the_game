class API::BaseController < ApplicationController
  include LevelAuthorization

  protect_from_forgery with: :null_session
end
