class LevelSerializer < ActiveModel::Serializer
  attributes :id
  has_one :conversation
end
