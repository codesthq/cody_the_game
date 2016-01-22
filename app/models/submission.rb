class Submission < ActiveRecord::Base
  belongs_to :level
  belongs_to :task

  enum status: [:pending, :failed, :succeed]

  validates :content, presence: true
end
