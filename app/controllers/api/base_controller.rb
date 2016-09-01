class API::BaseController < ApplicationController
  include LevelAuthorization
  include SubmissionAuthorization

  protect_from_forgery with: :null_session
end
