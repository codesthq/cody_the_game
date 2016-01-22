class Submission < ActiveRecord::Base
  belongs_to :level
  belongs_to :game_session

  enum status: [:pending, :failed, :succeed]

  validates :content, presence: true
end
