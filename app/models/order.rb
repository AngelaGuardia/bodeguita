class Order < ApplicationRecord
  validates :billing_address, :city, :state, :zip, :cc_name, :cc_number, :status, presence: true
  
  belongs_to :user
end
