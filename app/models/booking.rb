class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :raclette

  CATEGORIES = %w(confirmed pending declined)

  validates :start_date, presence: true
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
  validates :status, presence: true, inclusion: { in: CATEGORIES }
  validates :user, presence: true
  validates :raclette, presence: true
end
