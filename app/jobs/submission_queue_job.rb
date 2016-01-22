class SubmissionQueueJob < ActiveJob::Base
  queue_as :default

  def perform(submission_id)
    # Do something later
  end
end
