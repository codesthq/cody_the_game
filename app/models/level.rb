class Level < ActiveRecord::Base
  default_scope { order(position: :asc) }

  has_many :submissions
  has_many :characters
  has_one :conversation
  has_one :task

  validates :position, presence: true
  validates :position, uniqueness: true

  acts_as_list
end
