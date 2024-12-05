class Raclette < ApplicationRecord

  belongs_to :user
  has_one_attached :photo

  CATEGORIES = ["vertical", "poelons", "bougies"]
  CITIES = ["Soustons", "Anglet", "Provins"]

  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :description, presence: true, length: { minimum: 10 }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 20 }
  validates :price, presence: true
  validates :city, presence: true, inclusion: { in: CITIES }
end
