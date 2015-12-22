class MessageSerializer < ActiveModel::Serializer
  attributes :character_id, :content, :position
end
