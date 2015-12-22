class Conversation < ActiveRecord::Base
  has_many :messages, -> { order(position: :asc) }
  belongs_to :level
end
