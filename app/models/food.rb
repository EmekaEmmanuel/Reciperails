class Food < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods, foreign_key: :recipe_id, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 250 }

  validates :measurement_unit, presence: true

  validates :price, presence: true

  validates :quantity, presence: true
end
