class Message < ActiveRecord::Base
  has_one :character
  belongs_to :conversation

  validates :content, presence: true
  validates :position, uniqueness: { scope: :conversation_id }

  acts_as_list scope: :conversation
end
