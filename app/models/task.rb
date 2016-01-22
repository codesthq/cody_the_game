class Task < ActiveRecord::Base
  belongs_to :level

  validates :content, presence: true
  validates :points, presence: true
end
