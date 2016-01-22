class SubmissionVerifierJob < ActiveJob::Base
  queue_as :default

  def perform(submission_id)
    submission = Submission.find submission_id

    submission_validator = SubmissionVerifier.new submission
    submission_validator.verify
  end
end
