class SummaryAuthorizer
  attr_reader :current_session

  def initialize(current_session)
    @current_session = current_session
  end

  def authorized?
    last_level_done?
  end

  private

  def last_level_done?
    max_submission && max_level == max_submission.level && current_session.current_level == max_level.position
  end

  def max_level
    Level.order(:position).last
  end

  def max_submission
    current_session.submissions.order(:level_id).where(status: 2).last
  end
end
