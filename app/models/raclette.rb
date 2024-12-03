class Raclette < ApplicationRecord
  belongs_to :user

  TYPES = [ "vertical", "poelons", "bougies" ]

  validates :type, presence: true, inclusion: { in: TYPES }
  validates :description, presence: true, length: { minimum: 10 }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 20 }
  validates :price, presence: true
end
