class Character < ActiveRecord::Base
  belongs_to :message

  validates :name, presence: true
end
