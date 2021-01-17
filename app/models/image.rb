class Image < ApplicationRecord
  validates :name, :description, :price, :url, :inventory, presence: true
  validates :inventory, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }

  belongs_to :user
  has_many :order_images, dependent: :destroy
  has_many :orders, through: :order_images, dependent: :destroy
  has_many :discounts, through: :user

  def discounted_price(quantity)
    applicable_discount = discounts.where("minimum_quantity <= #{quantity}").order(percentage: :desc).limit(1)

    if applicable_discount.empty?
      price
    else
      price * (1 - applicable_discount.first.percentage)
    end
  end
end
