class Character < ActiveRecord::Base
  belongs_to :level
  belongs_to :message

  validates :name, presence: true
end
