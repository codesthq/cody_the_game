class Submission < ActiveRecord::Base
  belongs_to :level

  enum status: [:pending, :failed, :succeed]

  validates :content, presence: true
end
