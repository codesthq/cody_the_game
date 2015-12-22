class Conversation < ActiveRecord::Base
  has_many :messages
  belongs_to :level


end
