class Order < ApplicationRecord
  validates :billing_address, :city, :state, :zip, :cc_name, :cc_number, :status, presence: true

  belongs_to :user
  has_many :order_images, dependent: :destroy
  has_many :images, through: :order_images, dependent: :destroy

  def fulfillable?(cart)
    cart.each do |image_id, quantity|
      image = Image.find(image_id)
      return false if image.inventory < quantity
    end
  end

  def fulfill(cart)
    cart.each do |image_id, quantity|
      image = Image.find(image_id)
      OrderImage.create(order: self, image: image, price: image.discounted_price(quantity), quantity: quantity)
      image.update(inventory: image.inventory - quantity)
    end
  end

  def grand_total
    order_images.sum { |order_image| order_image.price * order_image.quantity }
  end
end
