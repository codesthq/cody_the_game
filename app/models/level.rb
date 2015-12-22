class Level < ActiveRecord::Base
  has_one :conversation
  has_one :task
end
