module SubmissionAuthorization
  extend ActiveSupport::Concern

  included do
    rescue_from SubmissionAuthorizer::SubmissionUnauthorized do
      head status: :unauthorized
    end
  end

  def authorize_submission!(submission)
    submission_authorizer.authorize! submission
  end

  def submission_authorizer
    @submission_authorizer ||= SubmissionAuthorizer.new current_session
  end
end
