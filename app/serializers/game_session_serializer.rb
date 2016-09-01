class GameSessionSerializer < ActiveModel::Serializer
  attributes :cookie_key, :current_level
end
