class Character < ActiveRecord::Base
  belongs_to :level
  has_many :messages

  validates :name, presence: true
end
