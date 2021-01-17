class Discount < ApplicationRecord
  validates :name, :percentage, :minimum_quantity, presence: true
  validates :percentage, numericality: { greater_than: 0, less_than: 1 }
  validates :minimum_quantity, numericality: { greater_than: 0 }

  belongs_to :user
end
