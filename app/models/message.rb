class Message < ActiveRecord::Base
  has_one :character
  belongs_to :conversation

  validates :content, presence: true
end
