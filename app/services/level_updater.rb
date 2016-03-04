class LevelUpdater
  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def update!
    if perform_update?
      game_session.update current_level: succeeding_level
    end
  end

  private

  def perform_update?
    level_authorized? && submission_succeed? && succeeding_level?
  end

  def level_authorized?
    level_authorizer.authorized? level_number
  end

  def submission_succeed?
    submission.succeed?
  end

  def succeeding_level?
    succeeding_level > game_session.current_level
  end

  def level_authorizer
    @level_authorizer ||= ::LevelAuthorizer.new game_session
  end

  def game_session
    @game_session ||= submission.game_session
  end

  def succeeding_level
    level_number + 1
  end

  def level_number
    level.position
  end

  def level
    @level ||= submission.level
  end
end
