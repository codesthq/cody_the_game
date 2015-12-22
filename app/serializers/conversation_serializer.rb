class ConversationSerializer < ActiveModel::Serializer
  has_many :messages
end
