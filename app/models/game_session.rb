class GameSession < ActiveRecord::Base
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,if: ->(attr) { attr.present? }
end
