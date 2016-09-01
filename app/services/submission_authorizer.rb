class SubmissionAuthorizer
  class SubmissionUnauthorized < StandardError; end

  attr_reader :current_session

  def initialize(current_session)
    @current_session = current_session
  end

  def authorize!(submission)
    raise SubmissionUnauthorized unless authorized?(submission)
  end

  def authorized?(submission)
    current_session == submission.game_session
  end
end
