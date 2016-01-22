class SubmissionVerifier
  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def verify
    if submission_succeed?
      submission.succeed!
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
    submission.level.task
  end
end
