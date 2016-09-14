class GameSession < ActiveRecord::Base
  has_many :submissions
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,if: ->(model) { model.email.present? }

  scope :finished, -> { where.not(email: nil) }
end
