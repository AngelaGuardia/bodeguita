class Image < ApplicationRecord
  validates :name, :description, :price, :url, :inventory, presence: true
  validates :inventory, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }

  belongs_to :user
  has_many :order_images
  has_many :orders, through: :order_images
end
