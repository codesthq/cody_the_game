class LevelBaseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :position
end
