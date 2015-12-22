class Task < ActiveRecord::Base
  has_many :submissions
  belongs_to :level

  validates :content, presence: true
  validates :points, presence: true
end
