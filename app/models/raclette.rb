class Raclette < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :user

  CATEGORIES = [ "vertical", "poelons", "bougies" ]

  validates :type, presence: true, inclusion: { in: CATEGORIES }
  validates :description, presence: true, length: { minimum: 10 }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 20 }
  validates :price, presence: true
end
