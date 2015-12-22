class Level < ActiveRecord::Base
  has_many :characters
  has_one :conversation
  has_one :task
end
