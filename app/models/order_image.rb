class OrderImage < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true

  belongs_to :order
  belongs_to :image
end
