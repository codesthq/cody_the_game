class LevelSerializer < ActiveModel::Serializer
  attributes :id

  has_many :characters
  has_one :conversation
  has_one :task
end
