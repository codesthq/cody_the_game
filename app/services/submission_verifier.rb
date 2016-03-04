class SubmissionVerifier
  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def verify!
    if submission_succeed?
      submission.succeed!

      level_updater = LevelUpdater.new submission
      level_updater.update!
    else
      submission.failed!
    end
  end

  private

  def submission_succeed?
    task_test.run
  end

  def task_test
    test_class.new submission.content
  end

  def test_class
    task.test_class.constantize
  end

  def task
    @task ||= submission.level.task
  end
end
