class Order < ApplicationRecord
  validates :billing_address, :city, :state, :zip, :cc_name, :cc_number, :status, presence: true

  belongs_to :user
  has_many :order_images
  has_many :images, through: :order_images
end
