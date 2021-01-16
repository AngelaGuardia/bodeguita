class User < ApplicationRecord
  validates :first_name, :last_name, :address, :city, :state, :zip, :email, presence: true
  validates :email, uniqueness: true

  has_many :images, dependent: :destroy
  enum role: { 'buyer' => 0, 'photographer' => 1 }
end
